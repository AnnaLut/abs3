Application Description: Библиотека функциональных классов 
		по открытию/обновлению счетов
	Outline Version - 4.0.26
	Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000100100 002C000000020000 0003000000FFFFFF FFFFFFFFFFF8FFFF
0040: FFE1FFFFFFFFFFFF FF000000007C0200 004D010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
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
0000: D4180909B80B1A00
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
		Dynalib: global.apd
		Dynalib: Absapi.apd
		File Include: GENLABEL.APL
		File Include: GENFCLS.APL
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
			Boolean: fAccLangInit
		Internal Functions
			Function: GenAcc_Init
				Description: Инициализация лингвистической таблицы и прочего
						для библиотеки
				Returns
					Boolean:
				Parameters
				Static Variables
				Local variables
					String: strPathToLangResources
					String: strLangId
					!
					String: strFileName
				Actions
					If NOT fAccLangInit
						Set strPathToLangResources = GetLangPath()
						Set strLangId = GetLang()
						Set strFileName = strPathToLangResources || "\\" || strLangId || "\\genacc.lng"
						If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFileSpecial( strFileName, strLangId, "", TRUE ))
							Call CurrentLangTable.AddAtom('cTErrAccRekv','Не заполнен реквизит')
							Call CurrentLangTable.AddAtom('cTErrAccMfo', 'МФО банка')
							Call CurrentLangTable.AddAtom('cTErrAccNbs', 'Балансовый счет')
							Call CurrentLangTable.AddAtom('cTErrAccNls', 'Номер счета')
							Call CurrentLangTable.AddAtom('cTErrAccKv',  'Валюта')
							Call CurrentLangTable.AddAtom('cTErrAccNms', 'Наименование счета')
							Call CurrentLangTable.AddAtom('cTErrAccTip', 'Тип счета')
							Call CurrentLangTable.AddAtom('cTErrAccVid', 'Вид счета')
							Call CurrentLangTable.AddAtom('cTErrAccIsp', 'Исполнитель')
							Call CurrentLangTable.AddAtom('cTErrAccGrp', 'Права доступа')
						! Call CurrentLangTable.SaveToFile('C:\\BARS98\\genacc.lng','RUS')
						Set fAccLangInit = TRUE
					Return fAccLangInit
		Named Menus
		Class Definitions
