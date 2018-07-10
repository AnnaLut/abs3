Application Description: ! BARS005.APL - функции по Финансовому Мониторингу
		! ООО Унити-Барс  (C)  2004
		! Чупахина Н.А.
		! ///////////////////////////////////////////////
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000CD0000 002C000000030000 00030000000E0300 000B000000F8FFFF
0040: FFE1FFFFFF200000 0015000000EA0200 00D7010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D04000000075769 6E646F777309446C
0080: 675F464D5061720D 4368696C64205769 6E646F7773086466 44464D5F3033
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001C51 3A5C424152533938 5C4C494252415259 5C4162736170692E
0020: 646C6C1C513A5C42 41525339385C4C49 42524152595C4162 736170692E617063
0040: 00000101011C513A 5C4241525339385C 4C4942524152595C 4162736170692E72
0060: 756E1C513A5C4241 525339385C4C4942 524152595C416273 6170692E646C6C1C
0080: 513A5C4241525339 385C4C4942524152 595C416273617069 2E61706300000101
00A0: 01175C4241525339 385C42494E5C6261 72733030352E6170 64165C4241525339
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
		Dynalib: docview.apd
		Dynalib: nsiapi.apd
		File Include: Gentbl.apl
		File Include: GENTBLD.APL
		File Include: GENLIST.APL
		File Include: Vttblwin.apl
		File Include: XSALCPT.APL
		Dynalib: custacnt.apd
		File Include: VTCOMM.APL
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
			Icon: icon_Folder2
				File Name: \Bars98\Resource\Ico\Folderop.ico
		Variables
			Window Handle: hWin0
			Window Handle: hWin1
			Window Handle: hWin2
			Number: nFetchRes
		Internal Functions
			!
			Function: Ini005
				Description: Коструктор
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
			Function: Sel005                !__exported
				Description:
				Returns
					Boolean:
				Parameters
					Window Handle: hWndParent
					Number: nMode
					Number: nPar
					String: strPar1
					String: strPar2
				Static Variables
				Local variables
				Actions
					Select Case nMode
						! Фин. Мониторинг
						Case 0
							If not IsWindow(hWin0)
								Call SalCreateWindow(Tbl_FMDoc, hWndParent, nPar, strPar1, strPar2)
							Else
								Call SalBringWindowToTop(hWin0)
							Break
						! Курсы валют
						Case 1
							If not IsWindow(hWin1)
								Call SalCreateWindow(Tbl_CurRates, hWndParent, nPar, strPar1, strPar2)
							Else
								Call SalBringWindowToTop(hWin1)
							Break
						! Фин. Мониторинг: импорт файла террористов
						Case 2
							! Call SalModalDialog(dlg_ImportReft, hWndMDI)
							! Break
							If not IsWindow(hWin0)
								Call SalCreateWindow(frm_ImportReft, hWndParent)
							Else
								Call SalBringWindowToTop(hWin0)
							Break
						Default
							Break
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
			Radio Button: cRadioButtonLabeled
			Option Button:
			Check Box: cCheckBoxLabeled
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
	! Формы ФМ
	Table Window: Tbl_FMDoc
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Перегляд і відбір до Фінансового Моніторингу документів
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
				Left:   1.1"
				Top:    0.917"
				Width:  13.0"
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
		Description: Отбор документов в финансовый мониторинг
		Named Menus
		Menu
		Tool Bar
			Display Settings
				Display Style? Class Default
				Location? Class Default
				Visible? Class Default
				Size: 0.87"
				Size Editable? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Bold-Strikeout
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
					Resource Id: 58402
					Class Child Ref Key: 37
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  7.75"
						Begin Y:  0.0"
						End X:  7.75"
						End Y:  0.45"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				Line
					Resource Id: 28214
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  6.7"
						Begin Y:  0.0"
						End X:  6.7"
						End Y:  0.45"
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
						On SAM_Click
							If bFM_DFLTR
								If SetQueryDFilterEx(cDF)
									Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
							Else
								If SetQueryFilterEx(cF)
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
					Resource Id: 58403
					Class Child Ref Key: 41
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  0.0"
						End X:  Class Default
						End Y:  0.45"
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
						Left:   7.85"
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
					Resource Id: 58404
					Class Child Ref Key: 43
					Class ChildKey: 0
					Class: cGenericTable
					Coordinates
						Begin X:  Class Default
						Begin Y:  0.0"
						End X:  Class Default
						End Y:  0.45"
					Visible? Class Default
					Line Style: Class Default
					Line Thickness: Class Default
					Line Color: Class Default
				!
				Pushbutton: pbNew	! Відправити
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
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
					Picture File Name: \BARS98\RESOURCE\BMP\DOC_OUT.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Відправити"
						On SAM_Click
							Set i = TBL_MinRow
							While SalTblFindNextRow(hWndForm, i, ROW_Selected, 0)
								Call SalTblSetContext(hWndForm, i)
								If hWndForm.Tbl_FMDoc.colStatusId != 'B' AND hWndForm.Tbl_FMDoc.colStatusId != 'D' AND 
										  (hWndForm.Tbl_FMDoc.colVid2 != '' OR hWndForm.Tbl_FMDoc.colVid3 != '') AND bParNew
									! If colAgentId = nUserId OR colAgentId = NUMBER_Null OR nPar1 = 1
									Set hWndForm.Tbl_FMDoc.colStatusId_New = 'N'
									Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
									Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
									Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
				Pushbutton: pbIn	! Внести (повідомити)
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbChilds
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.44"
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
							Set strTip = "Внести (повідомити)"
						On SAM_Click
							If bParComm
								If not SalModalDialog(dlg_FMComments, hWndForm, sComments)
									Return TRUE
							Set i = TBL_MinRow
							While SalTblFindNextRow(hWndForm, i, ROW_Selected, 0)
								Call SalTblSetContext(hWndForm, i)
								! если статус не D (Iмпортована)
										     и (     можно редактировать параметры и параметры заполнены
										        или нельзя редактировать параметры)
								If hWndForm.Tbl_FMDoc.colStatusId != 'D' AND 
										  ((hWndForm.Tbl_FMDoc.colVid2 != '' OR hWndForm.Tbl_FMDoc.colVid3 != '') AND not bParNotFMPar OR bParNotFMPar)
									If (hWndForm.Tbl_FMDoc.colAgentId = nUserId OR hWndForm.Tbl_FMDoc.colAgentId = NUMBER_Null) AND bParIn
										If bParComm
											Set colComments = sComments
										Set hWndForm.Tbl_FMDoc.colStatusId_New = 'I'
										Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
										Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
										Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
				Pushbutton: pbBack	! Вилучити
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbChilds
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   4.88"
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
							Set strTip = "Вилучити"
						On SAM_Click
							Set i = TBL_MinRow
							While SalTblFindNextRow(hWndForm, i, ROW_Selected, 0)
								Call SalTblSetContext(hWndForm, i)
								If hWndForm.Tbl_FMDoc.colStatusId != 'B' AND hWndForm.Tbl_FMDoc.colStatusId != 'D'
									! Если Разрешено pbBack и (Повідомив сам пользователь или пользователю разрешено Редакт. пар-ры любого usera)
									If bParBack AND (hWndForm.Tbl_FMDoc.colAgentId = nUserId OR bParEditPar)
										Set hWndForm.Tbl_FMDoc.colStatusId_New = 'B'
										Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
										Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
										Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
				Pushbutton: pbWait	! Відкласти
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbChilds
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.32"
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
					Picture File Name: \BARS98\RESOURCE\BMP\CLOCK-2.BMP
					Picture Transparent Color: Magenta
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = "Відкласти"
						On SAM_Click
							Set i = TBL_MinRow
							While SalTblFindNextRow(hWndForm, i, ROW_Selected, 0)
								Call SalTblSetContext(hWndForm, i)
								If hWndForm.Tbl_FMDoc.colStatusId != 'D'
									If (hWndForm.Tbl_FMDoc.colAgentId = nUserId OR hWndForm.Tbl_FMDoc.colAgentId = NUMBER_Null) AND bParWait
										Set hWndForm.Tbl_FMDoc.colStatusId_New = 'S'
										Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
										Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
										Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
									Else
										If bParWait AND bParEditPar
											Set hWndForm.Tbl_FMDoc.colStatusId_New = 'S'
											Call hWndForm.Tbl_FMDoc.colStatus.SetSelectById(hWndForm.Tbl_FMDoc.colStatusId_New)
											Call SalTblSetRowFlags(hWndForm, i, ROW_Edited, TRUE)
											Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
				Pushbutton: pbFMPar	! Параметри
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   5.76"
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
							Set strTip = 'Параметри'
						On SAM_Click
							Set nRow = SalTblQueryContext(hWndForm)
							If (hWndForm.Tbl_FMDoc.colRef != NUMBER_Null or
									    hWndForm.Tbl_FMDoc.colRec != NUMBER_Null) AND 
									   SalTblQueryRowFlags(hWndForm, nRow, ROW_Edited) = FALSE
								If SalModalDialog(Dlg_FMPar, hWndMDI, 
										IifN(nParEdit AND (
										     hWndForm.Tbl_FMDoc.colStatusId =''  AND bParIn OR 
										     hWndForm.Tbl_FMDoc.colStatusId!='B' AND 
										     hWndForm.Tbl_FMDoc.colStatusId!='D' AND bParEditPar OR
										     ( hWndForm.Tbl_FMDoc.colStatusId='N' OR 
										       hWndForm.Tbl_FMDoc.colStatusId='T' OR
										       hWndForm.Tbl_FMDoc.colStatusId='I' OR 
										       hWndForm.Tbl_FMDoc.colStatusId='S' OR 
										       hWndForm.Tbl_FMDoc.colStatusId='R') AND 
										     ( hWndForm.Tbl_FMDoc.colAgentId=nUserId OR 
										       hWndForm.Tbl_FMDoc.colAgentId=NUMBER_Null OR 
										       bParEditPar) ), 1, 0), hWndForm.Tbl_FMDoc.colId, 
										hWndForm.Tbl_FMDoc.colRef,  hWndForm.Tbl_FMDoc.colRec, 
										hWndForm.Tbl_FMDoc.colMfoa, hWndForm.Tbl_FMDoc.colNlsa, hWndForm.Tbl_FMDoc.colNama,
										hWndForm.Tbl_FMDoc.colMfob, hWndForm.Tbl_FMDoc.colNlsb, hWndForm.Tbl_FMDoc.colNamb,
										hWndForm.Tbl_FMDoc.colDatD, hWndForm.Tbl_FMDoc.colS,
										hWndForm.Tbl_FMDoc.colKv,   hWndForm.Tbl_FMDoc.colKv2, hWndForm.Tbl_FMDoc.colLcv, 
										hWndForm.Tbl_FMDoc.colNazn, hWndForm.Tbl_FMDoc.colDig, 
										hWndForm.Tbl_FMDoc.colVid1, hWndForm.Tbl_FMDoc.colVid2, hWndForm.Tbl_FMDoc.colComm2, 
										hWndForm.Tbl_FMDoc.colVid3, hWndForm.Tbl_FMDoc.colComm3, 
										hWndForm.Tbl_FMDoc.colMode, hWndForm.Tbl_FMDoc.colRnkA, hWndForm.Tbl_FMDoc.colRnkB,
										hWndForm.Tbl_FMDoc.colOkpoA, hWndForm.Tbl_FMDoc.colOkpoB)
									Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
				Pushbutton: pbHistory	! Історія змін
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbChilds
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.2"
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
					Picture File Name: \BARS98\RESOURCE\BMP\BOOKS1.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Історія змін'
						On SAM_Click
							If colId != NUMBER_Null
								! Call FunNSIEditFFiltered('FINMON_QUE_MODIFICATION',1,
										' FINMON_QUE_MODIFICATION.REF=' || Str(colRef) ||
										' ORDER BY FINMON_QUE_MODIFICATION.MOD_DATE')
								Call SalCreateWindow(Tbl_FMHistory, hWndMDI, hWndForm.Tbl_FMDoc.colId, 
										  IifN(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, hWndForm.Tbl_FMDoc.colRef, hWndForm.Tbl_FMDoc.colRec))
				Pushbutton: pbUnStop	! Розблокувати документ
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbBrowse
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   6.8"
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
					Picture File Name: \BARS98\RESOURCE\BMP\A_BKLD.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Розблокувати документ'
						On SAM_Click
							If colOtm > 0 or colBlk = 131313
								! If colStatusId = 'N' OR colStatusId = 'T' OR colStatusId = 'D'
									          Call SalMessageBox("Документ " || 
											  IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, "REF", "REC") || 
											  IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRef), Str(hWndForm.Tbl_FMDoc.colRec)) || 
											  " не може бути розблоковано, " || PutCrLf() || 
											  "бо він має статус " || IifS(colStatusId='N' OR colStatusId='T', "'До відправки'", "'Імпортована'") || ".", 
											  "Увага!", MB_IconExclamation | MB_Ok)
									          Return TRUE
								! If colStatusId = 'D' AND 
										   SalDateConstruct(SalDateYear(colAgentDat+2), SalDateMonth(colAgentDat+2), SalDateDay(colAgentDat+2), 0, 0, 0) > 
										   SalDateConstruct(SalDateYear(SalDateCurrent()), SalDateMonth(SalDateCurrent()), SalDateDay(SalDateCurrent()), 0, 0, 0)
									     Call SalMessageBox("Документ " || 
											  IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, "REF", "REC") || 
											  IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRef), Str(hWndForm.Tbl_FMDoc.colRec)) || 
											  " не може бути розблоковано, " || PutCrLf() || 
											  "бо не минув термін.", 
											  "Увага!", MB_IconExclamation | MB_Ok)
									     Return TRUE
								! If colPDat + 2 < SalDateCurrent()
									                  Call SalMessageBox("Документ " || Str(colRef) || " не може бути розблоковано, " || PutCrLf() || 
											  "бо не минув термін.", 
											  "Увага!", MB_IconExclamation | MB_Ok)
									                  Return TRUE
								If IDYES = SalMessageBox("Розблокувати документ " || 
										  IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
										  IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) || " для оплати?", "Увага!", MB_IconQuestion | MB_YesNo)
									If not SqlPLSQLCommand(hSql(), "p_fm_unblock(hWndForm.Tbl_FMDoc.colRef, hWndForm.Tbl_FMDoc.colRec)")
										Call SqlRollbackEx(hSql(), "FM. Не удалось разблокировать документ " || 
												     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
												     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) || " для оплаты")
									Else
										Call SqlCommitEx(hSql(), "FM. Разблокирован для оплаты документ " || 
												     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
												     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) )
										Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
									! If colOtm > 0
										        If NOT SqlPrepareAndExecute(hSql(), "UPDATE fm_ref_que SET otm=0 WHERE ref=:colRef")
											        Call SqlRollbackEx(hSql(), "FM. Не удалось разблокировать документ " || 
													     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
													     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) || " для оплаты")
										        Else 
											        Set nRow = SalTblQueryContext(hWndForm)
											        Call XSalTblSetRowBackColor(hWndForm, nRow, COLOR_White)
											        Set colOtm = 0
											        Call SalDisableWindow(pbUnStop)
											        Call SalDisableWindow(pbRefT)
											        If nFM_GRP2
												        If not  SqlPrepareAndExecute(hSql(), 
														"insert into oper_visa (ref, dat, userid, groupid, status)
														 values (:hWndForm.Tbl_FMDoc.colRef, sysdate, :nUserId, :nFM_GRP2, 2)")
													        Call SqlRollback(hSql())
											        Call SqlCommitEx(hSql(), "FM. Разблокирован для оплаты документ " || 
													     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
													     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) )
									! Else If colBlk = 131313
										        If NOT SqlPrepareAndExecute(hSql(), "UPDATE arc_rrp SET blk=0 WHERE rec=:colRec")
											        Call SqlRollbackEx(hSql(), "FM. Не удалось разблокировать документ " || 
													     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
													     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) || " для оплаты")
										        Else 
											! Set nRow = SalTblQueryContext(hWndForm)
											! Call XSalTblSetRowBackColor(hWndForm, nRow, COLOR_White)
											! Set colOtm = NUMBER_Null
											! Call SalDisableWindow(pbUnStop)
											        Call SqlCommitEx(hSql(), "FM. Разблокирован для оплаты документ " || 
													     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, "REC", "REF") || 
													     IifS(hWndForm.Tbl_FMDoc.colRec!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRec), Str(hWndForm.Tbl_FMDoc.colRef)) )
											        Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
				Pushbutton: pbRefT	! Перегляд даних з переліку осіб, підозрюваних у тероризмі
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbChilds
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   7.24"
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
					Picture File Name: \BARS98\RESOURCE\BMP\USER.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Перегляд даних з переліку осіб, підозрюваних у тероризмі'
						On SAM_Click
							Call FunNSIEditFFiltered("V_FINMON_REFT", 1, "c1="||Str(hWndForm.Tbl_FMDoc.colOtm))
				Line
					Resource Id: 37590
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  8.4"
						Begin Y:  0.0"
						End X:  8.4"
						End Y:  0.45"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: 3D Shadow Color
				Background Text: Документів всього:
					Resource Id: 48604
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   8.5"
						Top:    0.131"
						Width:  2.5"
						Width Editable? Yes
						Height: 0.2"
						Height Editable? Yes
					Visible? Yes
					Justify: Right
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Dark Blue
					Background Color: Default
				Data Field: dfDocCount
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
							Left:   11.1"
							Top:    0.095"
							Width:  1.2"
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
						Text Color: Dark Blue
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
				!
				Line
					Resource Id: 43701
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Coordinates
						Begin X:  0.0"
						Begin Y:  0.45"
						End X:  50.0"
						End Y:  0.45"
					Visible? Yes
					Line Style: Etched
					Line Thickness: 1
					Line Color: Default
				Pushbutton: pbShowRules
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbOk
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.086"
						Top:    0.5"
						Width:  Class Default
						Width Editable? Class Default
						Height: Class Default
						Height Editable? Class Default
					Visible? Class Default
					Keyboard Accelerator: Class Default
					Font Name: Class Default
					Font Size: Class Default
					Font Enhancement: Class Default
					Picture File Name: \bars98\RESOURCE\BMP\LOOK.BMP
					Picture Transparent Color: Class Default
					Image Style: Class Default
					Text Color: Class Default
					Background Color: Class Default
					Message Actions
						On SAM_Create
							Set strTip = 'Довідник правил'
						On SAM_Click
							If colRules
								Call FunNSIEditFFiltered('FM_RULES', 1, 'id in (' || colRules || ')')
				Pushbutton: pbFMFilter
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class: ctb_pbFilter
					Property Template:
					Class DLL Name:
					Title:
					Window Location and Size
						Left:   0.514"
						Top:    0.5"
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
						On SAM_Create
							Set strTip = 'Фільтр по правилам ФМ'
						On SAM_Click
							If GetFMFilter()
								Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
				Background Text: Дата валютування
					Resource Id: 43700
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   1.2"
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
					Text Color: Dark Blue
					Background Color: Default
				Data Field: bgVDat
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
				Data Field: dfVDat1
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
							Left:   3.25"
							Top:    0.55"
							Width:  1.4"
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
						Text Color: Dark Blue
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
				Background Text: -
					Resource Id: 40346
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   4.65"
						Top:    0.595"
						Width:  0.2"
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
				Data Field: dfVDat2
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
							Left:   4.9"
							Top:    0.55"
							Width:  1.4"
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
						Text Color: Dark Blue
						Background Color: Default
						Input Mask: Unformatted
					Message Actions
				Data Field: dfRuleName
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
							Left:   6.5"
							Top:    0.595"
							Width:  20.0"
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
						Text Color: Dark Blue
						Background Color: 3D Face Color
						Input Mask: Unformatted
					Message Actions
		Contents
			Column: colRules
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Правила
						ФМ
				Visible? Class Default
				Editable? No
				Maximum Data Length: 100
				Data Type: String
				Justify: Left
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
			Column: colId
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
			Column: colRef
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Референс
						документа
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
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
			Column: colRec
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: REC
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
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
			Column: colStatusId
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
			Column: colStatusId_New
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
			Column: colStatus
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cGenColComboBox_StrId
				Property Template:
				Class DLL Name:
				Title: Статус
						документа
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
					On SAM_Create
						Call colStatus.Init(hWndItem)
						Call colStatus.Populate(hSql(), "STATUS", "NAME", "FINMON_QUE_STATUS", "")
			Column: colTT
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
						ОП
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colNd
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Номер
						документа
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colDatD
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дата
						документа
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.2"
				Width Editable? Class Default
				Format: dd/MM/yyyy
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
			Column: colSEqv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Сума док.
						(екв.)
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.6"
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
			Column: colNlsa
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Рахунок А
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colNama
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Наименование
						Счета А
				Visible? No
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colS
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
			Column: colSs
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Сума А
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colKv
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
			Column: colLcv
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вал А
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colMfoa
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: МФО А
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colNlsb
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Рахунок В
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colNamb
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Наименование
						Счета В
				Visible? No
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colS2
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
			Column: colS2s
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Сума В
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colKv2
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
			Column: colLcv2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Вал В
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colMfob
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: МФО В
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colSK
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: СКП
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
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
			Column: colVDat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дата
						валютування
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
			Column: colNazn
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Призначення платежу
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: String
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
			Column: colBranch
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Відділення
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
			Column: colDig
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
			Column: colDig2
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
			Column: colVid1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Vid1
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
			Column: colVid2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Ознака
						обов'язк.
						моніторінгу
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
			Column: colComm2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Comm2
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
			Column: colVid3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Ознака
						внутр..
						моніторінгу
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
			Column: colComm3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Comm3
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
			Column: colMode
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Mode
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
			Column: colAgentId
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: AgentId
				Visible? No
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
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
			Column: colAgentFIO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Повідомив
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
			Column: colAgentDat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Дата
						реєстрації
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.6"
				Width Editable? Class Default
				Format: DateTime
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
			Column: colComments
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Коментар
				Visible? Class Default
				Editable? No
				Maximum Data Length: 254
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
			Column: colRnkA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: RnkA
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
			Column: colRnkB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: RnkB
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
			Column: colSOS
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
			Column: colDocCount
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
			! colOtm - признак блокировки документа по ФМ
			Column: colOtm
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: № особи 
						в переліку осіб
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  Default
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
			Column: colPDat
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title:
				Visible? No
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Date/Time
				Justify: Class Default
				Width:  Class Default
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
			Column: colOkpoA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title:
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
			Column: colOkpoB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title:
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
			! colBlk - код юлокировки в arc_rrp
			Column: colBlk
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
			Column: colNmka
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Клієнт А
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
			Column: colNmkb
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Клієнт Б
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
		Functions
			Function: GetFMFilter
				Description:
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
				Actions
					Set dDat1 = dfVDat1
					Set dDat2 = dfVDat2
					If not SalModalDialog(dlg_FMFilter, hWndForm, dDat1, dDat2, sFMRulesList, nFMRulesApply)
						Set sFMRulesList = STRING_Null
						Return FALSE
					Set dfVDat1 = dDat1
					Set dfVDat2 = dDat2
					Call SalWaitCursor(TRUE)
					If not SqlPLSQLCommand(hSql(), "p_fm_checkrules(dfVDat1,dfVDat2,sFMRulesList)")
						Call SqlRollback(hSql())
						Call SalWaitCursor(FALSE)
					Call SqlCommit(hSql())
					Call SalWaitCursor(FALSE)
					Return TRUE
		Window Parameters
			Number: nParEdit ! 0 - ReadOnly, 1 - Edit
			String: sParShow
			! sParShow:
					  N-Show pbNew  - Відправити
					  I-Show pbIn   - Внести (Повідомити)
					  B-Show pbBack - Вилучити
					  W-Show pbWait - Відкласти
					  5-Not Show pbFMPar
					  6-Not Show pbHistory
					  7-редактировать пар-ры любого юзера, иначе-только свои "отказать", "отложить", править пар-ры
					  O-операционист, спрятать колонку "Статус"
					  C-по кнопке "Внести (повідомити)" необходимо заполнить комментарий
			String: sFilter
		Window Variables
			: cDF
				Class: cGenDFilterEx
			: cF
				Class: cGenFilterEx
			Number: nUserId
			Date/Time: dBDat
			Date/Time: dDat1
			Date/Time: dDat2
			Number: nFM_GRP2
			Boolean: bFM_DFLTR
			Boolean: bFM_HRULES
			Number: nIndex
			Number: nMaxDig
			Number: nRow
			Number: nOrderBy
			Window Handle: hColumn
			Number: i
			Number: nRulesCount
			String: sComments
			Boolean: bParNew
			Boolean: bParIn
			Boolean: bParBack
			Boolean: bParWait
			Boolean: bParNotFMPar
			Boolean: bParNotHistory
			Boolean: bParEditPar
			Boolean: bParOper
			Boolean: bParComm
			Boolean: bParUnBlock
			Boolean: bParRefT
			String: sStrSelect
			String: sStrInto
			String: sStrFrom
			String: sStrFilter
			String: sStrFilterVdat
			String: sFMRulesFilter
			String: sFMRulesList
			Number: nFMRulesApply[*]
		Message Actions
			On SAM_Create
				Call PrepareWindow(hWndForm)
				Call SetWindowFullSize(hWndForm)
				!
				Set dBDat      = GetBankDate()
				Set nUserId    = GetUserId()
				Set nFM_GRP2   = GetGlobalOptionEx('FM_GRP2')
				Set bFM_DFLTR  = GetGlobalOptionEx('FM_DFLTR')=1
				Set bFM_HRULES = GetGlobalOptionEx('FM_HRULES') = 1
				Set nOrderBy = 1
				Set bParNew        = IifN(SalStrScan(sParShow,'N')=-1,0,1) ! Разрешить pbNew
				Set bParIn         = IifN(SalStrScan(sParShow,'I')=-1,0,1) ! Разрешить pbIn
				Set bParBack       = IifN(SalStrScan(sParShow,'B')=-1,0,1) ! Разрешить pbBack
				Set bParWait       = IifN(SalStrScan(sParShow,'S')=-1,0,1) ! Разрешить pbWait
				Set bParNotFMPar   = IifN(SalStrScan(sParShow,'5')=-1,0,1) ! Запретить pbFMPar
				Set bParNotHistory = IifN(SalStrScan(sParShow,'6')=-1,0,1) ! Запретить pbHistory
				Set bParEditPar    = IifN(SalStrScan(sParShow,'7')=-1,0,1) ! 1-Редакт. пар-ры любого usera, 0(7 нет)-только свои
				Set bParOper       = IifN(SalStrScan(sParShow,'O')=-1,0,1) ! операционист, спрятать колонку "Статус"
				Set bParComm       = IifN(SalStrScan(sParShow,'C')=-1,0,1) ! по кнопке "Внести (повідомити)" необходимо заполнить комментарий
				Set bParUnBlock    = IifN(SalStrScan(sParShow,'U')=-1,0,1) ! Разрешить разблокировать документ
				Set bParRefT       = IifN(SalStrScan(sParShow,'T')=-1,0,1) ! Разрешить смотреть инф. по террористу
				Call SalDisableWindow(pbUnStop)
				Call SalDisableWindow(pbRefT)
				If not nParEdit
					Call SalDisableWindow(pbNew)
					Call SalDisableWindow(pbIn)
					Call SalDisableWindow(pbBack)
					Call SalDisableWindow(pbWait)
				Else
					If not bParNew
						Call SalDisableWindow(pbNew)
					If not bParIn
						Call SalDisableWindow(pbIn)
					If not bParBack
						Call SalDisableWindow(pbBack)
					If not bParWait
						Call SalDisableWindow(pbWait)
				If bParNotFMPar
					Call SalDisableWindow(pbFMPar)
				If bParNotHistory
					Call SalDisableWindow(pbHistory)
				If bParOper
					Call SalHideWindow(colStatus)
					Call SalHideWindow(colOtm)
					Call SalDisableWindow(pbUnStop)
					Call SalDisableWindow(pbRefT)
				Else
					If GetGlobalOption('BANKTYPE') = 'SBER'
						Call SalShowWindow(colVid2)
						Call SalShowWindow(colVid3)
				If not bParUnBlock
					Call SalDisableWindow(pbUnStop)
				If not bParRefT
					Call SalDisableWindow(pbRefT)
					Call SalHideWindow(colOtm)
				!
				Call SqlPrepareAndExecute(hSql(), "select dat_next_u(:dBDat,-1) into :dfVDat1 from dual")
				Call SqlFetchNext(hSql(), nFetchRes)
				Set dfVDat2 = dfVDat1
				!
				Set nRulesCount = 0
				Set sFMRulesList = ""
				Set sFMRulesFilter = ""
				Call SqlPrepareAndExecute(hSql(), "select id into :i from fm_rules")
				While SqlFetchNext(hSql(), nFetchRes)
					Set nFMRulesApply[i] = 0
					Set nRulesCount = nRulesCount + 1
				If not nRulesCount
					Call SalHideWindow(colRules)
					Call SalHideWindow(pbShowRules)
					Call SalHideWindow(pbFMFilter)
					Call SalHideWindowAndLabel(bgVDat)
					Call SalHideWindow(dfVDat1)
					Call SalHideWindow(dfVDat2)
				!
				Set hWndForm.Tbl_FMDoc.nTabInstance = 1
				Set hWndForm.Tbl_FMDoc.nFlags = GT_NoDel | GT_NoIns
				Set hWndForm.Tbl_FMDoc.fFilterAtStart = TRUE
				Set hWndForm.Tbl_FMDoc.strFilterTblName = 'V_FINMON_QUE'
				Set hWndForm.Tbl_FMDoc.strPrintFileName = 'FM_DOC'
				Set sStrSelect =
						"SELECT v_finmon_que.id, v_finmon_que.ref, v_finmon_que.rec, v_finmon_que.tt, v_finmon_que.nd, v_finmon_que.datd, v_finmon_que.pdat, 
						        v_finmon_que.nlsa, v_finmon_que.s,  v_finmon_que.kv,  v_finmon_que.lcv,  v_finmon_que.mfoa, v_finmon_que.nam_a, 
						        v_finmon_que.nlsb, v_finmon_que.s2, v_finmon_que.kv2, v_finmon_que.lcv2, v_finmon_que.mfob, v_finmon_que.nam_b, 
						        v_finmon_que.sk, v_finmon_que.vdat, v_finmon_que.nazn,
						        v_finmon_que.tobo, v_finmon_que.sos, v_finmon_que.id_a, v_finmon_que.id_b, 
						        v_finmon_que.dig, v_finmon_que.dig2, v_finmon_que.status, 
						        v_finmon_que.opr_vid1, v_finmon_que.opr_vid2, v_finmon_que.comm_vid2, 
						        v_finmon_que.opr_vid3, v_finmon_que.comm_vid3, v_finmon_que.monitor_mode, 
						        v_finmon_que.agent_id, v_finmon_que.fio, v_finmon_que.in_date, v_finmon_que.rnk_a, v_finmon_que.rnk_b, 
						        v_finmon_que.blk, v_finmon_que.otm, v_finmon_que.comments,
						        gl.p_icurval(nvl(v_finmon_que.kv,980), nvl(v_finmon_que.s,0), v_finmon_que.vdat)/100,
						        v_finmon_que.nmka, v_finmon_que.nmkb, 1"
				Set sStrInto =
						"  INTO :hWndForm.Tbl_FMDoc.colId,   :hWndForm.Tbl_FMDoc.colRef,  :hWndForm.Tbl_FMDoc.colRec,:hWndForm.Tbl_FMDoc.colTT, :hWndForm.Tbl_FMDoc.colNd,  
						        :hWndForm.Tbl_FMDoc.colDatD, :hWndForm.Tbl_FMDoc.colPDat, 
						        :hWndForm.Tbl_FMDoc.colNlsa, :hWndForm.Tbl_FMDoc.colS,  :hWndForm.Tbl_FMDoc.colKv,  :hWndForm.Tbl_FMDoc.colLcv,  :hWndForm.Tbl_FMDoc.colMfoa, :hWndForm.Tbl_FMDoc.colNama,
						        :hWndForm.Tbl_FMDoc.colNlsb, :hWndForm.Tbl_FMDoc.colS2, :hWndForm.Tbl_FMDoc.colKv2, :hWndForm.Tbl_FMDoc.colLcv2, :hWndForm.Tbl_FMDoc.colMfob, :hWndForm.Tbl_FMDoc.colNamb,
						        :hWndForm.Tbl_FMDoc.colSK,   :hWndForm.Tbl_FMDoc.colVDat, :hWndForm.Tbl_FMDoc.colNazn,
						        :hWndForm.Tbl_FMDoc.colBranch, :hWndForm.Tbl_FMDoc.colSOS, 
						        :hWndForm.Tbl_FMDoc.colOkpoA, :hWndForm.Tbl_FMDoc.colOkpoB, 
						        :hWndForm.Tbl_FMDoc.colDig,  :hWndForm.Tbl_FMDoc.colDig2, :hWndForm.Tbl_FMDoc.colStatusId, 
						        :hWndForm.Tbl_FMDoc.colVid1, :hWndForm.Tbl_FMDoc.colVid2, :hWndForm.Tbl_FMDoc.colComm2, 
						        :hWndForm.Tbl_FMDoc.colVid3, :hWndForm.Tbl_FMDoc.colComm3, :hWndForm.Tbl_FMDoc.colMode, 
						        :hWndForm.Tbl_FMDoc.colAgentId, :hWndForm.Tbl_FMDoc.colAgentFIO, :hWndForm.Tbl_FMDoc.colAgentDat, 
						        :hWndForm.Tbl_FMDoc.colRnkA, :hWndForm.Tbl_FMDoc.colRnkB, 
						        :hWndForm.Tbl_FMDoc.colBlk,  :hWndForm.Tbl_FMDoc.colOtm,  :hWndForm.Tbl_FMDoc.colComments,
						        :hWndForm.Tbl_FMDoc.colSEqv, :hWndForm.Tbl_FMDoc.colNmka, :hWndForm.Tbl_FMDoc.colNmkb, :hWndForm.Tbl_FMDoc.colDocCount"
				Set sStrFrom =
						"  FROM v_finmon_que "
				Set nMaxDig = DigInit()
				Call SalSendClassMessage(SAM_Create, 0, 0)
				If bFM_DFLTR
					Call cDF.Init(strFilterTblName, strFilterTblName)
				Else
					Call cF.Init(strFilterTblName, strFilterTblName)
			On SAM_CreateComplete
				If nRulesCount
					If not bFM_HRULES
						Call GetFMFilter()
				Else
					If bFM_DFLTR
						Call hWndForm.Tbl_FMDoc.cDF.cNewFilter.NewString('', -1, 'PDAT', -1, 'v_finmon_que', '=', SalFmtFormatDateTime(SalDateCurrent(), 'dd/MM/yyyy'), 'Документы введенные сегодня ')
					Else
						Call hWndForm.Tbl_FMDoc.cF.NewString('', -1, 'PDAT', -1, 'v_finmon_que', '=', SalFmtFormatDateTime(SalDateCurrent(), 'dd/MM/yyyy'), 'Документы введенные сегодня ')
				Call SalSendClassMessage(SAM_CreateComplete, 0, 0)
			On UM_Populate
				If fFilterAtStart
					If bFM_DFLTR
						If SetQueryDFilterEx(cDF)
							Set fFilterAtStart = NOT fFilterAtStart
					Else
						If SetQueryFilterEx(cF)
							Set fFilterAtStart = NOT fFilterAtStart
				If NOT fFilterAtStart
					Call SalWaitCursor(TRUE)
					Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
					! sStrFilterVdat - Фильтр на даты ФМ
					Set sStrFilterVdat = IifS(nRulesCount=0, "", IifS(dfVDat1=dfVDat2, 
							    "v_finmon_que.vdat = :dfVDat1", 
							    "v_finmon_que.vdat between :dfVDat1 and :dfVDat2") )
					! sFMRulesFilter - Фильр на правила ФМ
					If sFMRulesList
						Call SalShowWindow(colRules)
						Set strDSql = sStrSelect || ", r.rules" ||
								    sStrInto || ", :hWndForm.Tbl_FMDoc.colRules" ||
								    sStrFrom || ", tmp_fm_checkrules r"
						Set sFMRulesFilter = "v_finmon_que.ref = r.ref and r.id = user_id"
						! если правило одно, показываемего наименование
						If SalStrScan(sFMRulesList, ',') = -1
							Call SqlPrepareAndExecute(hSql(), "select name into :dfRuleName from fm_rules where id = :sFMRulesList")
							Call SqlFetchNext(hSql(), nFetchRes)
						Else
							Set dfRuleName = ''
					Else
						Call SalHideWindow(colRules)
						Set strDSql = sStrSelect || sStrInto || sStrFrom
						Set sFMRulesFilter = ""
						Set dfRuleName = ''
					! sStrFilter - Фильтр на таблицу
					If bFM_DFLTR
						Set sStrFilter = cDF.GetFilterWhereClause(FALSE)
					Else
						Set sStrFilter = cF.GetFilterWhereClause(FALSE)
					Set sStrFilter = IifS(sStrFilter='', "", "(" || sStrFilter || ")")  
					! Формируем весь фильтр
					! sFilter - фильтр из ком.строки вызова
					Set sStrFilter = sStrFilter || IifS(sStrFilter='', "", IifS(sFilter='', "", " and ")) || IifS(sFilter='', "", "(" || sFilter || ")")  
					Set sStrFilter = sStrFilter || IifS(sStrFilter='', "", IifS(sStrFilterVdat='', "", " and ")) || sStrFilterVdat
					Set sStrFilter = sStrFilter || IifS(sStrFilter='', "", IifS(sFMRulesFilter='', "", " and ")) || sFMRulesFilter
					!
					Set strDSql = strDSql ||
							    IifS(sStrFilter='', "", " where " || sStrFilter) ||
							    " ORDER BY v_finmon_que.ref, v_finmon_que.rec"
					Call SaveInfoToLog(strDSql)
					Call BindList.ActivateBinds()
					Call SalTblPopulate(hWndForm, hSql(), strDSql, TBL_FillAll)
					Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
					Set dfDocCount = SalTblColumnSum(hWndForm, SalTblQueryColumnID(colDocCount), 0, 0)
					Call SalTblSetContext(hWndForm, 0)
					Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
					Call SalWaitCursor(FALSE)
				Else
					Call SalDestroyWindow( hWndForm )
			On UM_Update
				Call SalWaitCursor(TRUE)
				Call SaveInfoToLog(MSG_SaveDataRef() || ' ' || strTitleAux)
				Set nRow = TBL_MinRow
				While SalTblFindNextRow(hWndForm, nRow, ROW_Edited, 0)
					Call SalTblSetContext(hWndForm, nRow)
					Set strSqlUpdate =
							"p_fm_set_status(hWndForm.Tbl_FMDoc.colRef, hWndForm.Tbl_FMDoc.colRec, 
							 hWndForm.Tbl_FMDoc.colStatusId_New, hWndForm.Tbl_FMDoc.colComments, hWndForm.Tbl_FMDoc.colBlk)"
					If SqlPLSQLCommand(hSql(), strSqlUpdate)
						Call SqlCommitEx(hSql(), "FM. Установлен статус '" || hWndForm.Tbl_FMDoc.colStatusId_New || "' для документа " || 
								     IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, "REF", "REC") || 
								     IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRef), Str(hWndForm.Tbl_FMDoc.colRec)) )
					Else
						Call SqlRollbackEx(hSql(), "FM. Не удалось изменить статус документа " || 
								     IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, "REF", "REC") || 
								     IifS(hWndForm.Tbl_FMDoc.colRef!=NUMBER_Null, Str(hWndForm.Tbl_FMDoc.colRef), Str(hWndForm.Tbl_FMDoc.colRec)) )
				Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
				Call SalWaitCursor(FALSE)
			On SAM_FetchRowDone
				! Раскрасить таблицу по SOS
				If colRef
					Select Case colSOS
						Case DOC_PAY_BACK
						Case DOC_PAY_STORNO
							Call VisTblSetRowColor(hWndForm, lParam, COLOR_Red)
							Break
						Case DOC_PAY_BOOKED
							Call VisTblSetRowColor(hWndForm, lParam, COLOR_DarkGreen)
							Break
						Case DOC_PAY_FEATURE
							Call VisTblSetRowColor(hWndForm, lParam, COLOR_Blue)
							Break
						Default
							Break
				! Раскрасить колонку статуса 
				If colStatusId != ''
					Call colStatus.SetSelectById(colStatusId)
				If colStatusId = 'N' OR  colStatusId = 'T'
					Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_DarkGreen, FALSE)
				Else If colStatusId = 'I'
					Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_Blue, FALSE)
				Else If colStatusId = 'S'
					Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_DarkBlue, FALSE)
				Else If colStatusId = 'R'
					Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_DarkRed, FALSE)
				Else If colStatusId = 'B' OR colStatusId = 'D'
					Call SalTblSetCellTextColor(hWndForm.Tbl_FMDoc.colStatus, COLOR_DarkGray, FALSE)
				If colOtm > 0 or colBlk = 131313 or colBlk = 131312
					Call XSalTblSetRowBackColor(hWndForm, lParam, SalColorFromRGB(255,200,200))
				Set colSs  = Dig4(colS/100,  colDig,  4)
				Set colS2s = Dig4(colS2/100, colDig2, 4)
			On SAM_RowSetContext
				If nParEdit
					If bParNew
						Call SalEnableWindow(pbNew)
					If bParIn
						Call SalEnableWindow(pbIn)
					If bParBack
						Call SalEnableWindow(pbBack)
					If bParWait
						Call SalEnableWindow(pbWait)
					!
					! If colStatusId = 'B' OR colStatusId = 'D'
						        Call SalDisableWindow(pbNew)
						        Call SalDisableWindow(pbIn)
						        Call SalDisableWindow(pbBack)
						        Call SalDisableWindow(pbWait)
					If colStatusId = ''
						Call SalDisableWindow(pbBack)
					Else If colStatusId = 'B'
						Call SalDisableWindow(pbBack)
					Else If colStatusId = 'D'
						Call SalDisableWindow(pbNew)
						Call SalDisableWindow(pbIn)
						Call SalDisableWindow(pbBack)
						Call SalDisableWindow(pbWait)
					Else If colStatusId = 'I'
						Call SalDisableWindow(pbIn)
					Else If colStatusId = 'S'
						Call SalDisableWindow(pbWait)
					Else If colStatusId = 'N' OR colStatusId = 'T'
						Call SalDisableWindow(pbNew)
						Call SalDisableWindow(pbIn)
						Call SalDisableWindow(pbBack)
						Call SalDisableWindow(pbWait)
					!
					If colVid2 = '' AND colVid3 = '' AND NOT bParNotFMPar
						Call SalDisableWindow(pbNew)
						Call SalDisableWindow(pbIn)
					!
					If colAgentId = nUserId OR colAgentId = NUMBER_Null
					Else If NOT bParEditPar
						Call SalDisableWindow(pbIn)
						Call SalDisableWindow(pbBack)
						Call SalDisableWindow(pbWait)
					!
					If not bParOper
						If colOtm > 0 or colBlk = 131313
							Call SalEnableWindow(pbUnStop)
							If colOtm > 0
								Call SalEnableWindow(pbRefT)
						Else
							Call SalDisableWindow(pbUnStop)
							Call SalDisableWindow(pbRefT)
					!
					If not bParUnBlock
						Call SalDisableWindow(pbUnStop)
					If not bParRefT
						Call SalDisableWindow(pbRefT)
			On SAM_ColumnSelectClick
				Call SalWaitCursor(TRUE)
				Set nOrderBy = NOT nOrderBy
				Set hColumn = SalNumberToWindowHandle(wParam)
				Call SalTblSetColumnFlags(hColumn, COL_Selected, FALSE)
				If SalNumberToWindowHandle(wParam) = SalTblGetColumnWindow(hWndForm, SalTblQueryColumnID(colSs), COL_GetID)
					Set wParam = SalWindowHandleToNumber(SalTblGetColumnWindow(hWndForm, SalTblQueryColumnPos(colS), COL_GetID))
				If SalNumberToWindowHandle(wParam) = SalTblGetColumnWindow(hWndForm, SalTblQueryColumnID(colS2s), COL_GetID)
					Set wParam = SalWindowHandleToNumber(SalTblGetColumnWindow(hWndForm, SalTblQueryColumnPos(colS2), COL_GetID))
				Set hColumn = SalNumberToWindowHandle(wParam)
				Call SalTblSortRows(hWndForm, SalTblQueryColumnID(hColumn), nOrderBy)
				Call SalTblSetFocusRow(hWndForm, 0)
				Call SalSendMsg(hWndForm, SAM_RowSetContext, 0, 0)
				!
				Call SalWaitCursor(FALSE)
			On SAM_RowHeaderClick
				If colOtm > 0 or colBlk = 131313 or colBlk = 131312
					Call XSalTooltipSetColors(COLOR_Black, SalColorFromRGB(255,200,200))
					Call XSalTooltipShow(hWndForm, 'Блоковано на оплату')
					Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
			On SAM_DoubleClick
				If colRef > 0
					Call DocViewContentsEx(hWndMDI, Tbl_FMDoc.colRef)
				Else If colRec > 0
					Call DocViewContents(hWndMDI, Tbl_FMDoc.colRec)
			On UM_Print
				If strPrintFileName
					Call SalGetWindowText(hWndForm, strOldTitle, 99)
					Call TablePrint(hWndForm, strOldTitle, GetPrnDir() || '\\' || strPrintFileName, '')
	Table Window: Tbl_FMHistory
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Історія змін
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
				Width:  13.7"
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
					Resource Id: 30878
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
					Resource Id: 30879
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
					Resource Id: 30880
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
			Column: colMDate
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Дата
						модифікації
				Visible? Yes
				Editable? No
				Maximum Data Length: Default
				Data Type: Date/Time
				Justify: Center
				Width:  1.6"
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
			Column: colMType
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Тип
						модификации
				Visible? No
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
			Column: colMTypeName
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
			Column: colUserId
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ІД
						користувача
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
			Column: colUserName
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: ПІБ
						користувача
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
			Column: colMValue
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Старе значення
				Visible? Yes
				Editable? No
				Maximum Data Length: 1000
				Data Type: Long String
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
			Number: nId
			Number: nND
		Window Variables
		Message Actions
			On SAM_Create
				Call PrepareWindow(hWndForm)
				Call SetWindowFullSize(hWndForm)
				Set hWndForm.Tbl_FMHistory.nFlags = GT_ReadOnly
				Set hWndForm.Tbl_FMHistory.strPrintFileName = 'FM_HIST'
				Set hWndForm.Tbl_FMHistory.strTitleAux = 'док.№ ' || Str(nND)
				Set hWndForm.Tbl_FMHistory.strSqlPopulate = 
						"SELECT f.mod_date, f.mod_type, t.mod_name, 
						        f.user_id, f.user_name, substr(f.mod_value,1,1000) 
						 INTO :hWndForm.Tbl_FMHistory.colMDate, :hWndForm.Tbl_FMHistory.colMType, 
						      :hWndForm.Tbl_FMHistory.colMTypeName, :hWndForm.Tbl_FMHistory.colUserId, 
						      :hWndForm.Tbl_FMHistory.colUserName, :hWndForm.Tbl_FMHistory.colMValue 
						 FROM finmon_que_modification f, finmon_que_modtype t 
						 WHERE f.mod_type=t.mod_type AND f.id=:hWndForm.Tbl_FMHistory.nId"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On UM_Populate
				Call SqlSetLongBindDatatype(7, 22)
				Call SalSendClassMessage(UM_Populate, 0, 0)
				Call VisTblAutoSizeColumn(hWndForm, hWndNULL)
	Dialog Box: Dlg_FMPar
		Class:
		Property Template:
		Class DLL Name:
		Title: Параметри фінансового моніторингу
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  10.0"
				Width Editable? Yes
				Height: 5.5"
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
			Data Field: dfMfoA
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
						Left:   0.1"
						Top:    0.08"
						Width:  1.2"
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
			Data Field: dfNlsA
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
						Left:   1.3"
						Top:    0.083"
						Width:  1.8"
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
			Data Field: dfNamA
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
						Left:   3.1"
						Top:    0.083"
						Width:  6.7"
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
			Data Field: dfMfoB
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
						Left:   0.1"
						Top:    0.333"
						Width:  1.2"
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
			Data Field: dfNlsB
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
						Left:   1.3"
						Top:    0.333"
						Width:  1.8"
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
			Data Field: dfNamB
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
						Left:   3.1"
						Top:    0.333"
						Width:  6.7"
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
			Data Field: dfPDat
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
						Left:   0.1"
						Top:    0.619"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: dd/MM/yyyy
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
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
						Left:   1.3"
						Top:    0.619"
						Width:  1.8"
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
			Data Field: dfKv
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
						Left:   3.1"
						Top:    0.619"
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
					Maximum Data Length: Default
					Data Type: String
					Editable? No
				Display Settings
					Window Location and Size
						Left:   3.7"
						Top:    0.619"
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
			Group Box: Ознаки повідомлення
				Resource Id: 36829
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.067"
					Top:    1.0"
					Width:  9.7"
					Width Editable? Yes
					Height: 3.4"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Check Box: cbDFM_02
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cCheckBoxLabeled
				Property Template:
				Class DLL Name:
				Title: Обов'язковий моніторинг
				Window Location and Size
					Left:   0.3"
					Top:    1.2"
					Width:  3.0"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						Set cbDFM_02 = TRUE
						If cbDFM_02
							Set cbDFM_03 = FALSE
							Set dfDFM_03 = ''
							Set dfNameDFM_03 = ''
							Set dfCommDFM_03 = ''
							Call SalSendMsg(dfDFM_03, SAM_User, 0, 0)
							Call SalDisableWindow(dfDFM_03)
							Call SalDisableWindow(dfCommDFM_03)
							Call SalDisableWindow(pbDFM_03)
							Set rbDFM_02A = TRUE
							Set rbDFM_02B = TRUE
							If nParEdit
								Call SalEnableWindow(dfDFM_02)
								Call SalEnableWindow(dfCommDFM_02)
								Call SalEnableWindow(pbDFM_02)
			Radio Button: rbDFM_02A
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Сторона А
				Window Location and Size
					Left:   0.6"
					Top:    1.452"
					Width:  1.4"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						If rbDFM_02A OR rbDFM_02B
							Set cbDFM_02 = TRUE
							Call SalEnableWindow(dfDFM_02)
							Call SalEnableWindow(dfCommDFM_02)
							Call SalEnableWindow(pbDFM_02)
							If dfDFM_02 != '' and dfDFM_02 != '0000'
								Call SalEnableWindow(pbAddDFM_02)
							If rbDFM_02A AND rbDFM_02B
								Set cbDFM_03 = FALSE
								Set dfDFM_03 = ''
								Set dfNameDFM_03 = ''
								Set dfCommDFM_03 = ''
								Call SalSendMsg(dfDFM_03, SAM_User, 0, 0)
								Call SalDisableWindow(dfDFM_03)
								Call SalDisableWindow(dfCommDFM_03)
								Call SalDisableWindow(pbDFM_03)
								Call SalDisableWindow(pbAddDFM_03)
			Radio Button: rbDFM_03A
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Сторона А
				Window Location and Size
					Left:   0.6"
					Top:    2.25"
					Width:  1.4"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						If rbDFM_03A OR rbDFM_03B
							Set cbDFM_03 = TRUE
							Call SalEnableWindow(dfDFM_03)
							Call SalEnableWindow(dfCommDFM_03)
							Call SalEnableWindow(pbDFM_03)
							If dfDFM_03 != '' and dfDFM_03 != '000'
								Call SalEnableWindow(pbAddDFM_03)
							If rbDFM_03A AND rbDFM_03B
								Set cbDFM_02 = FALSE
								Set dfDFM_02 = ''
								Set dfNameDFM_02 = ''
								Set dfCommDFM_02 = ''
								Call SalSendMsg(dfDFM_02, SAM_User, 0, 0)
								Call SalDisableWindow(dfDFM_02)
								Call SalDisableWindow(dfCommDFM_02)
								Call SalDisableWindow(pbDFM_02)
								Call SalDisableWindow(pbAddDFM_02)
			Check Box: cbDFM_03
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cCheckBoxLabeled
				Property Template:
				Class DLL Name:
				Title: Внутрішній моніторинг
				Window Location and Size
					Left:   0.3"
					Top:    2.0"
					Width:  3.0"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						Set cbDFM_03 = TRUE
						If cbDFM_03
							Set cbDFM_02 = FALSE
							Set dfDFM_02 = ''
							Set dfNameDFM_02 = ''
							Set dfCommDFM_02 = ''
							Call SalSendMsg(dfDFM_02, SAM_User, 0, 0)
							Call SalDisableWindow(dfDFM_02)
							Call SalDisableWindow(dfCommDFM_02)
							Call SalDisableWindow(pbDFM_02)
							Set rbDFM_03A = TRUE
							Set rbDFM_03B = TRUE
							If nParEdit
								Call SalEnableWindow(dfDFM_03)
								Call SalEnableWindow(dfCommDFM_03)
								Call SalEnableWindow(pbDFM_03)
			Radio Button: rbDFM_02B
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Сторона Б
				Window Location and Size
					Left:   0.6"
					Top:    1.7"
					Width:  1.4"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						If rbDFM_02A OR rbDFM_02B
							Set cbDFM_02 = TRUE
							Call SalEnableWindow(dfDFM_02)
							Call SalEnableWindow(dfCommDFM_02)
							Call SalEnableWindow(pbDFM_02)
							If dfDFM_02 != '' and dfDFM_02 != '0000'
								Call SalEnableWindow(pbAddDFM_02)
							If rbDFM_02A AND rbDFM_02B
								Set cbDFM_03 = FALSE
								Set dfDFM_03 = ''
								Set dfNameDFM_03 = ''
								Set dfCommDFM_03 = ''
								Call SalSendMsg(dfDFM_03, SAM_User, 0, 0)
								Call SalDisableWindow(dfDFM_03)
								Call SalDisableWindow(dfCommDFM_03)
								Call SalDisableWindow(pbDFM_03)
								Call SalDisableWindow(pbAddDFM_03)
			Radio Button: rbDFM_03B
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Сторона Б
				Window Location and Size
					Left:   0.6"
					Top:    2.5"
					Width:  1.4"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						If rbDFM_03A OR rbDFM_03B
							Set cbDFM_03 = TRUE
							Call SalEnableWindow(dfDFM_03)
							Call SalEnableWindow(dfCommDFM_03)
							Call SalEnableWindow(pbDFM_03)
							If dfDFM_03 != '' and dfDFM_03 != '000'
								Call SalEnableWindow(pbAddDFM_03)
							If rbDFM_03A AND rbDFM_03B
								Set cbDFM_02 = FALSE
								Set dfDFM_02 = ''
								Set dfNameDFM_02 = ''
								Set dfCommDFM_02 = ''
								Call SalSendMsg(dfDFM_02, SAM_User, 0, 0)
								Call SalDisableWindow(dfDFM_02)
								Call SalDisableWindow(dfCommDFM_02)
								Call SalDisableWindow(pbDFM_02)
								Call SalDisableWindow(pbAddDFM_02)
			Data Field: dfDFM_02
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
						Left:   3.5"
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
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Return VALIDATE_Ok
					On SAM_User
						If dfDFM_02 = ''
							Set dfDFM_02 = '0000'
						If dfDFM_02
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT substr(name,1,254) INTO :dfNameDFM_02 
									 FROM K_DFM02 WHERE code=:dfDFM_02")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfDFM_02 = ''
								Set dfNameDFM_02 = ''
						If nId
							If dfDFM_02 = '0000' or dfDFM_02 = ''
								Call SalDisableWindow(pbAddDFM_02)
							Else
								Call SalEnableWindow(pbAddDFM_02)
			Data Field: dfNameDFM_02
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
						Left:   4.55"
						Top:    1.202"
						Width:  4.65"
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
			Pushbutton: pbDFM_02
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.25"
					Top:    1.2"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM02", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code",sPK, sPKName)
							Set dfDFM_02 = sPK
							Set dfNameDFM_02 = sPKName
							Call SalEnableWindow(pbSave)
							If nId
								If dfDFM_02 = '0000' or dfDFM_02 = ''
									Call SalDisableWindow(pbAddDFM_02)
								Else
									Call SalEnableWindow(pbAddDFM_02)
			Data Field: dfCommDFM_02
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
						Left:   3.5"
						Top:    1.5"
						Width:  5.7"
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
						Call SalEnableWindow(pbSave)
			Pushbutton: pbAddDFM_02
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.233"
					Top:    1.5"
					Width:  0.35"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\POP.BMP
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Додатково')
					On SAM_Click
						Call SalModalDialog(Dlg_AddVid, hWndForm, nId, 2, nParEdit)
			Data Field: dfDFM_03
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
						Left:   3.4"
						Top:    2.0"
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
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Return VALIDATE_Ok
					On SAM_User
						If dfDFM_03 = ''
							Set dfDFM_03 = '000'
						If dfDFM_03
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT substr(name,1,254) INTO :dfNameDFM_03 
									 FROM K_DFM03 WHERE code=:dfDFM_03 and D_CLOSE Is Null")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfDFM_03 = ''
								Set dfNameDFM_03 = ''
						If nId
							If dfDFM_03 = '000' or dfDFM_03 = ''
								Call SalDisableWindow(pbAddDFM_03)
							Else
								Call SalEnableWindow(pbAddDFM_03)
			Data Field: dfNameDFM_03
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
						Left:   4.55"
						Top:    2.0"
						Width:  4.65"
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
			Pushbutton: pbDFM_03
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.25"
					Top:    2.0"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM03", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfDFM_03 = sPK
							Set dfNameDFM_03 = sPKName
							Call SalEnableWindow(pbSave)
							If nId
								If dfDFM_03 = '000' or dfDFM_03 = ''
									Call SalDisableWindow(pbAddDFM_03)
								Else
									Call SalEnableWindow(pbAddDFM_03)
			Data Field: dfCommDFM_03
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
						Left:   3.5"
						Top:    2.3"
						Width:  5.7"
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
						Call SalEnableWindow(pbSave)
			Pushbutton: pbAddDFM_03
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbFilter
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.267"
					Top:    2.298"
					Width:  0.35"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\POP.BMP
				Picture Transparent Color: Class Default
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Додатково')
					On SAM_Click
						Call SalModalDialog(Dlg_AddVid, hWndForm, nId, 3, nParEdit)
			Group Box: Режим моніторингу клієнтів
				Resource Id: 3322
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.067"
					Top:    2.8"
					Width:  9.7"
					Width Editable? Yes
					Height: 1.1"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Radio Button: rbA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Сторона А
				Window Location and Size
					Left:   0.3"
					Top:    3.0"
					Width:  2.0"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						Call SalEnableWindow(pbCustomerA)
						Set dfOkpoB = STRING_Null
						Set dfRnkB  = NUMBER_Null
						Set dfNameB = STRING_Null
						Call SalDisableWindow(pbCustomerB)
						Set cbDFM_02 = TRUE
						Call SalSendMsg(cbDFM_02, SAM_Click, 0, 0)
						Call SalEnableWindow(cbDFM_02)
						Call SalEnableWindow(cbDFM_03)
						Call SalHideWindow(rbDFM_02A)
						Call SalHideWindow(rbDFM_02B)
						Call SalHideWindow(rbDFM_03A)
						Call SalHideWindow(rbDFM_03B)
			Radio Button: rbB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Сторона Б
				Window Location and Size
					Left:   0.3"
					Top:    3.3"
					Width:  2.0"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						Call SalEnableWindow(pbCustomerB)
						Set dfOkpoA = STRING_Null
						Set dfRnkA  = NUMBER_Null
						Set dfNameA = STRING_Null
						Call SalDisableWindow(pbCustomerA)
						Set cbDFM_02 = TRUE
						Call SalSendMsg(cbDFM_02, SAM_Click, 0, 0)
						Call SalEnableWindow(cbDFM_02)
						Call SalEnableWindow(cbDFM_03)
						Call SalHideWindow(rbDFM_02A)
						Call SalHideWindow(rbDFM_02B)
						Call SalHideWindow(rbDFM_03A)
						Call SalHideWindow(rbDFM_03B)
			Radio Button: rbAB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cRadioButtonLabeled
				Property Template:
				Class DLL Name:
				Title: Обидва
				Window Location and Size
					Left:   0.3"
					Top:    3.6"
					Width:  2.0"
					Width Editable? Class Default
					Height: 0.25"
					Height Editable? Class Default
				Visible? Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(pbSave)
						Call SalEnableWindow(pbCustomerA)
						Call SalEnableWindow(pbCustomerB)
						Call SalShowWindow(rbDFM_02A)
						Call SalShowWindow(rbDFM_02B)
						Call SalShowWindow(rbDFM_03A)
						Call SalShowWindow(rbDFM_03B)
						Set cbDFM_02  = TRUE
						Set rbDFM_02A = TRUE
						Set rbDFM_02B = TRUE
						Call SalSendMsg(rbDFM_02A, SAM_Click, 0, 0)
			Data Field: dfOkpoA
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
						Left:   3.5"
						Top:    3.0"
						Width:  1.2"
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
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'ЗКПО-А')
			Data Field: dfRnkA
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
						Left:   4.75"
						Top:    3.0"
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
					On SAM_Create
						If not SalIsNull(dfRnkA)
							Call getClientByRnk(dfRnkA, dfOkpoA, dfNameA)
						Else
							Call getClientByAcc(dfMfoA, dfNlsA, nKv, dfRnkA, dfNameA, dfOkpoA)
						If SalIsNull(dfRnkA)
							Call getClientByOkpo(sId_A, dfRnkA, dfNameA, dfOkpoA)
			Data Field: dfNameA
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
						Left:   5.8"
						Top:    3.0"
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
			! ctb_pbHelp: pbCustomerA
