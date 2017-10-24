Application Description: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		!! IMPNAL8.APL - Импорт данных в АБС   !!
		!!              (для налогового учета) !!
		!! ООО Унити-Барс (C) 2000             !!
		!! Разработчики: Марийко Б.Г. & Ko     !!
		!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B10000 002C000000020000 0003000000000000 00B1010000FCFFFF
0040: FFE9FFFFFFFFFFFF FFE9FFFFFF7C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D04000000075769 6E646F77730B646C
0080: 675F496D704E616C 380D4368696C6420 57696E646F777309 7062457865637574
00A0: 65
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001C71 3A5C626172733938 5C6C696272617279 5C524547434C4E2E
0020: 646C6C1C713A5C62 61727339385C6C69 62726172795C5245 47434C4E2E617063
0040: 00000101011C713A 5C6261727339385C 6C6962726172795C 524547434C4E2E72
0060: 756E1C713A5C6261 727339385C6C6962 726172795C524547 434C4E2E646C6C1C
0080: 713A5C6261727339 385C6C6962726172 795C524547434C4E 2E61706300000101
00A0: 01175C4241525339 385C42494E5C696D 706E616C382E6170 64165C4241525339
00C0: 385C42494E5C696D 706578702E646C6C 165C424152533938 5C42494E5C696D70
00E0: 6578702E61706300 00010101001C713A 5C6261727339385C 6C6962726172795C
0100: 524547434C4E2E64 6C6C1C713A5C6261 727339385C6C6962 726172795C524547
0120: 434C4E2E61706300 00010101
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
		Fully Qualified External References? No
		Reject Multiple Window Instances? Yes
		Enable Runtime Checks Of External References? Yes
		Use Release 4.0 Scope Rules? No
	Libraries
		Dynalib: Global.apd
		Dynalib: Message.apd
		Dynalib: Absapi.apd
		!
		File Include: Constant.apl
		File Include: XSALIMG.APL
		File Include: Vtmeter.apl
		File Include: Winbars2.apl
		File Include: Vtdos.apl
		File Include: Vtlbx.apl
		File Include: Vttblwin.apl
		File Include: Vtarray.apl
		File Include: Docfun6.apl
		File Include: Gentbl.apl
		File Include: Genlist.apl
		Dynalib: NAL_DEC.APd
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
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Multiline Field
				Font Name: MS Sans Serif
				Font Size: 8
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
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Pushbutton
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
			Radio Button
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Check Box
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Option Button
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
			Group Box
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Child Table Window
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			List Box
				Font Name: MS Sans Serif
				Font Size: 8
				Font Enhancement: Use Parent
				Text Color: Use Parent
				Background Color: Use Parent
			Combo Box
				Font Name: MS Sans Serif
				Font Size: 8
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
			! Переменные для обязательных реквизитов клиентов банка
			Number: nRnk
			Number: nCustType
			Number: nCountry
			String: strNmk
			String: strNmkv
			String: strNmkk
			Number: nCodcagent
			Number: nPrinsider
			Number: nOkpo
			String: strAdr
			String: strSab
			String: sTaxf
			Number: nTaxf
			Number: nC_reg
			Number: nC_dst
			Number: nRgtax
			Date/Time: dtDateA
			String: strAdm
			Date/Time: dtDateT
			Number: nStmt
			Date/Time: dtDateOn
			Date/Time: dtDateOff
			String: strNotes
			Number: nCrisk
			Long String: lstrNotesSec
			String: strPinCode
			Date/Time: dTempDate
			! Переменные для дополнительных реквизитов клиентов
					  (Юридические лица)
			String: strNmku
			String: strRuk
			String: strTelr
			String: strBuh
			String: strTelb
			String: strIse
			String: strFs
			String: strOe
			String: strSed
			String: strVed
			! Переменные для дополнительных реквизитов клиентов
					  (Физические лица)
			Number: nSex
			Number: nPassp
			String: strSer
			String: strNumDoc
			Date/Time: dtPdate
			String: strOrgan
			Date/Time: dtBday
			String: strBplace
			String: strTeld
			String: strTelw
			! Переменные для дополнительных реквизитов клиентов (Банки)
			String: strMfoEx
			String: strBic
			String: strAltBic
			Number: nFetchRes
			String: sText
			Sql Handle: hSqlABS
			Boolean: bFlagABS
			String: sODBDataBase
		Internal Functions
			Function: ImpNal8                            ! __exported
				Description:
				Returns
				Parameters
					Window Handle: hW
					Number: nType
				Static Variables
				Local variables
				Actions
					If nType = 0 or nType = 1 !! MOPER & SBU
						Call SalModalDialog(dlg_ImpNal8, hW, nType)
		Named Menus
		Class Definitions