.data RESOURCE 0 0 1 2286315003
0000: A600000067000000 0000000000000000 0200000100FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F2B003C00 000F410062737472
0040: 616374410063636F 756E746C00C00000 0400000083010D00 0000FFFF840D0000
0060: 030400FE00FF8311 00000001FB00FF0F 1E000000EE0100FF 3F
.enddata
			Functional Class: AbstractAccount
				Description:
				Derived From
				Class Variables
					Number: nFetchRes
					Sql Handle: hSql
					Number: nErrorCount
					Number: nMode
				Instance Variables
					Number: nNewAcc
					Number: nRnk
					Number: nAcc
					String: sNls
					String: sNlsAlt
					Number: nKv
					String: sNbs
					String: sOB22
					String: sNms
					Number: nPap
					String: sTip
					Number: nVid
					Number: nPos
					String: sTobo
					Date/Time: dDaos
					Date/Time: dDazs
					Date/Time: dDapp
					Date/Time: dMDate
					Number: nBlkd
					Number: nBlkk
					Number: nIsp
					Number: nGrp
					Number: nSeci
					Number: nSeco
					Number: nOstc
					Number: nOstb
					Number: nOstf
					Number: nDos
					Number: nKos
					Number: nOstq
					Number: nDosq
					Number: nKosq
					Number: nLim
					Number: nOstx
					Number: nProcMfo
					Number: nProcMfoOld
					Number: nP4_
					: SPList
						Class: cSParamList
					: ListAcrn
						Class: cAccAcrnList
					: ListRights
						Class: cAccRightsList
					: ListRates
						Class: cAccRatesList
					: ListSob
						Class: cAccSobList
				Functions
					Function: initAccount
						Description:
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql_
							Number: nAccId
						Static Variables
						Local variables
						Actions
							Call GenAcc_Init()
							Set hSql  = hSql_
							Set nAcc  = nAccId
							Call SPList.Init(nAcc)
							Call ListAcrn.Init(nAcc)
							Call ListRights.Init(nAcc)
							Call ListRates.Init(nAcc)
							Call ListSob.Init(nAcc)
							Return TRUE
					Function: populateAccount
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT SqlPrepareAndExecute(hSql, 
									"SELECT nls, kv, nbs, OB22, nlsalt, nms, pap, tip, vid, pos, 
									        daos, dazs, dapp, mdate, blkd, blkk, 
									        ostc, dos, kos, ostq, dosq, kosq, lim, ostx, 
									        isp, grp, seci, seco, tobo 
									 INTO :sNls, :nKv, :sNbs, :sOB22, :sNlsAlt, :sNms, :nPap, :sTip, :nVid, :nPos, 
									      :dDaos, :dDazs, :dDapp, :dMDate, :nBlkd, :nBlkk, 
									      :nOstc, :nDos, :nKos, :nOstq, :nDosq, :nKosq, :nLim, :nOstx, 
									      :nIsp, :nGrp, :nSeci, :nSeco, :sTobo 
									 FROM Accounts WHERE acc=:nAcc")
								Return FALSE
							Call SqlFetchNext(hSql, nFetchRes)
							Set nProcMfoOld = NUMBER_Null
							If NOT SqlPrepareAndExecute(hSql,
									"SELECT mfo INTO :nProcMfoOld FROM Bank_acc WHERE acc=:nAcc")
								Return FALSE
							Call SqlFetchNext(hSql, nFetchRes)
							Set nProcMfo = nProcMfoOld
							! Rights
							If NOT populateAccRights()
								Return FALSE
							! SP
							If NOT populateAccSParams()
								Return FALSE
							! %%
							! Tarif
							If NOT populateAccRates()
								Return FALSE
							! SOB
							If NOT populateAccSob()
								Return FALSE
							Return TRUE
					Function: populateAccountAttribute
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT SqlPrepareAndExecute(hSql, 
									"SELECT nls, kv, nbs, OB22, nlsalt, nms, pap, tip, vid, pos, 
									        daos, dazs, dapp, mdate, blkd, blkk, 
									        ostc, dos, kos, ostq, dosq, kosq, lim, ostx, 
									        isp, grp, seci, seco, tobo 
									 INTO :sNls, :nKv, :sNbs, :sOB22, :sNlsAlt, :sNms, :nPap, :sTip, :nVid, :nPos, 
									      :dDaos, :dDazs, :dDapp, :dMDate, :nBlkd, :nBlkk, 
									      :nOstc, :nDos, :nKos, :nOstq, :nDosq, :nKosq, :nLim, :nOstx, 
									      :nIsp, :nGrp, :nSeci, :nSeco, :sTobo 
									 FROM Accounts WHERE acc=:nAcc")
								Return FALSE
							Call SqlFetchNext(hSql, nFetchRes)
							Set nProcMfoOld = NUMBER_Null
							If NOT SqlPrepareAndExecute(hSql,
									"SELECT mfo INTO :nProcMfoOld FROM Bank_acc WHERE acc=:nAcc")
								Return FALSE
							Call SqlFetchNext(hSql, nFetchRes)
							Set nProcMfo = nProcMfoOld
							Return TRUE
					Function: saveAccount
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If nAcc = 0
								If NOT registerAccount()
									Return FALSE
							Else
								If NOT updateAccount()
									Return FALSE
							Return TRUE
					Function: registerAccount
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT registerAccountAttribute()
								Return FALSE
							! Rights
							If NOT registerAccountRights()
								Return FALSE
							! SP
							If NOT initAccountSParams()
								Return FALSE
							! %%
							If NOT initAccountAcrn()
								Return FALSE
							! Tarif
							If NOT initAccountRates()
								Return FALSE
							! SOB
							If NOT initAccountSob()
								Return FALSE
							Return TRUE
					Function: registerAccountAttribute
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							String: sOstX
							Number: nLastAcc
						Actions
							Set nMode = IifN(nProcMfo!=NUMBER_Null,4,77)
							Set sOstX = IifS(nOstx=NUMBER_Null,'NULL',Str(nOstx))
							Set nLastAcc = NUMBER_Null
							If not SqlPLSQLCommand( hSql,
									"accreg.setAccountAttr( nMode, nProcMfo, 0, nGrp, nP4_, nRnk, sNls, nKv, sNms, sTip, nIsp, nLastAcc,
									   sNbs, sOB22, nPap, nVid, nPos, NUMBER_Null, nSeci, nSeco,
									   nBlkd, nBlkk, nLim, sOstX, sNlsAlt, sTobo, NUMBER_Null )")
								Return FALSE
							! Set nAcc = nLastAcc
							Call setAcc(nLastAcc)
							Set dDaos = GetBankDate()
							Return TRUE
					Function: registerAccountRights
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							Number: nIterator
						Actions
							If getAccRightsParNum() > 0	! счет уже открыт и сейчас идет открытие по валютам
								Call ListRights.Assign(nAcc)
								Set nIterator = 0
								While nIterator <= getAccRightsParNum()
									If ListRights.List[nIterator].nPr = 0
										Set ListRights.List[nIterator].nPr = 1
									Set nIterator = nIterator + 1
							If NOT saveAccRights()
								Return FALSE
							Return TRUE
					Function: checkAccountAttribute
						Description:
						Returns
							Boolean:
						Parameters
							Receive String: sMsg
							Receive Number: nCheck
						Static Variables
						Local variables
						Actions
							If not SqlPLSQLCommand(hSql, "accreg.check_Account(nAcc, sMsg, nCheck)")
								Return FALSE
							Return TRUE
					Function: initAccountSParams
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Call SPList.Init(nAcc)
							If NOT SPList.Populate(hSql,sNbs)
								Return FALSE
							Return TRUE
					Function: initAccountAcrn
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Call ListAcrn.Init(nAcc)
							If NOT ListAcrn.Populate(hSql)
								Return FALSE
							Return TRUE
					Function: initAccountRates
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Call ListRates.Init(nAcc)
							Return TRUE
					Function: initAccountSob
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Call ListSob.Init(nAcc)
							Return TRUE
					Function: updateAccount
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							String: sOstX
							String: sNlsAlt_
						Actions
							! General + Financial
							If NOT saveAccountAttribute()
								Return FALSE
							! Rights
							If NOT saveAccRights()
								Return FALSE
							! SP
							If NOT saveAccSParams()
								Return FALSE
							! %%
							If NOT saveAccAcrn()
								Return FALSE
							! Tarif
							If NOT saveAccRates()
								Return FALSE
							! SOB
							If NOT saveAccSob()
								Return FALSE
							Return TRUE
					Function: saveAccountAttribute
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
							String: sOstX
							String: sNlsAlt_
						Actions
							Set nMode    = IifN(nProcMfoOld!=NUMBER_Null OR nProcMfo!=NUMBER_Null,4,77)
							Set sOstX    = IifS(nOstx=NUMBER_Null,'NULL',Str(nOstx))
							Set sNlsAlt_ = IifS(sNlsAlt='','NULL',sNlsAlt)
							If NOT SqlPLSQLCommand( hSql,
									"accreg.setAccountAttr( nMode, nProcMfo, 0, nGrp, nP4_, nRnk, sNls, nKv, sNms, sTip, nIsp, nAcc,
									   sNbs, sOB22, nPap, nVid, nPos, NUMBER_Null, nSeci, nSeco,
									   nBlkd, nBlkk, nLim, sOstX, sNlsAlt_, sTobo, NUMBER_Null )")
								Return FALSE
							Return TRUE
					Function: reserveAccountAttribute
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT SqlPLSQLCommand( hSql,
									"accreg.p_reserve_acc( nAcc, nRnk, sNls, nKv, sNms, sTip, nGrp, nIsp, 
									    nPap, nVid, nPos, nBlkd, nBlkk, nLim, nOstx, sNlsAlt, sTobo, sOB22 )" )
								Return FALSE
							Return TRUE
					Function: getErrAccountData
						Description:
						Returns
							String:
						Parameters
							Receive String: sPar
						Static Variables
						Local variables
							String: strErrorList
						Actions
							Set strErrorList = ''
							Set nErrorCount = 0
							Set sPar = ''
							!
							! If nProcMfo = NUMBER_Null
							If sNbs = STRING_Null and GetGlobalOptionEx('NBS_NULL')=0
								Set nErrorCount = nErrorCount + 1
								Set sPar = IifS(sPar='','NBS',sPar)
								! Не заполнен реквизит <Балансовый счет>
								Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccNbs')  || '>' || PutCrLf()
							If sOB22 = STRING_Null or chkNbsHasOB22() 
								Set nErrorCount = nErrorCount + 1
								Set sPar = IifS(sPar='','OB22',sPar)
								! Не заполнен реквизит <ОБ22>
								Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccOB22')  || '>' || PutCrLf()
							If sNls = STRING_Null
								Set nErrorCount = nErrorCount + 1
								Set sPar = IifS(sPar='','NLS',sPar)
								! Не заполнен реквизит <Номер счета>
								Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccNls')  || '>' || PutCrLf()
							!
							If nKv  = NUMBER_Null
								Set nErrorCount = nErrorCount + 1
								Set sPar = IifS(sPar='','KV',sPar)
								! Не заполнен реквизит <Валюта>
								Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccKv')  || '>' || PutCrLf()
							If sNms = STRING_Null
								Set nErrorCount = nErrorCount + 1
								Set sPar = IifS(sPar='','NMS',sPar)
								! Не заполнен реквизит <Наименование счета>
								Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccNms')  || '>' || PutCrLf()
							If sTip = STRING_Null
								Set nErrorCount = nErrorCount + 1
								Set sPar = IifS(sPar='','TIP',sPar)
								! Не заполнен реквизит <Тип счета>
								Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccTip')  || '>' || PutCrLf()
							If nVid = NUMBER_Null
								Set nErrorCount = nErrorCount + 1
								Set sPar = IifS(sPar='','VID',sPar)
								! Не заполнен реквизит <Вид счета>
								Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccVid')  || '>' || PutCrLf()
							If nIsp = NUMBER_Null
								Set nErrorCount = nErrorCount + 1
								Set sPar = IifS(sPar='','ISP',sPar)
								! Не заполнен реквизит <Исполнитель>
								Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccIsp')  || '>' || PutCrLf()
							! If nGrp=0 OR nGrp=NUMBER_Null
								       Set nErrorCount = nErrorCount + 1
								       Set sPar = IifS(sPar='','GRP',sPar)
								! <Права доступа> Не назначена группа счета.
								       Set strErrorList = strErrorList || SalNumberToStrX(nErrorCount,0) || ': ' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccRekv') || '<' ||
										    CurrentLangTable.GetAtomTitle('cTErrAccGrp')  || '>' || PutCrLf()
							!
							Return strErrorList
					! %%
					Function: setIntProfData
						Description:
						Returns
							Boolean:
						Parameters
							Number: nNbsProf
						Static Variables
						Local variables
						Actions
							If NOT SqlPLSQLCommand(hSql, "accreg.setAccountIntFromProf(nAcc, sNbs, nNbsProf)" )
								Return FALSE
							Return TRUE
					! Rights
					Function: populateAccRights
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT ListRights.Populate(hSql)
								Return FALSE
							Return TRUE
					Function: getAccRightsValue
						Description:
						Returns
						Parameters
							Number: nIndex
							Receive Number: nId
							Receive String: sName
						Static Variables
						Local variables
						Actions
							Set nId   = ListRights.List[nIndex].nId
							Set sName = ListRights.List[nIndex].strName
					Function: saveAccRights
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT ListRights.Update(hSql)
								Return FALSE
							Return TRUE
					Function: addAccRights
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
							String: sName
						Static Variables
						Local variables
						Actions
							Call ListRights.Add(nId, sName)
							Return TRUE
					Function: dropAccRights
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
						Static Variables
						Local variables
						Actions
							If NOT ListRights.Drop(nId)
								Return FALSE
							Return TRUE
					Function: getAccRightsParNum
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return ListRights.nParNum
					Function: getAccRightsIndexById
						Description:
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
						Actions
							Return ListRights.GetIndexById(nId)
					! SP
					Function: populateAccSParams
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT SPList.Populate(hSql, sNbs)
								Return FALSE
							Return TRUE
					Function: saveAccSParams
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Return SPList.Update(hSql)
					Function: getSParamsParNum
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return SPList.nParNum
					Function: getSParamsValue
						Description:
						Returns
						Parameters
							Number: nIndex
							Receive Number: nSpId
							Receive String: sName
							Receive String: sValue
							Receive String: sSemantic
							Receive String: sType
							Receive String: sNsi
							Receive String: sPKName
							Receive String: sNsiSqlWhere
							Receive String: sOpt
							Receive Long String: sSqlVal
							Receive String: sTabColumnCheck
							! Receive String: sCode
						Static Variables
						Local variables
						Actions
							Set nSpId = SPList.List[nIndex].nSpId
							Set sName = SPList.List[nIndex].strName
							Set sValue = SPList.List[nIndex].strValue
							Set sSemantic = SPList.List[nIndex].strSemantic
							Set sType = SPList.List[nIndex].strType
							Set sNsi = SPList.List[nIndex].strNSI
							Set sPKName = SPList.List[nIndex].strPKName
							Set sNsiSqlWhere = SPList.List[nIndex].strNsiSqlWhere
							Set sOpt = SPList.List[nIndex].strOpt
							Set sSqlVal = SPList.List[nIndex].strSqlVal
							Set sTabColumnCheck = SPList.List[nIndex].strTabColumnCheck
							! Set sCode = SPList.List[nIndex].strCode
					Function: setSParamsValue
						Description:
						Returns
							Boolean:
						Parameters
							Number: nSpId
							String: sName
							String: sValue
						Static Variables
						Local variables
						Actions
							Call SPList.SetV(nSpId, sName, sValue)
							Return TRUE
					Function: getSParamsValueBySpId
						Description:
						Returns
							String:
						Parameters
							Number: nSpId
						Static Variables
						Local variables
							Number: nIndex
							String: sValue
						Actions
							Set sValue = ''
							Set nIndex = SPList.GetIndexBySpId(nSpId)
							If nIndex != -1
								Set sValue = SPList.List[nIndex].strValue
							Return sValue
					Function: setSParamsProfData
						Description:
						Returns
							Boolean:
						Parameters
							Number: nNbsProf
						Static Variables
						Local variables
						Actions
							If NOT SPList.SetProfData(hSql, sNbs, nNbsProf)
								Return FALSE
							Return TRUE
					Function: getSParamCode
						Description:
						Returns
							String:
						Parameters
							Number: nIndex
						Static Variables
						Local variables
						Actions
							If nIndex < 0 or nIndex > SPList.nParNum or SPList.nParNum = 0
								Return ''
							Return SPList.List[nIndex].strCode
					! Acrn
					Function: populateAccAcrn
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT ListAcrn.Populate(hSql)
								Return FALSE
							Return TRUE
					Function: saveAccAcrn
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							Return ListAcrn.Update(hSql)
					Function: getAcrnParNum
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return ListAcrn.nParNum
					Function: getAcrnParNumRatn
						Description:
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIndex
						Actions
							If nId != NUMBER_Null
								Set nIndex = ListAcrn.GetIndexById(nId)
							If nIndex = -1
								Return 0
							Return ListAcrn.List[nIndex].nRatnParNum
					Function: addAcrnRatn
						Description: Добавить значение
						Returns
							Boolean:
						Parameters
							Number: nId
							Date/Time: dBDat
							Number: nIr
							Number: nBr
							Number: nOp
							Receive Number: nRatnIndex
						Static Variables
						Local variables
						Actions
							Call ListAcrn.AddRatn(nId, dBDat, nIr, nBr, nOp, nRatnIndex)
							Return TRUE
					Function: dropAcrnRatn
						Description: Удалить значение
						Returns
							Boolean:
						Parameters
							Number: nId
							Number: nRatnIndex
						Static Variables
						Local variables
						Actions
							Call ListAcrn.DropRatn(nId, nRatnIndex)
							Return TRUE
					Function: getAcrnAccn
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
							Receive Number: nMetr
							Receive Number: nBaseM
							Receive Number: nBaseY
							Receive Number: nFreq
							Receive Date/Time: dStpDat
							Receive Date/Time: dAcrDat
							Receive Date/Time: dAplDat
							Receive String: sTt
							Receive Number: nAcrA
							Receive Number: nAcrB
							Receive String: sTtB
							Receive Number: nKvB
							Receive String: sNlsB
							Receive String: sNamB
							Receive String: sMfo
							Receive String: sOkpo
							Receive String: sNazn
							Receive Number: nIo
						Static Variables
						Local variables
						Actions
							Return ListAcrn.GetAccn(nId, nMetr, nBaseM, nBaseY, nFreq, dStpDat, dAcrDat, dAplDat, 
									sTt, nAcrA, nAcrB, sTtB, nKvB, sNlsB, sNamB, sMfo, sOkpo, sNazn, nIo)
					Function: setAcrnAccn
						Description:
						Returns
						Parameters
							Number: nId
							Number: nMetr
							Number: nBaseM
							Number: nBaseY
							Number: nFreq
							Date/Time: dStpDat
							Date/Time: dAcrDat
							Date/Time: dAplDat
							String: sTt
							Number: nAcrA
							Number: nAcrB
							String: sTtB
							Number: nKvB
							String: sNlsB
							String: sNamB
							String: sMfo
							String: sOkpo
							String: sNazn
							Number: nIo
						Static Variables
						Local variables
						Actions
							Call ListAcrn.SetAccn(nId, nMetr, nBaseM, nBaseY, nFreq, dStpDat, dAcrDat, dAplDat, 
									sTt, nAcrA, nAcrB, sTtB, nKvB, sNlsB, sNamB, sMfo, sOkpo, sNazn, nIo)
					Function: getAcrnRatn
						Description:
						Returns
						Parameters
							Number: nId
							Number: nRatnIndex
							Receive Date/Time: dBDat
							Receive Number: nIr
							Receive Number: nBr
							Receive Number: nOp
							Receive Boolean: bIns
							Receive Boolean: bUpd
							Receive Boolean: bDel
						Static Variables
						Local variables
						Actions
							Call ListAcrn.GetRatn(nId, nRatnIndex, dBDat, nIr, nBr, nOp, bIns, bUpd, bDel)
					Function: setAcrnRatn
						Description:
						Returns
						Parameters
							Number: nId
							Number: nRatnIndex
							! Date/Time: dBDat
							Date/Time: dBDatNew
							Number: nIr
							Number: nBr
							Number: nOp
						Static Variables
						Local variables
						Actions
							! Call ListAcrn.SetRatn(nId, dBDat, dBDatNew, nIr, nBr, nOp)
							Call ListAcrn.SetRatn(nId, nRatnIndex, dBDatNew, nIr, nBr, nOp)
					! Rates
					Function: populateAccRates
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT ListRates.Populate(hSql)
								Return FALSE
							Return TRUE
					Function: saveAccRates
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT ListRates.Update(hSql)
								Return FALSE
							Return TRUE
					Function: getRatesValue
						Description:
						Returns
						Parameters
							Number: nKod
							Receive Number: nTar
							Receive Number: nPr
							Receive Number: nSMin
							Receive Number: nKvSMin
							Receive Number: nSMax
							Receive Number: nKvSMax
							Receive Date/Time: dBDate
							Receive Date/Time: dEDate
						Static Variables
						Local variables
						Actions
							Set nTar    = ListRates.getTar(nKod)
							Set nPr     = ListRates.getPr(nKod)
							Set nSMin   = ListRates.getSMin(nKod)
							Set nKvSMin = ListRates.getKvSMin(nKod)
							Set nSMax   = ListRates.getSMax(nKod)
							Set nKvSMax = ListRates.getKvSMax(nKod)
							Set dBDate  = ListRates.getBDate(nKod)
							Set dEDate  = ListRates.getEDate(nKod)
					Function: setRatesValue
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Number: nTar
							Number: nPr
							Number: nSMin
							Number: nKvSMin
							Number: nSMax
							Number: nKvSMax
							Date/Time: dBDate
							Date/Time: dEDate
						Static Variables
						Local variables
						Actions
							Call ListRates.setTar(nKod,nTar)
							Call ListRates.setPr(nKod,nPr)
							Call ListRates.setSMin(nKod,nSMin)
							Call ListRates.setKvSMin(nKod,nKvSMin)
							Call ListRates.setSMax(nKod,nSMax)
							Call ListRates.setKvSMax(nKod,nKvSMax)
							Call ListRates.setBDate(nKod,dBDate)
							Call ListRates.setEDate(nKod,dEDate)
							Call ListRates.setFlagChg(nKod, TRUE)
							Return TRUE
					Function: delRatesValue
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
						Static Variables
						Local variables
						Actions
							Call ListRates.setFlagDel(nKod, TRUE)
							Return TRUE
					! Sob
					Function: populateAccSob
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT ListSob.Populate(hSql)
								Return FALSE
							Return TRUE
					Function: saveAccSob
						Description:
						Returns
							Boolean:
						Parameters
						Static Variables
						Local variables
						Actions
							If NOT ListSob.Update(hSql)
								Return FALSE
							Return TRUE
					Function: getSobParNum
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return ListSob.nParNum
					Function: getSobValue
						Description:
						Returns
						Parameters
							Number: nIndex
							Receive Number: nId
							Receive Number: nIsp
							Receive String: sFio
							Receive Date/Time: dDat
							Receive Long String: sTxt
						Static Variables
						Local variables
						Actions
							Set nId  = ListSob.getId(nIndex)
							Set nIsp = ListSob.getIsp(nIndex)
							Set sFio = ListSob.getFio(nIndex)
							Set dDat = ListSob.getDat(nIndex)
							Set sTxt = ListSob.getTxt(nIndex)
					Function: setSobValue
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
							Number: nIsp
							Date/Time: dDat
							Long String: sTxt
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = ListSob.getIndexById(nId)
							! update
							If nIndex != -1
								If NOT ListSob.setIsp(nIndex,nIsp) 
										OR NOT ListSob.setDat(nIndex,dDat)
										OR NOT ListSob.setTxt(nIndex,sTxt)
									Return FALSE
							! insert
							Else
								If NOT ListSob.Insert(hSql,nIsp,dDat,sTxt)
									Return FALSE
							Return TRUE
					!
					Function: getRnk
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nRnk
					Function: setRnk
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nRnk = nVal
							Return TRUE
					Function: getAcc
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nAcc
					Function: setAcc
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nAcc = nVal
							Call SPList.Assign(nAcc)
							Return TRUE
					Function: getProcMfo
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nProcMfo
					Function: setProcMfo
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nProcMfo = nVal
							Return TRUE
					Function: getNls
						Description:
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return sNls
					Function: setNls
						Description:
						Returns
							Boolean:
						Parameters
							String: sVal
						Static Variables
						Local variables
						Actions
							Set sNls = sVal
							Return TRUE
					Function: getNlsAlt
						Description:
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return sNlsAlt
					Function: setNlsAlt
						Description:
						Returns
							Boolean:
						Parameters
							String: sVal
						Static Variables
						Local variables
						Actions
							Set sNlsAlt = sVal
							Return TRUE
					Function: getKv
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nKv
					Function: setKv
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nKv = nVal
							Return TRUE
					Function: getNbs
						Description:
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return sNbs
					Function: setNbs
						Description:
						Returns
							Boolean:
						Parameters
							String: sVal
						Static Variables
						Local variables
						Actions
							Set sNbs = sVal
							Return TRUE
					! OB22
					Function: getOB22
						Description:
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return sOB22
					Function: setOB22
						Description:
						Returns
							Boolean:
						Parameters
							String: sVal
						Static Variables
						Local variables
						Actions
							Set sOB22 = sVal
							Return TRUE
					Function: chkNbsHasOB22
						Description:
						Returns
						Parameters
						Static Variables
						Local variables
						Actions
							If ( sNbs = STRING_Null )
								Return TRUE
							Else
								Call SqlPrepareAndExecute( hSql,
										"select OB22
										   from BARS.SB_OB22
										  where lnnvl( D_OPEN > gl.bd() )
										    and lnnvl( D_CLOSE <= gl.bd() )
										    and R020 = :sNbs" )
								If SqlFetchNext( hSql, nFetchRes )
									Return TRUE
								Else
									Return FALSE
					! Nms
					Function: getNms
						Description:
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return sNms
					Function: setNms
						Description:
						Returns
							Boolean:
						Parameters
							String: sVal
						Static Variables
						Local variables
						Actions
							Set sNms = sVal
							Return TRUE
					Function: getPap
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nPap
					Function: setPap
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nPap = nVal
							Return TRUE
					Function: getTip
						Description:
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return sTip
					Function: setTip
						Description:
						Returns
							Boolean:
						Parameters
							String: sVal
						Static Variables
						Local variables
						Actions
							Set sTip = sVal
							Return TRUE
					Function: getVid
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nVid
					Function: setVid
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nVid = nVal
							Return TRUE
					Function: getPos
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nPos
					Function: setPos
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nPos = nVal
							Return TRUE
					Function: getTobo
						Description:
						Returns
							String:
						Parameters
						Static Variables
						Local variables
						Actions
							Return sTobo
					Function: setTobo
						Description:
						Returns
							Boolean:
						Parameters
							String: sVal
						Static Variables
						Local variables
						Actions
							Set sTobo = sVal
							Return TRUE
					Function: getDaos
						Description:
						Returns
							Date/Time:
						Parameters
						Static Variables
						Local variables
						Actions
							Return dDaos
					Function: setDaos
						Description:
						Returns
							Boolean:
						Parameters
							Date/Time: dVal
						Static Variables
						Local variables
						Actions
							Set dDaos = dVal
							Return TRUE
					Function: getDazs
						Description:
						Returns
							Date/Time:
						Parameters
						Static Variables
						Local variables
						Actions
							Return dDazs
					Function: setDazs
						Description:
						Returns
							Boolean:
						Parameters
							Date/Time: dVal
						Static Variables
						Local variables
						Actions
							Set dDazs = dVal
							Return TRUE
					Function: getDapp
						Description:
						Returns
							Date/Time:
						Parameters
						Static Variables
						Local variables
						Actions
							Return dDapp
					Function: setDapp
						Description:
						Returns
							Boolean:
						Parameters
							Date/Time: dVal
						Static Variables
						Local variables
						Actions
							Set dDapp = dVal
							Return TRUE
					Function: getMDate
						Description:
						Returns
							Date/Time:
						Parameters
						Static Variables
						Local variables
						Actions
							Return dMDate
					Function: setMDate
						Description:
						Returns
							Boolean:
						Parameters
							Date/Time: dVal
						Static Variables
						Local variables
						Actions
							Set dMDate = dVal
							Return TRUE
					Function: getBlkd
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nBlkd
					Function: setBlkd
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nBlkd = nVal
							Return TRUE
					Function: getBlkk
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nBlkk
					Function: setBlkk
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nBlkk = nVal
							Return TRUE
					Function: getIsp
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nIsp
					Function: setIsp
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nIsp = nVal
							Return TRUE
					Function: getGrp
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nGrp
					Function: setGrp
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nGrp = nVal
							Return TRUE
					Function: getSeci
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nSeci
					Function: setSeci
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nSeci = nVal
							Return TRUE
					Function: getSeco
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nSeco
					Function: setSeco
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nSeco = nVal
							Return TRUE
					Function: getOstc
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nOstc
					Function: getOstb
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nOstb
					Function: getOstf
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nOstf
					Function: getOstq
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nOstq
					Function: getDos
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nDos
					Function: getKos
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nKos
					Function: getDosq
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nDosq
					Function: getKosq
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nKosq
					Function: getLim
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nLim
					Function: setLim
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nLim = nVal
							Return TRUE
					Function: getOstx
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nOstx
					Function: setOstx
						Description:
						Returns
							Boolean:
						Parameters
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set nOstx = nVal
							Return TRUE
			Functional Class: cAccRights
				Description: Описание спецпараметра
				Derived From
				Class Variables
				Instance Variables
					Number: nId
					String: strName
					Number: nPr
				Functions
			Functional Class: cAccRightsList
				Description:
				Derived From
				Class Variables
				Instance Variables
					Number: nAcc
					: List[*]
						Class: cAccRights
					Number: nParNum
					Boolean: isEdit
					Number: nFetchRes
				Functions
					Function: Init
						Description: Конструктор
						Returns
							Boolean:
						Parameters
							Number: nAccId
						Static Variables
						Local variables
						Actions
							Set nParNum = 0
							Set isEdit  = FALSE
							Set nAcc    = nAccId
							Return TRUE
					Function: Assign
						Description: Назначить идентификатор счета
						Returns
							Boolean:
						Parameters
							Number: nAccId
						Static Variables
						Local variables
						Actions
							Set nAcc = nAccId
							Return TRUE
					Function: Populate
						Description: Населить данными из базы
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Number: nId
							String: sName
						Actions
							Set nParNum = 0
							If NOT SqlPrepareAndExecute(hSql,
									"SELECT g.id, g.name
									   INTO :nId, :sName
									   FROM groups_acc g, table(sec.getAgrp(:nAcc)) b
									  WHERE g.id=b.column_value
									  ORDER BY g.id" )
								Return FALSE
							While SqlFetchNext(hSql, nFetchRes)
								Set List[nParNum].nId     = nId
								Set List[nParNum].strName = sName
								Set List[nParNum].nPr     = 0
								Set nParNum = nParNum + 1
							Return TRUE
					Function: Update
						Description: Сохранить значения в базе данных
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Number: nIterator
							Number: nId
							Number: nPr
						Actions
							Set nIterator = 0
							While nIterator < nParNum
								Set nId = List[nIterator].nId
								Set nPr = List[nIterator].nPr
								If nPr = 1
									If NOT SqlPLSQLCommand(hSql,
											"sec.addAgrp(nAcc, nId)")
										Return FALSE
								Else If nPr = -1
									If NOT SqlPLSQLCommand(hSql,
											"sec.delAgrp(nAcc, nId)")
										Return FALSE
									Set List[nIterator].nId = NUMBER_Null
									Set List[nIterator].strName = ''
								Set List[nIterator].nPr = 0
								Set nIterator = nIterator + 1
							Return TRUE
					Function: Add
						Description: Добавить значение
						Returns
							Boolean:
						Parameters
							Number: nId
							String: sName
						Static Variables
						Local variables
						Actions
							Set List[nParNum].nId     = nId
							Set List[nParNum].strName = sName
							Set List[nParNum].nPr     = 1
							Set nParNum = nParNum + 1
							Return TRUE
					Function: Drop
						Description: Удалить значение
						Returns
							Boolean:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = GetIndexById(nId)
							If nIndex != -1
								Set List[nIndex].nPr = -1
							Return TRUE
					Function: GetIndexById
						Description: получить индекс параметра в массиве по id
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
							Boolean: fFound
						Actions
							If NOT nId
								Return -1
							Set nIterator = 0
							While nIterator < nParNum
								If List[nIterator].nId = nId
									Set fFound = TRUE
									Break
								Set nIterator = nIterator + 1
							If fFound
								Return nIterator
							Else
								Return -1
			Functional Class: cAccRates
				Description:
				Derived From
				Class Variables
				Instance Variables
					Number: nKod
					Number: nTar
					Number: nPr
					Number: nSMin
					Number: nKvSMin
					Number: nSMax
					Number: nKvSMax
					Date/Time: dBDate
					Date/Time: dEDate
					Boolean: bDelete
					Boolean: bChange
				Functions
			Functional Class: cAccRatesList
				Description:
				Derived From
				Class Variables
				Instance Variables
					Number: nAcc
					: List[*]
						Class: cAccRates
					Number: nParNum
					Number: nFetchRes
				Functions
					Function: Init
						Description: Конструктор
						Returns
							Boolean:
						Parameters
							Number: nAccId
						Static Variables
						Local variables
						Actions
							Set nParNum = 0
							Set nAcc    = nAccId
							Return TRUE
					Function: Populate
						Description: Населить данными из базы
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Number: nKod
							Number: nTar
							Number: nPr
							Number: nSMin
							Number: nKvSMin
							Number: nSMax
							Number: nKvSMax
							Date/Time: dBDate
							Date/Time: dEDate
						Actions
							Set nParNum = 0
							If NOT SqlPrepareAndExecute(hSql,
									"SELECT a.kod, a.tar, a.pr, a.smin, a.kv_smin, a.smax, a.kv_smax, a.bdate, a.edate 
									   INTO :nKod, :nTar, :nPr, :nSMin, :nKvSMin, :nSMax, :nKvSMax, :dBDate, :dEDate 
									   FROM v_acc_tarif a
									  WHERE a.acc = :nAcc")
								Return FALSE
							While SqlFetchNext(hSql, nFetchRes)
								Set List[nParNum].nKod    = nKod
								Set List[nParNum].nTar    = nTar
								Set List[nParNum].nPr     = nPr
								Set List[nParNum].nSMin   = nSMin
								Set List[nParNum].nKvSMin = nKvSMin
								Set List[nParNum].nSMax   = nSMax
								Set List[nParNum].nKvSMax = nKvSMax
								Set List[nParNum].dBDate  = dBDate
								Set List[nParNum].dEDate  = dEDate
								Set List[nParNum].bChange = FALSE
								Set List[nParNum].bDelete = FALSE
								Set nParNum = nParNum + 1
							Return TRUE
					Function: Update
						Description:
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Number: nIterator
							Number: nExist
							Number: nKod
							Number: nTar
							Number: nPr
							Number: nSMin
							Number: nKvSMin
							Number: nSMax
							Number: nKvSMax
							Date/Time: dBDate
							Date/Time: dEDate
						Actions
							Set nIterator = 0
							While nIterator < nParNum
								Set nExist  = 0
								Set nKod    = List[nIterator].nKod
								Set nTar    = List[nIterator].nTar
								Set nPr     = List[nIterator].nPr
								Set nSMin   = List[nIterator].nSMin
								Set nKvSMin = List[nIterator].nKvSMin
								Set nSMax   = List[nIterator].nSMax
								Set nKvSMax = List[nIterator].nKvSMax
								Set dBDate  = List[nIterator].dBDate
								Set dEDate  = List[nIterator].dEDate
								! Удаление
								If List[nIterator].bDelete
									If NOT Delete(hSql, nKod)
										Return FALSE
								! Добавление/изменение
								Else If List[nIterator].bChange
									! Проверка: есть ли в таблице данные
									If NOT SqlPrepareAndExecute(hSql, "SELECT acc INTO :nExist FROM acc_tarif WHERE acc=:nAcc AND kod=:nKod")
										Return FALSE
									Call SqlFetchNext(hSql, nFetchRes)
									If NOT nExist
										If List[nIterator].nTar  != NUMBER_Null AND
												   List[nIterator].nPr   != NUMBER_Null 
											If NOT SqlPrepareAndExecute( hSql,
													"INSERT INTO acc_tarif(acc, kod, tar, pr, smin, kv_smin, smax, kv_smax, bdate, edate) 
													 VALUES (:nAcc, :nKod, :nTar, :nPr, :nSMin, :nKvSMin, :nSMax, :nKvSMax, :dBDate, :dEDate)" )
												Return FALSE
									! Запись с Acc и Kod в хранилище есть
									If nExist
										! Если новое значение пустое - удаляем
										If List[nIterator].nTar   = NUMBER_Null AND
												   List[nIterator].nPr    = NUMBER_Null AND
												   List[nIterator].nSMin  = NUMBER_Null AND
												   List[nIterator].nSMax  = NUMBER_Null AND
												   List[nIterator].dBDate = DATETIME_Null AND
												   List[nIterator].dEDate = DATETIME_Null
											If NOT Delete(hSql, List[nIterator].nKod)
												Return FALSE
										! Обновляем значение
										Else
											If NOT SqlPrepareAndExecute(hSql,
													"UPDATE acc_tarif
													    SET tar     = nvl(:nTar,tar),
													        pr      = nvl(:nPr,pr),
													        smin    = :nSMin,
													        kv_smin = :nKvSMin,
													        smax    = :nSMax,
													        kv_smax = :nKvSMax,
													        bdate   = :dBDate,
													        edate   = :dEDate 
													  WHERE acc = :nAcc AND kod = :nKod")
												Return FALSE
								Set nIterator = nIterator + 1
							Return TRUE
					Function: Delete
						Description:
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
							Number: nKod
						Static Variables
						Local variables
						Actions
							If NOT SqlPrepareAndExecute(hSql, "DELETE FROM acc_tarif WHERE acc = :nAcc AND kod = :nKod")
								Return FALSE
							Return TRUE
					Function: getParNum
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nParNum
					Function: getIndexByKod
						Description: получить индекс параметра в массиве по имени
						Returns
							Number:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIterator
							Boolean: fFound
						Actions
							If NOT nKod
								Return -1
							Set nIterator = 0
							While nIterator < nParNum
								If List[nIterator].nKod = nKod
									Set fFound = TRUE
									Break
								Set nIterator = nIterator + 1
							If fFound
								Return nIterator
							Else
								Return -1
					!
					Function: getTar
						Description: Получить значение по имени параметра
						Returns
							Number:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod( nKod )
							If nIndex = -1
								Return NUMBER_Null
							Else
								Return List[nIndex].nTar
					Function: setTar
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Number: nVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].nTar = nVal
							Return TRUE
					Function: getPr
						Description: Получить значение по имени параметра
						Returns
							Number:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod( nKod )
							If nIndex = -1
								Return NUMBER_Null
							Else
								Return List[nIndex].nPr
					Function: setPr
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Number: nVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].nPr = nVal
							Return TRUE
					Function: getSMin
						Description: Получить значение по имени параметра
						Returns
							Number:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod( nKod )
							If nIndex = -1
								Return NUMBER_Null
							Else
								Return List[nIndex].nSMin
					Function: setSMin
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Number: nVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].nSMin = nVal
							Return TRUE
					Function: getKvSMin
						Description: Получить значение по имени параметра
						Returns
							Number:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod( nKod )
							If nIndex = -1
								Return NUMBER_Null
							Else
								Return List[nIndex].nKvSMin
					Function: setKvSMin
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Number: nVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].nKvSMin = nVal
							Return TRUE
					Function: getSMax
						Description: Получить значение по имени параметра
						Returns
							Number:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod( nKod )
							If nIndex = -1
								Return NUMBER_Null
							Else
								Return List[nIndex].nSMax
					Function: setSMax
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Number: nVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].nSMax = nVal
							Return TRUE
					Function: getKvSMax
						Description: Получить значение по имени параметра
						Returns
							Number:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod( nKod )
							If nIndex = -1
								Return NUMBER_Null
							Else
								Return List[nIndex].nKvSMax
					Function: setKvSMax
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Number: nVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].nKvSMax = nVal
							Return TRUE
					Function: getBDate
						Description: Получить значение по имени параметра
						Returns
							Date/Time:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod( nKod )
							If nIndex = -1
								Return DATETIME_Null
							Else
								Return List[nIndex].dBDate
					Function: setBDate
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Date/Time: dVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].dBDate = dVal
							Return TRUE
					Function: getEDate
						Description: Получить значение по имени параметра
						Returns
							Date/Time:
						Parameters
							Number: nKod
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod( nKod )
							If nIndex = -1
								Return DATETIME_Null
							Else
								Return List[nIndex].dEDate
					Function: setEDate
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Date/Time: dVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].dEDate = dVal
							Return TRUE
					Function: setFlagChg
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Boolean: bVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].bChange = bVal
							Return TRUE
					Function: setFlagDel
						Description:
						Returns
							Boolean:
						Parameters
							Number: nKod
							Boolean: bVal
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = getIndexByKod(nKod)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].bDelete = bVal
							Return TRUE
			Functional Class: cAccSob
				Description:
				Derived From
				Class Variables
				Instance Variables
					Number: nId
					Number: nIsp
					String: sFio
					Date/Time: dDat
					Long String: sTxt
				Functions
			Functional Class: cAccSobList
				Description:
				Derived From
				Class Variables
				Instance Variables
					Number: nAcc
					: List[*]
						Class: cAccSob
					Number: nParNum
					Number: nFetchRes
				Functions
					Function: Init
						Description: Конструктор
						Returns
							Boolean:
						Parameters
							Number: nAccId
						Static Variables
						Local variables
						Actions
							Set nParNum = 0
							Set nAcc    = nAccId
							Return TRUE
					Function: Populate
						Description: Населить данными из базы
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Number: nId
							Number: nIsp
							String: sFio
							Date/Time: dDat
							Long String: sTxt
						Actions
							Set nParNum = 0
							If NOT SqlPrepareAndExecute( hSql,
									"SELECT a.fdat, a.id, a.isp, s.fio, a.txt 
									 INTO :dDat, :nId, :nIsp, :sFio, :sTxt
									 FROM acc_sob a, staff$base s
									 WHERE a.isp=s.id AND a.acc=:nAcc 
									 ORDER BY a.fdat, a.id")
								Return FALSE
							While SqlFetchNext( hSql, nFetchRes )
								Set List[nParNum].nId  = nId
								Set List[nParNum].nIsp = nIsp
								Set List[nParNum].sFio = sFio
								Set List[nParNum].dDat = dDat
								Set List[nParNum].sTxt = sTxt
								Set nParNum = nParNum + 1
							Return TRUE
					Function: Insert
						Description:
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
							Number: nIsp
							Date/Time: dDat
							Long String: sTxt
						Static Variables
						Local variables
						Actions
							If NOT SqlPrepareAndExecute(hSql,
									"INSERT INTO acc_sob(acc,isp,fdat,txt) 
									 VALUES(:nAcc,:nIsp,:dDat,:sTxt)")
								Return FALSE
							Return TRUE
					Function: Update
						Description: Сохранить значения в базе данных
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Number: nId
							Number: nIsp
							Date/Time: dDat
							Long String: sTxt
							Number: nIterator
						Actions
							Set nIterator = 0
							While nIterator < nParNum
								! Если новые значения пустые - удаляем
								If List[nIterator].nIsp = NUMBER_Null AND
										   List[nIterator].dDat = DATETIME_Null AND
										   List[nIterator].sTxt = STRING_Null 
									If NOT Delete(hSql, List[nIterator].nId)
										Return FALSE
								! Обновляем значение
								Else
									Set nId  = List[nIterator].nId
									Set nIsp = List[nIterator].nIsp
									Set dDat = List[nIterator].dDat
									Set sTxt = List[nIterator].sTxt
									If NOT SqlPrepareAndExecute( hSql,
											"UPDATE acc_sob
											 SET isp=:nIsp, fdat=:dDat, txt=:sTxt 
											 WHERE acc=:nAcc AND id=:nId" )
										Return FALSE
								Set nIterator = nIterator + 1
							Call Populate(hSql)
							Return TRUE
					Function: Delete
						Description:
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
							Number: nId
						Static Variables
						Local variables
						Actions
							If NOT SqlPrepareAndExecute(hSql,
									"DELETE FROM acc_sob WHERE acc=:nAcc AND id=:nId")
								Return FALSE
							Return TRUE
					Function: getParNum
						Description:
						Returns
							Number:
						Parameters
						Static Variables
						Local variables
						Actions
							Return nParNum
					Function: getIndexById
						Description: получить индекс параметра в массиве по Id
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
							Boolean: fFound
						Actions
							If NOT nId
								Return -1
							Set nIterator = 0
							While nIterator < nParNum
								If List[nIterator].nId = nId
									Set fFound = TRUE
									Break
								Set nIterator = nIterator + 1
							If fFound
								Return nIterator
							Else
								Return -1
					!
					Function: getIsp
						Description: Получить значение по индексу
						Returns
							Number:
						Parameters
							Number: nIndex
						Static Variables
						Local variables
						Actions
							Return List[nIndex].nIsp
					Function: setIsp
						Description:
						Returns
							Boolean:
						Parameters
							Number: nIndex
							Number: nVal
						Static Variables
						Local variables
						Actions
							Set List[nIndex].nIsp = nVal
							Return TRUE
					Function: getDat
						Description: Получить значение по имени параметра
						Returns
							Date/Time:
						Parameters
							Number: nIndex
						Static Variables
						Local variables
						Actions
							Return List[nIndex].dDat
					Function: setDat
						Description:
						Returns
							Boolean:
						Parameters
							Number: nIndex
							Date/Time: dVal
						Static Variables
						Local variables
						Actions
							Set List[nIndex].dDat = dVal
							Return TRUE
					Function: getTxt
						Description: Получить значение по индексу
						Returns
							String:
						Parameters
							Number: nIndex
						Static Variables
						Local variables
						Actions
							Return List[nIndex].sTxt
					Function: setTxt
						Description:
						Returns
							Boolean:
						Parameters
							Number: nIndex
							String: sVal
						Static Variables
						Local variables
						Actions
							Set List[nIndex].sTxt = sVal
							Return TRUE
					!
					Function: getId
						Description: Получить значение по индексу
						Returns
							Number:
						Parameters
							Number: nIndex
						Static Variables
						Local variables
						Actions
							Return List[nIndex].nId
					Function: getFio
						Description: Получить значение по индексу
						Returns
							String:
						Parameters
							Number: nIndex
						Static Variables
						Local variables
						Actions
							Return List[nIndex].sFio
			! Класс для работы со спецпараметрами
			! Рассчитан на таблицу описания спецпараметров
			Functional Class: cSParam
				Description: Описание спецпараметра
				Derived From
				Class Variables
				Instance Variables
					Number: nSpId
					String: strName
					String: strSemantic
					String: strStorage
					String: strNSI
					String: strValue
					String: strType
					String: strPKName
					Boolean: fDelOnNULL
					String: strNsiSqlWhere
					String: strOpt
					Long String: strSqlVal
					String: strSqlCondition
					String: strTag
					String: strTabColumnCheck
					String: strCode
					Boolean: fHist
					Boolean: fUpdate
				Functions
			Functional Class: cSParamList
				Description: Список спецпараметров
				Derived From
				Class Variables
				Instance Variables
					Number: nAcc
					: List[*]
						Class: cSParam
					Number: nParNum
					Boolean: isEdit
					Number: nFetchRes
				Functions
					Function: Init
						Description: Конструктор
						Returns
							Boolean:
						Parameters
							Number: nAccId
						Static Variables
						Local variables
						Actions
							Set nParNum = 0
							Set isEdit  = FALSE
							Set nAcc    = nAccId
							Return TRUE
					Function: Assign
						Description: Назначить идентификатор счета
						Returns
							Boolean:
						Parameters
							Number: nAccId
						Static Variables
						Local variables
						Actions
							Set nAcc = nAccId
							Return TRUE
					Function: Populate
						Description: Населить данными из базы
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
							String: sNbs
						Static Variables
						Local variables
							Long String: strSqlSelect
							Number: nSpId			! Идентификатор Параметра
							String: strPName		! Наименование
							String: strPSem			! Описание
							String: strPVal			! Значение
							String: sPVal			! Значение (строковый тип)
							Long String: lsPVal		! Значение (длинная строка)
							Number: nPVal			! Значение (число)
							Date/Time: dPVal		! Значение (дата)
							String: strPTab			! Имя таблицы хранилища параметра
							String: strPNSI			! Имя таблицы справочника
							String: strPType		! Тип параметра
							String: strPNamePK		! Ключ
							Number: nDelOnNull		! Флаг: удалять строку из справочника если значение спецпар-ра is null
							String: sNsiSqlWhere
							String: strOpt
							Long String: strSqlVal		! Условие фильтра для справочника
							String: strSqlCondition		! Условие для отбора параметра
							String: strTag			! Наименование поля (из accounts_field)
							String: strTabColumnCheck	! Контроль значения по полю
							String: strCode
							Boolean: fHist
							!
							Number: nIterator
							Number: nCount
							Number: nCond
						Actions
							! для sNBS != ''
							Set nParNum = 0
							If NOT SqlPrepareAndExecute(hSql, "SELECT count(*) INTO :nCount FROM ps_sparam WHERE nbs=:sNbs")
								Return FALSE
							If NOT SqlFetchNext(hSql, nFetchRes)
								Return FALSE
							If nCount != 0
								Set strSqlSelect = 
										"SELECT DISTINCT l.spid, l.name, l.semantic, upper(l.tabname), upper(rtrim(l.type)), 
										        upper(l.nsiname), upper(l.pkname), l.delonnull, upper(l.nsisqlwhere), 
										        s.opt, s.sqlval, l.sqlcondition, l.tag, l.tabcolumn_check, l.code, nvl(l.hist,0)
										   INTO :nSpId, :strPName, :strPSem, :strPTab, :strPType, 
										        :strPNSI, :strPNamePK, :nDelOnNull, :sNsiSqlWhere, 
										        :strOpt, :strSqlVal, :strSqlCondition, :strTag, :strTabColumnCheck, :strCode, :fHist
										   FROM sparam_list l, ps_sparam s, ps p 
										  WHERE p.nbs=:sNbs AND p.nbs=s.nbs AND s.spid=l.spid AND l.inuse = 1 
										  order by s.opt, l.semantic"
								Call SqlSetLongBindDatatype(10, 22)
							Else
								Set strSqlSelect = 
										"SELECT spid, name, semantic, upper(tabname), upper(rtrim(type)), 
										        upper(nsiname), upper(pkname), delonnull, upper(nsisqlwhere), 
										        '', sqlcondition, tag, tabcolumn_check, code, hist
										   INTO :nSpId, :strPName, :strPSem, :strPTab, :strPType, 
										        :strPNSI, :strPNamePK, :nDelOnNull, :sNsiSqlWhere, 
										        :strOpt, :strSqlCondition, :strTag, :strTabColumnCheck, :strCode, :fHist
										   FROM sparam_list WHERE inuse = 1 
										  order by semantic"
							If NOT SqlPrepareAndExecute(hSql, strSqlSelect)
								Return FALSE
							While SqlFetchNext(hSql, nFetchRes)
								Set nCond = 1
								If strSqlCondition
									If NOT SqlPrepareAndExecute(hSqlAux(),
											"SELECT count(*) INTO :nCond 
											 FROM accounts a 
											 WHERE a.acc=:nAcc AND (" || strSqlCondition || ")")
										Return FALSE
									Call SqlFetchNext(hSqlAux(), nFetchRes)
								If nCond != 0
									! Защита от дурака
									If strPTab = 'ACCOUNTSW' and strTag = ''
										Call SalMessageBox('Некорректно заполнен справочник спецпараметров счетов!', 'Внимание!', MB_IconExclamation | MB_Ok)
										Return FALSE
									Set List[nParNum].nSpId = nSpId
									Set List[nParNum].strName = strPName
									Set List[nParNum].strSemantic = strPSem
									Set List[nParNum].strType = strPType
									Set List[nParNum].strStorage = strPTab
									Set List[nParNum].strNSI = strPNSI
									Set List[nParNum].strPKName = strPNamePK
									Set List[nParNum].fDelOnNULL = nDelOnNull
									Set List[nParNum].strNsiSqlWhere = sNsiSqlWhere
									Set List[nParNum].strOpt = strOpt
									Set List[nParNum].strSqlVal = IifS(nCount!=0,strSqlVal,'')
									Set List[nParNum].strTag = strTag
									Set List[nParNum].strTabColumnCheck = strTabColumnCheck
									Set List[nParNum].strCode = strCode
									Set List[nParNum].fHist = fHist
									Set List[nParNum].fUpdate = FALSE
									Set nParNum = nParNum + 1
							!
							Set nIterator = 0
							While nIterator < nParNum
								If List[nIterator].fHist
									Set strPVal = 'sPVal'
								Else If List[nIterator].strTag != ''
									Set strPVal = 'sPVal'
								Else If List[nIterator].strType = 'N'
									Set strPVal = 'nPVal'
								Else If List[nIterator].strType = 'D'
									Set strPVal = 'dPVal'
								Else If List[nIterator].strType = 'L'
									Set strPVal = 'lsPVal'
									Call SqlSetLongBindDatatype(1, 22)
								Else
									Set strPVal = 'sPVal'
								If SqlPrepareAndExecute(hSql,
										"SELECT " || List[nIterator].strName || " INTO :" || strPVal || " FROM " || List[nIterator].strStorage ||
										" WHERE acc=:nAcc" || 
										        IifS(List[nIterator].fHist=1, " and parid = " || Str(List[nIterator].nSpId) || " and bankdate between dat1 and dat2",
										        IifS(List[nIterator].strTag='', "", " AND tag='" || List[nIterator].strTag || "'")))
									If SqlFetchNext(hSql, nFetchRes)
										If List[nIterator].fHist
											Set List[nIterator].strValue = sPVal
										Else If List[nIterator].strTag != ''
											Set List[nIterator].strValue = sPVal
										Else If List[nIterator].strType = 'N'
											Set List[nIterator].strValue = Str(nPVal)
										Else If List[nIterator].strType = 'D'
											Set List[nIterator].strValue = SalFmtFormatDateTime(dPVal, 'dd/MM/yyyy')
										Else If List[nIterator].strType = 'L'
											Set List[nIterator].strValue = lsPVal
										Else
											Set List[nIterator].strValue = sPVal
									Else
										Set List[nIterator].strValue = ""
								Set nIterator = nIterator + 1
							Return TRUE
					Function: Update
						Description: Сохранить значения в базе данных
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Number: nIterator
							String: strProcedure
							! String: strPVal
							! String: sPVal			! Значение (строковый тип)
							! Long String: lsPVal		! Значение (длинная строка)
							! Number: nPVal			! Значение (число)
							! Date/Time: dPVal		! Значение (дата)
							!
							! Number: nExist
							! String: strUsedStorage
						Actions
							Set nIterator = 0
							While nIterator < nParNum
								If List[nIterator].fHist
								Else If List[nIterator].fUpdate
									If List[nIterator].strTag = ''
										Set strProcedure = "accreg.setAccountSParam(nAcc, List[nIterator].strName, List[nIterator].strValue)"
									Else
										Set strProcedure = "accreg.setAccountwParam(nAcc, List[nIterator].strTag, List[nIterator].strValue)"
									If NOT SqlPLSQLCommand(hSql, strProcedure)
										Return FALSE
									Set List[nIterator].fUpdate = FALSE
									!
									! Set nExist = 0
									! If NOT SqlPrepareAndExecute(hSql, 
											"SELECT acc INTO :nExist FROM " || List[nIterator].strStorage || " 
											  WHERE acc=:nAcc" || IifS(List[nIterator].strTag='', "", 
											"   AND tag='" || List[nIterator].strTag || "'"))
										           Return FALSE
									! Call SqlFetchNext(hSql, nFetchRes)
									! If NOT nExist
										           If List[nIterator].strValue != ''
											           If not SqlPrepareAndExecute(hSql, 
													"INSERT INTO " || List[nIterator].strStorage || " (acc" || IifS(List[nIterator].strTag='', "", ",tag") || ") 
													 VALUES (:nAcc" || IifS(List[nIterator].strTag='', "", ",'" || List[nIterator].strTag || "'") || ")" )
												           Return FALSE
											           Set nExist = 1
									! Запись с Acc в хранилище есть
									! If nExist
										! Обновление пустым значением и признак удаления пустых - нужно удалять
										           If List[nIterator].strValue = '' AND List[nIterator].fDelOnNULL
											! Ранее не было обновлено значений
											           If SalStrScan(strUsedStorage, List[nIterator].strStorage || ';') = -1
												           If NOT SqlPrepareAndExecute(hSql, 
														"DELETE FROM " || List[nIterator].strStorage || " 
														 WHERE acc=:nAcc" || IifS(List[nIterator].strTag='', "", 
														"  AND tag='" || List[nIterator].strTag || "'") )
													           Return FALSE
										! Обновляем значение
										           Else 
											! если List[nIterator].strTag != '', сохраняем в табл. типа accountsw и value = STRING, т.е. нам нужна переменная типа string
											           If List[nIterator].strType = 'N' and List[nIterator].strTag = ''
												           Set strPVal = 'nPVal'
												           Set nPVal = SalStrToNumber(List[nIterator].strValue)
												           If List[nIterator].strValue = ''
													           Set nPVal = NUMBER_Null
											           Else If List[nIterator].strType = 'D' and List[nIterator].strTag = ''
												           Set strPVal = 'dPVal'
												           Set dPVal = SalStrToDate(List[nIterator].strValue)
											           Else If List[nIterator].strType = 'L' and List[nIterator].strTag = ''
												           Set strPVal = 'lsPVal'
												           Set lsPVal = List[nIterator].strValue
												           Call SqlSetLongBindDatatype(1, 22)
											           Else 
												           Set strPVal = 'sPVal'
												           Set sPVal = List[nIterator].strValue
											           If NOT SqlPrepareAndExecute(hSql,
													"UPDATE " || List[nIterator].strStorage || " SET " || List[nIterator].strName || "=:" || strPVal || "
													  WHERE acc=:nAcc" || IifS(List[nIterator].strTag='', "", 
													"   AND tag='" || List[nIterator].strTag || "'"))
												           Return FALSE
											           If SalStrScan(strUsedStorage, List[nIterator].strStorage || ';') = -1 and List[nIterator].strTag = ''
												           Set strUsedStorage = strUsedStorage || List[nIterator].strStorage || ';'
								Set nIterator = nIterator + 1
							Return TRUE
					Function: GetV
						Description: Получить значение по имени параметра
						Returns
							String:
						Parameters
							String: strName
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = GetIndexByName( strName )
							If nIndex = -1
								Return ''
							Else
								Return List[nIndex].strValue
					Function: SetV
						Description:
						Returns
							Boolean:
						Parameters
							Number: nSpId
							String: strName
							String: strValue
						Static Variables
						Local variables
							Number: nIndex
						Actions
							If nSpId
								Set nIndex = GetIndexBySpId(nSpId)
							Else
								Set nIndex = GetIndexByName(strName)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].strValue = strValue
							Set List[nIndex].fUpdate  = TRUE
							Return TRUE
					Function: SetProfData
						Description:
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
							String: sNbs
							Number: nNbsProf
						Static Variables
						Local variables
							Number: nIterator
							Number: nExist
							Number: nProfId
							String: sProfVal
							Long String: sProfSql
							String: sValue
						Actions
							Call SqlPrepareAndExecute(hSqlAux2(),
									"SELECT v.id, v.val, v.sql_text 
									 INTO :nProfId, :sProfVal, :sProfSql 
									 FROM v_nbs_prof v, sparam_list s
									 WHERE v.nbs=:sNbs AND v.np=:nNbsProf AND v.id=s.spid AND v.pr=2")
							While SqlFetchNext(hSqlAux2(), nFetchRes)
								Set nIterator = 0
								While nIterator < nParNum
									If nProfId = List[nIterator].nSpId
										Set sValue = ''
										If sProfVal != ''
											Set sValue = sProfVal
										Else If sProfSql
											If NOT SqlPrepareAndExecute(hSqlAux3(), sProfSql || " INTO :sValue")
													OR NOT SqlFetchNext(hSqlAux3(), nFetchRes)
												Set sValue = ''
										If sValue != ''
											Set nExist = 0
											If NOT SqlPrepareAndExecute(hSql, 
													"SELECT acc INTO :nExist FROM " || List[nIterator].strStorage || " 
													 WHERE acc = :nAcc" || IifS(List[nIterator].strTag='', "", 
													"  AND tag='" || List[nIterator].strTag || "'"))
												Return FALSE
											Call SqlFetchNext(hSql, nFetchRes)
											If NOT nExist
												Call SqlPrepareAndExecute(hSql, 
														"INSERT INTO " || List[nIterator].strStorage || " (acc" || IifS(List[nIterator].strTag='', "", ",tag") || ") 
														 VALUES (:nAcc" || IifS(List[nIterator].strTag='', "", ",'" || List[nIterator].strTag || "'") || ")" )
												Set nExist = 1
											If nExist
												Set List[nIterator].strValue = sProfVal
												If NOT SqlPrepareAndExecute( hSql,
														"UPDATE " || List[nIterator].strStorage || 
														"   SET " || List[nIterator].strName || "=" || 
														   IifS(List[nIterator].strType='D', 
														        "TO_DATE('" || List[nIterator].strValue || "','DD-MM-YYYY')",
														        IifS(List[nIterator].strType='N', 
														             List[nIterator].strValue, 
														             "'" || List[nIterator].strValue || "'")) || 
														" WHERE acc=:nAcc" || IifS(List[nIterator].strTag='', "", 
														"   AND tag='" || List[nIterator].strTag || "'"))
													Return FALSE
									Set nIterator = nIterator + 1
							Return TRUE
					!
					Function: GetIndexByName
						Description: получить индекс параметра в массиве по имени
						Returns
							Number:
						Parameters
							String: strName
						Static Variables
						Local variables
							Number: nIterator
							Boolean: fFound
						Actions
							If NOT strName
								Return -1
							Set nIterator = 0
							While nIterator < nParNum
								If SalStrUpperX(SalStrTrimX(List[nIterator].strName)) = SalStrUpperX( SalStrTrimX(strName))
									Set fFound = TRUE
									Break
								Set nIterator = nIterator + 1
							If fFound
								Return nIterator
							Else
								Return -1
					Function: GetIndexBySpId
						Description: получить индекс параметра в массиве по имени
						Returns
							Number:
						Parameters
							Number: nSpId
						Static Variables
						Local variables
							Number: nIterator
							Boolean: fFound
						Actions
							If NOT nSpId
								Return -1
							Set nIterator = 0
							While nIterator < nParNum
								If List[nIterator].nSpId = nSpId
									Set fFound = TRUE
									Break
								Set nIterator = nIterator + 1
							If fFound
								Return nIterator
							Else
								Return -1
			Functional Class: cAccRatn
				Description:
				Derived From
				Class Variables
				Instance Variables
					Date/Time: dBDat
					Date/Time: dBDatEta
					Number: nIr
					Number: nBr
					Number: nOp
					Boolean: bInserted
					Boolean: bUpdated
					Boolean: bDeleted
				Functions
			Functional Class: cAccAcrn
				Description:
				Derived From
				Class Variables
				Instance Variables
					Number: nId
					Number: nMetr
					Number: nBaseM
					Number: nBaseY
					Number: nFreq
					Date/Time: dStpDat
					Date/Time: dAcrDat
					Date/Time: dAplDat
					String: sTt
					Number: nAcrA
					Number: nAcrB
					String: sTtB
					Number: nKvB
					String: sNlsB
					String: sNamB
					String: sMfo
					String: sOkpo
					String: sNazn
					Number: nIo
					: RatnList[*]
						Class: cAccRatn
					Number: nRatnParNum
					Boolean: bInserted
					Boolean: bUpdated
				Functions
			Functional Class: cAccAcrnList
				Description:
				Derived From
				Class Variables
				Instance Variables
					Number: nAcc
					: List[*]
						Class: cAccAcrn
					Number: nParNum
					! Number: nParNumRatn
					Boolean: bIo
					Number: nFetchRes
				Functions
					Function: Init
						Description: Конструктор
						Returns
							Boolean:
						Parameters
							Number: nAccId
						Static Variables
						Local variables
						Actions
							Set nParNum = 0
							! Set nParNumRatn = 0
							Set nAcc = nAccId
							If GetGlobalOption('IO%') = 'Y'
								Set bIo = TRUE
							Else
								Set bIo = FALSE
							Return TRUE
					Function: Populate
						Description:
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Boolean: bIo
							Number: nId
							Number: nMetr
							Number: nBaseM
							Number: nBaseY
							Number: nFreq
							Date/Time: dStpDat
							Date/Time: dAcrDat
							Date/Time: dAplDat
							String: sTt
							Number: nAcrA
							Number: nAcrB
							String: sTtB
							Number: nKvB
							String: sNlsB
							String: sNamB
							String: sMfo
							String: sOkpo
							String: sNazn
							Number: nIo
							Date/Time: dBDat
							Number: nIr
							Number: nBr
							Number: nOp
						Actions
							If GetGlobalOption('IO%') = 'Y'
								Set bIo = TRUE
							Else
								Set bIo = FALSE
							Set nParNum = 0
							If not SqlPrepareAndExecute(hSql,
									"SELECT id, metr, basem, basey, freq, stp_dat, acr_dat, apl_dat, tt, acrA, acrB,
									        ttb, mfob, kvb, nlsb, namb, okpo, nazn, " || IifS(bIo,"io","0") || "
									   INTO :nId, :nMetr, :nBaseM, :nBaseY, :nFreq, :dStpDat, :dAcrDat, :dAplDat,
									        :sTt, :nAcrA, :nAcrB, :sTtB, :sMfo, :nKvB, :sNlsB, :sNamB, :sOkpo, :sNazn, :nIo
									   FROM int_accn
									  WHERE acc = :nAcc")
								Return FALSE
							While SqlFetchNext(hSql, nFetchRes)
								Set List[nParNum].nId     = nId
								Set List[nParNum].nMetr   = nMetr
								Set List[nParNum].nBaseM  = nBaseM
								Set List[nParNum].nBaseY  = nBaseY
								Set List[nParNum].nFreq   = nFreq
								Set List[nParNum].dStpDat = dStpDat
								Set List[nParNum].dAcrDat = dAcrDat
								Set List[nParNum].dAplDat = dAplDat
								Set List[nParNum].sTt     = sTt
								Set List[nParNum].nAcrA   = nAcrA
								Set List[nParNum].nAcrB   = nAcrB
								Set List[nParNum].sTtB    = sTtB
								Set List[nParNum].sMfo    = sMfo
								Set List[nParNum].nKvB    = nKvB
								Set List[nParNum].sNlsB   = sNlsB
								Set List[nParNum].sNamB   = sNamB
								Set List[nParNum].sOkpo   = sOkpo
								Set List[nParNum].sNazn   = sNazn
								Set List[nParNum].nIo     = nIo
								Set List[nParNum].bInserted = FALSE
								Set List[nParNum].bUpdated  = FALSE
								Set List[nParNum].nRatnParNum = 0
								If not SqlPrepareAndExecute(hSqlAux(),
										"SELECT i.bdat, i.ir, i.br, i.op
										   INTO :dBDat, :nIr, :nBr, :nOp
										   FROM int_ratn i
										  WHERE i.acc = :nAcc
										    AND i.id  = :nId
										  ORDER BY i.bdat")
									Return FALSE
								While SqlFetchNext(hSqlAux(), nFetchRes)
									Set List[nParNum].RatnList[List[nParNum].nRatnParNum].dBDat = dBDat
									Set List[nParNum].RatnList[List[nParNum].nRatnParNum].dBDatEta = dBDat
									Set List[nParNum].RatnList[List[nParNum].nRatnParNum].nIr   = nIr
									Set List[nParNum].RatnList[List[nParNum].nRatnParNum].nBr   = nBr
									Set List[nParNum].RatnList[List[nParNum].nRatnParNum].nOp   = nOp
									Set List[nParNum].RatnList[List[nParNum].nRatnParNum].bInserted = FALSE
									Set List[nParNum].RatnList[List[nParNum].nRatnParNum].bUpdated = FALSE
									Set List[nParNum].RatnList[List[nParNum].nRatnParNum].bDeleted = FALSE
									Set List[nParNum].nRatnParNum = List[nParNum].nRatnParNum + 1
								Set nParNum = nParNum + 1
							Return TRUE
					! Function: Update
						           Description: Сохранить значения в базе данных
						           Returns 
							           Boolean: 
						           Parameters 
							           Sql Handle: hSql
						           Static Variables 
						           Local variables 
							           Number: nIterator
							           Number: nI
							           Number: nId
							           Number: nMetr
							           Number: nBaseM
							           Number: nBaseY
							           Number: nFreq
							           Date/Time: dStpDat
							           Date/Time: dAcrDat
							           Date/Time: dAplDat
							           String: sTt
							           Number: nAcrA
							           Number: nAcrB
							           String: sTtB
							           Number: nKvB
							           String: sNlsB
							           String: sNamB
							           String: sMfo
							           String: sOkpo
							           String: sNazn
							           Number: nIo
							           Date/Time: dBDat
							           Date/Time: dBDatEta
							           Number: nIr
							           Number: nBr
							           Number: nOp
						           Actions 
							           Set nIterator = 0
							           While nIterator < nParNum
								           Set nId     = List[nIterator].nId
								           Set nMetr   = List[nIterator].nMetr
								           Set nBaseM  = List[nIterator].nBaseM
								           Set nBaseY  = List[nIterator].nBaseY
								           Set nFreq   = List[nIterator].nFreq
								           Set dStpDat = List[nIterator].dStpDat
								           Set dAcrDat = List[nIterator].dAcrDat
								           Set dAplDat = List[nIterator].dAplDat
								           Set sTt     = List[nIterator].sTt
								           Set nAcrA   = List[nIterator].nAcrA
								           Set nAcrB   = List[nIterator].nAcrB
								           Set sTtB    = List[nIterator].sTtB
								           Set sMfo    = List[nIterator].sMfo
								           Set nKvB    = List[nIterator].nKvB
								           Set sNlsB   = List[nIterator].sNlsB
								           Set sNamB   = List[nIterator].sNamB
								           Set sOkpo   = List[nIterator].sOkpo
								           Set sNazn   = List[nIterator].sNazn
								           Set nIo     = List[nIterator].nIo
								           If List[nIterator].bInserted
									           If not SqlPrepareAndExecute(hSql,
											"INSERT INTO Int_accN (acc, id, metr, basem, basey, freq,
											        stp_dat, acr_dat, apl_dat, tt, acra, acrb,
											        ttb, mfob, kvb, nlsb, namb, nazn, okpo" || IifS(bIo,",io","") || ")
											 VALUES (:nAcc, :nId, :nMetr, :nBaseM, :nBaseY, :nFreq,
											         :dStpDat, :dAcrDat, :dAplDat, :sTt, :nAcrA, :nAcrB,
											         :sTtB, :sMfo, :nKvB, :sNlsB, :sNamB, :sNazn, :sOkpo" || IifS(bIo,",:nIo","") || ")")
										           Return FALSE 
								           Else If List[nIterator].bUpdated
									           If not SqlPrepareAndExecute(hSql, 
											"UPDATE int_accN
											    SET metr    = :nMetr,
											        basem   = :nBaseM,
											        basey   = :nBaseY,
											        freq    = :nFreq,
											        stp_dat = :dStpDat,
											        acr_dat = :dAcrDat,
											        apl_dat = :dAplDat,
											        tt      = :sTt,
											        acra    = :nAcrA,
											        acrb    = :nAcrB,
											        ttb     = :sTtB,
											        mfob    = :sMfo,
											        kvb     = :nKvB,
											        nlsb    = :sNlsB,
											        namb    = :sNamB,
											        okpo    = :sOkpo,
											        nazn    = :sNazn" || IifS(bIo,",io=:nIo","") || "
											  WHERE acc = :nAcc AND id = :nId" )
										           Return FALSE 
								           Set nI = 0
								           While nI < List[nIterator].nRatnParNum
									           Set dBDat = List[nIterator].RatnList[nI].dBDat
									           Set dBDatEta = List[nIterator].RatnList[nI].dBDatEta
									           Set nIr   = List[nIterator].RatnList[nI].nIr
									           Set nBr   = List[nIterator].RatnList[nI].nBr
									           Set nOp   = List[nIterator].RatnList[nI].nOp
									           If List[nIterator].RatnList[nI].bDeleted
										           If not SqlPrepareAndExecute(hSqlAux(), 
												"DELETE FROM int_ratN
												  WHERE acc = :nAcc and id = :nId and bdat = :dBDat")
											           Return FALSE 
									           Else If List[nIterator].RatnList[nI].bInserted
										           If not SqlPrepareAndExecute(hSqlAux(), 
												"INSERT INTO Int_ratN (acc, id, bdat, op, ir, br)
												 VALUES (:nAcc, :nId, :dBDat, :nOp, :nIr, :nBr)")
											           Return FALSE 
									           If List[nIterator].RatnList[nI].bUpdated
										           If not SqlPrepareAndExecute(hSqlAux(), 
												"UPDATE Int_ratN
												    SET bdat = :dBDat,
												        ir = :nIr,
												        br = :nBr,
												        op = :nOp
												  WHERE acc = :nAcc and id = :nId and bdat = :dBDatEta")
											           Return FALSE 
									           Set List[nIterator].RatnList[nI].bInserted = FALSE
									           Set List[nIterator].RatnList[nI].bUpdated = FALSE
									           Set List[nIterator].RatnList[nI].bDeleted = FALSE
									           Set nI = nI + 1
								           Set nIterator = nIterator + 1
							           Return TRUE
					Function: Update
						Description: Сохранить значения в базе данных
						Returns
							Boolean:
						Parameters
							Sql Handle: hSql
						Static Variables
						Local variables
							Number: nIterator
							Number: nI
							Number: nId
							Number: nMetr
							Number: nBaseM
							Number: nBaseY
							Number: nFreq
							Date/Time: dStpDat
							Date/Time: dAcrDat
							Date/Time: dAplDat
							String: sTt
							Number: nAcrA
							Number: nAcrB
							String: sTtB
							Number: nKvB
							String: sNlsB
							String: sNamB
							String: sMfo
							String: sOkpo
							String: sNazn
							Number: nIo
							Date/Time: dBDat
							Date/Time: dBDatEta
							Number: nIr
							Number: nBr
							Number: nOp
						Actions
							Set nIterator = 0
							While nIterator < nParNum
								Set nId     = List[nIterator].nId
								Set nMetr   = List[nIterator].nMetr
								Set nBaseM  = List[nIterator].nBaseM
								Set nBaseY  = List[nIterator].nBaseY
								Set nFreq   = List[nIterator].nFreq
								Set dStpDat = List[nIterator].dStpDat
								Set dAcrDat = List[nIterator].dAcrDat
								Set dAplDat = List[nIterator].dAplDat
								Set sTt     = List[nIterator].sTt
								Set nAcrA   = List[nIterator].nAcrA
								Set nAcrB   = List[nIterator].nAcrB
								Set sTtB    = List[nIterator].sTtB
								Set sMfo    = List[nIterator].sMfo
								Set nKvB    = List[nIterator].nKvB
								Set sNlsB   = List[nIterator].sNlsB
								Set sNamB   = List[nIterator].sNamB
								Set sOkpo   = List[nIterator].sOkpo
								Set sNazn   = List[nIterator].sNazn
								Set nIo     = List[nIterator].nIo
								If List[nIterator].bInserted
									If not SqlPrepareAndExecute(hSql,
											"INSERT INTO Int_accN (acc, id, metr, basem, basey, freq,
											        stp_dat, acr_dat, apl_dat, tt, acra, acrb,
											        ttb, mfob, kvb, nlsb, namb, nazn, okpo" || IifS(bIo,",io","") || ")
											 VALUES (:nAcc, :nId, :nMetr, :nBaseM, :nBaseY, :nFreq,
											         :dStpDat, :dAcrDat, :dAplDat, :sTt, :nAcrA, :nAcrB,
											         :sTtB, :sMfo, :nKvB, :sNlsB, :sNamB, :sNazn, :sOkpo" || IifS(bIo,",:nIo","") || ")")
										Return FALSE 
								Else If List[nIterator].bUpdated
									If not SqlPrepareAndExecute(hSql, 
											"UPDATE int_accN
											    SET metr    = :nMetr,
											        basem   = :nBaseM,
											        basey   = :nBaseY,
											        freq    = :nFreq,
											        stp_dat = :dStpDat,
											        acr_dat = :dAcrDat,
											        apl_dat = :dAplDat,
											        tt      = :sTt,
											        acra    = :nAcrA,
											        acrb    = :nAcrB,
											        ttb     = :sTtB,
											        mfob    = :sMfo,
											        kvb     = :nKvB,
											        nlsb    = :sNlsB,
											        namb    = :sNamB,
											        okpo    = :sOkpo,
											        nazn    = :sNazn" || IifS(bIo,",io=:nIo","") || "
											  WHERE acc = :nAcc AND id = :nId" )
										Return FALSE 
								Set nI = 0
								While nI < List[nIterator].nRatnParNum
									Set dBDat = List[nIterator].RatnList[nI].dBDat
									Set dBDatEta = List[nIterator].RatnList[nI].dBDatEta
									Set nIr   = List[nIterator].RatnList[nI].nIr
									Set nBr   = List[nIterator].RatnList[nI].nBr
									Set nOp   = List[nIterator].RatnList[nI].nOp
									If List[nIterator].RatnList[nI].bDeleted
										If not SqlPrepareAndExecute(hSqlAux(), 
												"DELETE FROM int_ratN
												  WHERE acc = :nAcc and id = :nId and bdat = :dBDat")
											Return FALSE 
									Else If List[nIterator].RatnList[nI].bInserted
										If not SqlPrepareAndExecute(hSqlAux(), 
												"INSERT INTO Int_ratN (acc, id, bdat, op, ir, br)
												 VALUES (:nAcc, :nId, :dBDat, :nOp, :nIr, :nBr)")
											Return FALSE 
									If List[nIterator].RatnList[nI].bUpdated
										If dBDat = dBDatEta
											If not SqlPrepareAndExecute(hSqlAux(), 
													"UPDATE Int_ratN
													    SET ir = :nIr,
													        br = :nBr,
													        op = :nOp
													  WHERE acc = :nAcc and id = :nId and bdat = :dBDatEta")
												Return FALSE 
										Else
											If not SqlPrepareAndExecute(hSqlAux(), 
													"DELETE FROM int_ratN
													  WHERE acc = :nAcc and id = :nId and bdat = :dBDatEta")
												Return FALSE 
											If not SqlPrepareAndExecute(hSqlAux(), 
													"INSERT INTO Int_ratN (acc, id, bdat, op, ir, br)
													 VALUES (:nAcc, :nId, :dBDat, :nOp, :nIr, :nBr)")
												Return FALSE 
									Set List[nIterator].RatnList[nI].bInserted = FALSE
									Set List[nIterator].RatnList[nI].bUpdated = FALSE
									Set List[nIterator].RatnList[nI].bDeleted = FALSE
									Set nI = nI + 1
								Set nIterator = nIterator + 1
							Return TRUE
					Function: AddAccn
						Description: Добавить значение
						Returns
							Boolean:
						Parameters
							Number: nId
							Number: nMetr
							Number: nBaseM
							Number: nBaseY
							Number: nFreq
							Date/Time: dStpDat
							Date/Time: dAcrDat
							Date/Time: dAplDat
							String: sTt
							Number: nAcrA
							Number: nAcrB
							String: sTtB
							Number: nKvB
							String: sNlsB
							String: sNamB
							String: sMfo
							String: sOkpo
							String: sNazn
							Number: nIo
						Static Variables
						Local variables
						Actions
							Set List[nParNum].nId     = nId
							Set List[nParNum].nMetr   = nMetr
							Set List[nParNum].nBaseM  = nBaseM
							Set List[nParNum].nBaseY  = nBaseY
							Set List[nParNum].nFreq   = nFreq
							Set List[nParNum].dStpDat = dStpDat
							Set List[nParNum].dAcrDat = dAcrDat
							Set List[nParNum].dAplDat = dAplDat
							Set List[nParNum].sTt     = sTt
							Set List[nParNum].nAcrA   = nAcrA
							Set List[nParNum].nAcrB   = nAcrB
							Set List[nParNum].sTtB    = sTtB
							Set List[nParNum].sMfo    = sMfo
							Set List[nParNum].nKvB    = nKvB
							Set List[nParNum].sNlsB   = sNlsB
							Set List[nParNum].sNamB   = sNamB
							Set List[nParNum].sOkpo   = sOkpo
							Set List[nParNum].sNazn   = sNazn
							Set List[nParNum].nIo     = nIo
							Set List[nParNum].bInserted = TRUE
							Set List[nParNum].bUpdated  = FALSE
							Set List[nParNum].nRatnParNum = 0
							Set nParNum = nParNum + 1
							Return TRUE
					Function: ChangeAccn
						Description:
						Returns
							Boolean:
						Parameters
							Number: nIndex
							Number: nMetr
							Number: nBaseM
							Number: nBaseY
							Number: nFreq
							Date/Time: dStpDat
							Date/Time: dAcrDat
							Date/Time: dAplDat
							String: sTt
							Number: nAcrA
							Number: nAcrB
							String: sTtB
							Number: nKvB
							String: sNlsB
							String: sNamB
							String: sMfo
							String: sOkpo
							String: sNazn
							Number: nIo
						Static Variables
						Local variables
						Actions
							Set List[nIndex].nMetr   = nMetr
							Set List[nIndex].nBaseM  = nBaseM
							Set List[nIndex].nBaseY  = nBaseY
							Set List[nIndex].nFreq   = nFreq
							Set List[nIndex].dStpDat = dStpDat
							Set List[nIndex].dAcrDat = dAcrDat
							Set List[nIndex].dAplDat = dAplDat
							Set List[nIndex].sTt     = sTt
							Set List[nIndex].nAcrA   = nAcrA
							Set List[nIndex].nAcrB   = nAcrB
							Set List[nIndex].sTtB    = sTtB
							Set List[nIndex].sMfo    = sMfo
							Set List[nIndex].nKvB    = nKvB
							Set List[nIndex].sNlsB   = sNlsB
							Set List[nIndex].sNamB   = sNamB
							Set List[nIndex].sOkpo   = sOkpo
							Set List[nIndex].sNazn   = sNazn
							Set List[nIndex].nIo     = nIo
							Set List[nIndex].bUpdated = TRUE
							Return TRUE
					Function: SetAccn
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
							Number: nMetr
							Number: nBaseM
							Number: nBaseY
							Number: nFreq
							Date/Time: dStpDat
							Date/Time: dAcrDat
							Date/Time: dAplDat
							String: sTt
							Number: nAcrA
							Number: nAcrB
							String: sTtB
							Number: nKvB
							String: sNlsB
							String: sNamB
							String: sMfo
							String: sOkpo
							String: sNazn
							Number: nIo
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = GetIndexById(nId)
							If nIndex = -1
								Call AddAccn(nId, nMetr, nBaseM, nBaseY, nFreq, dStpDat, dAcrDat, dAplDat, 
										sTt, nAcrA, nAcrB, sTtB, nKvB, sNlsB, sNamB, sMfo, sOkpo, sNazn, nIo)
							Else
								Call ChangeAccn(nIndex, nMetr, nBaseM, nBaseY, nFreq, dStpDat, dAcrDat, dAplDat, 
										sTt, nAcrA, nAcrB, sTtB, nKvB, sNlsB, sNamB, sMfo, sOkpo, sNazn, nIo)
							Return TRUE
					Function: GetAccn
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
							Receive Number: nMetr
							Receive Number: nBaseM
							Receive Number: nBaseY
							Receive Number: nFreq
							Receive Date/Time: dStpDat
							Receive Date/Time: dAcrDat
							Receive Date/Time: dAplDat
							Receive String: sTt
							Receive Number: nAcrA
							Receive Number: nAcrB
							Receive String: sTtB
							Receive Number: nKvB
							Receive String: sNlsB
							Receive String: sNamB
							Receive String: sMfo
							Receive String: sOkpo
							Receive String: sNazn
							Receive Number: nIo
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = GetIndexById(nId)
							If nIndex = -1
								Return FALSE
							Set nMetr   = List[nIndex].nMetr
							Set nBaseM  = List[nIndex].nBaseM
							Set nBaseY  = List[nIndex].nBaseY
							Set nFreq   = List[nIndex].nFreq
							Set dStpDat = List[nIndex].dStpDat
							Set dAcrDat = List[nIndex].dAcrDat
							Set dAplDat = List[nIndex].dAplDat
							Set sTt     = List[nIndex].sTt
							Set nAcrA   = List[nIndex].nAcrA
							Set nAcrB   = List[nIndex].nAcrB
							Set sTtB    = List[nIndex].sTtB
							Set sMfo    = List[nIndex].sMfo
							Set nKvB    = List[nIndex].nKvB
							Set sNlsB   = List[nIndex].sNlsB
							Set sNamB   = List[nIndex].sNamB
							Set sOkpo   = List[nIndex].sOkpo
							Set sNazn   = List[nIndex].sNazn
							Set nIo     = List[nIndex].nIo
							Return TRUE
					Function: GetIndexById
						Description: получить индекс параметра в массиве по имени
						Returns
							Number:
						Parameters
							Number: nId
						Static Variables
						Local variables
							Number: nIterator
							Boolean: fFound
						Actions
							If nId = NUMBER_Null
								Return -1
							Set fFound = FALSE
							Set nIterator = 0
							While nIterator < nParNum
								If List[nIterator].nId = nId
									Set fFound = TRUE
									Break
								Set nIterator = nIterator + 1
							If fFound
								Return nIterator
							Else
								Return -1
					!
					Function: AddRatn
						Description: Добавить значение
						Returns
							Boolean:
						Parameters
							Number: nId
							Date/Time: dBDat
							Number: nIr
							Number: nBr
							Number: nOp
							Receive Number: nRatnIndex
						Static Variables
						Local variables
							Number: nIndex
						Actions
							Set nIndex = GetIndexById(nId)
							If nIndex = -1
								Return FALSE
							Set List[nIndex].RatnList[List[nIndex].nRatnParNum].dBDat = dBDat
							Set List[nIndex].RatnList[List[nIndex].nRatnParNum].dBDatEta = DATETIME_Null
							Set List[nIndex].RatnList[List[nIndex].nRatnParNum].nIr   = nIr
							Set List[nIndex].RatnList[List[nIndex].nRatnParNum].nBr   = nBr
							Set List[nIndex].RatnList[List[nIndex].nRatnParNum].nOp   = nOp
							Set List[nIndex].RatnList[List[nIndex].nRatnParNum].bInserted = TRUE
							Set List[nIndex].RatnList[List[nIndex].nRatnParNum].bUpdated = FALSE
							Set List[nIndex].RatnList[List[nIndex].nRatnParNum].bDeleted = FALSE
							Set List[nIndex].nRatnParNum = List[nIndex].nRatnParNum + 1
							Set nRatnIndex = List[nIndex].nRatnParNum
							Return TRUE
					Function: SetRatn
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
							Number: nRatnIndex
							Date/Time: dBDat
							Number: nIr
							Number: nBr
							Number: nOp
						Static Variables
						Local variables
							Number: nAccnIndex
							! Number: nRatnIndex
						Actions
							Set nAccnIndex = GetIndexById(nId)
							If nAccnIndex = -1
								Return FALSE
							Set List[nAccnIndex].RatnList[nRatnIndex].dBDat = dBDat
							Set List[nAccnIndex].RatnList[nRatnIndex].nIr = nIr
							Set List[nAccnIndex].RatnList[nRatnIndex].nBr = nBr
							Set List[nAccnIndex].RatnList[nRatnIndex].nOp = nOp
							Set List[nAccnIndex].RatnList[nRatnIndex].bUpdated = TRUE
							Return TRUE
					Function: DropRatn
						Description: Удалить значение
						Returns
							Boolean:
						Parameters
							Number: nId
							Number: nRatnIndex
						Static Variables
						Local variables
							Number: nAccnIndex
						Actions
							Set nAccnIndex = GetIndexById(nId)
							If nAccnIndex != -1
								Set List[nAccnIndex].RatnList[nRatnIndex].bInserted = FALSE
								Set List[nAccnIndex].RatnList[nRatnIndex].bUpdated = FALSE
								Set List[nAccnIndex].RatnList[nRatnIndex].bDeleted = TRUE
							Return TRUE
					Function: GetRatn
						Description:
						Returns
							Boolean:
						Parameters
							Number: nId
							Number: nRatnIndex
							Receive Date/Time: dBDat
							Receive Number: nIr
							Receive Number: nBr
							Receive Number: nOp
							Receive Boolean: bIns
							Receive Boolean: bUpd
							Receive Boolean: bDel
						Static Variables
						Local variables
							Number: nAccnIndex
						Actions
							Set nAccnIndex = GetIndexById(nId)
							If nAccnIndex = -1
								Return FALSE
							Set dBDat = List[nAccnIndex].RatnList[nRatnIndex].dBDat
							Set nIr   = List[nAccnIndex].RatnList[nRatnIndex].nIr
							Set nBr   = List[nAccnIndex].RatnList[nRatnIndex].nBr
							Set nOp   = List[nAccnIndex].RatnList[nRatnIndex].nOp
							Set bIns  = List[nAccnIndex].RatnList[nRatnIndex].bInserted
							Set bUpd  = List[nAccnIndex].RatnList[nRatnIndex].bUpdated
							Set bDel  = List[nAccnIndex].RatnList[nRatnIndex].bDeleted
							Return TRUE
					Function: GetIndexByBDat
						Description: получить индекс параметра в массиве по Id, BDat
						Returns
							Number:
						Parameters
							Number: nAccnIndex
							Date/Time: dBDat
						Static Variables
						Local variables
							Number: nIterator
							Boolean: fFound
						Actions
							If not dBDat
								Return -1
							Set nIterator = 0
							While nIterator < List[nAccnIndex].nRatnParNum
								If List[nAccnIndex].RatnList[nIterator].dBDat = dBDat
									Set fFound = TRUE
									Break
								Set nIterator = nIterator + 1
							If fFound
								Return nIterator
							Else
								Return -1
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
			On SAM_AppStartup