.winattr class Pushbutton:
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.25"
					Top:    3.0"
					Width:  0.43"
					Width Editable? No
					Height: 0.317"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: F1
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: Gray
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
.end
				            Message Actions 
					            On SAM_TooltipSetText
						            Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					            On SAM_Click
						            If FunNSIGetFiltered("V_CUSTOMER_FM", "", " okpo is not null ORDER BY nmk", sPK, sPKName)
							            Set dfRnkA = Val(sPK)
							            Call SalSendMsg(dfRnkA, SAM_Create, 0, 0)
							            Call SalEnableWindow(pbSave)
			Pushbutton: pbCustomerA
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.25"
					Top:    3.0"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("V_CUSTOMER_FM", "", " okpo is not null ORDER BY nmk", sPK, sPKName)
							Set dfRnkA = Val(sPK)
							Call SalSendMsg(dfRnkA, SAM_Create, 0, 0)
							Call SalEnableWindow(pbSave)
			Data Field: dfOkpoB
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
						Left:   3.5"
						Top:    3.3"
						Width:  1.2"
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
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'ЗКПО-Б')
			Data Field: dfRnkB
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
						Left:   4.75"
						Top:    3.298"
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
					On SAM_Create
						If not SalIsNull(dfRnkB)
							Call getClientByRnk(dfRnkB, dfOkpoB, dfNameB)
						Else
							Call getClientByAcc(dfMfoB, dfNlsB, nKv2, dfRnkB, dfNameB, dfOkpoB)
						If SalIsNull(dfRnkB)
							Call getClientByOkpo(sId_B, dfRnkB, dfNameB, dfOkpoB)
			Data Field: dfNameB
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
						Left:   5.8"
						Top:    3.298"
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
			! ctb_pbHelp: pbCustomerB