.data RESOURCE 0 0 1 3232911755
0000: 4C02000021010000 0000000000000000 0200000300FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F41003C00 000D630052616469
0040: 6F4C69730074426F 7886000000F00500 0000E0010D000000 FF3F0D00B9000100
0060: FFFFE01A00000001 FE00FF8327000000 01FB00FF0F340000 00EE0100FF3F0180
0080: 005A000000010000 00000463446F63EE 0000E00009000000 C10204000000FF7F
00A0: 047200000200FFFF C10800000002FD00 FF070C00000001F6 0D00FF1F190000DC
00C0: 000100FF7F267000 00000100FFFFC133 00000001FD00FF07 4000000001F700FF
00E0: 1F4D0000DC000100 FF7F010080220000 0002000000000A63 47656E4669006C74
0100: 657274000000F604 008C0204000100FE 00C18001000000BF 04B100010D00FFFF
0120: E01100000002FE00 FF831500000001FB 00FF0F
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
			Custom Control: cMeter
		Application Actions
	Dialog Box: dlg_ImpNal8
		Class:
		Property Template:
		Class DLL Name:
		Title: Импорт информации для налогового учета из ОДБ (финансовый учет)
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   0.15"
				Top:    0.146"
				Width:  12.95"
				Width Editable? Yes
				Height: 6.833"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
		Description: Прием документов и оплата документов из 'старого' БАРСа
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
			Background Text: Всего:
				Resource Id: 49018
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.083"
					Top:    0.095"
					Width:  1.25"
					Width Editable? Yes
					Height: 0.31"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Arial Cyr
				Font Size: 14
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Data Field: dfAll
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 6
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   1.483"
						Top:    0.095"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.31"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: 14
					Font Enhancement: Default
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Background Text: Выбрано:
				Resource Id: 49019
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.783"
					Top:    0.095"
					Width:  1.717"
					Width Editable? Yes
					Height: 0.31"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Arial Cyr
				Font Size: 14
				Font Enhancement: Bold
				Text Color: Blue
				Background Color: Default
			Data Field: dfGood
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 6
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   4.683"
						Top:    0.095"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.31"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: 14
					Font Enhancement: Default
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Background Text: Обработано:
				Resource Id: 49020
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   5.983"
					Top:    0.095"
					Width:  2.167"
					Width Editable? Yes
					Height: 0.31"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Arial Cyr
				Font Size: 14
				Font Enhancement: Bold
				Text Color: Dark Green
				Background Color: Default
			Data Field: dfCurrent
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 6
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   8.283"
						Top:    0.095"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.31"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: 14
					Font Enhancement: Default
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Background Text: Нет связи:
				Resource Id: 49021
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   9.583"
					Top:    0.119"
					Width:  1.933"
					Width Editable? Yes
					Height: 0.31"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Arial Cyr
				Font Size: 14
				Font Enhancement: Bold
				Text Color: Red
				Background Color: Default
			Data Field: dfNoLink
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 6
					Data Type: Number
					Editable? No
				Display Settings
					Window Location and Size
						Left:   11.65"
						Top:    0.119"
						Width:  1.2"
						Width Editable? Yes
						Height: 0.31"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: 14
					Font Enhancement: Default
					Text Color: Default
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Pushbutton: pbExecute
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Импорт
				Window Location and Size
					Left:   3.083"
					Top:    5.988"
					Width:  1.6"
					Width Editable? Yes
					Height: 0.417"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: Enter
				Font Name: Default
				Font Size: 10
				Font Enhancement: Bold
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						If IsBankDayOpen()
							If sODB='DBF'
								! Call WaitCursorOff()
							Else
								Call SalDisableWindow(pbExecute)
								Call SalDisableWindow(pbExit)
								Set dfDone = ""
								Set dfStart = 'Старт: ' || SalFmtFormatDateTime(SalDateCurrent(), 'hhh:mm:ss')
								Call SaveInfoToLog("Прием/Оплата документов налогового учета.")
								Call SalModalDialog( dlg_Connect, hWndForm )
								! Подключение прошло успешно к ОДБ bFlagABS=1
								If bFlagABS=1
									! Заполнение MOPER
									Call SalTblReset( tbl1 )
									! Ищем док-т который могли не доимпортить
									Call SqlPrepareAndExecute( hSqlABS, "select nvl(val,0) into :nRefNotImport from params where par='REF_ASPO' " )
									If SqlFetchNext(hSqlABS, nFetchRes)
										Set sInsUpdParams = "update params set val = :nRefParams
												where par = 'REF_ASPO' "
									Else
										Set sInsUpdParams = "insert into params (par,val,comm)
												values ('REF_ASPO',:nRefParams,'Импорт док-в в АСПО')"
										Set nRefNotImport = 0
									If rbDates
										Set dDateStart = dfDbeg
										Set dDateEnd = dfDend
									Else
										Set dDateStart = SalDateQuarterBegin(SalDateConstruct(dfGod, dfKw*3, 1, 0, 0, 0))
										Set dDateEnd = SalDateQuarterBegin(SalDateConstruct(dfGod, dfKw*3, 1, 0, 0, 0) + 92) - 1
									Set dfDone = "Импортируем данные ..."
									If dDateStartABS > dDateStart
										Set dDateStart = dDateStartABS
									If dDateStartABS > dDateEnd
										Set dDateEnd = dDateStartABS
									Call WaitCursorOn(  )
									Set sSqlOut =''
									Set sSqlOut1=''
									Set sSqlAll =''
									Set sSqlAll1 =''
									Set sSqlAllN =''
									Set sSqlAllN1 =''
									If rbBii and SalStrTrimX( dfBi ) != ''
										Call ABSSqlLike(SalStrTrimX( dfBi ),' LIKE ', ' OR ',sSqlOut,sSqlOut1)
										If SalStrLength( sSqlOut )>0
											Set sSqlAll   = sSqlAll   || sSqlOut
											Set sSqlAll1 = sSqlAll1 || sSqlOut1
									If rbVii and SalStrTrimX( dfVi ) != ''
										Call ABSSqlLike(SalStrTrimX( dfVi ),' LIKE ', ' OR ',sSqlOut,sSqlOut1)
										If SalStrLength( sSqlOut )>0
											Set sSqlAll   = sSqlAll   || sSqlOut
											Set sSqlAll1 = sSqlAll1 || sSqlOut1
									If rbBoo and SalStrTrimX( dfBo ) != ''
										Call ABSSqlLike(SalStrTrimX( dfBo ),' NOT  LIKE ',' AND ',sSqlOut,sSqlOut1)
										If SalStrLength( sSqlOut )>0
											Set sSqlAllN   = sSqlAllN   || sSqlOut
											Set sSqlAllN1 = sSqlAllN1 || sSqlOut1
									If rbVoo and SalStrTrimX( dfVo ) != ''
										Call ABSSqlLike(SalStrTrimX( dfVo ),' NOT  LIKE ',' AND ',sSqlOut,sSqlOut1)
										If SalStrLength( sSqlOut )>0
											Set sSqlAllN   = sSqlAllN   || sSqlOut
											Set sSqlAllN1 = sSqlAllN1 || sSqlOut1
									If sSqlAll   !='' or sSqlAllN   !=''
										Set sSqlAll   = IifS(sSqlAll    !='' ," ( "||SalStrMidX( sSqlAll   , 4, SalStrLength( sSqlAll    ))||" ) " ,'')||
												                       IifS( ( sSqlAll !='' and ( rbBii or rbVii ) ) and ( sSqlAllN    !='' and ( rbBoo or rbVoo ) ),' and ','')||
												                       IifS(sSqlAllN !='' ," ( "||SalStrMidX( sSqlAllN, 5, SalStrLength( sSqlAllN  ))||" ) " ,'')
									If sSqlAll1   !='' or sSqlAllN1   !=''
										Set sSqlAll1 = IifS(sSqlAll1    !='' ," ( "||SalStrMidX( sSqlAll1   , 4, SalStrLength( sSqlAll1    ))||" ) " ,'')||
												                       IifS( ( sSqlAll1 !='' and ( rbBii or rbVii ) ) and ( sSqlAllN1    !='' and ( rbBoo or rbVoo ) ),' and ','')||
												                       IifS(sSqlAllN1 !='' ," ( "||SalStrMidX( sSqlAllN1, 5, SalStrLength( sSqlAllN1  ))||" ) " ,'')
									If sSqlAll   !=''  or sSqlAll1 !=''
										Set sSqlOut = ' AND ' ||
												                      IifS( sSqlAll   !='',"  ( ( ( "|| sSqlAll ||" ) AND o.mfoa=:sBankMFO ) ",'') ||
												                      IifS( sSqlAll   !=''  and sSqlAll1 !='' , ' OR ', IifS( sSqlAll   !='' , ' ) ' , ' ( ' ) ) ||
												                      IifS( sSqlAll1 !=''," ( ( "|| sSqlAll1 ||" ) AND o.mfob=:sBankMFO ) ) ",'')
									When SqlError
										Call WaitCursorOff()
										! Return FALSE
									Set sRnk = Str(GetIdRnk())
									Set sMfoA = GetValueStr("
											    SELECT mfo
											    FROM custbank
											    WHERE rnk=" || sRnk)
									Set sMfoA = IifS(sMfoA='', GetBankMfo(), sMfoA)
									Call SqlPrepareAndExecute( hSqlABS, "select val into :sBankMFO from params where par='MFO'" )
									Call SqlFetchNext(hSqlABS, nFetchRes)
									If not sBankMFO = sMfoA
										Call WaitCursorOff()
										Call MessageNoWait('Не совпадают МФО АБС('||sBankMFO||') и АСНУ('||sMfoA||'). Импорт прервано !!!', 'Сообщение', 7, 1)
										Call SqlDisconnect( hSqlABS )
										Call SalEnableWindow(pbExecute)
										Call SalEnableWindow(pbExit)
										Call SalSetFocus(pbExit)
										Return FALSE
									If SqlPrepareAndExecute( hSqlABS, "
											insert into moperabs(nm,ref,DATD,mfo,nls,nlsk,plat,polu,naz1,DK,S,VDATE,SOS,SK,ND,VOB,kod,vspo,kisp,ref99bm,stmt,nlsa,nmsa,nlsb,nmsb)
											select distinct  decode(o.mfoa,:sBankMFO,decode(o.mfoa,o.MFOB,1,2),decode(o.mfob,:sBankMFO,3)) nm, od.ref, o.DATD,
											       decode(o.mfoa,:sBankMFO,decode(o.mfoa,o.MFOB,0,o.MFOB),decode(o.mfob,:sBankMFO,o.mfoa)) mfo, ad.NLS nls,
											       ak.NLS nlsk, substr(ad.NMS,1,38) plat, substr(ak.NMS,1,38) polu, o.nazn naz1, o.DK, od.S, od.fdat vdate, od.SOS,
											       o.SK, o.ND, o.VOB, o.id_a kod, o.id_b vspo, '' kisp,  0 ref99bm, oD.stmt stmt, o.nlsa, o.nam_a nmsa, o.nlsb, o.nam_b nmsb
											from accounts aD,opldok oD,accounts ak,opldok ok, oper o
											where ad.ACC=od.ACC   and od.DK=0         and
											      ak.ACC=ok.ACC   and ok.DK=1         and od.sos=ok.sos  and od.sos=5  and
											      od.ref=ok.ref   and od.stmt=ok.stmt and od.dk<>ok.dk   and od.s=ok.s and
											      od.fdat=ok.fdat and od.tt=ok.tt     and od.acc<>ok.acc and
											      od.ref=o.ref    and aD.kv=980 and ak.kv=980 and  (oD.TT not like 'ZG_' and oK.TT not like 'ZG_')  and
											      od.fdat between :dDateStart and :dDateEnd and  " || IifS(rbKdok, ' ( o.vob = 96 ) and ',' ( o.vob not in (96,99) ) and ' ) ||
											   "o.ref not in (select ref from moperabs) "||sSqlOut||" order by od.ref ")
										Call SqlCommit( hSqlABS )
									Else
										Set nConnectError = SqlError( hSqlABS )
										Call MessageNoWait('Ошибка при заполнении таб. MOPER [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										Call SqlRollback( hSqlABS )
										Call SqlDisconnect( hSqlABS )
										Call SalEnableWindow(pbExecute)
										Call SalEnableWindow(pbExit)
										Call SalSetFocus(pbExit)
										Return FALSE
									Call SqlPrepareAndExecute(hSqlABS, "SELECT count(*) INTO :nRecCount FROM moperABS where ref99bm = 0 ")
									Call SqlFetchNext(hSqlABS, nFetchRes)
									If nRecCount = 0
										Call SqlDisconnect(hSqlABS)
										Call WaitCursorOff()
										Call MessageNoWait('Нет информации для импорта !!!', 'Сообщение', 7, 1)
										Call SalEnableWindow(pbExecute)
										Call SalEnableWindow(pbExit)
										Call SalSetFocus(pbExit)
										Return FALSE
									! Берем данные из SBU
									Call SalArraySetUpperBound(sSbuNLS, 1, -1)
									Call SalArraySetUpperBound(sSbuNLS8, 1, -1)
									Call SalArraySetUpperBound(nSbuFLAG, 1, -1)
									Set n21 = 0
									If not SqlPrepareAndExecute(hSql(), "
											       SELECT nls,nls8,flag
											       INTO :sNLS,:sNLS8,:nFLAG
											       FROM sbu
											       where Rtrim(rnk)=Rtrim(:sRnk)")
										Set nConnectError = SqlError( hSql() )
										Call MessageNoWait('Ошибка при работе с таб. SBU [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										Call SqlDisconnect( hSqlABS )
										Call SalEnableWindow(pbExecute)
										Call SalEnableWindow(pbExit)
										Call SalSetFocus(pbExit)
										Return FALSE
									Set bProdol = TRUE
									While SqlFetchNext(hSql(), nFetchRes)
										Set sSbuNLS[n21] = SalStrTrimX(sNLS)
										Set sSbuNLS8[n21] = SalStrTrimX(sNLS8)
										Set nSbuFLAG[n21] = IifN(nFLAG=NUMBER_Null, 0, nFLAG)
										Set n21 = n21 + 1
									! Втягуем MOPERABS
									Set nTimeStart = SalDateHour(SalDateCurrent())*3600 + SalDateMinute(
											    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
									Set dfStart = 'Старт: ' || SalFmtFormatDateTime(SalDateCurrent(), 'hhh:mm:ss')
									Set dfCurrent = 0
									Set dfAll = nRecCount
									Set dfGood = 0
									Set dfNoLink = 0
									Set nPos = 0
									Set nTek = 0
									Set nRecn = 1
									Set nDelta = 100 / nRecCount
									If not SqlPrepareAndExecute(hSql(), "
											       SELECT max(fdat)
											       INTO :dDat1
											       FROM fdat
											       WHERE fdat<:dfBD")
										Set nConnectError = SqlError( hSql() )
										Call MessageNoWait('Ошибка при работе с таб. Fdat [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										Call SqlDisconnect( hSqlABS )
										Call SalEnableWindow(pbExecute)
										Call SalEnableWindow(pbExit)
										Call SalSetFocus(pbExit)
										Return FALSE
									Call SqlFetchNext(hSql(), nFetchRes)
									Set dVdateU = dBankDate
									If SqlPrepareAndExecute(hSqlABS, "
											     SELECT ref, stmt
											     INTO    :nRefO ,:nSTMT
											     FROM moperabs
											     where ref99bm=0 ")
										! Call SqlOpen( hSqlABS , "moper" )
									Else
										Set nConnectError = SqlError( hSqlABS )
										Call MessageNoWait('Ошибка при работе с таб. MOPER [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										Call SqlDisconnect( hSqlABS )
										Call SalEnableWindow(pbExecute)
										Call SalEnableWindow(pbExit)
										Call SalSetFocus(pbExit)
										Return FALSE
									Set nABSNext=0
									While SqlFetchNext(hSqlABS, nFetchRes)
										Set nABSNext=nABSNext+1
										Set nABSRef[nABSNext]=nRefO
										Set nABSSTMT[nABSNext]=nSTMT
									If not SqlConnect( hSqlB )
										Set nConnectError = SqlError( hSqlABS )
										Call MessageNoWait('Ошибка при работе с базой данных АБС [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										Call SqlDisconnect( hSqlABS )
										Call SqlDisconnect( hSqlB )
										Call SalEnableWindow(pbExecute)
										Call SalEnableWindow(pbExit)
										Call SalSetFocus(pbExit)
										Return FALSE
									If not SqlConnect( hSqlC )
										Set nConnectError = SqlError( hSqlABS )
										Call MessageNoWait('Ошибка при работе с базой данных АБС [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										Call SqlDisconnect( hSqlABS )
										Call SqlDisconnect( hSqlC )
										Call SalEnableWindow(pbExecute)
										Call SalEnableWindow(pbExit)
										Call SalSetFocus(pbExit)
										Return FALSE
									While nABSNext>0
										If SqlPrepareAndExecute(hSqlB, "
												     SELECT nm,  dk,  mfo,  nd,  vob,  nls,  nlsk,  sk,  s,  plat,  polu, naz1,  vspo,  kod,  kisp,  sos,  ref99bm,  vdate,  tp, nlsa, nmsa, nlsb, nmsb
												     INTO    :nNm,:nDk,:nMfo,:sNd,:nVob,:sNls,:sNlsk,:nSk,:nS,:sPlat,:sPolu, :sNaz1,:sVspo,:sKod,:sKisp,:nSos,:nRef99bm,:dVdate,:sTp
												                 , :sNlsa, :sNmsa, :sNlsb, :sNmsb
												     FROM moperabs
												     where ref=:nABSRef[nABSNext]   and ref99bm=0 and stmt=:nABSSTMT[nABSNext]  and
												                 vdate  between :dDateStart and :dDateEnd  ") !-- FOR UPDATE OF ref99bm
											! Call SqlOpen( hSqlABS , "moper" )
										Else
											Set nConnectError = SqlError( hSqlABS )
											Call MessageNoWait('Ошибка при работе с таб. MOPER [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
													'Импорт ...', 10,1)
											Call SqlDisconnect( hSqlABS )
											Call SalEnableWindow(pbExecute)
											Call SalEnableWindow(pbExit)
											Call SalSetFocus(pbExit)
											Return FALSE
										!
										!
										!
										!
										!
										While SqlFetchNext(hSqlB, nFetchResABS)
										! Проверка есть ли документ в АСПО
										Set bPay = TRUE
										If nRefNotImport = nABSRef[nABSNext]
											Call SqlPrepareAndExecute( hSql(), "
													select distinct o.ref
													   into             :nRefASPO
													   from operw o, operw oo , oper op  , opldok od
													where o.ref=oo.REF and o.tag<>oo.tag and o.value=:nABSRef[nABSNext] and oo.value=:nABSSTMT[nABSNext] and
													           o.tag='ASPO1'  and oo.tag='ASPO2' and op.ref=o.ref  and od.ref=op.ref and od.dk=0  ")
											! ! @@@
											If SqlFetchNext(hSql(), nFetchResSBU)
												If SqlPrepareAndExecute(hSqlC, "
														   UPDATE moperabs
														   SET ref99bm=:nRefASPO
														   WHERE ref=:nABSRef[nABSNext]  and stmt=:nABSSTMT[nABSNext]  ")
													Call SqlCommit( hSqlC )
												Else
													! Call SqlRollback( hSqlC )
												Set bPay = FALSE
										! Импорт данных
										If bPay = TRUE
											! Пишем ref который будем импортить !!!
											Set nRefParams = nABSRef[nABSNext]
											If SqlPrepareAndExecute( hSqlABS,  sInsUpdParams)
												Call SqlCommit( hSqlABS )
												Set sInsUpdParams = "update params set val = :nRefParams
														where par = 'REF_ASPO' "
											Else
												! Call SqlRollback( hSqlABS )
												Break
											Set dVdateOrig = dVdate
											Set sNls = SalStrTrimX(sNls)
											Set sNlsk = SalStrTrimX(sNlsk)
											Set sNd = SalStrTrimX((sNd))
											Set sMfo = SalNumberToStrX(nMfo, 0)
											Set sMfo = IifS(Val(sMfo)=0, sMfoA, sMfo)
											If rb1
												Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
												Call SalTblSetContext(tbl1, nNewRow)
												Set tbl1.colNPP = nRecn
												Set tbl1.colND = sNd
												Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
												Set tbl1.colNLSA = sNls
												Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
												Set tbl1.colNLSB = sNlsk
												Set tbl1.colS = nS / 100
												Set tbl1.colVDATE = dVdate
												Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
												Call SalTblSetFocusRow(tbl1, nNewRow)
												Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New, FALSE)
												If Val(sNls) = 0
													Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Gray)
												Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
												If tbl1.colREF98 != NUMBER_Null
													Call SalTblSetCellTextColor(tbl1.colREF98, COLOR_DarkGreen, TRUE)
												Else
													Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Gray)
											If (nNm = 1 or nNm = 2 or nNm = 3) and nSos = 5 and nS > 0 and
													   (((nRef99bm = 0 or nRef99bm = NUMBER_Null) and nType = 0) or
													   nType = 1 and nRef99bm > 0)
												Set bStop = FALSE
												If not bStop
													Set sKisp = SalStrTrimX(sKisp)
													If Len(sKisp) = 0
														Set sKisp = GetBankOperIdent(sMfoA, sTp)
													Set sPlat = SalStrTrimX((sPlat))
													Set sPolu = SalStrTrimX((sPolu))
													Set sNaz1 = SalStrTrimX((sNaz1))
													Set sVspo = SalStrTrimX((sVspo))
													Set sKod = SalStrTrimX(sKod)
													If nNm != 0
														! Set sMfo = sMfoA
														If nDk = 5
															Set nIndex0 = VisArrayFindString(sSbuNLS, sNls)
															Set nIndex1 = VisArrayFindString(sSbuNLS, sNlsk)
														Else ! nDk = 0 or nDk =1
															Set nIndex0 = VisArrayFindString(sSbuNLS, sNlsk)
															Set nIndex1 = VisArrayFindString(sSbuNLS, sNls)
														Set bWozw = FALSE
														If nIndex0 >= 0 and nIndex1 >= 0 and
																   sSbuNLS8[nIndex0] = sSbuNLS8[nIndex1]
															Set nSbuFLAG_0 = nSbuFLAG[nIndex0]
															Set nSbuFLAG_1 = nSbuFLAG[nIndex1]
															Set nSbuFLAG[nIndex0] = 0 ! без визы
															Set nSbuFLAG[nIndex1] = 0 ! без визы
															Set bWozw = TRUE
														! flagi
														If nIndex0 >= 0 and nIndex1 >= 0 and
																   sSbuNLS8[nIndex0] != sSbuNLS8[nIndex1] and
																   nSbuFLAG[nIndex0] != nSbuFLAG[nIndex1]
															Set nSbuFLAG_0 = nSbuFLAG[nIndex0]
															Set nSbuFLAG_1 = nSbuFLAG[nIndex1]
															Set nSbuFLAG[nIndex0] = 1 ! с визой
															Set nSbuFLAG[nIndex1] = 1 ! с визой
															Set bWozw = TRUE
													Set n21 = 0
													Set bMa = FALSE
													Set bMc = FALSE
													Set nStep = 0
													While n21 < 2 and (nIndex0 >= 0 or nIndex1 >= 0) ! можно обрабатывать
														If n21 = 0
															If nIndex0 >= 0
																Set sNls8 = sSbuNLS8[nIndex0]
																Set nDk2 = 0
																Set nFlag = nSbuFLAG[nIndex0]
																If Len(sNls8) = 0 or (nNm = 1 and nIndex1 >= 0 and
																		   Len(sSbuNLS8[nIndex1]) = 0)
																	Set n21 = n21 + IifN(nNm=1, 2, 1)
																	Set bDalee = FALSE
																	! покрасить
																	If not rb1
																		Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																		Call SalTblSetContext(tbl1, nNewRow)
																		Set tbl1.colNPP = nRecn
																		Set tbl1.colND = sNd
																		Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																		Set tbl1.colNLSA = sNls
																		Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																		Set tbl1.colNLSB = sNlsk
																		Set tbl1.colS = nS / 100
																		Set tbl1.colVDATE = dVdate
																		Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																		Call SalTblSetFocusRow(tbl1, nNewRow)
																		Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																				     FALSE)
																	Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Teal)
																	! ----------------------------------------------------------------
																	If Len(sNls8)=0
																		Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																	If nIndex1 >= 0
																		If Len(sSbuNLS8[nIndex1])=0  ! and nIndex1 >= 0
																			Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																	Set dfNoLink = dfNoLink + 1
																	Set nI = 0
																Else
																	Set bDalee = TRUE
															Else
																Set n21 = n21 + 1
																Set bDalee = FALSE
														Else ! If n21 = 1
															If nIndex1 >= 0
																Set sNls8 = sSbuNLS8[nIndex1]
																Set nDk2 = 1
																Set nFlag = nSbuFLAG[nIndex1]
																If Len(sNls8) = 0 or (nNm = 1 and nIndex0 >= 0 and
																		   Len(sSbuNLS8[nIndex0]) = 0)
																	Set n21 = n21 + 1
																	Set bDalee = FALSE
																	! покрасить
																	! почему-то ЗЕЛЕНЫЙ есть ???
																	If not rb1
																		Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																		Call SalTblSetContext(tbl1, nNewRow)
																		Set tbl1.colNPP = nRecn
																		Set tbl1.colND = sNd
																		Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																		Set tbl1.colNLSA = sNls
																		Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																		Set tbl1.colNLSB = sNlsk
																		Set tbl1.colS = nS / 100
																		Set tbl1.colVDATE = dVdate
																		Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																		Call SalTblSetFocusRow(tbl1, nNewRow)
																		Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																				     FALSE)
																	Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Teal)
																	! -------------------------------------------------------------
																	If Len(sNls8)=0
																		Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																	If nIndex0 >= 0
																		If Len(sSbuNLS8[nIndex0])=0  ! and nIndex0 >= 0
																			Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																	Set dfNoLink = dfNoLink + 1
																Else
																	Set bDalee = TRUE
															Else
																Break
														If bDalee
															If nVob = 96 and Mod(SalDateMonth(dVdate), 3) = 1
																Set dVdate = IifD(dDat1=DATETIME_Null,
																		    SalDateMonthBegin(dBankDate)-1, dDat1)
															Else If nVob = 99
																Set dVdate = SalDateConstruct(SalDateYear(dVdate)-1, 12, 31, 0, 0,
																		    0)
															Else
																Set dVdate = dBankDate
															If (nVob = 96 and Mod(SalDateMonth(dVdate), 3) = 1) or nVob = 99
																Call SqlPrepareAndExecute(hSql(), "
																		     SELECT fdat
																		     FROM fdat
																		     WHERE fdat=:dVdate")
																! ! @@@
																If not SqlFetchNext(hSql(), nFetchRes1)
																	Call SqlPrepareAndExecute(hSql(), "
																			     INSERT
																			     INTO fdat (fdat)
																			     VALUES (:dVdate)")
															If dVdate != dVdateU
																Call Pl_dat(dVdate) ! Установить банковскую дату равной VDATE в
																		                    ! MOPER (но не совсем)
																Set dVdateU = dVdate
															If not bMa
																Set bMa = TRUE
																If not rb1
																	Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																	Call SalTblSetContext(tbl1, nNewRow)
																	Set tbl1.colNPP = nRecn
																	Set tbl1.colND = sNd
																	Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																	Set tbl1.colNLSA = sNls
																	Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																	Set tbl1.colNLSB = sNlsk
																	Set tbl1.colS = nS/100
																	Set tbl1.colVDATE = dVdate
																	Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																	Call SalTblSetFocusRow(tbl1, nNewRow)
																	Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																			     FALSE)
																Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Blue)
																Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
																Set dfGood = dfGood + 1
															Set nFlag = IifN(Left(sNaz1, 4)='ь-01' or Left(sNaz1, 4)='Ь-01' or
																	    Left(sNaz1, 4)='ь-02' or Left(sNaz1, 4)='Ь-02' or
																	    Left(sNaz1, 4)='ь-04' or Left(sNaz1, 4)='Ь-04', 0,
																	    IifN(nVob=96 or nVob=99, 1, nFlag))
															If nType = 1
																Set bSD = FALSE
																If Ful_Bak(nRef99bm)
																	Set bSD = SqlPrepareAndExecute(
																			    hSql(), "
																			    DELETE
																			    FROM oper
																			    WHERE ref=:nRef99bm")
															Else
																Set bSD = TRUE
															If bSD and Len(sNaz1)>3
																Call ccDoc.SetDoc(IifN(nStep=0, 0, nRef), 'PO' || Str(1-nFlag),
																		     nDk, nVob, sNd, dVdateOrig, SalDateCurrent(), dVdate, dVdate,
																		     IifS(nDk=0, sNlsk, sNls), IifS(nDk=0, sPolu, sPlat),
																		     sMfoA, '', 980, nS, sKod, IifS(nDk=0, sNls, sNlsk), IifS(nDk=0, sPlat, sPolu), sMfoA,
																		     '', 980, nS, '', sNaz1, sVspo, sKisp, '', nSk, 0)
																If ccDoc.oDoc()
																	Set nRef = ccDoc.m_nRef
																	Set nStep = nStep + 1
																	Set ccDoc.A.Kv = 980
																	Set ccDoc.m_nDk = nDk2
																	If ccDoc.PayTT(1-nFlag, nRef, ccDoc.m_dDatV1, 'PO' || Str(1-nFlag),
																			   ccDoc.m_nDk, ccDoc.A.Kv, sNls8, ccDoc.A.S, ccDoc.B.Kv, 
																			   'BBBBK' || SalStrRepeatX('0', 2-Len(sRnk)) || sRnk, ccDoc.B.S)
																		Set nL0 = 0
																		Set nL1 = 0
																		If nIndex0 >= 0
																			Set nL0 = Len(sSbuNLS8[nIndex0])
																		If nIndex1 >= 0
																			Set nL1 = Len(sSbuNLS8[nIndex1])
																		If nNm != 1 or (nNm = 1 and ((nL0 * nL1 > 0 and n21 = 1) or
																				   (nL0 > 0 and nL1 = 0) or (nL0 = 0 and nL1 > 0)))
																			Set sNmsa1 = IifS(nDk=1, sNmsa, sNmsb)
																			Set sNmsb1 = IifS(nDk=1, sNmsb, sNmsa)
																			If SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO1' , :nABSRef[nABSNext] ) " ) and
																					   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO2' , :nABSSTMT[nABSNext]) " ) and
																					   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO3' ,  "||  IifS(nNm=3, sMfo,sMfoA) ||" ) " ) and
																					   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO4' ,  "||  IifS(nDk=1, sNlsa  , sNlsb) ||" ) " ) and
																					   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO5' ,  :sNmsa1 ) " ) and
																					   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO6' ,  "||  IifS(nNm=3, sMfoA,sMfo) ||" ) " ) and
																					   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO7' ,  "||  IifS(nDk=1, sNlsb  , sNlsa) ||" ) " ) and
																					   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO8' ,  :sNmsb1 ) " )
																				If SqlPrepareAndExecute(hSqlC, "
																						   UPDATE moperabs
																						   SET ref99bm=:ccDoc.m_nRef
																						   WHERE ref=:nABSRef[nABSNext] and stmt=:nABSSTMT[nABSNext]  ")
																					If SqlCommitEx(hSql(), 'Мак.' || Str(nNm) || ', счетА='
																							     || sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(
																							     Str(nS), Len(Str(nS))-2) || '.' || Right(Str(nS), 2)
																							     || ', DK=' || Str(nDk) || ', ЧО=' || Str(1-nFlag) ||
																							     ', Ref=' || Str(nRef))
																						Call SqlCommit( hSqlC )
																					Else
																						!   Call SqlRollback( hSqlC )
																					If not bMc
																						Set dfCurrent = dfCurrent + 1
																						Set bMc = TRUE
																					Set tbl1.colREF98 = nRef
																					Call VisTblSetRowColor(tbl1, nNewRow, COLOR_DarkGreen)
																					Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
																				Else
																					Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) ||
																							     ', счетА=' || sNls || ', счетБ=' || sNlsk ||
																							     ', сумма=' || Left(Str(nS), Len(Str(nS))-2) || '.' ||
																							     Right(Str(nS), 2) || ', DK=' || Str(nDk) || ', ЧО='
																							     || Str(1-nFlag))
																					Set n21 = n21 + 1 ! Для выхода
																			Else
																				Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) ||
																						     ', счетА=' || sNls || ', счетБ=' || sNlsk ||
																						     ', сумма=' || Left(Str(nS), Len(Str(nS))-2) || '.' ||
																						     Right(Str(nS), 2) || ', DK=' || Str(nDk) || ', ЧО='
																						     || Str(1-nFlag))
																				Set n21 = n21 + 1 ! Для выхода
																	Else
																		Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																				     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(
																				     Str(nS), Len(Str(nS))-2) || '.' || Right(Str(nS), 2) ||
																				     ', DK=' || Str(nDk) || ', ЧО=' || Str(1-nFlag))
																		Set n21 = n21 + 1 ! Для выхода
																Else
																	Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																			     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(Str(nS),
																			     Len(Str(nS))-2) || '.' || Right(Str(nS), 2) || ', DK=' ||
																			     Str(nDk) || ', ЧО=' || Str(1-nFlag))
																	Set n21 = n21 + 1 ! Для выхода
															Else
																Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																		     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(Str(nS),
																		     Len(Str(nS))-2) || '.' || Right(Str(nS), 2) || ', DK=' ||
																		     Str(nDk) || ', ЧО=' || Str(1-nFlag))
																Set n21 = n21 + 1 ! Для выхода
															Set n21 = n21 + 1
													If nNm = 1 and nIndex0 >= 0 and nIndex1 >= 0 and bWozw
														Set nSbuFLAG[nIndex0] = nSbuFLAG_0
														Set nSbuFLAG[nIndex1] = nSbuFLAG_1
											Set nPos = nPos + nDelta
											Set nRecn = nRecn + 1
											If Int(nPos) != nTek
												Set nTek = Int(nPos)
												Set nTimeCurrent = SalDateHour(SalDateCurrent())*3600 +SalDateMinute(
														    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
												Set nTimeEnd = Int(100 * (nTimeCurrent-nTimeStart) / nPos + nTimeStart)
												Set nHour = Int(nTimeEnd/3600)
												Set nTemp = nTimeEnd - nHour*3600
												Set nMinu = Int(nTemp/60)
												Set dfAll = dfAll
												Set dfGood = dfGood
												Set dfCurrent = dfCurrent
												Set dfNoLink = dfNoLink
												Set dfStart = dfStart
												Set dfEnd = 'Финиш: ' || Right(Str(100+nHour), 2) || ':' || Right(
														    Str(100+nMinu), 2) || ':' || Right(Str(100+nTemp-nMinu*60), 2) ||
														    ' (прогноз)'
											Call ccProgressBar.SetProgress(nPos)
											Call SalUpdateWindow(hWndForm)
										Set nABSNext=nABSNext-1
									Set nRefParams = 0
									If SqlPrepareAndExecute( hSqlABS,  sInsUpdParams)
										Call SqlCommit( hSqlABS )
									Call ccProgressBar.SetProgress(100)
									Set dfEnd = Left(dfEnd, 15)
									Call SalSetFocus(tbl1)
									Call VisTblAutoSizeColumn(tbl1, hWndNULL)
									Call WaitCursorOff()
									Set dfDone = "Готово"
									Call SaveInfoToLog("Прием документов налогового учета ОКОНЧЕН.")
									Call SalMessageBox('Импорт успешно завершен !','Импорт ...', MB_Ok)
									Call SqlDisconnect( hSqlABS )
									Call SqlDisconnect( hSqlB )
									Call SqlDisconnect( hSqlC )
								Else
									Call SalMessageBox( 'Импорт прерван пользователем ...', 'Ошибка ...',  MB_Ok )
								Call SalEnableWindow(pbExecute)
								Call SalEnableWindow(pbExit)
								Call SalSetFocus(pbExit)
								Call WaitCursorOff()
						Else
							Call MessageNoWait('День закрыт !', 'Предупреждение', 0, 1)
			Pushbutton: pbExit
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Выход
				Window Location and Size
					Left:   10.983"
					Top:    5.988"
					Width:  1.7"
					Width Editable? Yes
					Height: 0.417"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: Esc
				Font Name: Default
				Font Size: 10
				Font Enhancement: Bold
				Picture File Name:
				Picture Transparent Color: None
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						Call SalEndDialog(hWndForm, FALSE)
			Frame
				Resource Id: 49022
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.983"
					Top:    5.905"
					Width:  9.8"
					Width Editable? Yes
					Height: 0.583"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Solid
				Border Thickness: 1
				Border Color: Default
				Background Color: 3D Face Color
			Data Field: dfDone
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
						Left:   8.983"
						Top:    5.988"
						Width:  1.9"
						Width Editable? Yes
						Height: 0.405"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Center
					Format: Unformatted
					Country: Default
					Font Name: Default
					Font Size: 10
					Font Enhancement: Bold
					Text Color: Magenta
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Custom Control: ccProgressBar
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
						Left:   0.083"
						Top:    5.571"
						Width:  12.7"
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
					Text Color: Jade
					Background Color: Gray
					DLL Settings
				Message Actions
			Child Table: tbl1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Display Settings
					Window Location and Size
						Left:   0.083"
						Top:    0.488"
						Width:  12.7"
						Width Editable? Yes
						Height: 3.0"
						Height Editable? Yes
					Visible? Yes
					Font Name: Default
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					View: Table
					Allow Row Sizing? No
					Lines Per Row: Default
				Memory Settings
					Maximum Rows in Memory: 333333
					Discardable? Yes
				Contents
					Column: colNPP
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Nпп
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Center
						Width:  0.629"
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
					Column: colND
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Номер док.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
						Justify: Left
						Width:  1.143"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
								Vertical Scroll? Yes
								Auto Drop Down? No
								Allow Text Editing? Yes
							Cell CheckBox
								Check Value:
								Uncheck Value:
								Ignore Case? Yes
						List Values
						Message Actions
					Column: colMFOA
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: МФО-А
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
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
					Column: colNLSA
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Счет-А
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
					Column: colMFOB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: МФО-Б
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: String
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
					Column: colNLSB
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Счет-Б
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
						Width:  1.386"
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
					Column: colVDATE
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Дата вал.
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Date/Time
						Justify: Left
						Width:  1.071"
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
					Column: colREF98
						Class Child Ref Key: 0
						Class ChildKey: 0
						Class:
						Property Template:
						Class DLL Name:
						Title: Референс
						Visible? Yes
						Editable? No
						Maximum Data Length: Default
						Data Type: Number
						Justify: Right
						Width:  0.971"
						Width Editable? Yes
						Format: Unformatted
						Country: Default
						Input Mask: Unformatted
						Cell Options
							Cell Type? Standard
							Multiline Cell? No
							Cell DropDownList
								Sorted? Yes
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
					Number: nFocusRow
					Window Handle: hWndCol
				Message Actions
					On SAM_Click
						Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
						If not SalIsWindowEnabled(pbExecute)
							Call VisTblAutoSizeColumn(tbl1, hWndNULL)
					On SAM_CornerClick
						Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					On SAM_CornerDoubleClick
						Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					On SAM_DoubleClick
						Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					On SAM_RowHeaderClick
						Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					On SAM_RowHeaderDoubleClick
						Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					On SAM_EndCellTab
						Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					On WM_LbuttonUp
						! Узнать текущую строку
						! Call SalTblQueryFocus(tbl1, nFocusRow, hWndCol)
						! Set nFocusRow = SalTblQueryContext(tbl1)
						! Почистить все
						Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
						! Call SalTblSetFocusRow (tbl1, nFocusRow)
						! Стать на нее (что выше)
						! Call SalTblSetRowFlags(tbl1, nFocusRow, ROW_Selected, FALSE)
						! Call SalSendMsg(tbl1, SAM_RowHeaderClick, 0, Max(TBL_MaxRow, nFocusRow+1))
					On VTM_KeyUp
						Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
						If not SalIsWindowEnabled(pbExecute)
							Call VisTblAutoSizeColumn(tbl1, hWndNULL)
					On WM_NCMouseMove ! 160
						If not SalIsWindowEnabled(pbExecute)
							Call VisTblAutoSizeColumn(tbl1, hWndNULL)
			Data Field: dfStart
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
						Left:   4.783"
						Top:    6.012"
						Width:  3.9"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Fixedsys
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Periwinkle
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Data Field: dfEnd
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
						Left:   4.783"
						Top:    6.179"
						Width:  3.9"
						Width Editable? Yes
						Height: 0.167"
						Height Editable? Yes
					Visible? Yes
					Border? No
					Justify: Left
					Format: Unformatted
					Country: Default
					Font Name: Fixedsys
					Font Size: Default
					Font Enhancement: Bold
					Text Color: Periwinkle
					Background Color: 3D Face Color
					Input Mask: Unformatted
				Message Actions
			Radio Button: rb1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Показывать все док.
				Window Location and Size
					Left:   0.183"
					Top:    5.94"
					Width:  2.5"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Teal
				Background Color: Default
				Message Actions
			Radio Button: rb2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Только допустимые
				Window Location and Size
					Left:   0.183"
					Top:    6.179"
					Width:  2.5"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Teal
				Background Color: Default
				Message Actions
			Frame
				Resource Id: 49023
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.083"
					Top:    5.905"
					Width:  2.8"
					Width Editable? Yes
					Height: 0.583"
					Height Editable? Yes
				Visible? Yes
				Corners: Round
				Border Style: Etched
				Border Thickness: 1
				Border Color: Default
				Background Color: Default
			Background Text: Дата отчетного периода
				Resource Id: 49024
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   9.383"
					Top:    4.845"
					Width:  3.2"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: 10
				Font Enhancement: Bold
				Text Color: Charcoal
				Background Color: Default
			Data Field: dfBD
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
						Left:   10.683"
						Top:    5.071"
						Width:  1.9"
						Width Editable? Yes
						Height: 0.333"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Center
					Format: Date
					Country: Default
					Font Name: Default
					Font Size: 12
					Font Enhancement: Bold
					Text Color: Burgundy
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Validate
						If dfBD > dBankDate
							Call MessageNoWait('Локальная дата не может быть больше текущей даты !', 'ОШИБКА',
									     30, 1)
							Return VALIDATE_Cancel
						Call SalSendMsg(dfGod, SAM_Create, 0, 0)
						Call SalSendMsg(dfKw, SAM_Create, 0, 0)
						Call SalSendMsg(dfDbeg, SAM_Create, 0, 0)
						Call SalSendMsg(dfDend, SAM_Create, 0, 0)
			Radio Button: rbGodKw
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Год, квартал
				Window Location and Size
					Left:   3.283"
					Top:    4.905"
					Width:  1.8"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						Call SalDisableWindow(dfDbeg)
						Call SalDisableWindow(dfDend)
						Call SalEnableWindow(dfGod)
						Call SalEnableWindow(dfKw)
			Radio Button: rbDates
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Интервал дат
				Window Location and Size
					Left:   3.283"
					Top:    5.155"
					Width:  1.8"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: 8
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						Call SalEnableWindow(dfDbeg)
						Call SalEnableWindow(dfDend)
						Call SalDisableWindow(dfGod)
						Call SalDisableWindow(dfKw)
			Data Field: dfGod
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
						Left:   5.583"
						Top:    4.905"
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
					Font Size: 10
					Font Enhancement: Bold
					Text Color: Dark Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Create
						! Set dfGod = SalDateYear(SalDateCurrent()-1)
						Set dfGod = SalDateYear(dfBD-1)
					On SAM_Validate
						! If dfGod < SalDateYear(SalDateCurrent()-1)-3 or dfGod > SalDateYear(
								   SalDateCurrent()) or (dfGod = SalDateYear(SalDateCurrent()-1) and
								   dfKw > SalDateQuarter(SalDateCurrent()-1))
							    Call MessageNoWait('Недопустимое сочетание года и номера квартала.', 'ОШИБКА', 30,
									     1)
							    Return VALIDATE_Cancel
						If dfGod < SalDateYear(dfBD-1)-3 or dfGod > SalDateYear(dfBD) or
								   (dfGod = SalDateYear(dfBD-1) and dfKw > SalDateQuarter(dfBD-1))
							Call MessageNoWait('Недопустимое сочетание года и номера квартала.', 'ОШИБКА', 30,
									     1)
							Return VALIDATE_Cancel
						Else
							Call SetDbegDend(dfGod, dfKw)
			Data Field: dfKw
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Data
					Maximum Data Length: 1
					Data Type: Number
					Editable? Yes
				Display Settings
					Window Location and Size
						Left:   7.083"
						Top:    4.905"
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
					Font Size: 10
					Font Enhancement: Bold
					Text Color: Midnight Blue
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Create
						! Set dfKw = SalDateQuarter(SalDateCurrent()-1)
						Set dfKw = SalDateQuarter(dfBD-1)
					On SAM_Validate
						! If dfKw < 1 or dfKw > 4 or (dfGod = SalDateYear(SalDateCurrent()-1) and
								   dfKw > SalDateQuarter(SalDateCurrent()-1))
							    Call MessageNoWait('Недопустимый номер квартала.', 'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						If dfKw < 1 or dfKw > 4 or (dfGod = SalDateYear(dfBD-1) and
								   dfKw > SalDateQuarter(dfBD-1))
							Call MessageNoWait('Недопустимый номер квартала.', 'ОШИБКА', 30, 1)
							Return VALIDATE_Cancel
						Else
							Call SetDbegDend(dfGod, dfKw)
			Data Field: dfDbeg
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
						Top:    5.155"
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
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Create
						! Set dTemp = SalDateQuarterBegin(SalDateCurrent()-1)
						Set dTemp = SalDateQuarterBegin(dfBD-1)
						! Set dfDbeg = IifD(dTemp > SalDateCurrent(), SalDateCurrent(), dTemp)
						Set dfDbeg = IifD(dTemp > dfBD, dfBD, dTemp)
					On SAM_Validate
						! If dfDbeg > SalDateCurrent()
							    Call MessageNoWait('Даты ("Интервал дат") не должны превышать текущей даты.',
									     'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						If dfDbeg > dfBD
							Call MessageNoWait('Даты ("Интервал дат") не должны превышать текущей даты.',
									     'ОШИБКА', 30, 1)
							Return VALIDATE_Cancel
						Else
							Set dfGod = SalDateYear(dfDbeg)
							Set dfKw = SalDateQuarter(dfDbeg)
					On SAM_KillFocus
						Call SalSetFocus(dfDend)
						Call SalSetFieldEdit(dfDend, TRUE)
			Data Field: dfDend
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
						Left:   7.083"
						Top:    5.155"
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
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_Create
						! Set dTemp = SalDateQuarterBegin(SalDateCurrent()+91) - 1
						Set dTemp = SalDateQuarterBegin(dfBD+91) - 1
						! Set dfDend = IifD(dTemp > SalDateCurrent(), SalDateCurrent(), dTemp)
						Set dfDend = IifD(dTemp > dfBD, dfBD, dTemp)
					On SAM_Validate
						! If dfDend > SalDateCurrent() or dfDbeg > dfDend or
								   SalDateQuarter(dfDbeg) != SalDateQuarter(dfDend) or dfDbeg > SalDateCurrent()
							    Call MessageNoWait(IifS(dfDbeg>dfDend, 'Вторая дата не может быть меньше первой.',
									     'Даты ("Интервал дат") ' || IifS(dfDend>SalDateCurrent(),
									     'не должны превышать текущей даты.',
									     'должны находиться в пределах одного квартала.')), 'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						If dfDend > dfBD or dfDbeg > dfDend or
								   SalDateQuarter(dfDbeg) != SalDateQuarter(dfDend) or dfDbeg > dfBD
							Call MessageNoWait(IifS(dfDbeg>dfDend, 'Вторая дата не может быть меньше первой.',
									     'Даты ("Интервал дат") ' || IifS(dfDend>dfBD,
									     'не должны превышать текущей даты.',
									     'должны находиться в пределах одного квартала.')), 'ОШИБКА', 30, 1)
							Return VALIDATE_Cancel
						Else
							Set dfGod = SalDateYear(dfDend)
							Set dfKw = SalDateQuarter(dfDend)
			Frame
				Resource Id: 49025
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.783"
					Top:    4.821"
					Width:  6.2"
					Width Editable? Yes
					Height: 0.667"
					Height Editable? Yes
				Visible? Yes
				Corners: Round
				Border Style: Etched
				Border Thickness: 1
				Border Color: Default
				Background Color: Default
			Group Box: Предварительная обработка
				Resource Id: 49026
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   0.083"
					Top:    3.488"
					Width:  9.0"
					Width Editable? Yes
					Height: 2.083"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: None
				Text Color: Default
				Background Color: Default
			Radio Button: rbPnone
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Не выполнять
				Window Location and Size
					Left:   0.183"
					Top:    3.738"
					Width:  2.6"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Purple
				Background Color: Default
				Message Actions
					On SAM_Click
						Call DisableDates()
						Call SalEnableWindow(dfGod)
						Call SalEnableWindow(dfKw)
						Call SalEnableWindow(pbExecute)
			Radio Button: rbOdok
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Обычные документы
				Window Location and Size
					Left:   0.183"
					Top:    4.071"
					Width:  2.6"
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
						Call SalEnableWindow(rbDates)
						If rbGodKw
							Call SalDisableWindow(dfDbeg)
							Call SalDisableWindow(dfDend)
							Call SalEnableWindow(dfGod)
							Call SalEnableWindow(dfKw)
						If rbDates
							Call SalEnableWindow(dfDbeg)
							Call SalEnableWindow(dfDend)
							Call SalDisableWindow(dfGod)
							Call SalDisableWindow(dfKw)
						Call SalEnableWindow(pbExecute)
			Radio Button: rbKdok
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Корректирующие док.
				Window Location and Size
					Left:   0.183"
					Top:    4.405"
					Width:  2.6"
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
						Call DisableDates()
						Call SalEnableWindow(dfGod)
						Call SalEnableWindow(dfKw)
						Call SalEnableWindow(pbExecute)
			Frame
				Resource Id: 49027
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   9.183"
					Top:    4.821"
					Width:  3.6"
					Width Editable? Yes
					Height: 0.667"
					Height Editable? Yes
				Visible? Yes
				Corners: Round
				Border Style: Drop-Shadow
				Border Thickness: 1
				Border Color: Dark Gray
				Background Color: Default
			Picture: pic1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   9.483"
					Top:    5.071"
					Width:  0.5"
					Width Editable? Yes
					Height: 0.333"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: \Bars98\RESOURCE\BMP\Cals.bmp
				Storage: External
				Picture Transparent Color: None
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Solid
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Gray
				Background Color: 3D Face Color
				Message Actions
			Radio Button: rbBi
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Включать бал.сч
				Window Location and Size
					Left:   2.883"
					Top:    3.655"
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
			Radio Button: rbBo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Исключать бал.сч
				Window Location and Size
					Left:   2.883"
					Top:    3.905"
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
			Data Field: dfBi
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
						Left:   4.983"
						Top:    3.655"
						Width:  3.1"
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
			Data Field: dfBo
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
						Left:   4.983"
						Top:    3.905"
						Width:  3.1"
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
			Background Text: Баланс
				Resource Id: 49028
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   8.183"
					Top:    3.845"
					Width:  0.8"
					Width Editable? Yes
					Height: 0.226"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Picture: pic2
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   0.183"
					Top:    4.905"
					Width:  2.5"
					Width Editable? Yes
					Height: 0.5"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: q:\BARS98\RESOURCE\GIF\Nsmailn6.gif
				Storage: Internal
				Picture Transparent Color: None
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: No Border
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: Gray
				Message Actions
			Picture: pic3
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   9.183"
					Top:    3.821"
					Width:  3.6"
					Width Editable? Yes
					Height: 0.917"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: q:\BARS98\RESOURCE\JPG\Adir-Su.jpg
				Storage: Internal
				Picture Transparent Color: None
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Round
				Border Style: No Border
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: Default
				Message Actions
			Check Box: cbSave
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Сохранить
				Window Location and Size
					Left:   10.183"
					Top:    3.571"
					Width:  1.4"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Dark Green
				Background Color: Default
				Message Actions
					On SAM_Click
						If cbSave
							Set cbClear = FALSE
			Check Box: cbClear
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Очистить
				Window Location and Size
					Left:   11.583"
					Top:    3.571"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? Yes
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Red
				Background Color: Default
				Message Actions
					On SAM_Click
						If cbClear
							Set cbSave = FALSE
			Radio Button: rbVi
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Включать бал.сч
				Window Location and Size
					Left:   2.883"
					Top:    4.238"
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
			Radio Button: rbVo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Исключать бал.сч
				Window Location and Size
					Left:   2.883"
					Top:    4.488"
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
			Data Field: dfVi
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
						Left:   4.983"
						Top:    4.238"
						Width:  3.1"
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
			Data Field: dfVo
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
						Left:   4.983"
						Top:    4.488"
						Width:  3.1"
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
			Background Text: Вне
					баланс
				Resource Id: 49029
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   8.183"
					Top:    4.345"
					Width:  0.833"
					Width Editable? Yes
					Height: 0.31"
					Height Editable? Yes
				Visible? Yes
				Justify: Left
				Font Name: Default
				Font Size: Default
				Font Enhancement: Bold
				Text Color: Default
				Background Color: Default
			Background Text: Бал.сч.
				Resource Id: 49030
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   9.183"
					Top:    3.595"
					Width:  0.8"
					Width Editable? Yes
					Height: 0.167"
					Height Editable? Yes
				Visible? Yes
				Justify: Right
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Black
				Background Color: Default
			Check Box: rbBii
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Включать бал.сч
				Window Location and Size
					Left:   2.883"
					Top:    3.655"
					Width:  1.9"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? No
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Check Box: rbBoo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Исключать бал.сч
				Window Location and Size
					Left:   2.883"
					Top:    3.905"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? No
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Check Box: rbVoo
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Исключать бал.сч
				Window Location and Size
					Left:   2.883"
					Top:    4.488"
					Width:  2.0"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? No
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
			Check Box: rbVii
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Включать бал.сч
				Window Location and Size
					Left:   2.883"
					Top:    4.238"
					Width:  2.1"
					Width Editable? Yes
					Height: 0.25"
					Height Editable? Yes
				Visible? No
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Text Color: Default
				Background Color: Default
				Message Actions
		Functions
			Function: GetBankOperIdent
				Description:
				Returns
					String:
				Parameters
					String: sMfo
					String: sId
				Static Variables
				Local variables
					String: sSab
				Actions
					Set sSab = GetValueStr("
							    SELECT sab
							    FROM banks
							    WHERE mfo=" || sMfo)
					Return IifS(sSab='', 'xxx', Right(sSab, 3)) || 'O' || sId
			Function: SetDbegDend
				Description:
				Returns
				Parameters
					Number: nGod
					Number: nKw
				Static Variables
				Local variables
				Actions
					Set dfDbeg = SalDateQuarterBegin(SalDateConstruct(nGod, nKw*3, 1, 0, 0, 0))
					Set dfDend = SalDateQuarterBegin(SalDateConstruct(nGod, nKw*3, 1, 0, 0, 0) + 92) - 1
			Function: DisableDates
				Description:
				Returns
				Parameters
				Static Variables
				Local variables
				Actions
					Call SalDisableWindow(dfDbeg)
					Call SalDisableWindow(dfDend)
					Call SalDisableWindow(rbDates)
					Set rbGodKw = TRUE
			Function: ABSSqlLike
				Description:
				Returns
				Parameters
					String: sSqlInABS
					String: sSqlInNotABS
					String: sOrAnd
					Receive String: sOut
					Receive String: sOut1
				Static Variables
				Local variables
					String: sSqlOutABS
					String: sSqlOutABS1
				Actions
					While not SalStrLength( sSqlInABS )=0 
						If SalStrScan( sSqlInABS , ',' ) = -1 
							Set sSqlOutABS  =   sSqlOutABS  || sOrAnd ||" ad.NLS"||sSqlInNotABS||"'"||SalStrTrimX(sSqlInABS)||"%' "
							Set sSqlOutABS1 =  sSqlOutABS1|| sOrAnd ||" ak.NLS"||sSqlInNotABS||"'"||SalStrTrimX(sSqlInABS)||"%' "
							Set sSqlInABS = ''
						Else
							If SalStrTrimX(SalStrMidX( sSqlInABS, 0, SalStrScan( sSqlInABS , ',' ))) !=''
								Set sSqlOutABS   =  sSqlOutABS  || sOrAnd ||" ad.NLS"||sSqlInNotABS||"'"||SalStrTrimX( SalStrMidX( sSqlInABS, 0, SalStrScan( sSqlInABS , ',' )))||"%' "
								Set sSqlOutABS1 =  sSqlOutABS1|| sOrAnd ||" ak.NLS"||sSqlInNotABS||"'"||SalStrTrimX( SalStrMidX( sSqlInABS, 0, SalStrScan( sSqlInABS , ',' )))||"%' "
								Set sSqlInABS = SalStrMidX( sSqlInABS, SalStrScan( sSqlInABS , ',' )+1,SalStrLength( sSqlInABS ))
							Else
								Set sSqlInABS = SalStrMidX( sSqlInABS, SalStrScan( sSqlInABS , ',' )+1,SalStrLength( sSqlInABS ))
					Set sOut   = sSqlOutABS
					Set sOut1 = sSqlOutABS1
		Window Parameters
			Number: nType
		Window Variables
			: ccDoc
				Class: cDoc
			String: ND
			String: sODB
			String: NLS
			String: NLSK
			Number: KVS
			Number: SK
			Number: REF
			Number: ISV
			String: NAZN
			String: sTmp
			Number: nCount
			String: sAn
			String: sNbw
			Number: nNls
			String: sMfo
			String: sMfoA
			String: sMdl
			Number: nMfop
			Number: nFetchRes
			Number: nFetchRes1
			Number: nFetchResABS
			Number: nFetchResSBU
			String: sBlk
			String: sFv
			String: sFs
			Number: nDocs
			Sql Handle: hSqlA
			Sql Handle: hSqlB
			Sql Handle: hSqlC
			Number: nPos
			Number: nDelta
			Number: nRecCount
			String: strMessage
			Number: nNm
			Number: nDk
			Number: nDk2
			Number: nMfo
			String: sNd
			Number: nVob
			String: sNls
			String: sNlsk
			String: sNls8
			Number: nSk
			Number: nS
			! Date/Time: dDat
			String: sPlat
			String: sPolu
			String: sNaz1
			String: sVspo
			String: sKod
			String: sKisp
			Number: nRow
			Number: nRef
			String: sODBCDir
			Date/Time: dTmp
			Number: n99
			Number: nSos
			Number: nRef99bm
			Date/Time: dVdate
			Date/Time: dVdateOrig
			Date/Time: dVdateU
			Date/Time: dBankDate
			!
			Number: nNewRow
			!
			Number: nTimeStart
			Number: nTimeCurrent
			Number: nTimeEnd
			Number: nHour
			Number: nMinu
			Number: nTemp
			Number: nTek
			Number: nRecn
			!
			Number: nFlag
			Number: n21
			Number: nStep
			!
			String: sNLS
			String: sNLS8
			Number: nFLAG
			String: sSbuNLS[*]
			String: sSbuNLS8[*]
			Number: nSbuFLAG[*]
			Number: nIndex0
			Number: nIndex1
			!
			Date/Time: dDat1
			!
			Boolean: bDalee
			Boolean: bSD
			!
			String: sTp
			!
			String: sNLS1
			String: sNLS2
			String: sStopNLS1[*]
			String: sStopNLS2[*]
			Number: n22
			Number: nI
			Boolean: bStop
			!
			Number: nRefO
			!
			Boolean: bMa
			Boolean: bMc
			!
			Boolean: bProdol
			!
			String: sRnk
			!
			Date/Time: dTemp
			!
			String: sCurDir
			String: sOdbkPath
			!
			String: sBalAcc
			String: sBalAccn
			!
			Number: nL0
			Number: nL1
			!
			Number: nSbuFLAG_0
			Number: nSbuFLAG_1
			Boolean: bWozw
			!
			String: sBi
			String: sVi
			String: sBii
			String: sBoo
			String: sVii
			String: sVoo
			Date/Time: dDateStart
			Date/Time: dDateStartABS
			String: sDateStartABS
			Date/Time: dDateEnd
			String: sBankMFO
			Long String: sSqlIn
			Long String: sSqlOut
			String: sSqlInNot
			String: sSqlAll
			String: sSqlAll1
			String: sSqlAllN
			String: sSqlAllN1
			String: strErrorText
			Number: nConnectError
			Long String: sSqlOut1
			Number: nABSRef[*]
			Number: nABSSTMT[*]
			Number: nSTMT
			Number: nABSNext
			Number: nRefASPO
			String: sNlsa
			String: sNlsb
			String: sNmsa
			String: sNmsb
			String: sNmsa1
			String: sNmsb1
			! ! Строка по которой изменяем или добавляем параметр
			String: sInsUpdParams
			Number: nRefNotImport
			Number: nRefParams
			Boolean: bPay
			String: TestDate
		Message Actions
			On SAM_Create
				Call SalWaitCursor(TRUE)
				Call ConPara('PUSH')
				Call SalFileGetCurrentDirectory(sCurDir)
				Call SalUseRegistry(FALSE, '')
				Call SalGetProfileString('Import', 'NalDecPath', Left(SalFileGetDrive(), 1) || ':\\BARS98\\ODBC.DSN\\SBU', sODBCDir, GetIniFileName())
				Call SalGetProfileString('Import', 'BarsFoxOdbkPath', Left(SalFileGetDrive(), 1) || ':\\BARS98\\ODBC.DSN\\ODBK', sOdbkPath, GetIniFileName())
				Call SalGetProfileString('Import', 'BalAcc', '99999999999999', sBalAcc, GetIniFileName())
				Call SalGetProfileString('Import', 'BalAccn', '99999999999999', sBalAccn, GetIniFileName())
				Call SalGetProfileString('NalUch', 'Input', 'DBF', sODB,GetIniFileName())
				Call SalGetProfileString('NalUch', 'DataBase', '', sODBDataBase,GetIniFileName())
				Call SalGetProfileString('NalUch', 'StartDate', '01/01/1899', sDateStartABS,GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAccBii',    '0', sBii, GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAccBoo',   '0', sBoo, GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAccVii', '0', sVii, GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAccVoo', '0', sVoo, GetIniFileName())
				! Set dfBi = sBalAcc
				! Set dfVi = sBalAccn
				Call SalUseRegistry(TRUE, GetCompanyName())
				Call SalGetProfileString('NalUch', 'BalAccVkl', sBalAcc, dfBi, GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAccIsk', '99999999999999', dfBo, GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAcnVkl', sBalAccn, dfVi, GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAcnIsk', '99999999999999', dfVo, GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAccA', '0', sBi, GetIniFileName())
				Call SalGetProfileString('NalUch', 'BalAccN', '0', sVi, GetIniFileName())
				If Len(dfBi) = 0
					Set dfBi = sBalAcc
				If Len(dfVi) = 0
					Set dfVi = sBalAccn
				Set rbBi = sBi='0'
				Set rbBo = sBi!='0'
				Set rbVi = sVi='0'
				Set rbVo = sVi!='0'
				Set dBankDate = GetBankDate()
				Set dfBD = dBankDate
				Call PrepareWindowEx(hWndForm)
				If nType = 1
					Call SalSetWindowText(hWndForm,
							     'ПОВТОРНЫЙ прием информации для налогового учета из ОДБ (финансовый учет)')
				! Call SalHideWindow(dfStart)
				! Call SalHideWindow(dfEnd)
				Call SalSetFocus(pbExit)
				Set rb2 = TRUE
				Call DisableDates()
				If sODB='ABS'
					!
					Call SalShowWindow ( rbBoo )
					Call SalShowWindow ( rbBii )
					Call SalHideWindow   ( rbBi )
					Call SalHideWindow   ( rbBo )
					Call SalShowWindow ( rbVii )
					Call SalShowWindow ( rbVoo )
					Call SalHideWindow   ( rbVi )
					Call SalHideWindow   ( rbVo )
					Call SalDisableWindow( rbPnone )
					Set rbBii = SalStrToNumber( sBii )
					Set rbBoo = SalStrToNumber( sBoo )
					Set rbVii = SalStrToNumber( sVii )
					Set rbVoo = SalStrToNumber( sVoo )
					Call SalEnableWindow( rbDates )
					! Call SalDisableWindow( rbKdok )
					Set rbOdok = '0'
					Set bFlagABS = 0
					Set dDateStartABS = SalStrToDate( sDateStartABS )
			On SAM_CreateComplete
				Call SalWaitCursor(FALSE)
			On SAM_Destroy
				Call ConPara('POP')
				Call SalFileSetCurrentDirectory(sCurDir)
				If cbSave
					Call SalUseRegistry(TRUE, GetCompanyName())
					Call SalSetProfileString('NalUch', 'BalAccVkl', dfBi, GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAccIsk', dfBo, GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAcnVkl', dfVi, GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAcnIsk', dfVo, GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAccA', IifS(rbBi, '0', '1'), GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAccN', IifS(rbVi, '0', '1'), GetIniFileName())
				If cbClear
					Call SalUseRegistry(TRUE, GetCompanyName())
					Call SalSetProfileString('NalUch', 'BalAccVkl', '', GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAccIsk', '', GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAcnVkl', '', GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAcnIsk', '', GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAccA', '0', GetIniFileName())
					Call SalSetProfileString('NalUch', 'BalAccN', '0', GetIniFileName())
				Call Pl_dat(dBankDate)
				!
				Call SalUseRegistry(FALSE, '')
				Call SalSetProfileString('NalUch', 'BalAccBii', IifS(rbBii=0, '0', '1'), GetIniFileName())
				Call SalSetProfileString('NalUch', 'BalAccBoo', IifS(rbBoo=0, '0', '1'), GetIniFileName())
				Call SalSetProfileString('NalUch', 'BalAccVii', IifS(rbVii=0, '0', '1'), GetIniFileName())
				Call SalSetProfileString('NalUch', 'BalAccVoo', IifS(rbVoo=0, '0', '1'), GetIniFileName())
	Dialog Box: dlg_Connect
		Class:
		Property Template:
		Class DLL Name:
		Title: Подключение к Базе Данных ОДБ
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   Default
				Top:    Default
				Width:  5.65"
				Width Editable? Yes
				Height: 1.655"
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
			Pushbutton: pbCancel
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Отмена
				Window Location and Size
					Left:   4.067"
					Top:    0.881"
					Width:  1.4"
					Width Editable? Yes
					Height: 0.452"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: Esc
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name:
				Picture Transparent Color: Magenta
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						Call SalDestroyWindow( dlg_Connect )
						Set bFlagABS=0
			Pushbutton: pbOk
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title: Да
				Window Location and Size
					Left:   2.617"
					Top:    0.881"
					Width:  1.4"
					Width Editable? Yes
					Height: 0.452"
					Height Editable? Yes
				Visible? Yes
				Keyboard Accelerator: Enter
				Font Name: Default
				Font Size: Default
				Font Enhancement: Default
				Picture File Name:
				Picture Transparent Color: Magenta
				Image Style: Single
				Text Color: Default
				Background Color: Default
				Message Actions
					On SAM_Click
						Set SqlDatabase = dDataBase
						Call WaitCursorOn()
						When SqlError
							Call WaitCursorOff()
							Set bFlagABS=0
							! Call SalMessageBox( 'Возникла ошибка при подключеннии ...', 'Ошибка ...',  MB_Ok )
							Return FALSE
						! Call SalMessageBox( ' nUseGateway '||SalNumberToStrX(nUseGateway,0),MSG_Attention(), MB_Ok)
						If nUseGateway  ! логиниться через шлюз
							If GateLogin(dUserName, dPassword, szOraUser, szOraPassword) = FALSE
								! Call SalMessageBox( 'Not GateLogin' , 'Параметры ... ', 0 )
								Set bFlagABS=0
								Call WaitCursorOff()
								Set nConnectError = SqlError( hSqlABS )
								! If nConnectError = 21017
									  Call SalMessageBox( MSG_NoConnectDbs() ||' Неверное рабочее имя или пароль. [Error #21017]',MSG_Attention(), MB_Ok)
								! Else
									  Call SalMessageBox(MSG_NoConnectDbs() ,MSG_Attention(), MB_Ok)
								Return 0
							Else
								! Call SalMessageBox( 'GateLogin' , 'Параметры ... ', 0 )
								Set SqlUser = szOraUser
								Set SqlPassword = szOraPassword
						Else
							! Call SalMessageBox( ' !!! no nUseGateway ',MSG_Attention(), MB_Ok)
							Set SqlUser = dUserName
							Set SqlPassword = dPassword
						If SqlConnect( hSqlABS )
							Call WaitCursorOff()
							Set bFlagABS=1
							Call SalEndDialog( dlg_Connect, FALSE )
						Else
							Set bFlagABS=0
							Call SalWaitCursor(FALSE)
							Set nConnectError = SqlError( hSqlABS )
							If nConnectError = 21017
								! Call DBSpy_Report(NUMBER_Null, DATETIME_Null,
											MSG_NoConnectDbs() || ' Неверное рабочее имя или пароль. [Error #21017]',
											DBSpy_Error, GetDBMS())
								Call SalMessageBox(MSG_NoConnectDbs() || ' Неверное рабочее имя или пароль. [Error #21017]',
										MSG_Attention(), MB_Ok)
							Else
								! Call DBSpy_Report(NUMBER_Null, DATETIME_Null,
											MSG_NoConnectDbs() || ' [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
											DBSpy_Error, GetDBMS())
								Call SalMessageBox(MSG_NoConnectDbs() || ' [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
										MSG_Attention(), MB_Ok)
			Background Text: База Данных
				Resource Id: 49015
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.267"
					Top:    0.083"
					Width:  1.167"
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
			Background Text: Пользователь
				Resource Id: 49016
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.217"
					Top:    0.357"
					Width:  1.217"
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
			Background Text: Пароль
				Resource Id: 49017
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.75"
					Top:    0.595"
					Width:  0.683"
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
			Data Field: dDataBase
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
						Left:   3.467"
						Top:    0.048"
						Width:  2.017"
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
					Font Enhancement: Bold
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_AnyEdit
						If Len(SalStrTrimX(dDataBase))*Len(SalStrTrimX(dUserName))*
								   Len(SalStrTrimX(dPassword)) = 0
							Call SalDisableWindow(pbOk)
						Else
							Call SalEnableWindow(pbOk)
			Data Field: dUserName
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
						Left:   3.467"
						Top:    0.321"
						Width:  2.017"
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
						If Len(SalStrTrimX(dDataBase))*Len(SalStrTrimX(dUserName))*
								   Len(SalStrTrimX(dPassword)) = 0
							Call SalDisableWindow(pbOk)
						Else
							Call SalEnableWindow(pbOk)
			Data Field: dPassword
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
						Left:   3.467"
						Top:    0.56"
						Width:  2.017"
						Width Editable? Yes
						Height: 0.25"
						Height Editable? Yes
					Visible? Yes
					Border? Yes
					Justify: Left
					Format: Invisible
					Country: Default
					Font Name: Default
					Font Size: Default
					Font Enhancement: Default
					Text Color: Default
					Background Color: Default
					Input Mask: Unformatted
				Message Actions
					On SAM_AnyEdit
						If Len(SalStrTrimX(dDataBase))*Len(SalStrTrimX(dUserName))*
								   Len(SalStrTrimX(dPassword)) = 0
							Call SalDisableWindow(pbOk)
						Else
							Call SalEnableWindow(pbOk)
			Pushbutton: pbF11
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   0.3"
					Top:    0.667"
					Width:  0.517"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? No
				Keyboard Accelerator: F11
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
						Call SalEnableWindow( dDataBase )
						Call SalSetFocus( dDataBase )
			Pushbutton: pbF12
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Title:
				Window Location and Size
					Left:   0.467"
					Top:    0.381"
					Width:  1.2"
					Width Editable? Yes
					Height: 0.298"
					Height Editable? Yes
				Visible? No
				Keyboard Accelerator: F12
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
						Set dUserName='BARS'
						Set dPassword='BARS'
						Call SalSendMsg( pbOk, SAM_Click , 0, 0 )
			Picture: pic1
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Property Template:
				Class DLL Name:
				Window Location and Size
					Left:   0.033"
					Top:    0.012"
					Width:  2.1"
					Width Editable? Yes
					Height: 1.333"
					Height Editable? Yes
				Visible? Yes
				Editable? No
				File Name: ..\RESOURCE\BMP\pass.bmp
				Storage: External
				Picture Transparent Color: None
				Fit: Scale
				Scaling
					Width:  100
					Height:  100
				Corners: Square
				Border Style: Solid
				Border Thickness: 1
				Tile To Parent? No
				Border Color: Default
				Background Color: Default
				Message Actions
			Frame
				Resource Id: 63741
				Class Child Ref Key: 0
				Class ChildKey: 0
				Class:
				Window Location and Size
					Left:   2.183"
					Top:    0.012"
					Width:  3.367"
					Width Editable? Yes
					Height: 0.845"
					Height Editable? Yes
				Visible? Yes
				Corners: Square
				Border Style: Etched
				Border Thickness: 3
				Border Color: Default
				Background Color: Default
		Functions
		Window Parameters
		Window Variables
			String: strErrorText
			Number: nConnectError
			Number: nUseGateway
			String: szOraUser
			String: szOraPassword
		Message Actions
			On SAM_Create
				Call SalUseRegistry(TRUE, GetDBMS())
				Call SalGetProfileString(GetHost(), "USERABS", GetUserLoginName(), dUserName, "netrc")
				Call SalCenterWindow(dlg_Connect)
				! Set dUserName=GetUserLoginName()
				Call SalUseRegistry(FALSE, GetDBMS())
				Set dDataBase=sODBDataBase
				Call SalDisableWindow(pbOk)
				Set bFlagABS=0
				If dUserName = '' 
					Call SalSetFocus( dUserName )
				Else
					Call SalSetFocus( dPassword )
				Set nUseGateway = SalGetProfileInt(INI_CommonParameters, 'UseGateway', 0, GetIniFileName())
				! ! Call SalMessageBox( SalNumberToStrX( nUseGateway ,0), 'Параметры ... ', 4 )
				If nUseGateway            ! логиниться через шлюз
					If GateParams(dDataBase)
						! Call SalMessageBox( 'Применение парамметров прошло успешно', 'Параметры ... ', 4 )
					Else
						Call SalDestroyWindow( dlg_Connect )
						Set bFlagABS=0
			On SAM_Destroy
				If dUserName != '' 
					Call SalSetProfileString(GetHost(), "USERABS", dUserName, "netrc")
	! Dialog Box: dlg_ImpNal9
.winattr
		Class:
		Property Template:
		Class DLL Name:
		Title: Импорт информации для налогового учета из ОДБ (финансовый учет)
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   0.15"
				Top:    0.146"
				Width:  12.95"
				Width Editable? Yes
				Height: 6.833"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
.end
		  Description: Прием документов и оплата документов из 'старого' БАРСа
		  Tool Bar 
			  Contents 
		  Contents 
			  Background Text: Всего:
			  Data Field: dfAll
				  Message Actions 
			  Background Text: Выбрано:
			  Data Field: dfGood
				  Message Actions 
			  Background Text: Обработано:
			  Data Field: dfCurrent
				  Message Actions 
			  Background Text: Нет связи:
			  Data Field: dfNoLink
				  Message Actions 
			  Pushbutton: pbExecute
				  Message Actions 
					  On SAM_Click
						  If IsBankDayOpen()
							  If MessageQuestion(
									   'Выполнять Прием/Оплату документов (КВАРТАЛ - ' || Str(dfKw) || IifS(rbPnone, '',
									   ', ПРЕДВАРИТЕЛЬНАЯ ОБРАБОТКА ' || IifS(rbKdok, 'корректирующих ', '') ||
									   'документов финансового учета' || IifS(rbKdok, '', ' с ' ||
									   SalFmtFormatDateTime(dfDbeg, 'dd/MM/yyyy') || ' по ' ||
									   SalFmtFormatDateTime(dfDend, 'dd/MM/yyyy'))) || ') ?') = IDNO
								  Return FALSE
							  Call WaitCursorOn()
							  Call SalDisableWindow(pbExecute)
							  Call SalDisableWindow(pbExit)
							  Set dfDone = ""
							  Set dfStart = 'Старт: ' || SalFmtFormatDateTime(SalDateCurrent(), 'hhh:mm:ss')
							  Call SaveInfoToLog("Прием/Оплата документов налогового учета.")
							! Call Debug('SaveInfoToLog - "Прием/Оплата" - Ok')
							  If SalFileSetCurrentDirectory(sODBCDir)
								  If not rbPnone
									! Здесь поставить предобработку
									! Call Debug(sCurDir || '\\SBU.EXE ' || IifS(rbOdok, '0 ', '9 ') ||
											     SalFmtFormatDateTime(dfDbeg, 'dd/MM/yyyy ') ||
											     SalFmtFormatDateTime(dfDend, 'dd/MM/yyyy ') || Str(dfGod) || ' ' ||
											     Str(dfKw) || ' ' || sODBCDir || ' ' || sOdbkPath || ' ' || sBalAcc || ' '
											     || sBalAccn)
									  Set n99 = -9
									  If SalLoadAppAndWait(sCurDir || '\\SBU.EXE ' || IifS(rbOdok, '0 ', '9 ') ||
											   SalFmtFormatDateTime(dfDbeg, 'dd/MM/yyyy ') ||
											   SalFmtFormatDateTime(dfDend, 'dd/MM/yyyy ') || Str(dfGod) || ' ' || Str(dfKw)
											   || ' ' || sODBCDir || ' ' || sOdbkPath || ' ' || IifS(rbBi, '0 ' || dfBi,
											   '1 ' || dfBo) || ' ' || IifS(rbVi, '0 ' || dfVi, '1 ' || dfVo),
											   Window_Maximized, n99)
										  If n99 != 0
											  Call SalMessageBeep(-1)
											  Call WaitCursorOff()
											  Call MessageNoWait('Ошибка (' || Str(n99) ||
													     ') при предварительной обработке информации (' || IifS(n99=1,
													     'отсутствует каталог ' || sOdbkPath, IifS(n99=2,
													     'не было добавлено ни одного документа для импорта',
													     'системная ошибка')) || ').', 'ИМПОРТ НЕ ВЫПОЛНЯЕТСЯ', 0, 1)
											  Call SalEnableWindow(pbExit)
											  Return FALSE
									  Else 
										  Call SalMessageBeep(-1)
										  Call WaitCursorOff()
										  Call MessageNoWait('Ошибка (' || Str(n99) ||
												     ') вызова модуля предварительной обработки информации !',
												     'ИМПОРТ НЕ ВЫПОЛНЯЕТСЯ', 0, 1)
										  Call SalEnableWindow(pbExit)
										  Return FALSE
								  Set SqlDatabase = 'dBase_Files'
								! Call Debug('Проверка наличия файлов ' || sODBCDir || '\\G' || Str(dfGod) || 'K'
										     || Str(dfKw) || '\\MOPER.dbf and ' || sODBCDir || '\\SBU.dbf')
								  If File(sODBCDir || '\\G' || Str(dfGod) || 'K' || Str(dfKw) || '\\MOPER.dbf') and
										   File(sODBCDir || '\\SBU.dbf')
									! Call Debug('Есть файлы ' || sODBCDir || '\\G' || Str(dfGod) || 'K' ||
											     Str(dfKw) || '\\MOPER.dbf and ' || sODBCDir || '\\SBU.dbf')
									! проверить, есть ли поле ref99bm в moper, если нет, то добавить его
									  Set n99 = -9
									  Set dfDone = "Подождите ..."
									! Call Debug('Вставляем ref99bm - FindVar')
									  Call SalLoadAppAndWait(sCurDir || "\\FindVar.Exe " || sODBCDir || '\\G' ||
											     Str(dfGod) || 'K' || Str(dfKw) || '\\MOPER' || " ref99bm",
											     Window_NotVisible, n99)
									! Call Debug('Вставили ref99bm')
									  Set dfDone = ""
									  Call SalFileSetCurrentDirectory(sODBCDir || '\\G' || Str(dfGod) || 'K' ||
											     Str(dfKw))
									  If SqlConnect(hSqlA)
										  Call SqlPrepareAndExecute(hSqlA, "
												     SELECT count(*)
												     FROM moper
												     INTO :nRecCount")
										  Call SqlFetchNext(hSqlA, nFetchRes)
										  If nRecCount = 0
											  Call SqlDisconnect(hSqlA)
											  Call SalMessageBeep(-1)
											  Call WaitCursorOff()
											  Call MessageNoWait('Нет информации или файл ' || sODBCDir || '\\G' ||
													     Str(dfGod) || 'K' || Str(dfKw) || '\\MOPER.dbf занят.', 'Сообщение', 7,
													     1)
											  Call SalEnableWindow(pbExit)
											  Return FALSE
										  Call SalArraySetUpperBound(sSbuNLS, 1, -1)
										  Call SalArraySetUpperBound(sSbuNLS8, 1, -1)
										  Call SalArraySetUpperBound(nSbuFLAG, 1, -1)
										  Set n21 = 0
										  Set n22 = 0
										! Call SqlPrepareAndExecute(hSqlC, "
												     SELECT nls,nls8,flag
												     FROM sbu
												     INTO :sNLS,:sNLS8,:nFLAG
												     WHERE Len(Trim(nls8))>4")
										  Call SqlDisconnect(hSqlA)
										  Set SqlDatabase = 'dBase_Files'
										  Call SalFileSetCurrentDirectory(sODBCDir)
										  If not SqlConnect(hSqlA) or not SqlConnect(hSqlB) or not SqlConnect(hSqlC)
											  Call SqlDisconnect(hSqlA)
											  Call SqlDisconnect(hSqlB)
											  Call SqlDisconnect(hSqlC)
											  Call SalMessageBeep(-1)
											  Call WaitCursorOff()
											  Call MessageAttention('Ошибка подсоединения к Базе данных: ' || SqlDatabase)
											  Call SalEnableWindow(pbExit)
											  Return FALSE
										  Call SqlPrepareAndExecute(hSqlC, "
												     SELECT nls,nls8,flag
												     FROM sbu
												     INTO :sNLS,:sNLS8,:nFLAG")
										  Set bProdol = TRUE
										  While SqlFetchNext(hSqlC, nFetchRes)
											  Set sSbuNLS[n21] = SalStrTrimX(sNLS)
											  Set sSbuNLS8[n21] = SalStrTrimX(sNLS8)
											  Set nSbuFLAG[n21] = IifN(nFLAG=NUMBER_Null, 0, nFLAG)
											! Этот блок возможно закомментировать потом (может быть) - нижний If
											! If Len(sSbuNLS8[n21]) = 0
												    Set bProdol = FALSE
												    Break 
											  Set n21 = n21 + 1
										! И этот блок возможно закомментировать потом (может быть) - нижний If
										! If not bProdol
											    Call SqlDisconnect(hSqlA)
											    Call SqlDisconnect(hSqlB)
											    Call SqlDisconnect(hSqlC)
											    Call SalMessageBeep(-1)
											    Call WaitCursorOff()
											    Call MessageNoWait('В файле ' || sODBCDir ||
													     '\\SBU.dbf есть счета ФИНАНСОВОГО учета, не имеющие связи cо счетами'
													     || ' НАЛОГОВОГО учета. Устраните эту ОШИБКУ и повторите операцию.',
													     'ИМПОРТ НЕ МОЖЕТ БЫТЬ ВЫПОЛНЕН', 60, 1)
											    Call SalEnableWindow(pbExit)
											    Return FALSE
										  If File(sODBCDir || '\\SBU_STOP.dbf')
											  Call SalArraySetUpperBound(sStopNLS1, 1, -1)
											  Call SalArraySetUpperBound(sStopNLS2, 1, -1)
											  Call SqlPrepareAndExecute(hSqlC, "
													     SELECT nls1,nls2
													     FROM sbu_stop
													     INTO :sNLS1,:sNLS2
													     WHERE Len(Trim(nls1))>4 and Len(Trim(nls2))>4")
											  While SqlFetchNext(hSqlC, nFetchRes)
												  Set sStopNLS1[n22] = SalStrTrimX(sNLS1)
												  Set sStopNLS2[n22] = SalStrTrimX(sNLS2)
												  Set n22 = n22 + 1
										  Set nTimeStart = SalDateHour(SalDateCurrent())*3600 + SalDateMinute(
												    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
										  Set dfStart = 'Старт: ' || SalFmtFormatDateTime(SalDateCurrent(), 'hhh:mm:ss')
										  Set dfCurrent = 0
										  Set dfAll = nRecCount
										  Set dfGood = 0
										  Set dfNoLink = 0
										  Set nPos = 0
										  Set nTek = 0
										  Set nRecn = 1
										  Set nDelta = 100 / nRecCount
										  Set sRnk = Str(GetIdRnk())
										  Set sMfoA = GetValueStr("
												    SELECT mfo
												    FROM custbank
												    WHERE rnk=" || sRnk)
										  Set sRnk = SalStrRepeatX('0', 2-Len(sRnk)) || sRnk
										  Set sMfoA = IifS(sMfoA='', GetBankMfo(), sMfoA)
										  Call SqlPrepareAndExecute(hSql(), "
												     SELECT max(fdat)
												     INTO :dDat1
												     FROM fdat     
												     WHERE fdat<:dfBD")
										  Call SqlFetchNext(hSql(), nFetchRes)
										  Set dVdateU = dBankDate
										  Call SqlDisconnect(hSqlA)
										  Call SqlDisconnect(hSqlB)
										  Call SqlDisconnect(hSqlC)
										  Set SqlDatabase = 'dBase_Files'
										  Call SalFileSetCurrentDirectory(sODBCDir || '\\G' || Str(dfGod) || 'K' ||
												     Str(dfKw))
										  If not SqlConnect(hSqlA) or not SqlConnect(hSqlB)
											  Call SqlDisconnect(hSqlA)
											  Call SqlDisconnect(hSqlB)
											  Call SalMessageBeep(-1)
											  Call WaitCursorOff()
											  Call MessageAttention('Ошибка подсоединения к Базе данных: ' || SqlDatabase)
											  Call SalEnableWindow(pbExit)
											  Return FALSE
										  Call SqlSetResultSet(hSqlA, FALSE)
										! Call SqlPrepare(hSqlA, "
												     SELECT rowid,nm,dk,mfo,nd,vob,nls,nlsk,sk,s,datd,plat,polu,naz1,vspo,kod,
												            kisp,sos,ref99bm,vdate,tp,ref
												     INTO :nRow,:nNm,:nDk,:nMfo,:sNd,:nVob,:sNls,:sNlsk,:nSk,:nS,:dDat,:sPlat,
												          :sPolu,:sNaz1,:sVspo,:sKod,:sKisp,:nSos,:nRef99bm,:dVdate,:sTp,
												          :nRefl
												     FROM moper
												     FOR UPDATE OF ref99bm")
										! Call SqlPrepare(hSqlA, "
												     SELECT rowid,nm,dk,mfo,nd,vob,nls,nlsk,sk,s,datd,plat,polu,naz1,vspo,kod,
												            kisp,sos,ref99bm,vdate,tp,ref
												     INTO :nRow,:nNm,:nDk,:nMfo,:sNd,:nVob,:sNls,:sNlsk,:nSk,:nS,:dDat,:sPlat,
												          :sPolu,:sNaz1,:sVspo,:sKod,:sKisp,:nSos,:nRef99bm,:dVdate,:sTp,
												          :nRefO
												     FROM moper
												     FOR UPDATE OF ref99bm")
										  Call SqlPrepare(hSqlA, "
												     SELECT rowid,nm,dk,mfo,nd,vob,nls,nlsk,sk,s,plat,polu,naz1,vspo,kod,kisp,
												            sos,ref99bm,vdate,tp,ref
												     INTO :nRow,:nNm,:nDk,:nMfo,:sNd,:nVob,:sNls,:sNlsk,:nSk,:nS,:sPlat,
												          :sPolu,:sNaz1,:sVspo,:sKod,:sKisp,:nSos,:nRef99bm,:dVdate,:sTp,
												          :nRefO
												     FROM moper
												     FOR UPDATE OF ref99bm")
										  Call SqlOpen(hSqlA, "moper")
										  While SqlFetchNext(hSqlA, nFetchRes)
											  Set dVdateOrig = dVdate
											  Set sNls = SalStrTrimX(sNls)
											  Set sNlsk = SalStrTrimX(sNlsk)
											  Set sNd = SalStrTrimX(StrDosToWinX(sNd))
											  Set sMfo = SalNumberToStrX(nMfo, 0)
											  Set sMfo = IifS(Val(sMfo)=0, sMfoA, sMfo)
											  If rb1
												  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
												  Call SalTblSetContext(tbl1, nNewRow)
												  Set tbl1.colNPP = nRecn
												  Set tbl1.colND = sNd
												  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
												  Set tbl1.colNLSA = sNls
												  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
												  Set tbl1.colNLSB = sNlsk
												  Set tbl1.colS = nS / 100
												  Set tbl1.colVDATE = dVdate
												  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
												  Call SalTblSetFocusRow(tbl1, nNewRow)
												  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New, FALSE)
												  If Val(sNls) = 0
													  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Gray)
												  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
												  If tbl1.colREF98 != NUMBER_Null
													  Call SalTblSetCellTextColor(tbl1.colREF98, COLOR_DarkGreen, TRUE)
												  Else 
													  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Gray)
											  If (nNm = 1 or nNm = 2 or nNm = 3) and nSos = 5 and nS > 0 and
													   (((nRef99bm = 0 or nRef99bm = NUMBER_Null) and nType = 0) or
													   nType = 1 and nRef99bm > 0)
												  Set bStop = FALSE
												  Set nI = 0
												  While nI < n22
													  If (sStopNLS1[nI] = sNls and sStopNLS2[nI] = sNlsk) or
															   (sStopNLS1[nI] = sNlsk and sStopNLS2[nI] = sNls)
														  Set bStop = TRUE
														  Break 
													  Set nI = nI + 1
												  If not bStop
													  Set sKisp = SalStrTrimX(sKisp)
													  If Len(sKisp) = 0
														  Set sKisp = GetBankOperIdent(sMfoA, sTp)
													  Set sPlat = SalStrTrimX(StrDosToWinX(sPlat))
													  Set sPolu = SalStrTrimX(StrDosToWinX(sPolu))
													  Set sNaz1 = SalStrTrimX(StrDosToWinX(sNaz1))
													  Set sVspo = SalStrTrimX(StrDosToWinX(sVspo))
													! If dDat = DATETIME_Null
														    Set dDat = dVdate
													  Set sKod = SalStrTrimX(sKod)
													  If nNm = 1
														  Set sMfo = sMfoA
														  If nDk = 0
															  Set nIndex0 = VisArrayFindString(sSbuNLS, sNls)
															  Set nIndex1 = VisArrayFindString(sSbuNLS, sNlsk)
														  Else 
															  Set nIndex0 = VisArrayFindString(sSbuNLS, sNlsk)
															  Set nIndex1 = VisArrayFindString(sSbuNLS, sNls)
														  Set bWozw = FALSE
														  If nIndex0 >= 0 and nIndex1 >= 0 and
																   sSbuNLS8[nIndex0] = sSbuNLS8[nIndex1]
															  Set nSbuFLAG_0 = nSbuFLAG[nIndex0]
															  Set nSbuFLAG_1 = nSbuFLAG[nIndex1]
															  Set nSbuFLAG[nIndex0] = 0 ! без визы
															  Set nSbuFLAG[nIndex1] = 0 ! без визы
															  Set bWozw = TRUE
														  If nIndex0 >= 0 and nIndex1 >= 0 and
																   sSbuNLS8[nIndex0] != sSbuNLS8[nIndex1] and
																   nSbuFLAG[nIndex0] != nSbuFLAG[nIndex1]
															  Set nSbuFLAG_0 = nSbuFLAG[nIndex0]
															  Set nSbuFLAG_1 = nSbuFLAG[nIndex1]
															  Set nSbuFLAG[nIndex0] = 1 ! с визой
															  Set nSbuFLAG[nIndex1] = 1 ! с визой
															  Set bWozw = TRUE
													  If nNm > 1 ! nNm = 2 or nNm = 3
														  If Mod(nNm+nDk, 2) = 0
															  Set nIndex0 =  VisArrayFindString(sSbuNLS, sNls)
															  Set nIndex1 = -1
														  Else 
															  Set nIndex1 = VisArrayFindString(sSbuNLS, sNls)
															  Set nIndex0 = -1
													  Set n21 = 0
													  Set bMa = FALSE
													  Set bMc = FALSE
													  Set nStep = 0
													  While n21 < 2 and (nIndex0 >= 0 or nIndex1 >= 0) ! можно обрабатывать
														  If n21 = 0
															  If nIndex0 >= 0
																  Set sNls8 = sSbuNLS8[nIndex0]
																  Set nDk2 = 0
																  Set nFlag = nSbuFLAG[nIndex0]
																! If nIndex1 >= 0 and nSbuFLAG[nIndex1] != nFlag
																	! Есть 2: план и факт (ПЛАН)
																	    Set nFlag = 1
																  If Len(sNls8) = 0 or (nNm = 1 and nIndex1 >= 0 and
																		   Len(sSbuNLS8[nIndex1]) = 0)
																	! Set n21 = n21 + 1
																	  Set n21 = n21 + IifN(nNm=1, 2, 1)
																	  Set bDalee = FALSE
																	! покрасить
																	  If not rb1
																		  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																		  Call SalTblSetContext(tbl1, nNewRow)
																		  Set tbl1.colNPP = nRecn
																		  Set tbl1.colND = sNd
																		  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																		  Set tbl1.colNLSA = sNls
																		  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																		  Set tbl1.colNLSB = sNlsk
																		  Set tbl1.colS = nS / 100
																		  Set tbl1.colVDATE = dVdate
																		  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																		  Call SalTblSetFocusRow(tbl1, nNewRow)
																		  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																				     FALSE)
																	  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Teal)
																	  If (nNm = 1 and ((nDk = 0 and Len(sNls8) = 0) or (nDk = 1 and
																			   Len(sNls8) > 0))) or (nNm > 1 and Mod(nNm+nDk, 2) = 0)
																		  Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																	  Else 
																		  Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																	  Set dfNoLink = dfNoLink + 1
																  Else 
																	  Set bDalee = TRUE
															  Else 
																  Set n21 = n21 + 1
																  Set bDalee = FALSE
														  Else ! If n21 = 1
															  If nIndex1 >= 0
																  Set sNls8 = sSbuNLS8[nIndex1]
																  Set nDk2 = 1
																  Set nFlag = nSbuFLAG[nIndex1]
																! If nIndex0 >= 0 and nSbuFLAG[nIndex0] != nFlag
																	! Есть 2: план и факт (ПЛАН)
																	    Set nFlag = 1
																  If Len(sNls8) = 0 or (nNm = 1 and nIndex0 >= 0 and
																		   Len(sSbuNLS8[nIndex0]) = 0)
																	  Set n21 = n21 + 1
																	  Set bDalee = FALSE
																	! покрасить
																	! почему-то ЗЕЛЕНЫЙ есть ???
																	  If not rb1
																		  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																		  Call SalTblSetContext(tbl1, nNewRow)
																		  Set tbl1.colNPP = nRecn
																		  Set tbl1.colND = sNd
																		  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																		  Set tbl1.colNLSA = sNls
																		  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																		  Set tbl1.colNLSB = sNlsk
																		  Set tbl1.colS = nS / 100
																		  Set tbl1.colVDATE = dVdate
																		  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																		  Call SalTblSetFocusRow(tbl1, nNewRow)
																		  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																				     FALSE)
																	  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Teal)
																	  If (nNm = 1 and ((nDk = 0 and Len(sNls8) = 0) or (nDk = 1 and
																			   Len(sNls8) > 0))) or (nNm > 1 and Mod(nNm+nDk, 2) = 0)
																		  Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																	! Else If (nNm = 1 and  nDk = 0 and nIndex0 >= 0 and
																			     Len(sSbuNLS8[nIndex0]) = 0)
																		    Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																	  Else 
																		  Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																	  Set dfNoLink = dfNoLink + 1
																  Else 
																	  Set bDalee = TRUE
															  Else 
																  Break 
														  If bDalee
															  If nVob = 96 and Mod(SalDateMonth(dVdate), 3) = 1
																  Set dVdate = IifD(dDat1=DATETIME_Null,
																		    SalDateMonthBegin(dBankDate)-1, dDat1)
															  Else If nVob = 99
																  Set dVdate = SalDateConstruct(SalDateYear(dVdate)-1, 12, 31, 0, 0,
																		    0)
															  Else 
																  Set dVdate = dBankDate
															  If (nVob = 96 and Mod(SalDateMonth(dVdate), 3) = 1) or nVob = 99
																  Call SqlPrepareAndExecute(hSql(), "
																		     SELECT fdat
																		     FROM fdat
																		     WHERE fdat=:dVdate")
																  If not SqlFetchNext(hSql(), nFetchRes)
																	  Call SqlPrepareAndExecute(hSql(), "
																			     INSERT
																			     INTO fdat (fdat)
																			     VALUES (:dVdate)")
															  If dVdate != dVdateU
																  Call Pl_dat(dVdate) ! Установить банковскую дату равной VDATE в
																		                    ! MOPER (но не совсем)
																  Set dVdateU = dVdate
															  If not bMa
																  Set bMa = TRUE
																  If not rb1 
																	  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																	  Call SalTblSetContext(tbl1, nNewRow)
																	  Set tbl1.colNPP = nRecn
																	  Set tbl1.colND = sNd
																	  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																	  Set tbl1.colNLSA = sNls
																	  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																	  Set tbl1.colNLSB = sNlsk
																	  Set tbl1.colS = nS/100
																	  Set tbl1.colVDATE = dVdate
																	  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																	  Call SalTblSetFocusRow(tbl1, nNewRow)
																	  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																			     FALSE)
																  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Blue)
																  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
																  Set dfGood = dfGood + 1
															  Set nFlag = IifN(Left(sNaz1, 4)='ь-01' or Left(sNaz1, 4)='Ь-01' or
																	    Left(sNaz1, 4)='ь-02' or Left(sNaz1, 4)='Ь-02' or
																	    Left(sNaz1, 4)='ь-04' or Left(sNaz1, 4)='Ь-04', 0,
																	    IifN(nVob=96 or nVob=99, 1, nFlag))
															  If nType = 1
																  Set bSD = FALSE
																  If Ful_Bak(nRef99bm)
																	  Set bSD = SqlPrepareAndExecute(
																			    hSql(), "
																			    DELETE
																			    FROM oper
																			    WHERE ref=:nRef99bm")
															  Else 
																  Set bSD = TRUE
															  If bSD and Len(sNaz1)>3
																! Call ccDoc.SetDoc(IifN(nStep=0, 0, nRef), 'PO' || Str(1-nFlag),
																		     nDk, nVob, sNd, dDat, SalDateCurrent(), dVdate, dVdate,
																		     IifS(nNm=3, sNlsk, sNls), IifS(nNm=3, sPolu, sPlat),
																		     IifS(nNm=3, sMfo, sMfoA), '', 980, nS, sKod, IifS(nNm=3,
																		     sNls, sNlsk), IifS(nNm=3, sPlat, sPolu), IifS(nNm=3, sMfoA,
																		     sMfo), '', 980, nS, '', sNaz1, sVspo, sKisp, '', nSk)
																  Call ccDoc.SetDoc(IifN(nStep=0, 0, nRef), 'PO' || Str(1-nFlag),
																		     nDk, nVob, sNd, dVdateOrig, SalDateCurrent(), dVdate, dVdate,
																		     IifS(nNm=3, sNlsk, sNls), IifS(nNm=3, sPolu, sPlat),
																		     IifS(nNm=3, sMfo, sMfoA), '', 980, nS, sKod, IifS(nNm=3,
																		     sNls, sNlsk), IifS(nNm=3, sPlat, sPolu), IifS(nNm=3, sMfoA,
																		     sMfo), '', 980, nS, '', sNaz1, sVspo, sKisp, '', nSk)
																! If nRefl = 0
																	    Set nRefl = NUMBER_Null
																  If ccDoc.oDoc()
																	  Set nRef = ccDoc.m_nRef
																	  Set nStep = nStep + 1
																	! Call SqlPrepareAndExecute(
																			     hSql(), "
																			     UPDATE oper
																			     SET refl=:nRefl
																			     WHERE ref=:nRef")
																	  Set ccDoc.A.Kv = 980
																	  Set ccDoc.m_nDk = nDk2
																	  If ccDoc.TT.SetTT(nRef, 'PO' || Str(1-nFlag), ccDoc.m_dDatV1,
																			   ccDoc.m_nDk, sNls8, ccDoc.A.Kv, ccDoc.A.S, 'BBBBK' || sRnk,
																			   ccDoc.B.Kv, ccDoc.B.S) and ccDoc.TT.PayTT(1-nFlag)
																		! Call Debug('nNm=' || Str(nNm) || ', n21=' || Str(n21))
																		! если макет не = 1 или (макет = 1 и ((обе связки есть в SBU и
																				! n21 = 1) или (только одна связка есть в SBU))
																		  Set nL0 = 0
																		  Set nL1 = 0
																		! Call Debug('nIndex0=' || Str(nIndex0) || ', nIndex1=' ||
																				     Str(nIndex1))
																		  If nIndex0 >= 0 
																			  Set nL0 = Len(sSbuNLS8[nIndex0])
																		  If nIndex1 >= 0 
																			  Set nL1 = Len(sSbuNLS8[nIndex1])
																		  If nNm != 1 or (nNm = 1 and ((nL0 * nL1 > 0 and n21 = 1) or
																				   (nL0 > 0 and nL1 = 0) or (nL0 = 0 and nL1 > 0)))
																			  If SqlPrepareAndExecute(hSqlB, "
																					   UPDATE moper
																					   SET ref99bm=:ccDoc.m_nRef
																					   WHERE CURRENT OF moper")
																				  Call SqlCommitEx(hSql(), 'Мак.' || Str(nNm) || ', счетА='
																						     || sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(
																						     Str(nS), Len(Str(nS))-2) || '.' || Right(Str(nS), 2)
																						     || ', DK=' || Str(nDk) || ', ЧО=' || Str(1-nFlag) ||
																						     ', Ref=' || Str(nRef))
																				! Call SqlCommit(hSqlB)
																				! If n21 = 0
																					    Set dfCurrent = dfCurrent + 1
																				  If not bMc
																					  Set dfCurrent = dfCurrent + 1
																					  Set bMc = TRUE
																				  Set tbl1.colREF98 = nRef
																				  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_DarkGreen)
																				  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
																			  Else 
																				  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) ||
																						     ', счетА=' || sNls || ', счетБ=' || sNlsk ||
																						     ', сумма=' || Left(Str(nS), Len(Str(nS))-2) || '.' ||
																						     Right(Str(nS), 2) || ', DK=' || Str(nDk) || ', ЧО='
																						     || Str(1-nFlag))
																				  Set n21 = n21 + 1 ! Для выхода
																	  Else 
																		  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																				     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(
																				     Str(nS), Len(Str(nS))-2) || '.' || Right(Str(nS), 2) ||
																				     ', DK=' || Str(nDk) || ', ЧО=' || Str(1-nFlag))
																		  Set n21 = n21 + 1 ! Для выхода
																  Else 
																	  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																			     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(Str(nS),
																			     Len(Str(nS))-2) || '.' || Right(Str(nS), 2) || ', DK=' ||
																			     Str(nDk) || ', ЧО=' || Str(1-nFlag))
																	  Set n21 = n21 + 1 ! Для выхода
															  Else 
																  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																		     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(Str(nS),
																		     Len(Str(nS))-2) || '.' || Right(Str(nS), 2) || ', DK=' ||
																		     Str(nDk) || ', ЧО=' || Str(1-nFlag))
																  Set n21 = n21 + 1 ! Для выхода
															  Set n21 = n21 + 1
													  If nNm = 1 and nIndex0 >= 0 and nIndex1 >= 0 and bWozw
														  Set nSbuFLAG[nIndex0] = nSbuFLAG_0
														  Set nSbuFLAG[nIndex1] = nSbuFLAG_1
											  Set nPos = nPos + nDelta
											  Set nRecn = nRecn + 1
											  If Int(nPos) != nTek
												  Set nTek = Int(nPos)
												  Set nTimeCurrent = SalDateHour(SalDateCurrent())*3600 +SalDateMinute(
														    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
												  Set nTimeEnd = Int(100 * (nTimeCurrent-nTimeStart) / nPos + nTimeStart)
												! Call Debug('nPos=' || Str(nPos) || ', nTimeStart=' || Str(nTimeStart) ||
														    ', nTimeEnd=' || Str(nTimeEnd))
												  Set nHour = Int(nTimeEnd/3600)
												  Set nTemp = nTimeEnd - nHour*3600
												  Set nMinu = Int(nTemp/60)
												  Set dfAll = dfAll
												  Set dfGood = dfGood
												  Set dfCurrent = dfCurrent
												  Set dfNoLink = dfNoLink
												  Set dfStart = dfStart
												  Set dfEnd = 'Финиш: ' || Right(Str(100+nHour), 2) || ':' || Right(
														    Str(100+nMinu), 2) || ':' || Right(Str(100+nTemp-nMinu*60), 2) ||
														    ' (прогноз)'
											  Call ccProgressBar.SetProgress(nPos)
											  Call SalUpdateWindow(hWndForm)
											! Call SalUpdateWindow(tbl1)
											! Call SalSetFocus(tbl1)
										  Call ccProgressBar.SetProgress(100)
										  Set dfEnd = Left(dfEnd, 15)
										! Call SqlCommitEx(hSql(), 'OK')
										! Call SqlCommit(hSqlB)
										  Call SqlDisconnect(hSqlA)
										  Call SqlDisconnect(hSqlB)
										  Call SaveInfoToLog("Прием документов налогового учета ОКОНЧЕН.")
										  Set dfDone = "Готово"
										  Call SalMessageBeep(-1)
										  Call SalSetFocus(tbl1)
										  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
										! Call SalSetWindowText(hWndForm, sText)
										! Call SalDisableWindow(rb1)
										! Call SalDisableWindow(rb2)
										! Call SalHideWindow(dfStart)
										! Call SalHideWindow(dfEnd)
									  Else 
										  Call MessageAttention('Ошибка подсоединения к Базе данных: ' || SqlDatabase)
								  Else 
									  Call MessageAttention('Нет файла: ' || sODBCDir || '\\G' || Str(dfGod) || 'K' ||
											     Str(dfKw) || '\\MOPER.dbf или ' || sODBCDir || '\\SBU.dbf')
							  Else 
								  Call MessageAttention('Нет каталога: ' || sODBCDir)
							  Call SalEnableWindow(pbExecute)
							  Set rbPnone = TRUE
							  Call SalEnableWindow(pbExit)
							  Call SalSetFocus(pbExit)
							  Call WaitCursorOff()
						  Else 
							  Call MessageNoWait('День закрыт !', 'Предупреждение', 0, 1)
			  Pushbutton: pbExit
				  Message Actions 
					  On SAM_Click
						  Call SalEndDialog(hWndForm, FALSE)
			  Frame 
			  Data Field: dfDone
				  Message Actions 
			  Custom Control: ccProgressBar
				  Message Actions 
			  Child Table: tbl1
				  Contents 
					  Column: colNPP
						  List Values 
						  Message Actions 
					  Column: colND
						  List Values 
						  Message Actions 
					  Column: colMFOA
						  List Values 
						  Message Actions 
					  Column: colNLSA
						  List Values 
						  Message Actions 
					  Column: colMFOB
						  List Values 
						  Message Actions 
					  Column: colNLSB
						  List Values 
						  Message Actions 
					  Column: colS
						  List Values 
						  Message Actions 
					  Column: colVDATE
						  List Values 
						  Message Actions 
					  Column: colREF98
						  List Values 
						  Message Actions 
				  Functions 
				  Window Variables 
					  Number: nFocusRow
					  Window Handle: hWndCol
				  Message Actions 
					  On SAM_Click
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
						  If not SalIsWindowEnabled(pbExecute)
							  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
					  On SAM_CornerClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_CornerDoubleClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_DoubleClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_RowHeaderClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_RowHeaderDoubleClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_EndCellTab
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On WM_LbuttonUp
						! Узнать текущую строку
						! Call SalTblQueryFocus(tbl1, nFocusRow, hWndCol)
						! Set nFocusRow = SalTblQueryContext(tbl1)
						! Почистить все
						  Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
						! Call SalTblSetFocusRow (tbl1, nFocusRow)
						! Стать на нее (что выше)
						! Call SalTblSetRowFlags(tbl1, nFocusRow, ROW_Selected, FALSE)
						! Call SalSendMsg(tbl1, SAM_RowHeaderClick, 0, Max(TBL_MaxRow, nFocusRow+1))
					  On VTM_KeyUp
						  Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
						  If not SalIsWindowEnabled(pbExecute)
							  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
					  On WM_NCMouseMove ! 160
						  If not SalIsWindowEnabled(pbExecute)
							  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
			  Data Field: dfStart
				  Message Actions 
			  Data Field: dfEnd
				  Message Actions 
			  Radio Button: rb1
				  Message Actions 
			  Radio Button: rb2
				  Message Actions 
			  Frame 
			  Background Text: Дата отчетного периода
			  Data Field: dfBD
				  Message Actions 
					  On SAM_Validate
						  If dfBD > dBankDate
							  Call MessageNoWait('Локальная дата не может быть больше текущей даты !', 'ОШИБКА',
									     30, 1)
							  Return VALIDATE_Cancel
						  Call SalSendMsg(dfGod, SAM_Create, 0, 0)
						  Call SalSendMsg(dfKw, SAM_Create, 0, 0)
						  Call SalSendMsg(dfDbeg, SAM_Create, 0, 0)
						  Call SalSendMsg(dfDend, SAM_Create, 0, 0)
			  Radio Button: rbGodKw
				  Message Actions 
					  On SAM_Click
						  Call SalDisableWindow(dfDbeg)
						  Call SalDisableWindow(dfDend)
						  Call SalEnableWindow(dfGod)
						  Call SalEnableWindow(dfKw)
			  Radio Button: rbDates
				  Message Actions 
					  On SAM_Click
						  Call SalEnableWindow(dfDbeg)
						  Call SalEnableWindow(dfDend)
						  Call SalDisableWindow(dfGod)
						  Call SalDisableWindow(dfKw)
			  Data Field: dfGod
				  Message Actions 
					  On SAM_Create
						! Set dfGod = SalDateYear(SalDateCurrent()-1)
						  Set dfGod = SalDateYear(dfBD-1)
					  On SAM_Validate
						! If dfGod < SalDateYear(SalDateCurrent()-1)-3 or dfGod > SalDateYear(
								   SalDateCurrent()) or (dfGod = SalDateYear(SalDateCurrent()-1) and
								   dfKw > SalDateQuarter(SalDateCurrent()-1))
							    Call MessageNoWait('Недопустимое сочетание года и номера квартала.', 'ОШИБКА', 30,
									     1)
							    Return VALIDATE_Cancel
						  If dfGod < SalDateYear(dfBD-1)-3 or dfGod > SalDateYear(dfBD) or
								   (dfGod = SalDateYear(dfBD-1) and dfKw > SalDateQuarter(dfBD-1))
							  Call MessageNoWait('Недопустимое сочетание года и номера квартала.', 'ОШИБКА', 30,
									     1)
							  Return VALIDATE_Cancel
						  Else 
							  Call SetDbegDend(dfGod, dfKw)
			  Data Field: dfKw
				  Message Actions 
					  On SAM_Create
						! Set dfKw = SalDateQuarter(SalDateCurrent()-1)
						  Set dfKw = SalDateQuarter(dfBD-1)
					  On SAM_Validate
						! If dfKw < 1 or dfKw > 4 or (dfGod = SalDateYear(SalDateCurrent()-1) and
								   dfKw > SalDateQuarter(SalDateCurrent()-1))
							    Call MessageNoWait('Недопустимый номер квартала.', 'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						  If dfKw < 1 or dfKw > 4 or (dfGod = SalDateYear(dfBD-1) and
								   dfKw > SalDateQuarter(dfBD-1))
							  Call MessageNoWait('Недопустимый номер квартала.', 'ОШИБКА', 30, 1)
							  Return VALIDATE_Cancel
						  Else 
							  Call SetDbegDend(dfGod, dfKw)
			  Data Field: dfDbeg
				  Message Actions 
					  On SAM_Create
						! Set dTemp = SalDateQuarterBegin(SalDateCurrent()-1)
						  Set dTemp = SalDateQuarterBegin(dfBD-1)
						! Set dfDbeg = IifD(dTemp > SalDateCurrent(), SalDateCurrent(), dTemp)
						  Set dfDbeg = IifD(dTemp > dfBD, dfBD, dTemp)
					  On SAM_Validate
						! If dfDbeg > SalDateCurrent()
							    Call MessageNoWait('Даты ("Интервал дат") не должны превышать текущей даты.',
									     'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						  If dfDbeg > dfBD
							  Call MessageNoWait('Даты ("Интервал дат") не должны превышать текущей даты.',
									     'ОШИБКА', 30, 1)
							  Return VALIDATE_Cancel
						  Else 
							  Set dfGod = SalDateYear(dfDbeg)
							  Set dfKw = SalDateQuarter(dfDbeg)
					  On SAM_KillFocus
						  Call SalSetFocus(dfDend)
						  Call SalSetFieldEdit(dfDend, TRUE)
			  Data Field: dfDend
				  Message Actions 
					  On SAM_Create
						! Set dTemp = SalDateQuarterBegin(SalDateCurrent()+91) - 1
						  Set dTemp = SalDateQuarterBegin(dfBD+91) - 1
						! Set dfDend = IifD(dTemp > SalDateCurrent(), SalDateCurrent(), dTemp)
						  Set dfDend = IifD(dTemp > dfBD, dfBD, dTemp)
					  On SAM_Validate
						! If dfDend > SalDateCurrent() or dfDbeg > dfDend or
								   SalDateQuarter(dfDbeg) != SalDateQuarter(dfDend) or dfDbeg > SalDateCurrent()
							    Call MessageNoWait(IifS(dfDbeg>dfDend, 'Вторая дата не может быть меньше первой.',
									     'Даты ("Интервал дат") ' || IifS(dfDend>SalDateCurrent(),
									     'не должны превышать текущей даты.',
									     'должны находиться в пределах одного квартала.')), 'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						  If dfDend > dfBD or dfDbeg > dfDend or
								   SalDateQuarter(dfDbeg) != SalDateQuarter(dfDend) or dfDbeg > dfBD
							  Call MessageNoWait(IifS(dfDbeg>dfDend, 'Вторая дата не может быть меньше первой.',
									     'Даты ("Интервал дат") ' || IifS(dfDend>dfBD,
									     'не должны превышать текущей даты.',
									     'должны находиться в пределах одного квартала.')), 'ОШИБКА', 30, 1)
							  Return VALIDATE_Cancel
						  Else 
							  Set dfGod = SalDateYear(dfDend)
							  Set dfKw = SalDateQuarter(dfDend)
			  Frame 
			  Group Box: Предварительная обработка
			  Radio Button: rbPnone
				  Message Actions 
					  On SAM_Click
						  Call DisableDates()
						  Call SalEnableWindow(dfGod)
						  Call SalEnableWindow(dfKw)
						  Call SalEnableWindow(pbExecute)
			  Radio Button: rbOdok
				  Message Actions 
					  On SAM_Click
						  Call SalEnableWindow(rbDates)
						  If rbGodKw
							  Call SalDisableWindow(dfDbeg)
							  Call SalDisableWindow(dfDend)
							  Call SalEnableWindow(dfGod)
							  Call SalEnableWindow(dfKw)
						  If rbDates
							  Call SalEnableWindow(dfDbeg)
							  Call SalEnableWindow(dfDend)
							  Call SalDisableWindow(dfGod)
							  Call SalDisableWindow(dfKw)
						  Call SalEnableWindow(pbExecute)
			  Radio Button: rbKdok
				  Message Actions 
					  On SAM_Click
						  Call DisableDates()
						  Call SalEnableWindow(dfGod)
						  Call SalEnableWindow(dfKw)
						  Call SalEnableWindow(pbExecute)
			  Frame 
			  Picture: pic1
				  Message Actions 
			  Radio Button: rbBi
				  Message Actions 
			  Radio Button: rbBo
				  Message Actions 
			  Data Field: dfBi
				  Message Actions 
			  Data Field: dfBo
				  Message Actions 
			  Background Text: Баланс
			  Picture: pic2
				  Message Actions 
			  Picture: pic3
				  Message Actions 
			  Check Box: cbSave
				  Message Actions 
					  On SAM_Click
						  If cbSave
							  Set cbClear = FALSE
			  Check Box: cbClear
				  Message Actions 
					  On SAM_Click
						  If cbClear
							  Set cbSave = FALSE
			  Radio Button: rbVi
				  Message Actions 
			  Radio Button: rbVo
				  Message Actions 
			  Data Field: dfVi
				  Message Actions 
			  Data Field: dfVo
				  Message Actions 
			  Background Text: Вне
					баланс
			  Background Text: Бал.сч.
		  Functions 
			  Function: GetBankOperIdent
				  Description: 
				  Returns 
					  String: 
				  Parameters 
					  String: sMfo
					  String: sId
				  Static Variables 
				  Local variables 
					  String: sSab
				  Actions 
					  Set sSab = GetValueStr("
							    SELECT sab
							    FROM banks
							    WHERE mfo=" || sMfo)
					  Return IifS(sSab='', 'xxx', Right(sSab, 3)) || 'O' || sId
			  Function: SetDbegDend
				  Description: 
				  Returns 
				  Parameters 
					  Number: nGod
					  Number: nKw
				  Static Variables 
				  Local variables 
				  Actions 
					  Set dfDbeg = SalDateQuarterBegin(SalDateConstruct(nGod, nKw*3, 1, 0, 0, 0))
					  Set dfDend = SalDateQuarterBegin(SalDateConstruct(nGod, nKw*3, 1, 0, 0, 0) + 92) - 1
			  Function: DisableDates
				  Description: 
				  Returns 
				  Parameters 
				  Static Variables 
				  Local variables 
				  Actions 
					  Call SalDisableWindow(dfDbeg)
					  Call SalDisableWindow(dfDend)
					  Call SalDisableWindow(rbDates)
					  Set rbGodKw = TRUE
		  Window Parameters 
			  Number: nType
		  Window Variables 
			  : ccDoc
			  String: ND
			  String: NLS
			  String: NLSK
			  Number: KVS
			  Number: SK
			  Number: REF
			  Number: ISV
			  String: NAZN
			  String: sTmp
			  Number: nCount
			  String: sAn
			  String: sNbw
			  Number: nNls
			  String: sMfo
			  String: sMfoA
			  String: sMdl
			  Number: nMfop
			  Number: nFetchRes
			  String: sBlk
			  String: sFv
			  String: sFs
			  Number: nDocs
			  Sql Handle: hSqlA
			  Sql Handle: hSqlB
			  Sql Handle: hSqlC
			  Number: nPos
			  Number: nDelta
			  Number: nRecCount
			  String: strMessage
			  Number: nNm
			  Number: nDk
			  Number: nDk2
			  Number: nMfo
			  String: sNd
			  Number: nVob
			  String: sNls
			  String: sNlsk
			  String: sNls8
			  Number: nSk
			  Number: nS
			! Date/Time: dDat
			  String: sPlat
			  String: sPolu
			  String: sNaz1
			  String: sVspo
			  String: sKod
			  String: sKisp
			  Number: nRow
			  Number: nRef
			  String: sODBCDir
			  Date/Time: dTmp
			  Number: n99
			  Number: nSos
			  Number: nRef99bm
			  Date/Time: dVdate
			  Date/Time: dVdateOrig
			  Date/Time: dVdateU
			  Date/Time: dBankDate
			!
			  Number: nNewRow
			!
			  Number: nTimeStart
			  Number: nTimeCurrent
			  Number: nTimeEnd
			  Number: nHour
			  Number: nMinu
			  Number: nTemp
			  Number: nTek
			  Number: nRecn
			!
			  Number: nFlag
			  Number: n21
			  Number: nStep
			!
			  String: sNLS
			  String: sNLS8
			  Number: nFLAG
			  String: sSbuNLS[*]
			  String: sSbuNLS8[*]
			  Number: nSbuFLAG[*]
			  Number: nIndex0
			  Number: nIndex1
			!
			  Date/Time: dDat1
			!
			  Boolean: bDalee
			  Boolean: bSD
			!
			  String: sTp
			!
			  String: sNLS1
			  String: sNLS2
			  String: sStopNLS1[*]
			  String: sStopNLS2[*]
			  Number: n22
			  Number: nI
			  Boolean: bStop
			!
			  Number: nRefO
			!
			  Boolean: bMa
			  Boolean: bMc
			!
			  Boolean: bProdol
			!
			  String: sRnk
			!
			  Date/Time: dTemp
			!
			  String: sCurDir
			  String: sOdbkPath
			!
			  String: sBalAcc
			  String: sBalAccn
			!
			  Number: nL0
			  Number: nL1
			!
			  Number: nSbuFLAG_0
			  Number: nSbuFLAG_1
			  Boolean: bWozw
			!
			  String: sBi
			  String: sVi
		  Message Actions 
			  On SAM_Create
				  Call SalWaitCursor(TRUE)
				  Call ConPara('PUSH')
				  Call SalFileGetCurrentDirectory(sCurDir)
				  Call SalUseRegistry(FALSE, '')
				  Call SalGetProfileString('Import', 'NalDecPath', Left(SalFileGetDrive(), 1) ||
						     ':\\BARS98\\ODBC.DSN\\SBU', sODBCDir, GetIniFileName())
				  Call SalGetProfileString('Import', 'BarsFoxOdbkPath', Left(SalFileGetDrive(), 1) ||
						     ':\\BARS98\\ODBC.DSN\\ODBK', sOdbkPath, GetIniFileName())
				  Call SalGetProfileString('Import', 'BalAcc', '99999999999999', sBalAcc, GetIniFileName())
				  Call SalGetProfileString('Import', 'BalAccn', '99999999999999', sBalAccn,
						     GetIniFileName())
				! Set dfBi = sBalAcc
				! Set dfVi = sBalAccn
				  Call SalUseRegistry(TRUE, GetCompanyName())
				  Call SalGetProfileString('NalUch', 'BalAccVkl', sBalAcc, dfBi, 'Bars98')
				  Call SalGetProfileString('NalUch', 'BalAccIsk', '99999999999999', dfBo, 'Bars98')
				  Call SalGetProfileString('NalUch', 'BalAcnVkl', sBalAccn, dfVi, 'Bars98')
				  Call SalGetProfileString('NalUch', 'BalAcnIsk', '99999999999999', dfVo, 'Bars98')
				  Call SalGetProfileString('NalUch', 'BalAccA', '0', sBi, 'Bars98')
				  Call SalGetProfileString('NalUch', 'BalAccN', '0', sVi, 'Bars98')
				  If Len(dfBi) = 0
					  Set dfBi = sBalAcc
				  If Len(dfVi) = 0
					  Set dfVi = sBalAccn
				  Set rbBi = sBi='0'
				  Set rbBo = sBi!='0'
				  Set rbVi = sVi='0'
				  Set rbVo = sVi!='0'
				  Set dBankDate = GetBankDate()
				  Set dfBD = dBankDate
				  Call PrepareWindowEx(hWndForm)
				  If nType = 1
					  Call SalSetWindowText(hWndForm,
							     'ПОВТОРНЫЙ прием информации для налогового учета из ОДБ (финансовый учет)')
				! Call SalHideWindow(dfStart)
				! Call SalHideWindow(dfEnd)
				  Call SalSetFocus(pbExit)
				  Set rb2 = TRUE
				  Call DisableDates()
			  On SAM_CreateComplete
				  Call SalWaitCursor(FALSE)
			  On SAM_Destroy
				  Call ConPara('POP')
				  Call SalFileSetCurrentDirectory(sCurDir)
				  If cbSave
					  Call SalUseRegistry(TRUE, GetCompanyName())
					  Call SalSetProfileString('NalUch', 'BalAccVkl', dfBi, 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAccIsk', dfBo, 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAcnVkl', dfVi, 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAcnIsk', dfVo, 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAccA', IifS(rbBi, '0', '1'), 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAccN', IifS(rbVi, '0', '1'), 'Bars98')
				  If cbClear
					  Call SalUseRegistry(TRUE, GetCompanyName())
					  Call SalSetProfileString('NalUch', 'BalAccVkl', '', 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAccIsk', '', 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAcnVkl', '', 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAcnIsk', '', 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAccA', '0', 'Bars98')
					  Call SalSetProfileString('NalUch', 'BalAccN', '0', 'Bars98')
				  Call Pl_dat(dBankDate)
	! Dialog Box: dlg_ImpNal8_old
.winattr
		Class:
		Property Template:
		Class DLL Name:
		Title: Импорт информации для налогового учета из ОДБ (финансовый учет)
		Accesories Enabled? No
		Visible? Yes
		Display Settings
			Display Style? Default
			Visible at Design time? Yes
			Type of Dialog: Modal
			Window Location and Size
				Left:   0.15"
				Top:    0.146"
				Width:  12.95"
				Width Editable? Yes
				Height: 6.833"
				Height Editable? Yes
			Absolute Screen Location? Yes
			Font Name: Default
			Font Size: Default
			Font Enhancement: Default
			Text Color: Default
			Background Color: Default
.end
		  Description: Прием документов и оплата документов из 'старого' БАРСа
		  Tool Bar 
			  Contents 
		  Contents 
			  Background Text: Всего:
			  Data Field: dfAll
				  Message Actions 
			  Background Text: Выбрано:
			  Data Field: dfGood
				  Message Actions 
			  Background Text: Обработано:
			  Data Field: dfCurrent
				  Message Actions 
			  Background Text: Нет связи:
			  Data Field: dfNoLink
				  Message Actions 
			  Pushbutton: pbExecute
				  Message Actions 
					  On SAM_Click
						  If IsBankDayOpen()
							  If sODB='DBF'
								  If MessageQuestion(
										   'Выполнять Прием/Оплату документов (КВАРТАЛ - ' || Str(dfKw) || IifS(rbPnone, '',
										   ', ПРЕДВАРИТЕЛЬНАЯ ОБРАБОТКА ' || IifS(rbKdok, 'корректирующих ', '') ||
										   'документов финансового учета' || IifS(rbKdok, '', ' с ' ||
										   SalFmtFormatDateTime(dfDbeg, 'dd/MM/yyyy') || ' по ' ||
										   SalFmtFormatDateTime(dfDend, 'dd/MM/yyyy'))) || ') ?') = IDNO
									  Return FALSE
								  Call WaitCursorOn()
								  Call SalDisableWindow(pbExecute)
								  Call SalDisableWindow(pbExit)
								  Set dfDone = ""
								  Set dfStart = 'Старт: ' || SalFmtFormatDateTime(SalDateCurrent(), 'hhh:mm:ss')
								  Call SaveInfoToLog("Прием/Оплата документов налогового учета.")
								! Call Debug('SaveInfoToLog - "Прием/Оплата" - Ok')
								  If SalFileSetCurrentDirectory(sODBCDir)
									  If not rbPnone
										! Здесь поставить предобработку
										! Call Debug(sCurDir || '\\SBU.EXE ' || IifS(rbOdok, '0 ', '9 ') ||
												     SalFmtFormatDateTime(dfDbeg, 'dd/MM/yyyy ') ||
												     SalFmtFormatDateTime(dfDend, 'dd/MM/yyyy ') || Str(dfGod) || ' ' ||
												     Str(dfKw) || ' ' || sODBCDir || ' ' || sOdbkPath || ' ' || sBalAcc || ' '
												     || sBalAccn)
										  Set n99 = -9
										  If SalLoadAppAndWait(sCurDir || '\\SBU.EXE ' || IifS(rbOdok, '0 ', '9 ') ||
												   SalFmtFormatDateTime(dfDbeg, 'dd/MM/yyyy ') ||
												   SalFmtFormatDateTime(dfDend, 'dd/MM/yyyy ') || Str(dfGod) || ' ' || Str(dfKw)
												   || ' ' || sODBCDir || ' ' || sOdbkPath || ' ' || IifS(rbBi, '0 ' || dfBi,
												   '1 ' || dfBo) || ' ' || IifS(rbVi, '0 ' || dfVi, '1 ' || dfVo),
												   Window_Maximized, n99)
											  If n99 != 0
												  Call SalMessageBeep(-1)
												  Call WaitCursorOff()
												  Call MessageNoWait('Ошибка (' || Str(n99) ||
														     ') при предварительной обработке информации (' || IifS(n99=1,
														     'отсутствует каталог ' || sOdbkPath, IifS(n99=2,
														     'не было добавлено ни одного документа для импорта',
														     'системная ошибка')) || ').', 'ИМПОРТ НЕ ВЫПОЛНЯЕТСЯ', 0, 1)
												  Call SalEnableWindow(pbExit)
												  Return FALSE
										  Else 
											  Call SalMessageBeep(-1)
											  Call WaitCursorOff()
											  Call MessageNoWait('Ошибка (' || Str(n99) ||
													     ') вызова модуля предварительной обработки информации !',
													     'ИМПОРТ НЕ ВЫПОЛНЯЕТСЯ', 0, 1)
											  Call SalEnableWindow(pbExit)
											  Return FALSE
									  Set SqlDatabase = 'dBase_Files'
									! Call Debug('Проверка наличия файлов ' || sODBCDir || '\\G' || Str(dfGod) || 'K'
											     || Str(dfKw) || '\\MOPER.dbf and ' || sODBCDir || '\\SBU.dbf')
									  If File(sODBCDir || '\\G' || Str(dfGod) || 'K' || Str(dfKw) || '\\MOPER.dbf') and
											   File(sODBCDir || '\\SBU.dbf')
										! Call Debug('Есть файлы ' || sODBCDir || '\\G' || Str(dfGod) || 'K' ||
												     Str(dfKw) || '\\MOPER.dbf and ' || sODBCDir || '\\SBU.dbf')
										! проверить, есть ли поле ref99bm в moper, если нет, то добавить его
										  Set n99 = -9
										  Set dfDone = "Подождите ..."
										! Call Debug('Вставляем ref99bm - FindVar')
										  Call SalLoadAppAndWait(sCurDir || "\\FindVar.Exe " || sODBCDir || '\\G' ||
												     Str(dfGod) || 'K' || Str(dfKw) || '\\MOPER' || " ref99bm",
												     Window_NotVisible, n99)
										! Call Debug('Вставили ref99bm')
										  Set dfDone = ""
										  Call SalFileSetCurrentDirectory(sODBCDir || '\\G' || Str(dfGod) || 'K' ||
												     Str(dfKw))
										  If SqlConnect(hSqlA)
											  Call SqlPrepareAndExecute(hSqlA, "
													     SELECT count(*)
													     FROM moper
													     INTO :nRecCount")
											  Call SqlFetchNext(hSqlA, nFetchRes)
											  If nRecCount = 0
												  Call SqlDisconnect(hSqlA)
												  Call SalMessageBeep(-1)
												  Call WaitCursorOff()
												  Call MessageNoWait('Нет информации или файл ' || sODBCDir || '\\G' ||
														     Str(dfGod) || 'K' || Str(dfKw) || '\\MOPER.dbf занят.', 'Сообщение', 7,
														     1)
												  Call SalEnableWindow(pbExit)
												  Return FALSE
											  Call SalArraySetUpperBound(sSbuNLS, 1, -1)
											  Call SalArraySetUpperBound(sSbuNLS8, 1, -1)
											  Call SalArraySetUpperBound(nSbuFLAG, 1, -1)
											  Set n21 = 0
											  Set n22 = 0
											! Call SqlPrepareAndExecute(hSqlC, "
													     SELECT nls,nls8,flag
													     FROM sbu
													     INTO :sNLS,:sNLS8,:nFLAG
													     WHERE Len(Trim(nls8))>4")
											  Call SqlDisconnect(hSqlA)
											  Set SqlDatabase = 'dBase_Files'
											  Call SalFileSetCurrentDirectory(sODBCDir)
											  If not SqlConnect(hSqlA) or not SqlConnect(hSqlB) or not SqlConnect(hSqlC)
												  Call SqlDisconnect(hSqlA)
												  Call SqlDisconnect(hSqlB)
												  Call SqlDisconnect(hSqlC)
												  Call SalMessageBeep(-1)
												  Call WaitCursorOff()
												  Call MessageAttention('Ошибка подсоединения к Базе данных: ' || SqlDatabase)
												  Call SalEnableWindow(pbExit)
												  Return FALSE
											  Call SqlPrepareAndExecute(hSqlC, "
													     SELECT nls,nls8,flag
													     FROM sbu
													     INTO :sNLS,:sNLS8,:nFLAG")
											  Set bProdol = TRUE
											  While SqlFetchNext(hSqlC, nFetchRes)
												  Set sSbuNLS[n21] = SalStrTrimX(sNLS)
												  Set sSbuNLS8[n21] = SalStrTrimX(sNLS8)
												  Set nSbuFLAG[n21] = IifN(nFLAG=NUMBER_Null, 0, nFLAG)
												! Этот блок возможно закомментировать потом (может быть) - нижний If
												! If Len(sSbuNLS8[n21]) = 0
													    Set bProdol = FALSE
													    Break 
												  Set n21 = n21 + 1
											! И этот блок возможно закомментировать потом (может быть) - нижний If
											! -------------------------_________________________---------------------------
											! If not bProdol
												    Call SqlDisconnect(hSqlA)
												    Call SqlDisconnect(hSqlB)
												    Call SqlDisconnect(hSqlC)
												    Call SalMessageBeep(-1)
												    Call WaitCursorOff()
												    Call MessageNoWait('В файле ' || sODBCDir ||
														     '\\SBU.dbf есть счета ФИНАНСОВОГО учета, не имеющие связи cо счетами'
														     || ' НАЛОГОВОГО учета. Устраните эту ОШИБКУ и повторите операцию.',
														     'ИМПОРТ НЕ МОЖЕТ БЫТЬ ВЫПОЛНЕН', 60, 1)
												    Call SalEnableWindow(pbExit)
												    Return FALSE
											  If File(sODBCDir || '\\SBU_STOP.dbf')
												  Call SalArraySetUpperBound(sStopNLS1, 1, -1)
												  Call SalArraySetUpperBound(sStopNLS2, 1, -1)
												  Call SqlPrepareAndExecute(hSqlC, "
														     SELECT nls1,nls2
														     FROM sbu_stop
														     INTO :sNLS1,:sNLS2
														     WHERE Len(Trim(nls1))>4 and Len(Trim(nls2))>4")
												  While SqlFetchNext(hSqlC, nFetchRes)
													  Set sStopNLS1[n22] = SalStrTrimX(sNLS1)
													  Set sStopNLS2[n22] = SalStrTrimX(sNLS2)
													  Set n22 = n22 + 1
											  Set nTimeStart = SalDateHour(SalDateCurrent())*3600 + SalDateMinute(
													    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
											  Set dfStart = 'Старт: ' || SalFmtFormatDateTime(SalDateCurrent(), 'hhh:mm:ss')
											  Set dfCurrent = 0
											  Set dfAll = nRecCount
											  Set dfGood = 0
											  Set dfNoLink = 0
											  Set nPos = 0
											  Set nTek = 0
											  Set nRecn = 1
											  Set nDelta = 100 / nRecCount
											  Set sRnk = Str(GetIdRnk())
											  Set sMfoA = GetValueStr("
													    SELECT mfo
													    FROM custbank
													    WHERE rnk=" || sRnk)
											  Set sRnk = SalStrRepeatX('0', 2-Len(sRnk)) || sRnk
											  Set sMfoA = IifS(sMfoA='', GetBankMfo(), sMfoA)
											  Call SqlPrepareAndExecute(hSql(), "
													     SELECT max(fdat)
													     INTO :dDat1
													     FROM fdat     
													     WHERE fdat<:dfBD")
											  Call SqlFetchNext(hSql(), nFetchRes)
											  Set dVdateU = dBankDate
											  Call SqlDisconnect(hSqlA)
											  Call SqlDisconnect(hSqlB)
											  Call SqlDisconnect(hSqlC)
											  Set SqlDatabase = 'dBase_Files'
											  Call SalFileSetCurrentDirectory(sODBCDir || '\\G' || Str(dfGod) || 'K' ||
													     Str(dfKw))
											  If not SqlConnect(hSqlA) or not SqlConnect(hSqlB)
												  Call SqlDisconnect(hSqlA)
												  Call SqlDisconnect(hSqlB)
												  Call SalMessageBeep(-1)
												  Call WaitCursorOff()
												  Call MessageAttention('Ошибка подсоединения к Базе данных: ' || SqlDatabase)
												  Call SalEnableWindow(pbExit)
												  Return FALSE
											  Call SqlSetResultSet(hSqlA, FALSE)
											! Call SqlPrepare(hSqlA, "
													     SELECT rowid,nm,dk,mfo,nd,vob,nls,nlsk,sk,s,datd,plat,polu,naz1,vspo,kod,
													            kisp,sos,ref99bm,vdate,tp,ref
													     INTO :nRow,:nNm,:nDk,:nMfo,:sNd,:nVob,:sNls,:sNlsk,:nSk,:nS,:dDat,:sPlat,
													          :sPolu,:sNaz1,:sVspo,:sKod,:sKisp,:nSos,:nRef99bm,:dVdate,:sTp,
													          :nRefl
													     FROM moper
													     FOR UPDATE OF ref99bm")
											! Call SqlPrepare(hSqlA, "
													     SELECT rowid,nm,dk,mfo,nd,vob,nls,nlsk,sk,s,datd,plat,polu,naz1,vspo,kod,
													            kisp,sos,ref99bm,vdate,tp,ref
													     INTO :nRow,:nNm,:nDk,:nMfo,:sNd,:nVob,:sNls,:sNlsk,:nSk,:nS,:dDat,:sPlat,
													          :sPolu,:sNaz1,:sVspo,:sKod,:sKisp,:nSos,:nRef99bm,:dVdate,:sTp,
													          :nRefO
													     FROM moper
													     FOR UPDATE OF ref99bm")
											  Call SqlPrepare(hSqlA, "
													     SELECT rowid,nm,dk,mfo,nd,vob,nls,nlsk,sk,s,plat,polu,naz1,vspo,kod,kisp,
													            sos,ref99bm,vdate,tp,ref
													     INTO :nRow,:nNm,:nDk,:nMfo,:sNd,:nVob,:sNls,:sNlsk,:nSk,:nS,:sPlat,
													          :sPolu,:sNaz1,:sVspo,:sKod,:sKisp,:nSos,:nRef99bm,:dVdate,:sTp,
													          :nRefO
													     FROM moper
													     FOR UPDATE OF ref99bm")
											  Call SqlOpen(hSqlA, "moper")
											  While SqlFetchNext(hSqlA, nFetchRes)
												  Set dVdateOrig = dVdate
												  Set sNls = SalStrTrimX(sNls)
												  Set sNlsk = SalStrTrimX(sNlsk)
												  Set sNd = SalStrTrimX(StrDosToWinX(sNd))
												  Set sMfo = SalNumberToStrX(nMfo, 0)
												  Set sMfo = IifS(Val(sMfo)=0, sMfoA, sMfo)
												  If rb1
													  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
													  Call SalTblSetContext(tbl1, nNewRow)
													  Set tbl1.colNPP = nRecn
													  Set tbl1.colND = sNd
													  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
													  Set tbl1.colNLSA = sNls
													  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
													  Set tbl1.colNLSB = sNlsk
													  Set tbl1.colS = nS / 100
													  Set tbl1.colVDATE = dVdate
													  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
													  Call SalTblSetFocusRow(tbl1, nNewRow)
													  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New, FALSE)
													  If Val(sNls) = 0
														  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Gray)
													  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
													  If tbl1.colREF98 != NUMBER_Null
														  Call SalTblSetCellTextColor(tbl1.colREF98, COLOR_DarkGreen, TRUE)
													  Else 
														  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Gray)
												  If (nNm = 1 or nNm = 2 or nNm = 3) and nSos = 5 and nS > 0 and
														   (((nRef99bm = 0 or nRef99bm = NUMBER_Null) and nType = 0) or
														   nType = 1 and nRef99bm > 0) and Left(sNls, 4) != '5040' and
														   Left(sNlsk, 4) != '5040'
													! Left(sNls, 4) != '5040' and Left(sNlsk, 4) != '5040'
															! - добавлено по просьбе STA & QWA 17.12.2002
													  Set bStop = FALSE
													  Set nI = 0
													  While nI < n22
														  If (sStopNLS1[nI] = sNls and sStopNLS2[nI] = sNlsk) or
																   (sStopNLS1[nI] = sNlsk and sStopNLS2[nI] = sNls)
															  Set bStop = TRUE
															  Break 
														  Set nI = nI + 1
													  If not bStop
														  Set sKisp = SalStrTrimX(sKisp)
														  If Len(sKisp) = 0
															  Set sKisp = GetBankOperIdent(sMfoA, sTp)
														  Set sPlat = SalStrTrimX(StrDosToWinX(sPlat))
														  Set sPolu = SalStrTrimX(StrDosToWinX(sPolu))
														  Set sNaz1 = SalStrTrimX(StrDosToWinX(sNaz1))
														  Set sVspo = SalStrTrimX(StrDosToWinX(sVspo))
														! If dDat = DATETIME_Null
															    Set dDat = dVdate
														  Set sKod = SalStrTrimX(sKod)
														  If nNm = 1
															  Set sMfo = sMfoA
															  If nDk = 0
																  Set nIndex0 = VisArrayFindString(sSbuNLS, sNls)
																  Set nIndex1 = VisArrayFindString(sSbuNLS, sNlsk)
															  Else 
																  Set nIndex0 = VisArrayFindString(sSbuNLS, sNlsk)
																  Set nIndex1 = VisArrayFindString(sSbuNLS, sNls)
															  Set bWozw = FALSE
															  If nIndex0 >= 0 and nIndex1 >= 0 and
																	   sSbuNLS8[nIndex0] = sSbuNLS8[nIndex1]
																  Set nSbuFLAG_0 = nSbuFLAG[nIndex0]
																  Set nSbuFLAG_1 = nSbuFLAG[nIndex1]
																  Set nSbuFLAG[nIndex0] = 0 ! без визы
																  Set nSbuFLAG[nIndex1] = 0 ! без визы
																  Set bWozw = TRUE
															  If nIndex0 >= 0 and nIndex1 >= 0 and
																	   sSbuNLS8[nIndex0] != sSbuNLS8[nIndex1] and
																	   nSbuFLAG[nIndex0] != nSbuFLAG[nIndex1]
																  Set nSbuFLAG_0 = nSbuFLAG[nIndex0]
																  Set nSbuFLAG_1 = nSbuFLAG[nIndex1]
																  Set nSbuFLAG[nIndex0] = 1 ! с визой
																  Set nSbuFLAG[nIndex1] = 1 ! с визой
																  Set bWozw = TRUE
														  If nNm > 1 ! nNm = 2 or nNm = 3
															  If Mod(nNm+nDk, 2) = 0
																  Set nIndex0 =  VisArrayFindString(sSbuNLS, sNls)
																  Set nIndex1 = -1
															  Else 
																  Set nIndex1 = VisArrayFindString(sSbuNLS, sNls)
																  Set nIndex0 = -1
														  Set n21 = 0
														  Set bMa = FALSE
														  Set bMc = FALSE
														  Set nStep = 0
														  While n21 < 2 and (nIndex0 >= 0 or nIndex1 >= 0) ! можно обрабатывать
															  If n21 = 0
																  If nIndex0 >= 0
																	  Set sNls8 = sSbuNLS8[nIndex0]
																	  Set nDk2 = 0
																	  Set nFlag = nSbuFLAG[nIndex0]
																	! If nIndex1 >= 0 and nSbuFLAG[nIndex1] != nFlag
																		! Есть 2: план и факт (ПЛАН)
																		    Set nFlag = 1
																	  If Len(sNls8) = 0 or (nNm = 1 and nIndex1 >= 0 and
																			   Len(sSbuNLS8[nIndex1]) = 0)
																		! Set n21 = n21 + 1
																		  Set n21 = n21 + IifN(nNm=1, 2, 1)
																		  Set bDalee = FALSE
																		! покрасить
																		  If not rb1
																			  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																			  Call SalTblSetContext(tbl1, nNewRow)
																			  Set tbl1.colNPP = nRecn
																			  Set tbl1.colND = sNd
																			  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																			  Set tbl1.colNLSA = sNls
																			  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																			  Set tbl1.colNLSB = sNlsk
																			  Set tbl1.colS = nS / 100
																			  Set tbl1.colVDATE = dVdate
																			  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																			  Call SalTblSetFocusRow(tbl1, nNewRow)
																			  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																					     FALSE)
																		  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Teal)
																		  If (nNm = 1 and ((nDk = 0 and Len(sNls8) = 0) or (nDk = 1 and
																				   Len(sNls8) > 0))) or (nNm > 1 and Mod(nNm+nDk, 2) = 0)
																			  Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																		  Else 
																			  Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																		  Set dfNoLink = dfNoLink + 1
																	  Else 
																		  Set bDalee = TRUE
																  Else 
																	  Set n21 = n21 + 1
																	  Set bDalee = FALSE
															  Else ! If n21 = 1
																  If nIndex1 >= 0
																	  Set sNls8 = sSbuNLS8[nIndex1]
																	  Set nDk2 = 1
																	  Set nFlag = nSbuFLAG[nIndex1]
																	! If nIndex0 >= 0 and nSbuFLAG[nIndex0] != nFlag
																		! Есть 2: план и факт (ПЛАН)
																		    Set nFlag = 1
																	  If Len(sNls8) = 0 or (nNm = 1 and nIndex0 >= 0 and
																			   Len(sSbuNLS8[nIndex0]) = 0)
																		  Set n21 = n21 + 1
																		  Set bDalee = FALSE
																		! покрасить
																		! почему-то ЗЕЛЕНЫЙ есть ???
																		  If not rb1
																			  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																			  Call SalTblSetContext(tbl1, nNewRow)
																			  Set tbl1.colNPP = nRecn
																			  Set tbl1.colND = sNd
																			  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																			  Set tbl1.colNLSA = sNls
																			  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																			  Set tbl1.colNLSB = sNlsk
																			  Set tbl1.colS = nS / 100
																			  Set tbl1.colVDATE = dVdate
																			  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																			  Call SalTblSetFocusRow(tbl1, nNewRow)
																			  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																					     FALSE)
																		  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Teal)
																		  If (nNm = 1 and ((nDk = 0 and Len(sNls8) = 0) or (nDk = 1 and
																				   Len(sNls8) > 0))) or (nNm > 1 and Mod(nNm+nDk, 2) = 0)
																			  Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																		! Else If (nNm = 1 and  nDk = 0 and nIndex0 >= 0 and
																				     Len(sSbuNLS8[nIndex0]) = 0)
																			    Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																		  Else 
																			  Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																		  Set dfNoLink = dfNoLink + 1
																	  Else 
																		  Set bDalee = TRUE
																  Else 
																	  Break 
															  If bDalee
																  If nVob = 96 and Mod(SalDateMonth(dVdate), 3) = 1
																	  Set dVdate = IifD(dDat1=DATETIME_Null,
																			    SalDateMonthBegin(dBankDate)-1, dDat1)
																  Else If nVob = 99
																	  Set dVdate = SalDateConstruct(SalDateYear(dVdate)-1, 12, 31, 0, 0,
																			    0)
																  Else 
																	  Set dVdate = dBankDate
																  If (nVob = 96 and Mod(SalDateMonth(dVdate), 3) = 1) or nVob = 99
																	  Call SqlPrepareAndExecute(hSql(), "
																			     SELECT fdat
																			     FROM fdat
																			     WHERE fdat=:dVdate")
																	  If not SqlFetchNext(hSql(), nFetchRes)
																		  Call SqlPrepareAndExecute(hSql(), "
																				     INSERT
																				     INTO fdat (fdat)
																				     VALUES (:dVdate)")
																  If dVdate != dVdateU
																	  Call Pl_dat(dVdate) ! Установить банковскую дату равной VDATE в
																			                    ! MOPER (но не совсем)
																	  Set dVdateU = dVdate
																  If not bMa
																	  Set bMa = TRUE
																	  If not rb1 
																		  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																		  Call SalTblSetContext(tbl1, nNewRow)
																		  Set tbl1.colNPP = nRecn
																		  Set tbl1.colND = sNd
																		  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																		  Set tbl1.colNLSA = sNls
																		  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																		  Set tbl1.colNLSB = sNlsk
																		  Set tbl1.colS = nS/100
																		  Set tbl1.colVDATE = dVdate
																		  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																		  Call SalTblSetFocusRow(tbl1, nNewRow)
																		  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																				     FALSE)
																	  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Blue)
																	  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
																	  Set dfGood = dfGood + 1
																  Set nFlag = IifN(Left(sNaz1, 4)='ь-01' or Left(sNaz1, 4)='Ь-01' or
																		    Left(sNaz1, 4)='ь-02' or Left(sNaz1, 4)='Ь-02' or
																		    Left(sNaz1, 4)='ь-04' or Left(sNaz1, 4)='Ь-04', 0,
																		    IifN(nVob=96 or nVob=99, 1, nFlag))
																  If nType = 1
																	  Set bSD = FALSE
																	  If Ful_Bak(nRef99bm)
																		  Set bSD = SqlPrepareAndExecute(
																				    hSql(), "
																				    DELETE
																				    FROM oper
																				    WHERE ref=:nRef99bm")
																  Else 
																	  Set bSD = TRUE
																  If bSD and Len(sNaz1)>3
																	! Call ccDoc.SetDoc(IifN(nStep=0, 0, nRef), 'PO' || Str(1-nFlag),
																			     nDk, nVob, sNd, dDat, SalDateCurrent(), dVdate, dVdate,
																			     IifS(nNm=3, sNlsk, sNls), IifS(nNm=3, sPolu, sPlat),
																			     IifS(nNm=3, sMfo, sMfoA), '', 980, nS, sKod, IifS(nNm=3,
																			     sNls, sNlsk), IifS(nNm=3, sPlat, sPolu), IifS(nNm=3, sMfoA,
																			     sMfo), '', 980, nS, '', sNaz1, sVspo, sKisp, '', nSk)
																	  Call ccDoc.SetDoc(IifN(nStep=0, 0, nRef), 'PO' || Str(1-nFlag),
																			     nDk, nVob, sNd, dVdateOrig, SalDateCurrent(), dVdate, dVdate,
																			     IifS(nNm=3, sNlsk, sNls), IifS(nNm=3, sPolu, sPlat),
																			     IifS(nNm=3, sMfo, sMfoA), '', 980, nS, sKod, IifS(nNm=3,
																			     sNls, sNlsk), IifS(nNm=3, sPlat, sPolu), IifS(nNm=3, sMfoA,
																			     sMfo), '', 980, nS, '', sNaz1, sVspo, sKisp, '', nSk)
																	! If nRefl = 0
																		    Set nRefl = NUMBER_Null
																	  If ccDoc.oDoc()
																		  Set nRef = ccDoc.m_nRef
																		  Set nStep = nStep + 1
																		! Call SqlPrepareAndExecute(
																				     hSql(), "
																				     UPDATE oper
																				     SET refl=:nRefl
																				     WHERE ref=:nRef")
																		  Set ccDoc.A.Kv = 980
																		  Set ccDoc.m_nDk = nDk2
																		  If ccDoc.TT.SetTT(nRef, 'PO' || Str(1-nFlag), ccDoc.m_dDatV1,
																				   ccDoc.m_nDk, sNls8, ccDoc.A.Kv, ccDoc.A.S, 'BBBBK' || sRnk,
																				   ccDoc.B.Kv, ccDoc.B.S) and ccDoc.TT.PayTT(1-nFlag)
																			! Call Debug('nNm=' || Str(nNm) || ', n21=' || Str(n21))
																			! если макет не = 1 или (макет = 1 и ((обе связки есть в SBU и
																					! n21 = 1) или (только одна связка есть в SBU))
																			  Set nL0 = 0
																			  Set nL1 = 0
																			! Call Debug('nIndex0=' || Str(nIndex0) || ', nIndex1=' ||
																					     Str(nIndex1))
																			  If nIndex0 >= 0 
																				  Set nL0 = Len(sSbuNLS8[nIndex0])
																			  If nIndex1 >= 0 
																				  Set nL1 = Len(sSbuNLS8[nIndex1])
																			  If nNm != 1 or (nNm = 1 and ((nL0 * nL1 > 0 and n21 = 1) or
																					   (nL0 > 0 and nL1 = 0) or (nL0 = 0 and nL1 > 0)))
																				  If SqlPrepareAndExecute(hSqlB, "
																						   UPDATE moper
																						   SET ref99bm=:ccDoc.m_nRef
																						   WHERE CURRENT OF moper")
																					  Call SqlCommitEx(hSql(), 'Мак.' || Str(nNm) || ', счетА='
																							     || sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(
																							     Str(nS), Len(Str(nS))-2) || '.' || Right(Str(nS), 2)
																							     || ', DK=' || Str(nDk) || ', ЧО=' || Str(1-nFlag) ||
																							     ', Ref=' || Str(nRef))
																					! Call SqlCommit(hSqlB)
																					! If n21 = 0
																						    Set dfCurrent = dfCurrent + 1
																					  If not bMc
																						  Set dfCurrent = dfCurrent + 1
																						  Set bMc = TRUE
																					  Set tbl1.colREF98 = nRef
																					  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_DarkGreen)
																					  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
																				  Else 
																					  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) ||
																							     ', счетА=' || sNls || ', счетБ=' || sNlsk ||
																							     ', сумма=' || Left(Str(nS), Len(Str(nS))-2) || '.' ||
																							     Right(Str(nS), 2) || ', DK=' || Str(nDk) || ', ЧО='
																							     || Str(1-nFlag))
																					  Set n21 = n21 + 1 ! Для выхода
																		  Else 
																			  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																					     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(
																					     Str(nS), Len(Str(nS))-2) || '.' || Right(Str(nS), 2) ||
																					     ', DK=' || Str(nDk) || ', ЧО=' || Str(1-nFlag))
																			  Set n21 = n21 + 1 ! Для выхода
																	  Else 
																		  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																				     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(Str(nS),
																				     Len(Str(nS))-2) || '.' || Right(Str(nS), 2) || ', DK=' ||
																				     Str(nDk) || ', ЧО=' || Str(1-nFlag))
																		  Set n21 = n21 + 1 ! Для выхода
																  Else 
																	  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																			     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(Str(nS),
																			     Len(Str(nS))-2) || '.' || Right(Str(nS), 2) || ', DK=' ||
																			     Str(nDk) || ', ЧО=' || Str(1-nFlag))
																	  Set n21 = n21 + 1 ! Для выхода
																  Set n21 = n21 + 1
														  If nNm = 1 and nIndex0 >= 0 and nIndex1 >= 0 and bWozw
															  Set nSbuFLAG[nIndex0] = nSbuFLAG_0
															  Set nSbuFLAG[nIndex1] = nSbuFLAG_1
												  Set nPos = nPos + nDelta
												  Set nRecn = nRecn + 1
												  If Int(nPos) != nTek
													  Set nTek = Int(nPos)
													  Set nTimeCurrent = SalDateHour(SalDateCurrent())*3600 +SalDateMinute(
															    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
													  Set nTimeEnd = Int(100 * (nTimeCurrent-nTimeStart) / nPos + nTimeStart)
													! Call Debug('nPos=' || Str(nPos) || ', nTimeStart=' || Str(nTimeStart) ||
															    ', nTimeEnd=' || Str(nTimeEnd))
													  Set nHour = Int(nTimeEnd/3600)
													  Set nTemp = nTimeEnd - nHour*3600
													  Set nMinu = Int(nTemp/60)
													  Set dfAll = dfAll
													  Set dfGood = dfGood
													  Set dfCurrent = dfCurrent
													  Set dfNoLink = dfNoLink
													  Set dfStart = dfStart
													  Set dfEnd = 'Финиш: ' || Right(Str(100+nHour), 2) || ':' || Right(
															    Str(100+nMinu), 2) || ':' || Right(Str(100+nTemp-nMinu*60), 2) ||
															    ' (прогноз)'
												  Call ccProgressBar.SetProgress(nPos)
												  Call SalUpdateWindow(hWndForm)
												! Call SalUpdateWindow(tbl1)
												! Call SalSetFocus(tbl1)
											  Call ccProgressBar.SetProgress(100)
											  Set dfEnd = Left(dfEnd, 15)
											! Call SqlCommitEx(hSql(), 'OK')
											! Call SqlCommit(hSqlB)
											  Call SqlDisconnect(hSqlA)
											  Call SqlDisconnect(hSqlB)
											  Call SaveInfoToLog("Прием документов налогового учета ОКОНЧЕН.")
											  Set dfDone = "Готово"
											  Call SalMessageBeep(-1)
											  Call SalSetFocus(tbl1)
											  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
											! Call SalSetWindowText(hWndForm, sText)
											! Call SalDisableWindow(rb1)
											! Call SalDisableWindow(rb2)
											! Call SalHideWindow(dfStart)
											! Call SalHideWindow(dfEnd)
										  Else 
											  Call MessageAttention('Ошибка подсоединения к Базе данных: ' || SqlDatabase)
									  Else 
										  Call MessageAttention('Нет файла: ' || sODBCDir || '\\G' || Str(dfGod) || 'K' ||
												     Str(dfKw) || '\\MOPER.dbf или ' || sODBCDir || '\\SBU.dbf')
								  Else 
									  Call MessageAttention('Нет каталога: ' || sODBCDir)
								  Call SalEnableWindow(pbExecute)
								  Set rbPnone = TRUE
								  Call SalEnableWindow(pbExit)
								  Call SalSetFocus(pbExit)
								  Call WaitCursorOff()
							  Else 
								  Call SalDisableWindow(pbExecute)
								  Call SalDisableWindow(pbExit)
								  Set dfDone = ""
								  Set dfStart = 'Старт: ' || SalFmtFormatDateTime(SalDateCurrent(), 'hhh:mm:ss')
								  Call SaveInfoToLog("Прием/Оплата документов налогового учета.")
								  Call SalModalDialog( dlg_Connect, hWndForm )
								! Подключение прошло успешно к ОДБ bFlagABS=1
								  If bFlagABS=1
									! Заполнение MOPER
									  Call SalTblReset( tbl1 )
									! Ищем док-т который могли не доимпортить
									  Call SqlPrepareAndExecute( hSqlABS, "select nvl(val,0) into :nRefNotImport from params where par='REF_ASPO' " )
									  If SqlFetchNext(hSqlABS, nFetchRes)
										  Set sInsUpdParams = "update params set val = :nRefParams
												where par = 'REF_ASPO' "
									  Else 
										  Set sInsUpdParams = "insert into params (par,val,comm)
												values ('REF_ASPO',:nRefParams,'Импорт док-в в АСПО')"
										  Set nRefNotImport = 0
									  If rbDates
										  Set dDateStart = dfDbeg
										  Set dDateEnd = dfDend
									  Else 
										  Set dDateStart = SalDateQuarterBegin(SalDateConstruct(dfGod, dfKw*3, 1, 0, 0, 0))
										  Set dDateEnd = SalDateQuarterBegin(SalDateConstruct(dfGod, dfKw*3, 1, 0, 0, 0) + 92) - 1
									  Set dfDone = "Импортируем данные ..."
									  If dDateStartABS > dDateStart
										  Set dDateStart = dDateStartABS
									  If dDateStartABS > dDateEnd
										  Set dDateEnd = dDateStartABS
									  Call WaitCursorOn(  )
									  Set sSqlOut =''
									  Set sSqlOut1=''
									  Set sSqlAll =''
									  Set sSqlAll1 =''
									  Set sSqlAllN =''
									  Set sSqlAllN1 =''
									  If rbBii and SalStrTrimX( dfBi ) != ''
										  Call ABSSqlLike(SalStrTrimX( dfBi ),' LIKE ', ' OR ',sSqlOut,sSqlOut1)
										  If SalStrLength( sSqlOut )>0
											  Set sSqlAll   = sSqlAll   || sSqlOut
											  Set sSqlAll1 = sSqlAll1 || sSqlOut1
									  If rbVii and SalStrTrimX( dfVi ) != ''
										  Call ABSSqlLike(SalStrTrimX( dfVi ),' LIKE ', ' OR ',sSqlOut,sSqlOut1)
										  If SalStrLength( sSqlOut )>0
											  Set sSqlAll   = sSqlAll   || sSqlOut
											  Set sSqlAll1 = sSqlAll1 || sSqlOut1
									  If rbBoo and SalStrTrimX( dfBo ) != ''
										  Call ABSSqlLike(SalStrTrimX( dfBo ),' NOT  LIKE ',' AND ',sSqlOut,sSqlOut1)
										  If SalStrLength( sSqlOut )>0
											  Set sSqlAllN   = sSqlAllN   || sSqlOut
											  Set sSqlAllN1 = sSqlAllN1 || sSqlOut1
									  If rbVoo and SalStrTrimX( dfVo ) != ''
										  Call ABSSqlLike(SalStrTrimX( dfVo ),' NOT  LIKE ',' AND ',sSqlOut,sSqlOut1)
										  If SalStrLength( sSqlOut )>0
											  Set sSqlAllN   = sSqlAllN   || sSqlOut
											  Set sSqlAllN1 = sSqlAllN1 || sSqlOut1
									  If sSqlAll   !='' or sSqlAllN   !=''
										  Set sSqlAll   = IifS(sSqlAll    !='' ," ( "||SalStrMidX( sSqlAll   , 4, SalStrLength( sSqlAll    ))||" ) " ,'')||
												                       IifS( ( sSqlAll !='' and ( rbBii or rbVii ) ) and ( sSqlAllN    !='' and ( rbBoo or rbVoo ) ),' and ','')||
												                       IifS(sSqlAllN !='' ," ( "||SalStrMidX( sSqlAllN, 5, SalStrLength( sSqlAllN  ))||" ) " ,'')
									  If sSqlAll1   !='' or sSqlAllN1   !=''
										  Set sSqlAll1 = IifS(sSqlAll1    !='' ," ( "||SalStrMidX( sSqlAll1   , 4, SalStrLength( sSqlAll1    ))||" ) " ,'')||
												                       IifS( ( sSqlAll1 !='' and ( rbBii or rbVii ) ) and ( sSqlAllN1    !='' and ( rbBoo or rbVoo ) ),' and ','')||
												                       IifS(sSqlAllN1 !='' ," ( "||SalStrMidX( sSqlAllN1, 5, SalStrLength( sSqlAllN1  ))||" ) " ,'')
									  If sSqlAll   !=''  or sSqlAll1 !=''
										  Set sSqlOut = ' AND ' ||
												                      IifS( sSqlAll   !='',"  ( ( ( "|| sSqlAll ||" ) AND o.mfoa=:sBankMFO ) ",'') ||
												                      IifS( sSqlAll   !=''  and sSqlAll1 !='' , ' OR ', IifS( sSqlAll   !='' , ' ) ' , ' ( ' ) ) ||
												                      IifS( sSqlAll1 !=''," ( ( "|| sSqlAll1 ||" ) AND o.mfob=:sBankMFO ) ) ",'')
									  When SqlError
										  Call WaitCursorOff()
										! Return FALSE
									  Set sRnk = Str(GetIdRnk())
									  Set sMfoA = GetValueStr("
											    SELECT mfo
											    FROM custbank
											    WHERE rnk=" || sRnk)
									  Set sMfoA = IifS(sMfoA='', GetBankMfo(), sMfoA)
									  Call SqlPrepareAndExecute( hSqlABS, "select val into :sBankMFO from params where par='MFO'" )
									  Call SqlFetchNext(hSqlABS, nFetchRes)
									  If not sBankMFO = sMfoA
										  Call WaitCursorOff()
										  Call MessageNoWait('Не совпадают МФО АБС('||sBankMFO||') и АСНУ('||sMfoA||'). Импорт прервано !!!', 'Сообщение', 7, 1)
										  Call SqlDisconnect( hSqlABS )
										  Call SalEnableWindow(pbExecute)
										  Call SalEnableWindow(pbExit)
										  Call SalSetFocus(pbExit)
										  Return FALSE
									  If SqlPrepareAndExecute( hSqlABS, "
											insert into moperabs(nm,ref,DATD,mfo,nls,nlsk,plat,polu,naz1,DK,S,VDATE,SOS,SK,ND,VOB,kod,vspo,kisp,ref99bm,stmt,nlsa,nmsa,nlsb,nmsb)
											select distinct  decode(o.mfoa,:sBankMFO,decode(o.mfoa,o.MFOB,1,2),decode(o.mfob,:sBankMFO,3)) nm, od.ref, o.DATD,
											       decode(o.mfoa,:sBankMFO,decode(o.mfoa,o.MFOB,0,o.MFOB),decode(o.mfob,:sBankMFO,o.mfoa)) mfo, ad.NLS nls,
											       ak.NLS nlsk, substr(ad.NMS,1,38) plat, substr(ak.NMS,1,38) polu, o.nazn naz1, o.DK, od.S, od.fdat vdate, od.SOS,
											       o.SK, o.ND, o.VOB, o.id_a kod, o.id_b vspo, '' kisp,  0 ref99bm, oD.stmt stmt, o.nlsa, o.nam_a nmsa, o.nlsb, o.nam_b nmsb
											from accounts aD,opldok oD,accounts ak,opldok ok, oper o
											where ad.ACC=od.ACC   and od.DK=0         and
											      ak.ACC=ok.ACC   and ok.DK=1         and od.sos=ok.sos  and od.sos=5  and
											      od.ref=ok.ref   and od.stmt=ok.stmt and od.dk<>ok.dk   and od.s=ok.s and
											      od.fdat=ok.fdat and od.tt=ok.tt     and od.acc<>ok.acc and
											      od.ref=o.ref    and aD.kv=980 and ak.kv=980 and  (oD.TT not like 'ZG_' and oK.TT not like 'ZG_')  and
											      od.fdat between :dDateStart and :dDateEnd and  " || IifS(rbKdok, ' ( o.vob = 96 ) and ',' ( o.vob not in (96,99) ) and ' ) ||
											   "o.ref not in (select ref from moperabs) "||sSqlOut||" order by od.ref ")
										  Call SqlCommit( hSqlABS )
										! Call Debug ('COMMIT')
									  Else 
										  Set nConnectError = SqlError( hSqlABS )
										  Call MessageNoWait('Ошибка при заполнении таб. MOPER [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										  Call SqlRollback( hSqlABS )
										  Call SqlDisconnect( hSqlABS )
										  Call SalEnableWindow(pbExecute)
										  Call SalEnableWindow(pbExit)
										  Call SalSetFocus(pbExit)
										  Return FALSE
									  Call SqlPrepareAndExecute(hSqlABS, "SELECT count(*) INTO :nRecCount FROM moperABS where ref99bm = 0 ")
									  Call SqlFetchNext(hSqlABS, nFetchRes)
									  If nRecCount = 0
										  Call SqlDisconnect(hSqlABS)
										  Call WaitCursorOff()
										  Call MessageNoWait('Нет информации для импорта !!!', 'Сообщение', 7, 1)
										  Call SalEnableWindow(pbExecute)
										  Call SalEnableWindow(pbExit)
										  Call SalSetFocus(pbExit)
										  Return FALSE
									! Берем данные из SBU
									  Call SalArraySetUpperBound(sSbuNLS, 1, -1)
									  Call SalArraySetUpperBound(sSbuNLS8, 1, -1)
									  Call SalArraySetUpperBound(nSbuFLAG, 1, -1)
									  Set n21 = 0
									  If not SqlPrepareAndExecute(hSql(), "
											       SELECT nls,nls8,flag
											       INTO :sNLS,:sNLS8,:nFLAG
											       FROM sbu
											       where Rtrim(rnk)=Rtrim(:sRnk)")
										  Set nConnectError = SqlError( hSql() )
										  Call MessageNoWait('Ошибка при работе с таб. SBU [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										  Call SqlDisconnect( hSqlABS )
										  Call SalEnableWindow(pbExecute)
										  Call SalEnableWindow(pbExit)
										  Call SalSetFocus(pbExit)
										  Return FALSE
									  Set bProdol = TRUE
									  While SqlFetchNext(hSql(), nFetchRes)
										  Set sSbuNLS[n21] = SalStrTrimX(sNLS)
										  Set sSbuNLS8[n21] = SalStrTrimX(sNLS8)
										  Set nSbuFLAG[n21] = IifN(nFLAG=NUMBER_Null, 0, nFLAG)
										  Set n21 = n21 + 1
									! Втягуем MOPERABS
									  Set nTimeStart = SalDateHour(SalDateCurrent())*3600 + SalDateMinute(
											    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
									  Set dfStart = 'Старт: ' || SalFmtFormatDateTime(SalDateCurrent(), 'hhh:mm:ss')
									  Set dfCurrent = 0
									  Set dfAll = nRecCount
									  Set dfGood = 0
									  Set dfNoLink = 0
									  Set nPos = 0
									  Set nTek = 0
									  Set nRecn = 1
									  Set nDelta = 100 / nRecCount
									  If not SqlPrepareAndExecute(hSql(), "
											       SELECT max(fdat)
											       INTO :dDat1
											       FROM fdat
											       WHERE fdat<:dfBD")
										  Set nConnectError = SqlError( hSql() )
										  Call MessageNoWait('Ошибка при работе с таб. Fdat [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										  Call SqlDisconnect( hSqlABS )
										  Call SalEnableWindow(pbExecute)
										  Call SalEnableWindow(pbExit)
										  Call SalSetFocus(pbExit)
										  Return FALSE
									  Call SqlFetchNext(hSql(), nFetchRes)
									  Set dVdateU = dBankDate
									  If SqlPrepareAndExecute(hSqlABS, "
											     SELECT ref, stmt
											     INTO    :nRefO ,:nSTMT
											     FROM moperabs
											     where ref99bm=0 ")
										! Call SqlOpen( hSqlABS , "moper" )
									  Else 
										  Set nConnectError = SqlError( hSqlABS )
										  Call MessageNoWait('Ошибка при работе с таб. MOPER [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										  Call SqlDisconnect( hSqlABS )
										  Call SalEnableWindow(pbExecute)
										  Call SalEnableWindow(pbExit)
										  Call SalSetFocus(pbExit)
										  Return FALSE
									  Set nABSNext=0
									  While SqlFetchNext(hSqlABS, nFetchRes)
										  Set nABSNext=nABSNext+1
										  Set nABSRef[nABSNext]=nRefO
										  Set nABSSTMT[nABSNext]=nSTMT
									  If not SqlConnect( hSqlB )
										  Set nConnectError = SqlError( hSqlABS )
										  Call MessageNoWait('Ошибка при работе с базой данных АБС [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
												'Импорт ...', 10,1)
										  Call SqlDisconnect( hSqlABS )
										  Call SqlDisconnect( hSqlB )
										  Call SalEnableWindow(pbExecute)
										  Call SalEnableWindow(pbExit)
										  Call SalSetFocus(pbExit)
										  Return FALSE
									  While nABSNext>0
										  If SqlPrepareAndExecute(hSqlB, "
												     SELECT nm,  dk,  mfo,  nd,  vob,  nls,  nlsk,  sk,  s,  plat,  polu, naz1,  vspo,  kod,  kisp,  sos,  ref99bm,  vdate,  tp, nlsa, nmsa, nlsb, nmsb
												     INTO    :nNm,:nDk,:nMfo,:sNd,:nVob,:sNls,:sNlsk,:nSk,:nS,:sPlat,:sPolu, :sNaz1,:sVspo,:sKod,:sKisp,:nSos,:nRef99bm,:dVdate,:sTp
												                 , :sNlsa, :sNmsa, :sNlsb, :sNmsb
												     FROM moperabs
												     where ref=:nABSRef[nABSNext]   and ref99bm=0 and stmt=:nABSSTMT[nABSNext]  and
												                 vdate  between :dDateStart and :dDateEnd  -- FOR UPDATE OF ref99bm")
											! Call SqlOpen( hSqlABS , "moper" )
										  Else 
											  Set nConnectError = SqlError( hSqlABS )
											  Call MessageNoWait('Ошибка при работе с таб. MOPER [Error #' || SalNumberToStrX(nConnectError, 0) || ']',
													'Импорт ...', 10,1)
											  Call SqlDisconnect( hSqlABS )
											  Call SalEnableWindow(pbExecute)
											  Call SalEnableWindow(pbExit)
											  Call SalSetFocus(pbExit)
											  Return FALSE
										  While SqlFetchNext(hSqlB, nFetchRes)
											! Проверка есть ли документ в АСПО
											  Set bPay = TRUE
											  If nRefNotImport = nABSRef[nABSNext]
												  Call SqlPrepareAndExecute( hSql(), "
														select distinct o.ref
														   into             :nRefASPO
														   from operw o, operw oo , oper op  , opldok od
														where o.ref=oo.REF and o.tag<>oo.tag and o.value=:nABSRef[nABSNext] and oo.value=:nABSSTMT[nABSNext] and
														           o.tag='ASPO1'  and oo.tag='ASPO2' and op.ref=o.ref  and od.ref=op.ref and od.dk=0  ")
												  If SqlFetchNext(hSql(), nFetchRes)
													  If SqlPrepareAndExecute(hSqlB, "
															   UPDATE moperabs
															   SET ref99bm=:nRefASPO
															   WHERE ref=:nABSRef[nABSNext]  and stmt=:nABSSTMT[nABSNext]  ")
														  Call SqlCommit( hSqlB )
													  Else 
														  Call SqlRollback( hSqlB )
													  Set bPay = FALSE
											! Импорт данных
											  If bPay = TRUE
												! Пишем ref который будем импортить !!!
												  Set nRefParams = nABSRef[nABSNext]
												  If SqlPrepareAndExecute( hSqlABS,  sInsUpdParams)
													  Call SqlCommit( hSqlABS )
													  Set sInsUpdParams = "update params set val = :nRefParams
															where par = 'REF_ASPO' "
												  Else 
													  Call SqlRollback( hSqlABS )
													  Break 
												  Set dVdateOrig = dVdate
												  Set sNls = SalStrTrimX(sNls)
												  Set sNlsk = SalStrTrimX(sNlsk)
												  Set sNd = SalStrTrimX((sNd))
												  Set sMfo = SalNumberToStrX(nMfo, 0)
												  Set sMfo = IifS(Val(sMfo)=0, sMfoA, sMfo)
												  If rb1
													  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
													  Call SalTblSetContext(tbl1, nNewRow)
													  Set tbl1.colNPP = nRecn
													  Set tbl1.colND = sNd
													  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
													  Set tbl1.colNLSA = sNls
													  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
													  Set tbl1.colNLSB = sNlsk
													  Set tbl1.colS = nS / 100
													  Set tbl1.colVDATE = dVdate
													  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
													  Call SalTblSetFocusRow(tbl1, nNewRow)
													  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New, FALSE)
													  If Val(sNls) = 0
														  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Gray)
													  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
													  If tbl1.colREF98 != NUMBER_Null
														  Call SalTblSetCellTextColor(tbl1.colREF98, COLOR_DarkGreen, TRUE)
													  Else 
														  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Gray)
												  If (nNm = 1 or nNm = 2 or nNm = 3) and nSos = 5 and nS > 0 and
														   (((nRef99bm = 0 or nRef99bm = NUMBER_Null) and nType = 0) or
														   nType = 1 and nRef99bm > 0)
													  Set bStop = FALSE
													  If not bStop
														  Set sKisp = SalStrTrimX(sKisp)
														  If Len(sKisp) = 0
															  Set sKisp = GetBankOperIdent(sMfoA, sTp)
														  Set sPlat = SalStrTrimX((sPlat))
														  Set sPolu = SalStrTrimX((sPolu))
														  Set sNaz1 = SalStrTrimX((sNaz1))
														  Set sVspo = SalStrTrimX((sVspo))
														  Set sKod = SalStrTrimX(sKod)
														  If nNm != 0
															! Set sMfo = sMfoA
															  If nDk = 5
																  Set nIndex0 = VisArrayFindString(sSbuNLS, sNls)
																  Set nIndex1 = VisArrayFindString(sSbuNLS, sNlsk)
															  Else ! nDk = 0 or nDk =1
																  Set nIndex0 = VisArrayFindString(sSbuNLS, sNlsk)
																  Set nIndex1 = VisArrayFindString(sSbuNLS, sNls)
															  Set bWozw = FALSE
															  If nIndex0 >= 0 and nIndex1 >= 0 and
																	   sSbuNLS8[nIndex0] = sSbuNLS8[nIndex1]
																  Set nSbuFLAG_0 = nSbuFLAG[nIndex0]
																  Set nSbuFLAG_1 = nSbuFLAG[nIndex1]
																  Set nSbuFLAG[nIndex0] = 0 ! без визы
																  Set nSbuFLAG[nIndex1] = 0 ! без визы
																  Set bWozw = TRUE
															! flagi
															  If nIndex0 >= 0 and nIndex1 >= 0 and
																	   sSbuNLS8[nIndex0] != sSbuNLS8[nIndex1] and
																	   nSbuFLAG[nIndex0] != nSbuFLAG[nIndex1]
																  Set nSbuFLAG_0 = nSbuFLAG[nIndex0]
																  Set nSbuFLAG_1 = nSbuFLAG[nIndex1]
																  Set nSbuFLAG[nIndex0] = 1 ! с визой
																  Set nSbuFLAG[nIndex1] = 1 ! с визой
																  Set bWozw = TRUE
														  Set n21 = 0
														  Set bMa = FALSE
														  Set bMc = FALSE
														  Set nStep = 0
														  While n21 < 2 and (nIndex0 >= 0 or nIndex1 >= 0) ! можно обрабатывать
															  If n21 = 0
																  If nIndex0 >= 0
																	  Set sNls8 = sSbuNLS8[nIndex0]
																	  Set nDk2 = 0
																	  Set nFlag = nSbuFLAG[nIndex0]
																	  If Len(sNls8) = 0 or (nNm = 1 and nIndex1 >= 0 and
																			   Len(sSbuNLS8[nIndex1]) = 0)
																		  Set n21 = n21 + IifN(nNm=1, 2, 1)
																		  Set bDalee = FALSE
																		! покрасить
																		  If not rb1
																			  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																			  Call SalTblSetContext(tbl1, nNewRow)
																			  Set tbl1.colNPP = nRecn
																			  Set tbl1.colND = sNd
																			  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																			  Set tbl1.colNLSA = sNls
																			  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																			  Set tbl1.colNLSB = sNlsk
																			  Set tbl1.colS = nS / 100
																			  Set tbl1.colVDATE = dVdate
																			  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																			  Call SalTblSetFocusRow(tbl1, nNewRow)
																			  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																					     FALSE)
																		  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Teal)
																		! ----------------------------------------------------------------
																		! Call Debug(SalNumberToStrX( nIndex0,0)||" - 0     1 - "||SalNumberToStrX( nIndex1,0) )
																		  If Len(sNls8)=0
																			  Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																		  If nIndex1 >= 0
																			  If Len(sSbuNLS8[nIndex1])=0  ! and nIndex1 >= 0
																				  Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																		  Set dfNoLink = dfNoLink + 1
																		  Set nI = 0
																	  Else 
																		  Set bDalee = TRUE
																  Else 
																	  Set n21 = n21 + 1
																	  Set bDalee = FALSE
															  Else ! If n21 = 1
																  If nIndex1 >= 0
																	  Set sNls8 = sSbuNLS8[nIndex1]
																	  Set nDk2 = 1
																	  Set nFlag = nSbuFLAG[nIndex1]
																	  If Len(sNls8) = 0 or (nNm = 1 and nIndex0 >= 0 and
																			   Len(sSbuNLS8[nIndex0]) = 0)
																		  Set n21 = n21 + 1
																		  Set bDalee = FALSE
																		! покрасить
																		! почему-то ЗЕЛЕНЫЙ есть ???
																		  If not rb1
																			  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																			  Call SalTblSetContext(tbl1, nNewRow)
																			  Set tbl1.colNPP = nRecn
																			  Set tbl1.colND = sNd
																			  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																			  Set tbl1.colNLSA = sNls
																			  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																			  Set tbl1.colNLSB = sNlsk
																			  Set tbl1.colS = nS / 100
																			  Set tbl1.colVDATE = dVdate
																			  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																			  Call SalTblSetFocusRow(tbl1, nNewRow)
																			  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																					     FALSE)
																		  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Teal)
																		! -------------------------------------------------------------
																		! If (nNm = 1 and ((nDk = 0 and Len(sNls8) = 0) or (nDk = 1 and
																				   Len(sNls8) > 0))) or (nNm > 1 and Mod(nNm+nDk, 2) = 0)
																			     Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																		! Else
																			     Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																		! Call Debug(SalNumberToStrX( nIndex0,0)||" - 0     1 - "||SalNumberToStrX( nIndex1,0) )
																		  If Len(sNls8)=0
																			  Call SalTblSetCellTextColor(tbl1.colNLSA, COLOR_Red, TRUE)
																		  If nIndex0 >= 0
																			  If Len(sSbuNLS8[nIndex0])=0  ! and nIndex0 >= 0
																				  Call SalTblSetCellTextColor(tbl1.colNLSB, COLOR_Red, TRUE)
																		  Set dfNoLink = dfNoLink + 1
																	  Else 
																		  Set bDalee = TRUE
																  Else 
																	  Break 
															  If bDalee
																  If nVob = 96 and Mod(SalDateMonth(dVdate), 3) = 1
																	  Set dVdate = IifD(dDat1=DATETIME_Null,
																			    SalDateMonthBegin(dBankDate)-1, dDat1)
																  Else If nVob = 99
																	  Set dVdate = SalDateConstruct(SalDateYear(dVdate)-1, 12, 31, 0, 0,
																			    0)
																  Else 
																	  Set dVdate = dBankDate
																  If (nVob = 96 and Mod(SalDateMonth(dVdate), 3) = 1) or nVob = 99
																	  Call SqlPrepareAndExecute(hSql(), "
																			     SELECT fdat
																			     FROM fdat
																			     WHERE fdat=:dVdate")
																	  If not SqlFetchNext(hSql(), nFetchRes)
																		  Call SqlPrepareAndExecute(hSql(), "
																				     INSERT
																				     INTO fdat (fdat)
																				     VALUES (:dVdate)")
																  If dVdate != dVdateU
																	  Call Pl_dat(dVdate) ! Установить банковскую дату равной VDATE в
																			                    ! MOPER (но не совсем)
																	  Set dVdateU = dVdate
																  If not bMa
																	  Set bMa = TRUE
																	  If not rb1
																		  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
																		  Call SalTblSetContext(tbl1, nNewRow)
																		  Set tbl1.colNPP = nRecn
																		  Set tbl1.colND = sNd
																		  Set tbl1.colMFOA = IifS(Val(sNls)=0, '', sMfoA)
																		  Set tbl1.colNLSA = sNls
																		  Set tbl1.colMFOB = IifS(Val(sNls)=0, '', sMfo)
																		  Set tbl1.colNLSB = sNlsk
																		  Set tbl1.colS = nS/100
																		  Set tbl1.colVDATE = dVdate
																		  Set tbl1.colREF98 = IifN(nRef99bm = 0, NUMBER_Null, nRef99bm)
																		  Call SalTblSetFocusRow(tbl1, nNewRow)
																		  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_Edited | ROW_New,
																				     FALSE)
																	  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_Blue)
																	  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
																	  Set dfGood = dfGood + 1
																  Set nFlag = IifN(Left(sNaz1, 4)='ь-01' or Left(sNaz1, 4)='Ь-01' or
																		    Left(sNaz1, 4)='ь-02' or Left(sNaz1, 4)='Ь-02' or
																		    Left(sNaz1, 4)='ь-04' or Left(sNaz1, 4)='Ь-04', 0,
																		    IifN(nVob=96 or nVob=99, 1, nFlag))
																  If nType = 1
																	  Set bSD = FALSE
																	  If Ful_Bak(nRef99bm)
																		  Set bSD = SqlPrepareAndExecute(
																				    hSql(), "
																				    DELETE
																				    FROM oper
																				    WHERE ref=:nRef99bm")
																  Else 
																	  Set bSD = TRUE
																  If bSD and Len(sNaz1)>3
																	  Call ccDoc.SetDoc(IifN(nStep=0, 0, nRef), 'PO' || Str(1-nFlag),
																			     nDk, nVob, sNd, dVdateOrig, SalDateCurrent(), dVdate, dVdate,
																			     IifS(nDk=0, sNlsk, sNls), IifS(nDk=0, sPolu, sPlat),
																			     sMfoA, '', 980, nS, sKod, IifS(nDk=0, sNls, sNlsk), IifS(nDk=0, sPlat, sPolu), sMfoA,
																			     '', 980, nS, '', sNaz1, sVspo, sKisp, '', nSk)
																	  If ccDoc.oDoc()
																		  Set nRef = ccDoc.m_nRef
																		  Set nStep = nStep + 1
																		  Set ccDoc.A.Kv = 980
																		  Set ccDoc.m_nDk = nDk2
																		  If ccDoc.TT.SetTT(nRef, 'PO' || Str(1-nFlag), ccDoc.m_dDatV1,
																				   ccDoc.m_nDk, sNls8, ccDoc.A.Kv, ccDoc.A.S, 'BBBBK' || SalStrRepeatX('0', 2-Len(sRnk)) || sRnk,
																				   ccDoc.B.Kv, ccDoc.B.S) and ccDoc.TT.PayTT(1-nFlag)
																			  Set nL0 = 0
																			  Set nL1 = 0
																			  If nIndex0 >= 0
																				  Set nL0 = Len(sSbuNLS8[nIndex0])
																			  If nIndex1 >= 0
																				  Set nL1 = Len(sSbuNLS8[nIndex1])
																			  If nNm != 1 or (nNm = 1 and ((nL0 * nL1 > 0 and n21 = 1) or
																					   (nL0 > 0 and nL1 = 0) or (nL0 = 0 and nL1 > 0)))
																				  Set sNmsa1 = IifS(nDk=1, sNmsa, sNmsb)
																				  Set sNmsb1 = IifS(nDk=1, sNmsb, sNmsa)
																				  If SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO1' , :nABSRef[nABSNext] ) " ) and
																						   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO2' , :nABSSTMT[nABSNext]) " ) and
																						   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO3' ,  "||  IifS(nNm=3, sMfo,sMfoA) ||" ) " ) and
																						   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO4' ,  "||  IifS(nDk=1, sNlsa  , sNlsb) ||" ) " ) and
																						   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO5' ,  :sNmsa1 ) " ) and
																						   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO6' ,  "||  IifS(nNm=3, sMfoA,sMfo) ||" ) " ) and
																						   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO7' ,  "||  IifS(nDk=1, sNlsb  , sNlsa) ||" ) " ) and
																						   SqlPrepareAndExecute( hSql(), "insert into operw (ref,tag,value) values ( :ccDoc.m_nRef , 'ASPO8' ,  :sNmsb1 ) " )
																					  If SqlPrepareAndExecute(hSqlB, "
																							   UPDATE moperabs
																							   SET ref99bm=:ccDoc.m_nRef
																							   WHERE ref=:nABSRef[nABSNext] and stmt=:nABSSTMT[nABSNext]  ")
																						  If SqlCommitEx(hSql(), 'Мак.' || Str(nNm) || ', счетА='
																								     || sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(
																								     Str(nS), Len(Str(nS))-2) || '.' || Right(Str(nS), 2)
																								     || ', DK=' || Str(nDk) || ', ЧО=' || Str(1-nFlag) ||
																								     ', Ref=' || Str(nRef))
																							  Call SqlCommit( hSqlB )
																						  Else 
																							  Call SqlRollback( hSqlB )
																						  If not bMc
																							  Set dfCurrent = dfCurrent + 1
																							  Set bMc = TRUE
																						  Set tbl1.colREF98 = nRef
																						  Call VisTblSetRowColor(tbl1, nNewRow, COLOR_DarkGreen)
																						  Call SalTblSetCellTextColor(tbl1.colNPP, COLOR_Teal, TRUE)
																					  Else 
																						  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) ||
																								     ', счетА=' || sNls || ', счетБ=' || sNlsk ||
																								     ', сумма=' || Left(Str(nS), Len(Str(nS))-2) || '.' ||
																								     Right(Str(nS), 2) || ', DK=' || Str(nDk) || ', ЧО='
																								     || Str(1-nFlag))
																						  Set n21 = n21 + 1 ! Для выхода
																				  Else 
																					  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) ||
																							     ', счетА=' || sNls || ', счетБ=' || sNlsk ||
																							     ', сумма=' || Left(Str(nS), Len(Str(nS))-2) || '.' ||
																							     Right(Str(nS), 2) || ', DK=' || Str(nDk) || ', ЧО='
																							     || Str(1-nFlag))
																					  Set n21 = n21 + 1 ! Для выхода
																		  Else 
																			  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																					     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(
																					     Str(nS), Len(Str(nS))-2) || '.' || Right(Str(nS), 2) ||
																					     ', DK=' || Str(nDk) || ', ЧО=' || Str(1-nFlag))
																			  Set n21 = n21 + 1 ! Для выхода
																	  Else 
																		  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																				     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(Str(nS),
																				     Len(Str(nS))-2) || '.' || Right(Str(nS), 2) || ', DK=' ||
																				     Str(nDk) || ', ЧО=' || Str(1-nFlag))
																		  Set n21 = n21 + 1 ! Для выхода
																  Else 
																	  Call SqlRollbackEx(hSql(), 'Мак.' || Str(nNm) || ', счетА=' ||
																			     sNls || ', счетБ=' || sNlsk || ', сумма=' || Left(Str(nS),
																			     Len(Str(nS))-2) || '.' || Right(Str(nS), 2) || ', DK=' ||
																			     Str(nDk) || ', ЧО=' || Str(1-nFlag))
																	  Set n21 = n21 + 1 ! Для выхода
																  Set n21 = n21 + 1
														  If nNm = 1 and nIndex0 >= 0 and nIndex1 >= 0 and bWozw
															  Set nSbuFLAG[nIndex0] = nSbuFLAG_0
															  Set nSbuFLAG[nIndex1] = nSbuFLAG_1
												  Set nPos = nPos + nDelta
												  Set nRecn = nRecn + 1
												  If Int(nPos) != nTek
													  Set nTek = Int(nPos)
													  Set nTimeCurrent = SalDateHour(SalDateCurrent())*3600 +SalDateMinute(
															    SalDateCurrent())*60 + SalDateSecond(SalDateCurrent())
													  Set nTimeEnd = Int(100 * (nTimeCurrent-nTimeStart) / nPos + nTimeStart)
													  Set nHour = Int(nTimeEnd/3600)
													  Set nTemp = nTimeEnd - nHour*3600
													  Set nMinu = Int(nTemp/60)
													  Set dfAll = dfAll
													  Set dfGood = dfGood
													  Set dfCurrent = dfCurrent
													  Set dfNoLink = dfNoLink
													  Set dfStart = dfStart
													  Set dfEnd = 'Финиш: ' || Right(Str(100+nHour), 2) || ':' || Right(
															    Str(100+nMinu), 2) || ':' || Right(Str(100+nTemp-nMinu*60), 2) ||
															    ' (прогноз)'
												  Call ccProgressBar.SetProgress(nPos)
												  Call SalUpdateWindow(hWndForm)
										  Set nABSNext=nABSNext-1
									  Set nRefParams = 0
									  If SqlPrepareAndExecute( hSqlABS,  sInsUpdParams)
										  Call SqlCommit( hSqlABS )
									  Call ccProgressBar.SetProgress(100)
									  Set dfEnd = Left(dfEnd, 15)
									  Call SalSetFocus(tbl1)
									  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
									  Call WaitCursorOff()
									  Set dfDone = "Готово"
									  Call SaveInfoToLog("Прием документов налогового учета ОКОНЧЕН.")
									  Call SalMessageBox('Импорт успешно завершен !','Импорт ...', MB_Ok)
									  Call SqlDisconnect( hSqlABS )
									  Call SqlDisconnect( hSqlB )
								  Else 
									  Call SalMessageBox( 'Импорт прерван пользователем ...', 'Ошибка ...',  MB_Ok )
								  Call SalEnableWindow(pbExecute)
								  Call SalEnableWindow(pbExit)
								  Call SalSetFocus(pbExit)
								  Call WaitCursorOff()
						  Else 
							  Call MessageNoWait('День закрыт !', 'Предупреждение', 0, 1)
			  Pushbutton: pbExit
				  Message Actions 
					  On SAM_Click
						  Call SalEndDialog(hWndForm, FALSE)
			  Frame 
			  Data Field: dfDone
				  Message Actions 
			  Custom Control: ccProgressBar
				  Message Actions 
			  Child Table: tbl1
				  Contents 
					  Column: colNPP
						  List Values 
						  Message Actions 
					  Column: colND
						  List Values 
						  Message Actions 
					  Column: colMFOA
						  List Values 
						  Message Actions 
					  Column: colNLSA
						  List Values 
						  Message Actions 
					  Column: colMFOB
						  List Values 
						  Message Actions 
					  Column: colNLSB
						  List Values 
						  Message Actions 
					  Column: colS
						  List Values 
						  Message Actions 
					  Column: colVDATE
						  List Values 
						  Message Actions 
					  Column: colREF98
						  List Values 
						  Message Actions 
				  Functions 
				  Window Variables 
					  Number: nFocusRow
					  Window Handle: hWndCol
				  Message Actions 
					  On SAM_Click
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
						  If not SalIsWindowEnabled(pbExecute)
							  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
					  On SAM_CornerClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_CornerDoubleClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_DoubleClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_RowHeaderClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_RowHeaderDoubleClick
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On SAM_EndCellTab
						  Call SalTblSetRowFlags(tbl1, lParam, ROW_Selected, FALSE)
					  On WM_LbuttonUp
						! Узнать текущую строку
						! Call SalTblQueryFocus(tbl1, nFocusRow, hWndCol)
						! Set nFocusRow = SalTblQueryContext(tbl1)
						! Почистить все
						  Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
						! Call SalTblSetFocusRow (tbl1, nFocusRow)
						! Стать на нее (что выше)
						! Call SalTblSetRowFlags(tbl1, nFocusRow, ROW_Selected, FALSE)
						! Call SalSendMsg(tbl1, SAM_RowHeaderClick, 0, Max(TBL_MaxRow, nFocusRow+1))
					  On VTM_KeyUp
						  Call SalTblSetFlagsAnyRows(tbl1, ROW_Selected, FALSE, 0, 0)
						  If not SalIsWindowEnabled(pbExecute)
							  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
					  On WM_NCMouseMove ! 160
						  If not SalIsWindowEnabled(pbExecute)
							  Call VisTblAutoSizeColumn(tbl1, hWndNULL)
			  Data Field: dfStart
				  Message Actions 
			  Data Field: dfEnd
				  Message Actions 
			  Radio Button: rb1
				  Message Actions 
			  Radio Button: rb2
				  Message Actions 
			  Frame 
			  Background Text: Дата отчетного периода
			  Data Field: dfBD
				  Message Actions 
					  On SAM_Validate
						  If dfBD > dBankDate
							  Call MessageNoWait('Локальная дата не может быть больше текущей даты !', 'ОШИБКА',
									     30, 1)
							  Return VALIDATE_Cancel
						  Call SalSendMsg(dfGod, SAM_Create, 0, 0)
						  Call SalSendMsg(dfKw, SAM_Create, 0, 0)
						  Call SalSendMsg(dfDbeg, SAM_Create, 0, 0)
						  Call SalSendMsg(dfDend, SAM_Create, 0, 0)
			  Radio Button: rbGodKw
				  Message Actions 
					  On SAM_Click
						  Call SalDisableWindow(dfDbeg)
						  Call SalDisableWindow(dfDend)
						  Call SalEnableWindow(dfGod)
						  Call SalEnableWindow(dfKw)
			  Radio Button: rbDates
				  Message Actions 
					  On SAM_Click
						  Call SalEnableWindow(dfDbeg)
						  Call SalEnableWindow(dfDend)
						  Call SalDisableWindow(dfGod)
						  Call SalDisableWindow(dfKw)
			  Data Field: dfGod
				  Message Actions 
					  On SAM_Create
						! Set dfGod = SalDateYear(SalDateCurrent()-1)
						  Set dfGod = SalDateYear(dfBD-1)
					  On SAM_Validate
						! If dfGod < SalDateYear(SalDateCurrent()-1)-3 or dfGod > SalDateYear(
								   SalDateCurrent()) or (dfGod = SalDateYear(SalDateCurrent()-1) and
								   dfKw > SalDateQuarter(SalDateCurrent()-1))
							    Call MessageNoWait('Недопустимое сочетание года и номера квартала.', 'ОШИБКА', 30,
									     1)
							    Return VALIDATE_Cancel
						  If dfGod < SalDateYear(dfBD-1)-3 or dfGod > SalDateYear(dfBD) or
								   (dfGod = SalDateYear(dfBD-1) and dfKw > SalDateQuarter(dfBD-1))
							  Call MessageNoWait('Недопустимое сочетание года и номера квартала.', 'ОШИБКА', 30,
									     1)
							  Return VALIDATE_Cancel
						  Else 
							  Call SetDbegDend(dfGod, dfKw)
			  Data Field: dfKw
				  Message Actions 
					  On SAM_Create
						! Set dfKw = SalDateQuarter(SalDateCurrent()-1)
						  Set dfKw = SalDateQuarter(dfBD-1)
					  On SAM_Validate
						! If dfKw < 1 or dfKw > 4 or (dfGod = SalDateYear(SalDateCurrent()-1) and
								   dfKw > SalDateQuarter(SalDateCurrent()-1))
							    Call MessageNoWait('Недопустимый номер квартала.', 'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						  If dfKw < 1 or dfKw > 4 or (dfGod = SalDateYear(dfBD-1) and
								   dfKw > SalDateQuarter(dfBD-1))
							  Call MessageNoWait('Недопустимый номер квартала.', 'ОШИБКА', 30, 1)
							  Return VALIDATE_Cancel
						  Else 
							  Call SetDbegDend(dfGod, dfKw)
			  Data Field: dfDbeg
				  Message Actions 
					  On SAM_Create
						! Set dTemp = SalDateQuarterBegin(SalDateCurrent()-1)
						  Set dTemp = SalDateQuarterBegin(dfBD-1)
						! Set dfDbeg = IifD(dTemp > SalDateCurrent(), SalDateCurrent(), dTemp)
						  Set dfDbeg = IifD(dTemp > dfBD, dfBD, dTemp)
					  On SAM_Validate
						! If dfDbeg > SalDateCurrent()
							    Call MessageNoWait('Даты ("Интервал дат") не должны превышать текущей даты.',
									     'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						  If dfDbeg > dfBD
							  Call MessageNoWait('Даты ("Интервал дат") не должны превышать текущей даты.',
									     'ОШИБКА', 30, 1)
							  Return VALIDATE_Cancel
						  Else 
							  Set dfGod = SalDateYear(dfDbeg)
							  Set dfKw = SalDateQuarter(dfDbeg)
					  On SAM_KillFocus
						  Call SalSetFocus(dfDend)
						  Call SalSetFieldEdit(dfDend, TRUE)
			  Data Field: dfDend
				  Message Actions 
					  On SAM_Create
						! Set dTemp = SalDateQuarterBegin(SalDateCurrent()+91) - 1
						  Set dTemp = SalDateQuarterBegin(dfBD+91) - 1
						! Set dfDend = IifD(dTemp > SalDateCurrent(), SalDateCurrent(), dTemp)
						  Set dfDend = IifD(dTemp > dfBD, dfBD, dTemp)
					  On SAM_Validate
						! If dfDend > SalDateCurrent() or dfDbeg > dfDend or
								   SalDateQuarter(dfDbeg) != SalDateQuarter(dfDend) or dfDbeg > SalDateCurrent()
							    Call MessageNoWait(IifS(dfDbeg>dfDend, 'Вторая дата не может быть меньше первой.',
									     'Даты ("Интервал дат") ' || IifS(dfDend>SalDateCurrent(),
									     'не должны превышать текущей даты.',
									     'должны находиться в пределах одного квартала.')), 'ОШИБКА', 30, 1)
							    Return VALIDATE_Cancel
						  If dfDend > dfBD or dfDbeg > dfDend or
								   SalDateQuarter(dfDbeg) != SalDateQuarter(dfDend) or dfDbeg > dfBD
							  Call MessageNoWait(IifS(dfDbeg>dfDend, 'Вторая дата не может быть меньше первой.',
									     'Даты ("Интервал дат") ' || IifS(dfDend>dfBD,
									     'не должны превышать текущей даты.',
									     'должны находиться в пределах одного квартала.')), 'ОШИБКА', 30, 1)
							  Return VALIDATE_Cancel
						  Else 
							  Set dfGod = SalDateYear(dfDend)
							  Set dfKw = SalDateQuarter(dfDend)
			  Frame 
			  Group Box: Предварительная обработка
			  Radio Button: rbPnone
				  Message Actions 
					  On SAM_Click
						  Call DisableDates()
						  Call SalEnableWindow(dfGod)
						  Call SalEnableWindow(dfKw)
						  Call SalEnableWindow(pbExecute)
			  Radio Button: rbOdok
				  Message Actions 
					  On SAM_Click
						  Call SalEnableWindow(rbDates)
						  If rbGodKw
							  Call SalDisableWindow(dfDbeg)
							  Call SalDisableWindow(dfDend)
							  Call SalEnableWindow(dfGod)
							  Call SalEnableWindow(dfKw)
						  If rbDates
							  Call SalEnableWindow(dfDbeg)
							  Call SalEnableWindow(dfDend)
							  Call SalDisableWindow(dfGod)
							  Call SalDisableWindow(dfKw)
						  Call SalEnableWindow(pbExecute)
			  Radio Button: rbKdok
				  Message Actions 
					  On SAM_Click
						  Call DisableDates()
						  Call SalEnableWindow(dfGod)
						  Call SalEnableWindow(dfKw)
						  Call SalEnableWindow(pbExecute)
			  Frame 
			  Picture: pic1
				  Message Actions 
			  Radio Button: rbBi
				  Message Actions 
			  Radio Button: rbBo
				  Message Actions 
			  Data Field: dfBi
				  Message Actions 
			  Data Field: dfBo
				  Message Actions 
			  Background Text: Баланс
			  Picture: pic2
				  Message Actions 
			  Picture: pic3
				  Message Actions 
			  Check Box: cbSave
				  Message Actions 
					  On SAM_Click
						  If cbSave
							  Set cbClear = FALSE
			  Check Box: cbClear
				  Message Actions 
					  On SAM_Click
						  If cbClear
							  Set cbSave = FALSE
			  Radio Button: rbVi
				  Message Actions 
			  Radio Button: rbVo
				  Message Actions 
			  Data Field: dfVi
				  Message Actions 
			  Data Field: dfVo
				  Message Actions 
			  Background Text: Вне
					баланс
			  Background Text: Бал.сч.
			  Check Box: rbBii
				  Message Actions 
			  Check Box: rbBoo
				  Message Actions 
			  Check Box: rbVoo
				  Message Actions 
			  Check Box: rbVii
				  Message Actions 
		  Functions 
			  Function: GetBankOperIdent
				  Description: 
				  Returns 
					  String: 
				  Parameters 
					  String: sMfo
					  String: sId
				  Static Variables 
				  Local variables 
					  String: sSab
				  Actions 
					  Set sSab = GetValueStr("
							    SELECT sab
							    FROM banks
							    WHERE mfo=" || sMfo)
					  Return IifS(sSab='', 'xxx', Right(sSab, 3)) || 'O' || sId
			  Function: SetDbegDend
				  Description: 
				  Returns 
				  Parameters 
					  Number: nGod
					  Number: nKw
				  Static Variables 
				  Local variables 
				  Actions 
					  Set dfDbeg = SalDateQuarterBegin(SalDateConstruct(nGod, nKw*3, 1, 0, 0, 0))
					  Set dfDend = SalDateQuarterBegin(SalDateConstruct(nGod, nKw*3, 1, 0, 0, 0) + 92) - 1
			  Function: DisableDates
				  Description: 
				  Returns 
				  Parameters 
				  Static Variables 
				  Local variables 
				  Actions 
					  Call SalDisableWindow(dfDbeg)
					  Call SalDisableWindow(dfDend)
					  Call SalDisableWindow(rbDates)
					  Set rbGodKw = TRUE
			  Function: ABSSqlLike
				  Description: 
				  Returns 
				  Parameters 
					  String: sSqlInABS
					  String: sSqlInNotABS
					  String: sOrAnd
					  Receive String: sOut
					  Receive String: sOut1
				  Static Variables 
				  Local variables 
					  String: sSqlOutABS
					  String: sSqlOutABS1
				  Actions 
					  While not SalStrLength( sSqlInABS )=0 
						  If SalStrScan( sSqlInABS , ',' ) = -1 
							  Set sSqlOutABS  =   sSqlOutABS  || sOrAnd ||" ad.NLS"||sSqlInNotABS||"'"||SalStrTrimX(sSqlInABS)||"%' "
							  Set sSqlOutABS1 =  sSqlOutABS1|| sOrAnd ||" ak.NLS"||sSqlInNotABS||"'"||SalStrTrimX(sSqlInABS)||"%' "
							  Set sSqlInABS = ''
						  Else 
							  If SalStrTrimX(SalStrMidX( sSqlInABS, 0, SalStrScan( sSqlInABS , ',' ))) !=''
								  Set sSqlOutABS   =  sSqlOutABS  || sOrAnd ||" ad.NLS"||sSqlInNotABS||"'"||SalStrTrimX( SalStrMidX( sSqlInABS, 0, SalStrScan( sSqlInABS , ',' )))||"%' "
								  Set sSqlOutABS1 =  sSqlOutABS1|| sOrAnd ||" ak.NLS"||sSqlInNotABS||"'"||SalStrTrimX( SalStrMidX( sSqlInABS, 0, SalStrScan( sSqlInABS , ',' )))||"%' "
								  Set sSqlInABS = SalStrMidX( sSqlInABS, SalStrScan( sSqlInABS , ',' )+1,SalStrLength( sSqlInABS ))
							  Else 
								  Set sSqlInABS = SalStrMidX( sSqlInABS, SalStrScan( sSqlInABS , ',' )+1,SalStrLength( sSqlInABS ))
					  Set sOut   = sSqlOutABS
					  Set sOut1 = sSqlOutABS1
		  Window Parameters 
			  Number: nType
		  Window Variables 
			  : ccDoc
			  String: ND
			  String: sODB
			  String: NLS
			  String: NLSK
			  Number: KVS
			  Number: SK
			  Number: REF
			  Number: ISV
			  String: NAZN
			  String: sTmp
			  Number: nCount
			  String: sAn
			  String: sNbw
			  Number: nNls
			  String: sMfo
			  String: sMfoA
			  String: sMdl
			  Number: nMfop
			  Number: nFetchRes
			  String: sBlk
			  String: sFv
			  String: sFs
			  Number: nDocs
			  Sql Handle: hSqlA
			  Sql Handle: hSqlB
			  Sql Handle: hSqlC
			  Number: nPos
			  Number: nDelta
			  Number: nRecCount
			  String: strMessage
			  Number: nNm
			  Number: nDk
			  Number: nDk2
			  Number: nMfo
			  String: sNd
			  Number: nVob
			  String: sNls
			  String: sNlsk
			  String: sNls8
			  Number: nSk
			  Number: nS
			! Date/Time: dDat
			  String: sPlat
			  String: sPolu
			  String: sNaz1
			  String: sVspo
			  String: sKod
			  String: sKisp
			  Number: nRow
			  Number: nRef
			  String: sODBCDir
			  Date/Time: dTmp
			  Number: n99
			  Number: nSos
			  Number: nRef99bm
			  Date/Time: dVdate
			  Date/Time: dVdateOrig
			  Date/Time: dVdateU
			  Date/Time: dBankDate
			!
			  Number: nNewRow
			!
			  Number: nTimeStart
			  Number: nTimeCurrent
			  Number: nTimeEnd
			  Number: nHour
			  Number: nMinu
			  Number: nTemp
			  Number: nTek
			  Number: nRecn
			!
			  Number: nFlag
			  Number: n21
			  Number: nStep
			!
			  String: sNLS
			  String: sNLS8
			  Number: nFLAG
			  String: sSbuNLS[*]
			  String: sSbuNLS8[*]
			  Number: nSbuFLAG[*]
			  Number: nIndex0
			  Number: nIndex1
			!
			  Date/Time: dDat1
			!
			  Boolean: bDalee
			  Boolean: bSD
			!
			  String: sTp
			!
			  String: sNLS1
			  String: sNLS2
			  String: sStopNLS1[*]
			  String: sStopNLS2[*]
			  Number: n22
			  Number: nI
			  Boolean: bStop
			!
			  Number: nRefO
			!
			  Boolean: bMa
			  Boolean: bMc
			!
			  Boolean: bProdol
			!
			  String: sRnk
			!
			  Date/Time: dTemp
			!
			  String: sCurDir
			  String: sOdbkPath
			!
			  String: sBalAcc
			  String: sBalAccn
			!
			  Number: nL0
			  Number: nL1
			!
			  Number: nSbuFLAG_0
			  Number: nSbuFLAG_1
			  Boolean: bWozw
			!
			  String: sBi
			  String: sVi
			  String: sBii
			  String: sBoo
			  String: sVii
			  String: sVoo
			  Date/Time: dDateStart
			  Date/Time: dDateStartABS
			  String: sDateStartABS
			  Date/Time: dDateEnd
			  String: sBankMFO
			  Long String: sSqlIn
			  Long String: sSqlOut
			  String: sSqlInNot
			  String: sSqlAll
			  String: sSqlAll1
			  String: sSqlAllN
			  String: sSqlAllN1
			  String: strErrorText
			  Number: nConnectError
			  Long String: sSqlOut1
			  Number: nABSRef[*]
			  Number: nABSSTMT[*]
			  Number: nSTMT
			  Number: nABSNext
			  Number: nRefASPO
			  String: sNlsa
			  String: sNlsb
			  String: sNmsa
			  String: sNmsb
			  String: sNmsa1
			  String: sNmsb1
			! ! Строка по которой изменяем или добавляем параметр
			  String: sInsUpdParams
			  Number: nRefNotImport
			  Number: nRefParams
			  Boolean: bPay
			  String: TestDate
		  Message Actions 
			  On SAM_Create
				  Call SalWaitCursor(TRUE)
				  Call ConPara('PUSH')
				  Call SalFileGetCurrentDirectory(sCurDir)
				  Call SalUseRegistry(FALSE, '')
				  Call SalGetProfileString('Import', 'NalDecPath', Left(SalFileGetDrive(), 1) || ':\\BARS98\\ODBC.DSN\\SBU', sODBCDir, GetIniFileName())
				  Call SalGetProfileString('Import', 'BarsFoxOdbkPath', Left(SalFileGetDrive(), 1) || ':\\BARS98\\ODBC.DSN\\ODBK', sOdbkPath, GetIniFileName())
				  Call SalGetProfileString('Import', 'BalAcc', '99999999999999', sBalAcc, GetIniFileName())
				  Call SalGetProfileString('Import', 'BalAccn', '99999999999999', sBalAccn, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'Input', 'DBF', sODB,GetIniFileName())
				  Call SalGetProfileString('NalUch', 'DataBase', '', sODBDataBase,GetIniFileName())
				  Call SalGetProfileString('NalUch', 'StartDate', '01/01/1899', sDateStartABS,GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAccBii',    '0', sBii, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAccBoo',   '0', sBoo, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAccVii', '0', sVii, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAccVoo', '0', sVoo, GetIniFileName())
				! Set dfBi = sBalAcc
				! Set dfVi = sBalAccn
				  Call SalUseRegistry(TRUE, GetCompanyName())
				  Call SalGetProfileString('NalUch', 'BalAccVkl', sBalAcc, dfBi, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAccIsk', '99999999999999', dfBo, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAcnVkl', sBalAccn, dfVi, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAcnIsk', '99999999999999', dfVo, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAccA', '0', sBi, GetIniFileName())
				  Call SalGetProfileString('NalUch', 'BalAccN', '0', sVi, GetIniFileName())
				  If Len(dfBi) = 0
					  Set dfBi = sBalAcc
				  If Len(dfVi) = 0
					  Set dfVi = sBalAccn
				  Set rbBi = sBi='0'
				  Set rbBo = sBi!='0'
				  Set rbVi = sVi='0'
				  Set rbVo = sVi!='0'
				  Set dBankDate = GetBankDate()
				  Set dfBD = dBankDate
				  Call PrepareWindowEx(hWndForm)
				  If nType = 1
					  Call SalSetWindowText(hWndForm,
							     'ПОВТОРНЫЙ прием информации для налогового учета из ОДБ (финансовый учет)')
				! Call SalHideWindow(dfStart)
				! Call SalHideWindow(dfEnd)
				  Call SalSetFocus(pbExit)
				  Set rb2 = TRUE
				  Call DisableDates()
				  If sODB='ABS'
					!
					  Call SalShowWindow ( rbBoo )
					  Call SalShowWindow ( rbBii )
					  Call SalHideWindow   ( rbBi )
					  Call SalHideWindow   ( rbBo )
					  Call SalShowWindow ( rbVii )
					  Call SalShowWindow ( rbVoo )
					  Call SalHideWindow   ( rbVi )
					  Call SalHideWindow   ( rbVo )
					  Call SalDisableWindow( rbPnone )
					  Set rbBii = SalStrToNumber( sBii )
					  Set rbBoo = SalStrToNumber( sBoo )
					  Set rbVii = SalStrToNumber( sVii )
					  Set rbVoo = SalStrToNumber( sVoo )
					  Call SalEnableWindow( rbDates )
					! Call SalDisableWindow( rbKdok )
					  Set rbOdok = '0'
					  Set bFlagABS = 0
					  Set dDateStartABS = SalStrToDate( sDateStartABS )
			  On SAM_CreateComplete
				  Call SalWaitCursor(FALSE)
			  On SAM_Destroy
				  Call ConPara('POP')
				  Call SalFileSetCurrentDirectory(sCurDir)
				  If cbSave
					  Call SalUseRegistry(TRUE, GetCompanyName())
					  Call SalSetProfileString('NalUch', 'BalAccVkl', dfBi, GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAccIsk', dfBo, GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAcnVkl', dfVi, GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAcnIsk', dfVo, GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAccA', IifS(rbBi, '0', '1'), GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAccN', IifS(rbVi, '0', '1'), GetIniFileName())
				  If cbClear
					  Call SalUseRegistry(TRUE, GetCompanyName())
					  Call SalSetProfileString('NalUch', 'BalAccVkl', '', GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAccIsk', '', GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAcnVkl', '', GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAcnIsk', '', GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAccA', '0', GetIniFileName())
					  Call SalSetProfileString('NalUch', 'BalAccN', '0', GetIniFileName())
				  Call Pl_dat(dBankDate)
				!
				  Call SalUseRegistry(FALSE, '')
				  Call SalSetProfileString('NalUch', 'BalAccBii', IifS(rbBii=0, '0', '1'), GetIniFileName())
				  Call SalSetProfileString('NalUch', 'BalAccBoo', IifS(rbBoo=0, '0', '1'), GetIniFileName())
				  Call SalSetProfileString('NalUch', 'BalAccVii', IifS(rbVii=0, '0', '1'), GetIniFileName())
				  Call SalSetProfileString('NalUch', 'BalAccVoo', IifS(rbVoo=0, '0', '1'), GetIniFileName())