.winattr class Pushbutton:
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.25"
					Top:    3.298"
					Width:  0.43"
					Width Editable? No
					Height: 0.317"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: F1
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: Gray
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
.end
				            Message Actions 
					            On SAM_TooltipSetText
						            Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					            On SAM_Click
						            If FunNSIGetFiltered("V_CUSTOMER_FM", "", " okpo is not null ORDER BY nmk", sPK, sPKName)
							            Set dfRnkB = Val(sPK)
							            Call SalSendMsg(dfRnkB, SAM_Create, 0, 0)
							            Call SalEnableWindow(pbSave)
			Pushbutton: pbCustomerB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.25"
					Top:    3.298"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
				Font Name: Class Default
				Font Size: Class Default
				Font Enhancement: Class Default
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Class Default
				Text Color: Class Default
				Background Color: Class Default
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("V_CUSTOMER_FM", "", " okpo is not null ORDER BY nmk", sPK, sPKName)
							Set dfRnkB = Val(sPK)
							Call SalSendMsg(dfRnkB, SAM_Create, 0, 0)
							Call SalEnableWindow(pbSave)
			Background Text: Код виду фінансової операції
				Resource Id: 123
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    4.05"
					Width:  3.0"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfDFM_01
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
						Left:   3.5"
						Top:    4.0"
						Width:  5.7"
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
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_User
						If dfDFM_01 = ''
							Set dfDFM_01 = '000000000000000'
					! On SAM_Validate
						! проверка правильности заполнения
								(сравнить со значениями из справочников)
						                                                         If NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01a WHERE code=substr(:dfDFM_01,1,1)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
							                                                         Call Debug('ERROR!')
						                                                         Return VALIDATE_Ok
			Pushbutton: pbDFM_01
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   9.25"
					Top:    4.0"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						Set sKodDFM01 = dfDFM_01
						If SalModalDialog(Dlg_FMKod, hWndForm, nParEdit, sKodDFM01)
							Set dfDFM_01 = sKodDFM01
							Call SalEnableWindow(pbSave)
			Pushbutton: pbSave
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Зберегти
				Window Location and Size
					Left:   1.5"
					Top:    4.6"
					Width:  1.5"
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
						If cbDFM_02 AND dfDFM_02 = ''
							Call SalMessageBox("Не заповнено дані для обов'язкового моніторингу !", "Помилка", MB_Ok | MB_IconExclamation)
							Call SalSetFocus(dfDFM_02)
							Return FALSE
						If cbDFM_03
							If dfDFM_03 = ''
								Call SalMessageBox("Не заповнено дані для внутрішнього моніторингу !", "Помилка", MB_Ok | MB_IconExclamation)
								Call SalSetFocus(dfDFM_03)
								Return FALSE
							Else If dfDFM_03 = '900' AND dfCommDFM_03 = ''
								Call SalMessageBox("Не заповнено коментар для коду 900 внутрішнього моніторингу !", "Помилка", MB_Ok | MB_IconExclamation)
								Call SalSetFocus(dfCommDFM_03)
								Return FALSE
						If dfDFM_01 != '' AND (NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01a WHERE code=substr(:dfDFM_01,1,1)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
								OR NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01a WHERE code=substr(:dfDFM_01,2,1)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
								OR NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01b WHERE code=substr(:dfDFM_01,3,1)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
								OR NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01b WHERE code=substr(:dfDFM_01,4,1)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
								OR NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01c WHERE code=substr(:dfDFM_01,5,1)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
								OR NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01c WHERE code=substr(:dfDFM_01,6,1)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
								OR NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01d WHERE code=substr(:dfDFM_01,7,4)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
								OR NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01d WHERE code=substr(:dfDFM_01,11,4)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes)
								OR NOT SqlPrepareAndExecute(hSql(), 
								"SELECT code FROM k_dfm01e WHERE code=substr(:dfDFM_01,15,1)") 
								OR NOT SqlFetchNext(hSql(), nFetchRes) )
							Call SalMessageBox("Невірно заповнено код виду фінансової операції !", "Помилка", MB_Ok | MB_IconExclamation)
							Call SalSetFocus(dfDFM_01)
							Return FALSE
						If SqlPrepareAndExecute(hSql(), "SELECT count(*) INTO :nCount FROM finmon_que WHERE id=:nId")
							Call SqlFetchNext(hSql(), nFetchRes)
							Set nMode = 
									IifN(rbA=TRUE, 1, 
									IifN(rbB=TRUE, 2, 
									IifN(rbAB=TRUE,
									  IifN(rbDFM_02A=TRUE AND rbDFM_03B=TRUE,4,
									  IifN(rbDFM_02B=TRUE AND rbDFM_03A=TRUE,5,3)),nMode)))
							If nCount
								If NOT SqlPrepareAndExecute(hSql(), 
										"UPDATE finmon_que 
										 SET opr_vid1=:dfDFM_01, opr_vid2=:dfDFM_02, comm_vid2=:dfCommDFM_02, 
										     opr_vid3=:dfDFM_03, comm_vid3=:dfCommDFM_03, 
										     monitor_mode=:nMode, status=decode(status,'R','I',status), 
										     rnk_a=:dfRnkA, rnk_b=:dfRnkB 
										 WHERE id=:nId")
									Call SqlRollback(hSql())
									Return TRUE
								If dfDFM_02 = '0000'
									If not SqlPrepareAndExecute(hSql(), "delete from finmon_que_vid2 where id=:nId")
										Call SqlRollback(hSql())
										Return TRUE
								If dfDFM_03 = '000'
									If not SqlPrepareAndExecute(hSql(), "delete from finmon_que_vid3 where id=:nId")
										Call SqlRollback(hSql())
										Return TRUE
							Else
								If NOT SqlPrepareAndExecute(hSql(), 
										"INSERT INTO finmon_que(ref,rec,status,opr_vid1,opr_vid2,comm_vid2,opr_vid3,comm_vid3,monitor_mode,agent_id,rnk_a,rnk_b) 
										 VALUES(:nRef,:nRec,'I',:dfDFM_01,:dfDFM_02,:dfCommDFM_02,:dfDFM_03,:dfCommDFM_03,:nMode,:nUserId,:dfRnkA,:dfRnkB)")
									Call SqlRollback(hSql())
									Return TRUE
							Call SqlCommit(hSql())
						Call SalEndDialog(hWndForm,1)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   6.7"
					Top:    4.595"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.448"
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
						Call SalEndDialog(hWndForm,0)
		Functions
			Function: getClientByRnk
				Description:
				Returns
					Boolean:
				Parameters
					Number: nRnk
					Receive String: sRetOkpo
					Receive String: sRetName
				Static Variables
				Local variables
				Actions
					If nRnk != NUMBER_Null
						If not SqlPrepareAndExecute(hSql(), 
								"select okpo, nmk into :sRetOkpo, :sRetName 
								   from customer
								  where rnk = :nRnk")
							Return FALSE
						If not SqlFetchNext(hSql(), nFetchRes)
							Return FALSE
					Return TRUE
			Function: getClientByAcc
				Description:
				Returns
					Boolean:
				Parameters
					String: sMfo
					String: sNls
					Number: nVal
					Receive Number: nRetRnk
					Receive String: sRetName
					Receive String: sRetOkpo
				Static Variables
				Local variables
					Number: nFind
				Actions
					Set nRetRnk  = NUMBER_Null
					Set sRetName = STRING_Null
					Set sRetOkpo = STRING_Null
					If sMfo = GetBankMfo() and sNls != STRING_Null and nVal != NUMBER_Null
						If not SqlPrepareAndExecute(hSql(), 
								"select c.rnk, c.nmk, c.okpo into :nRetRnk, :sRetName, :sRetOkpo
								   from customer c, accounts a
								  where a.nls = :sNls and a.kv = :nVal
								    and a.rnk = c.rnk")
							Return FALSE
						If not SqlFetchNext(hSql(), nFetchRes)
							Return FALSE
					Return TRUE
			Function: getClientByOkpo
				Description:
				Returns
					Boolean:
				Parameters
					String: sOkpo
					Receive Number: nRetRnk
					Receive String: sRetName
					Receive String: sRetOkpo
				Static Variables
				Local variables
					Number: nFind
				Actions
					Set nRetRnk  = NUMBER_Null
					Set sRetName = STRING_Null
					Set sRetOkpo = sOkpo
					If sOkpo != STRING_Null
						Set nFind = 0
						If not SqlPrepareAndExecute(hSql(), 
								"select c.rnk, c.nmk, c.okpo into :nRetRnk, :sRetName, :sRetOkpo
								   from customer c
								  where c.okpo = :sOkpo")
							Return FALSE
						While SqlFetchNext(hSql(), nFetchRes)
							Set nFind = nFind + 1
						If nFind > 1
							Set nRetRnk  = NUMBER_Null
							Set sRetName = STRING_Null
							Set sRetOkpo = sOkpo
					Return TRUE
		Window Parameters
			Number: nParEdit	! 1-EDIT, 0-READ_ONLY/
			Number: nId
			Number: nRef
			Number: nRec
			String: sMfoA
			String: sNlsA
			String: sNamA
			String: sMfoB
			String: sNlsB
			String: sNamB
			Date/Time: dPDat
			Number: nS		! сумма в копейках
			Number: nKv
			Number: nKv2
			String: sKv
			String: sNazn
			Number: nDig
			String: sVid1
			String: sVid2
			String: sComm2
			String: sVid3
			String: sComm3
			Number: nMode
			Number: nRnkA
			Number: nRnkB
			String: sId_A		! OkpoA (id_a from oper)
			String: sId_B		! OkpoB (id_b from oper)
		Window Variables
			Number: nUserId
			String: sFormat
			String: sPK
			String: sPKName
			String: sKodDFM01
			Number: nCount
			String: sTmp
			Number: nAcc
		Message Actions
			On SAM_Create
				Call SalCenterWindow(hWndForm)
				Set nUserId = GetUserId()
				If NOT nParEdit
					Call SalDisableWindow(cbDFM_02)
					Call SalDisableWindow(dfDFM_02)
					Call SalDisableWindow(pbDFM_02)
					Call SalDisableWindow(dfCommDFM_02)
					Call SalDisableWindow(cbDFM_03)
					Call SalDisableWindow(dfDFM_03)
					Call SalDisableWindow(pbDFM_03)
					Call SalDisableWindow(dfCommDFM_03)
					Call SalDisableWindow(dfDFM_01)
					Call SalDisableWindow(rbA)
					Call SalDisableWindow(rbDFM_02A)
					Call SalDisableWindow(rbDFM_03A)
					Call SalDisableWindow(rbB)
					Call SalDisableWindow(rbDFM_02B)
					Call SalDisableWindow(rbDFM_03B)
					Call SalDisableWindow(rbAB)
					Call SalDisableWindow(dfOkpoA)
					Call SalDisableWindow(dfOkpoB)
					Call SalDisableWindow(pbCustomerA)
					Call SalDisableWindow(pbCustomerB)
				If nMode = NUMBER_Null 
					Set cbDFM_02 = TRUE
					Call SalDisableWindow(dfDFM_03)
					Call SalDisableWindow(dfCommDFM_03)
					Call SalDisableWindow(pbDFM_03)
					Call SalDisableWindow(pbAddDFM_03)
					Call SalDisableWindow(pbAddDFM_02)
				Else If nMode < 3
					Call SalHideWindow(rbDFM_02A)
					Call SalHideWindow(rbDFM_02B)
					Call SalHideWindow(rbDFM_03A)
					Call SalHideWindow(rbDFM_03B)
					If sVid3 != '' AND sVid3 != '000'
						Set cbDFM_03 = TRUE
						Call SalDisableWindow(dfDFM_02)
						Call SalDisableWindow(dfCommDFM_02)
						Call SalDisableWindow(pbDFM_02)
						Call SalDisableWindow(pbAddDFM_02)
					Else
						Set cbDFM_02 = TRUE
						Call SalDisableWindow(dfDFM_03)
						Call SalDisableWindow(dfCommDFM_03)
						Call SalDisableWindow(pbDFM_03)
						Call SalDisableWindow(pbAddDFM_03)
				Set dfMfoA = sMfoA
				Set dfNlsA = sNlsA
				Set dfNamA = sNamA
				Set dfMfoB = sMfoB
				Set dfNlsB = sNlsB
				Set dfNamB = sNamB
				Set dfPDat = dPDat
				Set dfS    = nS * SalNumberPower(10,-nDig)
				Set dfKv   = sKv
				Set dfNazn = sNazn
				Set dfDFM_01 = sVid1
				Call SalSendMsg(dfDFM_01, SAM_User, 0, 0)
				Set dfDFM_02 = sVid2
				Set dfCommDFM_02 = sComm2
				Call SalSendMsg(dfDFM_02, SAM_User, 0, 0)
				Set dfDFM_03 = sVid3
				Set dfCommDFM_03 = sComm3
				Call SalSendMsg(dfDFM_03, SAM_User, 0, 0)
				If dfMfoA != dfMfoB
					Call SalHideWindow(rbDFM_02A)
					Call SalHideWindow(rbDFM_02B)
					Call SalHideWindow(rbDFM_03A)
					Call SalHideWindow(rbDFM_03B)
					Call SalDisableWindow(rbA)
					Call SalDisableWindow(rbB)
					Call SalDisableWindow(rbAB)
					If dfMfoB = GetBankMfo()
						Set rbB = TRUE
					Else
						Set rbA = TRUE
				Else
					If nMode = 1
						Set rbA = TRUE
					Else If nMode = 2
						Set rbB = TRUE
					Else
						Set rbAB = TRUE
						If nMode = 3
							If Val(dfDFM_02)
								Set cbDFM_02  = TRUE
								Set rbDFM_02A = TRUE
								Set rbDFM_02B = TRUE
								Call SalDisableWindow(dfDFM_03)
								Call SalDisableWindow(dfCommDFM_03)
								Call SalDisableWindow(pbDFM_03)
								Call SalDisableWindow(pbAddDFM_03)
							Else
								Set cbDFM_03  = TRUE
								Set rbDFM_03A = TRUE
								Set rbDFM_03B = TRUE
								Call SalDisableWindow(dfDFM_02)
								Call SalDisableWindow(dfCommDFM_02)
								Call SalDisableWindow(pbDFM_02)
								Call SalDisableWindow(pbAddDFM_02)
						Else If nMode = 4
							Set cbDFM_02  = TRUE
							Set rbDFM_02A = TRUE
							Set cbDFM_03  = TRUE
							Set rbDFM_03B = TRUE
						Else If nMode = 5
							Set cbDFM_02  = TRUE
							Set rbDFM_02B = TRUE
							Set cbDFM_03  = TRUE
							Set rbDFM_03A = TRUE
				If rbA
					Call SalDisableWindow(dfOkpoB)
					Call SalDisableWindow(pbCustomerB)
				If rbB
					Call SalDisableWindow(dfOkpoA)
					Call SalDisableWindow(pbCustomerA)
				Set dfRnkA = nRnkA
				Set dfRnkB = nRnkB
				Call SalDisableWindow(pbSave)
				Set sFormat = '#0.' || SalStrRepeatX('0', IifN(nDig!=NUMBER_Null, nDig, 2))
				Call SalFmtSetPicture(dfS, sFormat)
				Call SalSetFocus(pbCancel)
	Dialog Box: Dlg_FMKod
		Class:
		Property Template:
		Class DLL Name:
		Title: Код виду фінансової операції
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
				Height: 5.8"
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
			Background Text: Код виду фінансової операції
				Resource Id: 124
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.131"
					Width:  3.0"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Dark Blue
				Background Color: Default
			Data Field: bgKod
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
			Data Field: dfKod
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
						Left:   3.15"
						Top:    0.095"
						Width:  2.0"
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
					Text Color: Dark Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
			!
			Group Box: Форма розрахунку
				Resource Id: 125
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.4"
					Width:  8.6"
					Width Editable? Yes
					Height: 0.9"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: що надається
				Resource Id: 9031
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    0.7"
					Width:  2.0"
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
			Data Field: bgAKod
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
			Data Field: dfAKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.65"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfAKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT name INTO :dfAName FROM K_DFM01a WHERE code=:dfAKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfAKod = ''
								Set dfAName = ''
			Data Field: dfAName
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
						Left:   3.15"
						Top:    0.655"
						Width:  5.0"
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
			Pushbutton: pbAKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    0.655"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01A", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfAKod = sPK
							Set dfAName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			Background Text: що отримується
				Resource Id: 9032
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    1.0"
					Width:  2.0"
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
			Data Field: bgBKod
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
			Data Field: dfBKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    0.95"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfBKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT name INTO :dfBName FROM K_DFM01a WHERE code=:dfBKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfBKod = ''
								Set dfBName = ''
			Data Field: dfBName
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
						Left:   3.15"
						Top:    0.952"
						Width:  5.0"
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
			Pushbutton: pbBKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    0.952"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01A", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfBKod= sPK
							Set dfBName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			!
			Group Box: Вид активу
				Resource Id: 38378
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    1.35"
					Width:  8.6"
					Width Editable? Yes
					Height: 0.9"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: що одержується
				Resource Id: 19335
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    1.65"
					Width:  2.0"
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
			Data Field: bgCKod
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
			Data Field: dfCKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.6"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfCKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT name INTO :dfCName FROM K_DFM01b WHERE code=:dfCKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfCKod = ''
								Set dfCName = ''
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
						Left:   3.15"
						Top:    1.595"
						Width:  5.0"
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
			Pushbutton: pbCKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    1.595"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01B", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfCKod = sPK
							Set dfCName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			Background Text: що передається
				Resource Id: 19340
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    1.95"
					Width:  2.0"
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
			Data Field: bgDKod
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
			Data Field: dfDKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    1.9"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfDKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT name INTO :dfDName FROM K_DFM01b WHERE code=:dfDKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfDKod = ''
								Set dfDName = ''
			Data Field: dfDName
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
						Left:   3.15"
						Top:    1.905"
						Width:  5.0"
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
			Pushbutton: pbDKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    1.905"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01B", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfDKod= sPK
							Set dfDName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			!
			Group Box: Місцезнаходження об'єкта
				Resource Id: 38379
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    2.3"
					Width:  8.6"
					Width Editable? Yes
					Height: 0.9"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: що одержується
				Resource Id: 19339
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    2.6"
					Width:  2.0"
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
			Data Field: bgEKod
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
			Data Field: dfEKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    2.55"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfEKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT name INTO :dfEName FROM K_DFM01c WHERE code=:dfEKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfEKod = ''
								Set dfEName = ''
			Data Field: dfEName
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
						Left:   3.15"
						Top:    2.548"
						Width:  5.0"
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
			Pushbutton: pbEKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    2.548"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01C", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfEKod = sPK
							Set dfEName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			Background Text: що передається
				Resource Id: 19338
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    2.9"
					Width:  2.0"
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
			Data Field: bgFKod
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
			Data Field: dfFKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    2.85"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfFKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT name INTO :dfFName FROM K_DFM01c WHERE code=:dfFKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfFKod = ''
								Set dfFName = ''
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
						Left:   3.15"
						Top:    2.845"
						Width:  5.0"
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
			Pushbutton: pbFKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    2.845"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01C", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfFKod= sPK
							Set dfFName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			!
			Group Box: Об'єкт операції
				Resource Id: 38376
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    3.25"
					Width:  8.6"
					Width Editable? Yes
					Height: 0.9"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: що одержується
				Resource Id: 19337
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    3.55"
					Width:  2.0"
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
			Data Field: bgGKod
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
			Data Field: dfGKod
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
						Left:   2.5"
						Top:    3.5"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfGKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT substr(name,1,254) INTO :dfGName 
									 FROM K_DFM01d WHERE code=:dfGKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfGKod = ''
								Set dfGName = ''
			Data Field: dfGName
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
						Left:   3.15"
						Top:    3.5"
						Width:  5.0"
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
			Pushbutton: pbGKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    3.5"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01D", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfGKod = sPK
							Set dfGName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			Background Text: що передається
				Resource Id: 19336
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.3"
					Top:    3.85"
					Width:  2.0"
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
			Data Field: bgJKod
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
			Data Field: dfJKod
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
						Left:   2.5"
						Top:    3.8"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfJKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT substr(name,1,254) INTO :dfJName 
									 FROM K_DFM01d WHERE code=:dfJKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfJKod = ''
								Set dfJName = ''
			Data Field: dfJName
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
						Left:   3.15"
						Top:    3.798"
						Width:  5.0"
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
			Pushbutton: pbJKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    3.798"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01D", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfJKod= sPK
							Set dfJName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			!
			Group Box: Відкриття або закриття рахунку
				Resource Id: 38377
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    4.2"
					Width:  8.6"
					Width Editable? Yes
					Height: 0.6"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfIKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: String
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   2.5"
						Top:    4.45"
						Width:  0.6"
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
					On SAM_Create
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
					On SAM_AnyEdit
						Call SalEnableWindow(pbSave)
					On SAM_Validate
						Call SalSendMsg(hWndItem, SAM_User, 0, 0)
						Call CreateKod()
						Return VALIDATE_Ok
					On SAM_User
						If dfIKod
							Call SqlPrepareAndExecute(hSql(), 
									"SELECT name INTO :dfIName FROM K_DFM01e WHERE code=:dfIKod")
							If NOT SqlFetchNext(hSql(), nFetchRes)
								Set dfIKod = ''
								Set dfIName = ''
			Data Field: dfIName
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
						Left:   3.15"
						Top:    4.452"
						Width:  5.0"
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
			Pushbutton: pbIKod
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: ctb_pbHelp
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   8.2"
					Top:    4.452"
					Width:  0.35"
					Width Editable? No
					Height: 0.25"
					Height Editable? No
				Visible? Yes
				Keyboard Accelerator: (none)
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Picture File Name: \BARS98\RESOURCE\BMP\help2.bmp
				Picture Transparent Color: White
				Image Style: Single
				Text Color: Default
				Background Color: 3D Face Color
				Message Actions
					On SAM_TooltipSetText
						Return XSalTooltipSetText(lParam, 'Вибрати значення з довідника')
					On SAM_Click
						If FunNSIGetFiltered("K_DFM01E", "", " code is not null and (d_close is null or d_close > bankdate) ORDER BY code", sPK, sPKName)
							Set dfIKod = sPK
							Set dfIName = sPKName
							Call SalEnableWindow(pbSave)
							Call CreateKod()
			!
			Pushbutton: pbSave
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbOk
				Property Template:
				Class DLL Name:
				Title: Зберегти
				Window Location and Size
					Left:   0.6"
					Top:    4.9"
					Width:  1.5"
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
						Set sKodDFM01 = dfKod
						Call SalEndDialog(hWndForm,1)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   6.65"
					Top:    4.905"
					Width:  1.5"
					Width Editable? Class Default
					Height: 0.448"
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
						Call SalDestroyWindow(hWndForm)
						Call SalEndDialog(hWndForm,0)
		Functions
			Function: CreateKod
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Set dfKod = 
							  IifS(dfAKod!='', dfAKod, ' ') || IifS(dfBKod!='', dfBKod, ' ') || 
							  IifS(dfCKod!='', dfCKod, ' ') || IifS(dfDKod!='', dfDKod, ' ') || 
							  IifS(dfEKod!='', dfEKod, ' ') || IifS(dfFKod!='', dfFKod, ' ') || 
							  IifS(dfGKod!='', dfGKod, '     ') || IifS(dfJKod!='', dfJKod, '     ') || 
							  IifS(dfIKod!='', dfIKod, ' ')
		Window Parameters
			Number: nParEdit
			Receive String: sKodDFM01
		Window Variables
			String: sPK
			String: sPKName
		Message Actions
			On SAM_Create
				Call SalCenterWindow(hWndForm)
				Call SalDisableWindow(pbSave)
				If NOT nParEdit
					Call SalDisableWindow(dfAKod)
					Call SalDisableWindow(dfBKod)
					Call SalDisableWindow(dfCKod)
					Call SalDisableWindow(dfDKod)
					Call SalDisableWindow(dfEKod)
					Call SalDisableWindow(dfFKod)
					Call SalDisableWindow(dfGKod)
					Call SalDisableWindow(dfJKod)
					Call SalDisableWindow(dfIKod)
					Call SalDisableWindow(pbAKod)
					Call SalDisableWindow(pbBKod)
					Call SalDisableWindow(pbCKod)
					Call SalDisableWindow(pbDKod)
					Call SalDisableWindow(pbEKod)
					Call SalDisableWindow(pbFKod)
					Call SalDisableWindow(pbGKod)
					Call SalDisableWindow(pbJKod)
					Call SalDisableWindow(pbIKod)
				Set dfKod  = sKodDFM01
				Set dfAKod = SalStrMidX(sKodDFM01, 0, 1)
				Set dfBKod = SalStrMidX(sKodDFM01, 1, 1)
				Set dfCKod = SalStrMidX(sKodDFM01, 2, 1)
				Set dfDKod = SalStrMidX(sKodDFM01, 3, 1)
				Set dfEKod = SalStrMidX(sKodDFM01, 4, 1)
				Set dfFKod = SalStrMidX(sKodDFM01, 5, 1)
				Set dfGKod = SalStrMidX(sKodDFM01, 6, 4)
				Set dfJKod = SalStrMidX(sKodDFM01, 10, 4)
				Set dfIKod = SalStrMidX(sKodDFM01, 14, 1)
	! Установка курсов покупки/продажи валют
	Table Window: Tbl_CurRates
		Class: cGenericTable
		Property Template:
		Class DLL Name:
		Title: Установка курсов покупки/продажи валют
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
				Left:   1.375"
				Top:    1.146"
				Width:  7.45"
				Width Editable? Class Default
				Height: 5.143"
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
				Size: 2.274"
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
					Resource Id: 10833
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
					Resource Id: 10834
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
					Resource Id: 10835
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
				Group Box: Предыдущий банковский день
					Resource Id: 32039
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   -0.017"
						Top:    0.488"
						Width:  7.3"
						Width Editable? Yes
						Height: 1.333"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
				Group Box: Текущий банковский день
					Resource Id: 32040
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   -0.017"
						Top:    1.821"
						Width:  7.3"
						Width Editable? Yes
						Height: 1.107"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
				Data Field: df1
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
							Left:   5.283"
							Top:    1.929"
							Width:  1.9"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? No
						Justify: Right
						Format: dd/MM/yyyy
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Bold
						Text Color: Royal Blue
						Background Color: 3D Face Color
						Input Mask: Unformatted
					Message Actions
				Data Field: df2
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
							Left:   5.25"
							Top:    0.619"
							Width:  1.9"
							Width Editable? Yes
							Height: 0.25"
							Height Editable? Yes
						Visible? Yes
						Border? No
						Justify: Right
						Format: dd/MM/yyyy
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Bold
						Text Color: Royal Blue
						Background Color: 3D Face Color
						Input Mask: Unformatted
					Message Actions
				Data Field: dfCur
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
							Left:   1.817"
							Top:    0.726"
							Width:  1.267"
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
						Text Color: Royal Blue
						Background Color: 3D Face Color
						Input Mask: Unformatted
					Message Actions
				Data Field: dfCurB
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
							Left:   1.817"
							Top:    1.012"
							Width:  1.267"
							Width Editable? Yes
							Height: 0.31"
							Height Editable? Yes
						Visible? Yes
						Border? No
						Justify: Left
						Format: Unformatted
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Bold
						Text Color: Royal Blue
						Background Color: 3D Face Color
						Input Mask: Unformatted
					Message Actions
				Data Field: dfCurS
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
							Left:   1.817"
							Top:    1.345"
							Width:  1.267"
							Width Editable? Yes
							Height: 0.202"
							Height Editable? Yes
						Visible? Yes
						Border? No
						Justify: Left
						Format: Unformatted
						Country: Default
						Font Name: Default
						Font Size: Default
						Font Enhancement: Bold
						Text Color: Royal Blue
						Background Color: 3D Face Color
						Input Mask: Unformatted
					Message Actions
				Background Text: Курс НБУ
					Resource Id: 32041
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   0.383"
						Top:    0.762"
						Width:  1.0"
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
				Background Text: Курс покупки
					Resource Id: 32043
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   0.383"
						Top:    1.036"
						Width:  1.2"
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
				Background Text: Курс продажи
					Resource Id: 32042
					Class Child Ref Key: 0
					Class ChildKey: 0
					Class:
					Window Location and Size
						Left:   0.383"
						Top:    1.31"
						Width:  1.267"
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
			Column: colKV
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
			Column: colLCV
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Код
						валюты
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
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
			Column: colBSum
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Базовая
						сумма
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
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
			Column: colRatO
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Курс НБУ
				Visible? Class Default
				Editable? No
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.6"
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
			Column: colRatB
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Курс
						покупки
				Visible? Class Default
				Editable? Yes
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.683"
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
			Column: colRatS
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cColumnLabeled
				Property Template:
				Class DLL Name:
				Title: Курс
						продажи
				Visible? Class Default
				Editable? Yes
				Maximum Data Length: Class Default
				Data Type: Number
				Justify: Right
				Width:  1.717"
				Width Editable? Class Default
				Format: Unformatted
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
			Number: nPar
			String: sPar1
			String: sPar2
		Window Variables
			Date/Time: dBDat
			Number: nMaxDig
			Number: nRow
			Number: nOrderBy
			Window Handle: hColumn
		Message Actions
			On SAM_Create
				Call PrepareWindow(hWndForm)
				Call SalCenterWindow(hWndForm)
				Set dBDat = GetBankDate()
				Set df1 = GetBankDate()
				If SqlPrepareAndExecute(hSql(), "SELECT max(fdat) INTO :Tbl_CurRates.df2 FROM fdat WHERE fdat<bankdate")
					Call SqlFetchNext(hSql(), nFetchRes)
				Set nOrderBy = 1
				Set Tbl_CurRates.nFlags = GT_NoDel | GT_NoIns
				Call SalDisableWindow( pbDetails )
				Set Tbl_CurRates.strFilterTblName = 'CUR_RATES'
				Set Tbl_CurRates.strPrintFileName = 'CUR_RATES'
				Set Tbl_CurRates.strSqlPopulate = 
						"SELECT t.kv, t.lcv, CUR_RATES.bsum, CUR_RATES.rate_o, CUR_RATES.rate_b, CUR_RATES.rate_s 
						 INTO :Tbl_CurRates.colKV, :Tbl_CurRates.colLCV, :Tbl_CurRates.colBSum, 
						      :Tbl_CurRates.colRatO, :Tbl_CurRates.colRatB, :Tbl_CurRates.colRatS 
						 FROM tabval t, CUR_RATES 
						 WHERE t.kv=CUR_RATES.kv AND CUR_RATES.vdate=:Tbl_CurRates.dBDat"
				Set Tbl_CurRates.strSqlUpdate = 
						"UPDATE cur_rates 
						 SET rate_b=:Tbl_CurRates.colRatB, rate_s=:Tbl_CurRates.colRatS
						 WHERE kv=:Tbl_CurRates.colKV and vdate=:Tbl_CurRates.dBDat"
				Call SalSendClassMessage(SAM_Create, 0, 0)
			On SAM_RowSetContext
				If SqlPrepareAndExecute(hSql(), 
						"SELECT rate_o, rate_b, rate_s 
						 INTO :Tbl_CurRates.dfCur, :Tbl_CurRates.dfCurB, :Tbl_CurRates.dfCurS
						 FROM cur_rates WHERE vdate=(SELECT max(fdat) from fdat WHERE fdat<bankdate)
						 AND kv=:Tbl_CurRates.colKV")
					Call SqlFetchNext(hSql(), nFetchRes)
	Dialog Box: Dlg_AddVid
		Class: cGenericTableDlg
		Property Template:
		Class DLL Name:
		Title:
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
				Height: 3.7"
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
					Resource Id: 1177
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
					Resource Id: 1178
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
				Line
					Resource Id: 1179
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
						Height: 2.8"
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
					Column: colVid
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Код
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: 4
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
							On SAM_SetFocus
								Set sTmpVid = MyValue
								If SalTblQueryRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_New)
									Call SalStatusSetText(hWndForm, 'F4-вибрати з довідника')
								Else
									Call SalStatusSetText(hWndForm, '')
							On SAM_AnyEdit
								If not SalTblQueryRowFlags(hWndForm, SalTblQueryContext(hWndForm), ROW_New)
									Set colVid = sTmpVid
							On SAM_Validate
								If not SalIsNull(hWndItem)
									Call SqlPrepareAndExecute(hSql(), 
											"select name into :tbl.colName from k_dfm0"|| Str(nKod) || " where code=:tbl.colVid")
									If not SqlFetchNext(hSql(), nFetchRes)
										Call SalMessageBox('Невідомий код!', 'Увага!', MB_IconStop | MB_Ok)
										Return VALIDATE_Cancel
								Return VALIDATE_Ok
							On SAM_DoubleClick
								Set nRow = SalTblQueryContext(hWndForm)
								If SalTblQueryRowFlags(hWndForm, nRow, ROW_New)
									If FunNSIGetFiltered("K_DFM0" || Str(nKod), 'name', ' 1=1 order by code', s1, s2)
										Set colVid = s1
										Set colName = s2
									Call SalSetFocus(hWndForm)
									Call SalTblSetFocusRow(hWndForm, nRow)
									Call SalTblSetFocusCell(hWndForm, nRow, colVid, 0, 0)
							On VTM_KeyDown
								If wParam = VK_F4
									Call SalSendMsg(hWndItem, SAM_DoubleClick, 0, 0)
							On SAM_KillFocus
								Call SalStatusSetText(hWndForm, '')
					Column: colName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Назва
						Visible? Class Default
						Editable? No
						Maximum Data Length: Class Default
						Data Type: Long String
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
					Column: colComm
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class: cColumnLabeled
						Property Template:
						Class DLL Name:
						Title: Коментар
						Visible? Class Default
						Editable? Class Default
						Maximum Data Length: 254
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
				Functions
				Window Variables
					Number: nRow
					String: s1
					String: s2
				Message Actions
					On SAM_DoubleClick
		Functions
		Window Parameters
			Number: nId
			Number: nKod
			Boolean: bEdit	! 1-Edit, 0-ReadOnly
		Window Variables
			String: sTmpVid
		Message Actions
			On SAM_Create
				Call SalSetWindowText(hWndForm, "Ознаки повідомлення, " || IifS(nKod=2, 
						  "Обов'язковий моніторинг", 
						  "Внутрішній моніторинг"))
				Call PrepareWindowEx(hWndForm)
				Set strSqlPopulate = 
						"select f.vid, k.name, f.comm
						 into :Dlg_AddVid.tbl.colVid, 
						      :Dlg_AddVid.tbl.colName,
						      :Dlg_AddVid.tbl.colComm
						 from finmon_que_vid" || Str(nKod) || " f, k_dfm0" || Str(nKod) || " k
						 where f.vid=k.code and f.id=:Dlg_AddVid.nId
						 order by f.vid"
				Set strSqlInsert = 
						"insert into finmon_que_vid" || Str(nKod) || "(id, vid, comm)
						 values(:Dlg_AddVid.nId, :Dlg_AddVid.tbl.colVid, :Dlg_AddVid.tbl.colComm)"
				Set strSqlUpdate = 
						"update finmon_que_vid" || Str(nKod) || "
						 set comm=:Dlg_AddVid.tbl.colComm
						 where id=:Dlg_AddVid.nId and vid=:Dlg_AddVid.tbl.colVid"
				Set strSqlDelete = 
						"delete from finmon_que_vid" || Str(nKod) || "
						 where id=:Dlg_AddVid.nId and vid=:Dlg_AddVid.tbl.colVid"
				Call SalDisableWindow(pbPrint)
				Call SalDisableWindow(pbOk)
				If not bEdit
					Set nFlags = GT_ReadOnly
					Call SalDisableWindow(tbl.colVid)
					Call SalDisableWindow(tbl.colComm)
				If nKod = 2
					Call SalSetMaxDataLength(tbl.colVid, 4)
				Else If nKod = 3
					Call SalSetMaxDataLength(tbl.colVid, 3)
				Call SalSendClassMessage(SAM_Create, 0, 0)
	Dialog Box: dlg_FMComments
		Class:
		Property Template:
		Class DLL Name:
		Title: Коментар
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  5.8"
				Width Editable? Yes
				Height: 2.5"
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
			Multiline Field: mlComm
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 254
					String Type: String
					Editable? Yes
				Display Settings
					Border? Yes
					Word Wrap? Yes
					Vertical Scroll? Yes
					Window Location and Size
						Left:   0.1"
						Top:    0.05"
						Width:  5.5"
						Width Editable? Yes
						Height: 1.3"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
				Message Actions
			Frame
				Resource Id: 24741
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    1.4"
					Width:  5.5"
					Width Editable? Yes
					Height: 0.7"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 1
				Border Color: Default
				Background Color: Default
			Pushbutton: pbSave
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbUpdate
				Property Template:
				Class DLL Name:
				Title: Записати
				Window Location and Size
					Left:   2.9"
					Top:    1.55"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
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
						If mlComm
							Set sComment = mlComm
							Call SalEndDialog(hWndForm, TRUE)
						Else
							Call SalMessageBox('Не заповнено коментар!', 'Увага!', MB_IconExclamation)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   4.2"
					Top:    1.55"
					Width:  Class Default
					Width Editable? Class Default
					Height: Class Default
					Height Editable? Class Default
				Visible? Class Default
				Keyboard Accelerator: Class Default
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
		Window Parameters
			Receive String: sComment
		Window Variables
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
	Form Window: frm_ImportReft
		Class:
		Property Template:
		Class DLL Name:
		Title: Імпорт файлу терористів
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
				Resource Id: 6885
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
				Resource Id: 6886
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
						If IDYES = SalMessageBox("Виконати імпорт файлу терористів " || dfFileName || " ?", "Увага!", MB_IconQuestion | MB_YesNo)
							Call SalWaitCursor(TRUE)
							If not SqlPrepareAndExecute(hSql(), "delete from fm_imp_file")
								Call SqlRollback(hSql())
							Else
								Call SqlCommit(hSql())
								If PutFileToClob(hSql(), dfFileName, 'fm_imp_file', 'id', 'file_data',
										1, STRING_Null, STRING_Null, 1)
									If not SqlPLSQLCommand(hSql(), "p_fm_imp_file(nFileId)")
										Call SqlRollback(hSql())
									Else
										Call SalMessageBox("Виконано імпорт файлу " || dfFileName, "Інформація", MB_IconAsterisk | MB_Ok)
										Call SqlCommitEx(hSql(), "Выполнен импорт файла террористов " || dfFileName)
										Call SqlPrepareAndExecute(hSql(), "select count(*) into :nCount from finmon_reft_inperr where id = :nFileId")
										Call SqlFetchNext(hSql(), nFetchRes)
										If nCount
											If IDYES = SalMessageBox("Файл імпортовано з помилками." || PutCrLf() || "Показати помилкові рядки?", "Увага!", MB_IconQuestion | MB_YesNo)
												Call FunNSIEditFFiltered('finmon_reft_inperr', 1, 'id=' || Str(nFileId))
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
		Window Parameters
		Window Variables
			String: strFilters[2]
			Number: nIndex
			String: strFile
			String: dfPath
			Number: nFileId
			Number: nCount
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
	! Dialog Box: dlg_FMFilter_
.winattr
		Class:
		Property Template:
		Class DLL Name:
		Title: Вибір правил ФМ
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  8.3"
				Width Editable? Yes
				Height: 6.7"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
.end
		    Description: 
		    Tool Bar 
			    Contents 
		    Contents 
			    Line 
			    Background Text: Період відбору документів
			    Background Text: з
			    Data Field: dfVDat1
				    Message Actions 
					    On SAM_Validate
						    If not SalIsNull(dfVDat1)
							    If not SalIsValidDateTime(dfVDat1)
								    Call SalMessageBox("Невірний формат дати!", "Увага!", 0)
								    Return VALIDATE_Cancel
						    Return VALIDATE_Ok
			    Background Text: по
			    Data Field: dfVDat2
				    Message Actions 
					    On SAM_Validate
						    If not SalIsNull(dfVDat2)
							    If not SalIsValidDateTime(dfVDat2)
								    Call SalMessageBox("Невірний формат дати!", "Увага!", 0)
								    Return VALIDATE_Cancel
						    Return VALIDATE_Ok
			    Line 
			    Child Table: tblRules
				    Contents 
					    Column: colApply
						    List Values 
						    Message Actions 
					    Column: colId
						    List Values 
						    Message Actions 
					    Column: colName
						    List Values 
						    Message Actions 
					    Column: colVName
						    List Values 
						    Message Actions 
				    Functions 
				    Window Variables 
				    Message Actions 
					    On UM_Populate
						    Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
						    Call SalTblPopulate(hWndForm, hSql(), 
								"select id, name, v_name
								   into :colId, :colName, :colVName
								   from fm_rules
								  where v_name is not null
								  order by id", TBL_FillAll)
						    Call SalTblSetContext(hWndForm, 0)
						    Call SalTblSetRowFlags(hWndForm, 0, ROW_Selected, TRUE)
					    On SAM_FetchRowDone
						    Set colApply = TRUE
			    Check Box: cbApplyFilter
				    Message Actions 
			    Check Box: cbApplyFilter
				    Message Actions 
			    Line 
			    Pushbutton: pbOk
				    Message Actions 
					    On SAM_Click
						    If SalIsNull(dfVDat1)
							    Call SalMessageBox("Не вказано дату!", "Увага!", 0)
							    Return FALSE
						    If SalIsNull(dfVDat2)
							    Call SalMessageBox("Не вказано дату!", "Увага!", 0)
							    Return FALSE
						    Set dDat1 = dfVDat1
						    Set dDat2 = dfVDat2
						    Set sRuleName = ''
						    Set sVName = ''
						    If cbApplyFilter
							    Set sRuleName = tblRules.colName
							    Set sVName = tblRules.colVName
						    Call SalEndDialog(hWndForm, TRUE)
			    Pushbutton: pbCancel
				    Message Actions 
					    On SAM_Click
						    Call SalEndDialog(hWndForm, FALSE)
		    Functions 
		    Window Parameters 
			    Receive Date/Time: dDat1
			    Receive Date/Time: dDat2
			    Receive String: sRuleName
			    Receive String: sVName
		    Window Variables 
		    Message Actions 
			    On SAM_Create
				    Call PrepareWindowEx(hWndForm)
				    Set dfVDat1 = dDat1
				    Set dfVDat2 = dDat2
				    Set cbApplyFilter = TRUE
				    Call SalSetFocus(tblRules)
				    Call SalSendMsg(tblRules, UM_Populate, 0, 0)
	Dialog Box: dlg_FMFilter
		Class:
		Property Template:
		Class DLL Name:
		Title: Вибір правил ФМ
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  8.3"
				Width Editable? Yes
				Height: 6.5"
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
			Line
				Resource Id: 31891
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.0"
					Begin Y:  0.05"
					End X:  9.0"
					End Y:  0.05"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: Default
			Background Text: Період відбору документів
				Resource Id: 31892
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.2"
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
			Background Text: з
				Resource Id: 31893
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.1"
					Top:    0.55"
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
			Data Field: dfVDat1
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
						Left:   1.2"
						Top:    0.5"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: dd/MM/yyyy
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If not SalIsNull(dfVDat1)
							If not SalIsValidDateTime(dfVDat1)
								Call SalMessageBox("Невірний формат дати!", "Увага!", 0)
								Return VALIDATE_Cancel
						Return VALIDATE_Ok
			Background Text: по
				Resource Id: 31894
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   4.0"
					Top:    0.512"
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
			Data Field: dfVDat2
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
						Left:   5.1"
						Top:    0.5"
						Width:  2.0"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: dd/MM/yyyy
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If not SalIsNull(dfVDat2)
							If not SalIsValidDateTime(dfVDat2)
								Call SalMessageBox("Невірний формат дати!", "Увага!", 0)
								Return VALIDATE_Cancel
						Return VALIDATE_Ok
			Line
				Resource Id: 31895
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.0"
					Begin Y:  5.2"
					End X:  9.0"
					End Y:  5.2"
				Visible? Yes
				Line Style: Etched
				Line Thickness: 1
				Line Color: Default
			Child Table: tblRules
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.1"
						Top:    1.05"
						Width:  8.0"
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
					Maximum Rows in Memory: Default
					Discardable? Yes
				Contents
					Column: colApply
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Вибрати
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
					Column: colId
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Код
								правила
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
					Column: colName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Назва правила
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  5.2"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colVName
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: view
						Visible? No
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
					Function: GetRules
						Description:
						Returns
							String:
						Parameters
						Static Variables
						Local variables
							String: sRulesList
							Number: nRow
						Actions
							Set sRulesList = ''
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblSetContext(hWndForm, nRow)
								Set nFMRulesApply[colId] = colApply
								If colApply
									Set sRulesList = sRulesList || IifS(sRulesList='', '', ',') || Str(colId)
							Return sRulesList
					Function: SetApply
						Description:
						Returns
							Boolean:
						Parameters
							Boolean: bApply
						Static Variables
						Local variables
							Number: nRow
						Actions
							Set nRow = TBL_MinRow
							While SalTblFindNextRow(hWndForm, nRow, 0, 0)
								Call SalTblSetContext(hWndForm, nRow)
								Set colApply = bApply
							Return TRUE
				Window Variables
				Message Actions
					On UM_Populate
						Call SalTblSetTableFlags(hWndForm, TBL_Flag_SingleSelection, TRUE)
						Call SalTblPopulate(hWndForm, hSql(),
								"select id, name, v_name
								   into :colId, :colName, :colVName
								   from fm_rules
								  where v_name is not null
								  order by id", TBL_FillAll)
						Call SalTblSetContext(hWndForm, 0)
						Call SalTblSetRowFlags(hWndForm, 0, ROW_Selected, TRUE)
					On SAM_FetchRowDone
						Set colApply = nFMRulesApply[colId]
			Check Box: cbApplyFilter
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cCheckBoxLabeled
				Property Template:
				Class DLL Name:
				Title: Відмітити для всіх правил
				Window Location and Size
					Left:   0.083"
					Top:    4.8"
					Width:  8.0"
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
						Call tblRules.SetApply(cbApplyFilter)
			Line
				Resource Id: 31896
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Coordinates
					Begin X:  0.0"
					Begin Y:  0.9"
					End X:  9.0"
					End Y:  0.9"
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
				Title: Застосувати
				Window Location and Size
					Left:   5.0"
					Top:    5.45"
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
						If SalIsNull(dfVDat1)
							Call SalMessageBox("Не вказано дату!", "Увага!", 0)
							Return FALSE
						If SalIsNull(dfVDat2)
							Call SalMessageBox("Не вказано дату!", "Увага!", 0)
							Return FALSE
						Set dDat1 = dfVDat1
						Set dDat2 = dfVDat2
						Set sRules = tblRules.GetRules()
						Call SalEndDialog(hWndForm, TRUE)
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class: cpbCancel
				Property Template:
				Class DLL Name:
				Title: Відмінити
				Window Location and Size
					Left:   6.5"
					Top:    5.45"
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
		Window Parameters
			Receive Date/Time: dDat1
			Receive Date/Time: dDat2
			Receive String: sRules
			Receive Number: nFMRulesApply[*]
		Window Variables
		Message Actions
			On SAM_Create
				Call PrepareWindowEx(hWndForm)
				Set dfVDat1 = dDat1
				Set dfVDat2 = dDat2
				Set cbApplyFilter = FALSE
				Call SalSetFocus(tblRules)
				Call SalSendMsg(tblRules, UM_Populate, 0, 0)
