.head 0 +  Application Description: ! BARS018.APL - Выходные формы НБУ и ДПА
! ООО Унити-Барс  (C)  2001
! Разработчики: Чупахина Н.А., Овчарук А.В.
! ///////////////////////////////////////////
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000AB0000 002C000000030000 00030000000E0300 000B000000F8FFFF
0040: FFE2FFFFFF200000 0015000000EA0200 00D7010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 0200000000001C51 3A5C424152533938 5C4C494252415259 5C4162736170692E
0020: 646C6C1C513A5C42 41525339385C4C49 42524152595C4162 736170692E617063
0040: 00000101011C513A 5C4241525339385C 4C4942524152595C 4162736170692E72
0060: 756E1C513A5C4241 525339385C4C4942 524152595C416273 6170692E646C6C1C
0080: 513A5C4241525339 385C4C4942524152 595C416273617069 2E61706300000101
00A0: 01175C4241525339 385C42494E5C6261 72733031382E6170 64165C4241525339
00C0: 385C42494E5C4162 736170692E646C6C 165C424152533938 5C42494E5C416273
00E0: 6170692E61706300 00010101001C513A 5C4241525339385C 4C4942524152595C
0100: 4162736170692E64 6C6C1C513A5C4241 525339385C4C4942 524152595C416273
0120: 6170692E61706300 00010101
.enddata
.head 2 -  Outline Window State: Normal
.head 2 +  Outline Window Location and Size
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
.head 3 -  Left:   -0.013"
.head 3 -  Top:    0.0"
.head 3 -  Width:  8.013"
.head 3 -  Height: 4.969"
.head 2 +  Options Box Location
.data VIEWINFO
0000: 0418B80BB80B2500
.enddata
.data VIEWSIZE
0000: 0800
.enddata
.head 3 -  Visible? Yes
.head 3 -  Left:   4.15"
.head 3 -  Top:    1.885"
.head 3 -  Width:  3.8"
.head 3 -  Height: 2.073"
.head 2 +  Class Editor Location
.head 3 -  Visible? No
.head 3 -  Left:   0.575"
.head 3 -  Top:    0.094"
.head 3 -  Width:  5.063"
.head 3 -  Height: 2.719"
.head 2 +  Tool Palette Location
.head 3 -  Visible? No
.head 3 -  Left:   6.388"
.head 3 -  Top:    0.729"
.head 2 -  Fully Qualified External References? Yes
.head 2 -  Reject Multiple Window Instances? No
.head 2 -  Enable Runtime Checks Of External References? Yes
.head 2 -  Use Release 4.0 Scope Rules? No
.head 1 +  Libraries
.head 2 -  Dynalib: Global.apd
.head 2 -  Dynalib: Message.apd
.head 2 -  Dynalib: Absapi.apd
.head 2 -  Dynalib: Nsiapi.apd
.head 2 -  !
.head 2 -  File Include: xsalspl.apl
.head 2 -  File Include: Constant.apl
.head 2 -  File Include: Genbutn.apl
.head 2 -  File Include: Genfcls.apl
.head 2 -  File Include: Genemnu.apl
.head 2 -  File Include: Gentbl.apl
.head 2 -  File Include: Genlist.apl
.head 2 -  File Include: Winapi.apl
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: Sqlnsi.apl
.head 2 -  !
.head 2 -  File Include: Vtcal.apl
.head 2 -  File Include: Vtmeter.apl
.head 2 -  File Include: Vttblwin.apl
.head 2 -  File Include: vtsplit.apl
.head 2 -  File Include: vtlbx.apl
.head 2 -  File Include: vtdos.apl
.head 2 -  File Include: VTFILE.APL
.head 2 -  File Include: signfile.apl
.head 2 -  File Include: XSALIMG.APL
.head 2 -  File Include: Gentimer.apl
.head 1 +  Global Declarations
.head 2 +  Window Defaults
.head 3 +  Tool Bar
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Form Window
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Dialog Box
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Top Level Table Window
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Window Color
.head 3 +  Data Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Multiline Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Spin Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Background Text
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Pushbutton
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 3 +  Radio Button
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Check Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Option Button
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 3 +  Group Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Child Table Window
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: System Window Color
.head 3 +  List Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Combo Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Line
.head 4 -  Line Color: Use Parent
.head 3 +  Frame
.head 4 -  Border Color: Use Parent
.head 4 -  Background Color: 3D Face Color
.head 3 +  Picture
.head 4 -  Border Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 2 +  Formats
.head 3 -  Number: 0'%'
.head 3 -  Number: #0
.head 3 -  Number: ###000
.head 3 -  Number: ###000;'($'###000')'
.head 3 -  Date/Time: hh:mm:ss AMPM
.head 3 -  Date/Time: M/d/yy
.head 3 -  Date/Time: MM-dd-yy
.head 3 -  Date/Time: dd-MMM-yyyy
.head 3 -  Date/Time: MMM d, yyyy
.head 3 -  Date/Time: MMM d, yyyy hh:mm AMPM
.head 3 -  Date/Time: MMMM d, yyyy hh:mm AMPM
.head 3 -  Input: 99/99/99
.head 3 -  Number: ###00000
.head 3 -  Date/Time: dd/MM/yyyy
.head 3 -  Date/Time: dd/MM/yy
.head 3 -  Date/Time: dd
.head 3 -  Date/Time: dd-MM-yyyy
.head 3 -  Date/Time: ddMMyy
.head 3 -  Input: 99/99/9999
.head 3 -  Date/Time: dd.MM.yyyy
.head 2 +  External Functions
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 3 +  User
.head 4 -  Number: O_RDWR 		= 0x0002
.head 4 -  Number: O_CREAT		= 0x0100
.head 4 -  Number: O_TRUNC		= 0x0200
.head 4 -  Number: O_BINARY	= 0x8000
.head 4 -  Number: _SH_DENYRW	= 0x10
.head 4 -  Number: _S_IREAD	= 0000400
.head 4 -  Number: _S_IWRITE	= 0000200
.head 4 -  Number: _SH_DENYNO	= 0x40
.head 4 -  ! Данные из таблицы FLAG_LIM
.head 4 -  String: sFlagU = 'U'   ! Установить
.head 4 -  String: sFlag_ = ' '   ! Оставить предыдущее значение
.head 4 -  String: sFlagO = '0'   ! Обнулить
.head 2 +  Resources
.head 3 +  Icon: icon_Folder1
.head 4 -  File Name: \Bars98\Resource\Ico\Folder.ico
.head 3 +  Icon: icon_Folder2
.head 4 -  File Name: \Bars98\Resource\Ico\Folderop.ico
.head 2 +  Variables
.head 3 -  Window Handle: hWinBS
.head 3 -  Window Handle: hWinL
.head 3 -  Window Handle: hWinP
.head 3 -  Window Handle: hWinBT
.head 3 -  Window Handle: hWinG
.head 3 -  !
.head 3 -  String: strFileName
.head 3 -  String: strRepDate
.head 3 -  String: strBankDate
.head 3 -  !
.head 3 -  Number: nFetchRes
.head 3 -  String: sStrSel
.head 3 -  String: sFPath
.head 3 -  Number: hFile
.head 3 -  !
.head 3 -  String: Path_Backup
.head 3 -  String: Path_BSF
.head 3 -  String: BS_Sign
.head 3 -  String: strOperId
.head 3 -  String: strOperId_UNI
.head 2 +  Internal Functions
.head 3 -  !
.head 3 +  Function: Ini018
.head 4 -  Description: Коструктор
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 -  Actions
.head 3 +  Function: Sel018                !__exported
.head 4 -  Description: Вызыватор.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWndParent
.head 5 -  Number: nMode     ! 0-BS, 1-L
.head 5 -  Number: nPar      !
.head 5 -  String: strPar1   !
.head 5 -  String: strPar2   !
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: i
.head 5 -  !
.head 5 -  ! String: sTab
.head 5 -  ! Sql Handle: hSqlOdbc
.head 5 -  ! String: tt
.head 5 -  ! String: strInsert
.head 5 -  ! String: strCreate
.head 5 -  ! Date/Time: fdat
.head 5 -  ! String: nls1
.head 5 -  ! String: nls2
.head 5 -  ! String: nls3
.head 5 -  ! String: nls
.head 4 +  Actions
.head 5 +  Select Case nMode
.head 6 +  Case 0	! Формирование файла BS*
.head 7 -  Set strOperId = SalStrReplaceX ( GetIdOper(), 3, 1, 'B' )
.head 7 -  Set strOperId_UNI = GetIdOper()
.head 7 -  Call SalUseRegistry( FALSE, '' )
.head 7 -  Call SalGetProfileString( INI_Directory, 'BackupDir', GetPrnDir(), Path_Backup, GetIniFileName() )
.head 7 -  Call SalGetProfileString( INI_Directory, 'DIR_BS', GetPrnDir(), Path_BSF, GetIniFileName() )
.head 7 -  ! Call SalGetProfileString( 'Files', 'BS_Sign', '', BS_Sign, GetIniFileName() )
.head 7 -  ! Посмотреть для strOperId
.head 7 +  ! If BS_Sign = 'T'
.head 8 -    Set strOperId_UNI = SalStrReplaceX ( GetIdOper(), 3, 1, 'T' )
.head 7 +  ! Else If BS_Sign = 'B'
.head 8 -    Set strOperId_UNI = SalStrReplaceX ( GetIdOper(), 3, 1, 'B' )
.head 7 +  ! Else
.head 8 -    Set strOperId_UNI = GetIdOper()
.head 7 +  Select Case nPar
.head 8 +  Case 0      ! вызываем форму BS
.head 9 +  If not IsWindow( hWinBS )
.head 10 -  ! Set hWinBS = SalCreateWindow( frm_BSFiles, hWndParent, Path_BSF )
.head 10 -  Set hWinBS = SalCreateWindow( frm_BSFiles, hWndParent )
.head 9 +  Else
.head 10 -  Call SalBringWindowToTop( hWinBS )
.head 9 -  Break
.head 8 +  Case 4      ! формируем 4 дневных
.head 9 -  Call SalModalDialog( dlg_BS, hWndForm, nPar )
.head 9 -  Break
.head 8 +  Case 2      ! формируем 2 месячных
.head 9 -  Call SalModalDialog( dlg_BS, hWndForm, nPar )
.head 9 -  Break
.head 8 +  ! Case 10
.head 9 +    If not IsWindow( hWinBS_ )
.head 10 -  ! Set hWinBS = SalCreateWindow( frm_BSFiles, hWndParent, Path_BSF )
.head 10 -    Set hWinBS_ = SalCreateWindow( frm_BSFiles_, hWndParent )
.head 9 +    Else 
.head 10 -    Call SalBringWindowToTop( hWinBS_ )
.head 9 -    Break 
.head 8 +  Default
.head 9 -  Break
.head 7 -  Break
.head 6 +  Case 1	! Формирование файла L*
.head 7 +  ! Select Case nPar
.head 8 +  Case 0
.head 9 +  If not IsWindow( hWinL )
.head 10 -  Set hWinL = SalCreateWindow( frm_L, hWndParent, nPar )
.head 9 +  Else 
.head 10 -  Call SalBringWindowToTop( hWinL )
.head 9 -  Break 
.head 8 +  Case 1
.head 9 +  If not IsWindow( hWinL )
.head 10 -  Set hWinL = SalCreateWindow( frm_L, hWndParent, nPar )
.head 9 +  Else 
.head 10 -  Call SalBringWindowToTop( hWinL )
.head 9 -  Break 
.head 8 +  Default 
.head 9 -  Break 
.head 7 +  If not IsWindow( hWinL )
.head 8 -  Set hWinL = SalCreateWindow( frm_L, hWndParent, nPar )
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop( hWinL )
.head 7 -  Break
.head 6 +  ! Case 2  ! Просмотр данных файла P*
.head 7 +    If not IsWindow( hWinP )
.head 8 -    Set hWinP = SalCreateWindow( tbl_P, hWndParent )
.head 7 +    Else 
.head 8 -    Call SalBringWindowToTop( hWinP )
.head 7 -    Break 
.head 6 +  Case 3  ! Квитанции BT*
.head 7 +  If not IsWindow( hWinBT )
.head 8 -  Set hWinBT = SalCreateWindow( frm_BT, hWndParent )
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop( hWinBT )
.head 7 -  Break
.head 6 +  Case 4	! Файлы $G*
.head 7 +  If not IsWindow( hWinG )
.head 8 -  Set hWinG = SalCreateWindow( tbl_G, hWndParent )
.head 7 +  Else
.head 8 -  Call SalBringWindowToTop( hWinG )
.head 7 -  Break
.head 6 +  Default
.head 7 -  Break
.head 3 -  !
.head 3 +  Function: GetFileName   ! nbu_zag_bs
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nTip
.head 5 -  Date/Time: dDat
.head 5 -  Receive Number: nFileNum
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sTipRF
.head 5 -  String: strFileName
.head 4 +  Actions
.head 5 -  ! Get the Number of Current File
.head 5 +  If SqlPrepareAndExecute( hSql(), '
  SELECT tip_r
  INTO :sTipRF
  FROM nbu_int
  WHERE id=:nTip' )
.head 6 -  Call SqlFetchNext( hSql(), nFetchRes )
.head 5 +  ! If SqlPrepareAndExecute( hSql(), "
  SELECT f_n
  INTO :nFileNum
  FROM nbu_intf
  WHERE id=:nTip and f_dat=:dDat " )
.head 6 +   If NOT SqlFetchNext( hSql(), nFetchRes )
.head 7 -   Call SqlPrepareAndExecute( hSql(), "
  INSERT INTO nbu_intf
  VALUES (:nTip, :dDat, :nFileNum) " )
.head 5 +  If SqlPrepareAndExecute( hSql(), "
  SELECT max(to_number(substr(fn,11,2)))
  INTO :nFileNum
  FROM nbu_zag_bs 
  WHERE upper(substr(fn,10,1))=
       (select upper(tip_r) from nbu_int where id=:nTip) 
    and dat=:dDat " )
.head 6 -  If NOT SqlFetchNext( hSql(), nFetchRes )
.head 5 -  Set nFileNum = nFileNum + 1
.head 5 -  ! Create file names
.head 5 -  Set strFileName = 'BS' || Subs( GetBankSab(), 1, 4 ) ||
     GetCharForDigit( SalDateMonth( dDat )) ||
     GetCharForDigit( SalDateDay( dDat )) || '.' ||
     sTipRF || Right( '00' || Str( nFileNum ), 2 )
.head 5 -  Return strFileName
.head 3 +  Function: FunBackUpFile
.head 4 -  Description: Забэкапить файл в подкаталог дня.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: strSrcFile
.head 5 -  String: strBkpDir
.head 5 -  Boolean: fIn
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strFName
.head 5 -  String: strFExt
.head 5 -  String: strFDrv
.head 5 -  String: strFPath
.head 5 -  !
.head 5 -  String: strBckPath
.head 5 -  String: strDayDir
.head 5 -  String: strDDir
.head 4 +  Actions
.head 5 -  Set strDayDir = SalFmtFormatDateTime( SalDateCurrent( ), 'yyMMdd' )
.head 5 +  If fIn
.head 6 -  Set strDDir = 'In'
.head 5 +  Else
.head 6 -  Set strDDir = 'Out'
.head 5 -  Call VisDosSplitPath( strSrcFile, strFDrv, strFPath, strFName, strFExt )
.head 5 -  Set strBckPath = strBkpDir || '\\' || strDayDir || '\\' || strDDir || '\\' || strFName || strFExt 
.head 5 -  !
.head 5 +  If NOT VisDosExist( strBkpDir || '\\' || strDayDir || '\\' || strDDir )
.head 6 +  If VisDosMakeAllDir( strBkpDir || '\\' || strDayDir || '\\' || strDDir ) != VTERR_Ok
.head 7 -  Call SalMessageBox( 'Невозможно создать каталог копий - ' || 
strBkpDir || '\\' || strDayDir || '\\' || strDDir, 'Ошибка', MB_Ok )
.head 7 -  Call SaveErrorToLog( 'Невозможно создать каталог копий - ' || 
strBkpDir || '\\' || strDayDir || '\\' || strDDir )
.head 7 -  Return FALSE
.head 5 +  If SalFileCopy( strSrcFile, strBckPath, TRUE ) != FILE_CopyOK
.head 6 -  Call SalMessageBox( 'Невозможно скопировать файл из ' || strSrcFile || ' в ' || strBckPath, 'Ошибка', MB_Ok )
.head 6 -  Call SaveErrorToLog( 'Невозможно скопировать файл из ' || strSrcFile || ' в ' || strBckPath )
.head 6 -  Return FALSE
.head 5 -  Call SaveInfoToLog( 'Файл ' || strSrcFile || ' перемещен в архив дня ' || strBckPath )
.head 5 -  Return TRUE
.head 3 -  !
.head 2 +  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 1304403309
0000: 96030000A3010000 0000000000000000 0200000500FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F6C003C00 000863005461626C
0040: 654253EE80000000 0900000007010D00 0000FFFFC90D0000 01FD00FF071A0000
0060: 0004F40D0000FF1F 270000C000020400 0000FF7F2B700000 000100FFFFC13800
0080: 000001FD00FF0745 00000001F700FF1F 520000DC000100FF 7F5F700000000100
00A0: FFFF010180410000 0001000000000D63 52616400696F4C69 7374426F40788600
00C0: 000005009E00010D FD00FF270D000001 F700FFDF1ADC0001 00FF7F2773000100
00E0: FFFFC13400000001 FD00FF0701804E00 0000000200000009 63530069676E4669
0100: 6C65A08000000006 00000067010D00FF FFCD0D0001FD00FF 371A0001F700FFDF
0120: 27DC000100FF7F34 73000100FFFFC941 000001FD00FF0701 8022000000000300
0140: 00000A634718656E 4674657240740000 00040000CF0204E8 000100001F800100
0160: FC00001B0400010D FB00FF0F11000000 EE0200FF3F1500B8 00000100FFFF9801
0180: 8022000461000B63 4744FC4669D90004 003B020001FA0000 2780010000FFC604
01A0: 00010DFE00FF9B11 0002FB00FF6F1500 EE0100FF3F
.enddata
.head 3 +  Child Table Class: cTableBS
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:  
.head 6 -  Top:   
.head 6 -  Width:  5.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 2.0"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  View: Class Default
.head 5 -  Allow Row Sizing? Class Default
.head 5 -  Lines Per Row: Class Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 30000
.head 5 -  Discardable? Class Default
.head 4 -  Next Class Child Key: 30
.head 4 -  List in Tool Palette? Yes
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Description:
.head 4 -  Derived From
.head 4 +  Contents
.head 5 +  Column: colNLSA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 1
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Рахунок
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKV
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 2
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNMS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 3
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва рахунку
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  5.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colPAP
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 4
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Акт.-
Пас.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.55"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  ! Column: colPAPs  ! -
.winattr
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 30
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Акт.-
Пас.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.55"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.end
.head 6 -   List Values 
.head 6 -   Message Actions 
.head 5 +  Column: colDat   ! -
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 24
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата
операцii
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Format: dd/MM/yyyy
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colPO
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 6
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 1-вiдкр.
2-оновл.
3-закр.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.75"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colVOB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 7
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид
платежу
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colVOBs  ! -
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 25
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид
платежу
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  3.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 9
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Д/К
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.4"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNM
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 10
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
макету
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.8"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colMFO
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 11
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: МФО
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Right
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNLSB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 12
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Рахунок Б
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  ! Column: colSVal
.winattr
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 28
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сума в валютi
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.end
.head 6 -   List Values 
.head 6 -   Message Actions 
.head 5 +  ! Column: colSEkv
.winattr
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 29
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сума в екв.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.end
.head 6 -   List Values 
.head 6 -   Message Actions 
.head 5 +  Column: colOstV
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 17
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Залишок
в вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDOSV
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 18
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Обороти Дт
в вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKOSV
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 19
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Обороти Кт
в вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colOst
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 20
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Залишок
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDOS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 21
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Обороти Дт
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKOS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 22
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Обороти Кт
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNamB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 15
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назва кореспондента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  5.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNazn
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 16
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Призначення платежу
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 160
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  5.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 +  Class Variables
.head 5 -  Number: nTip
.head 5 -  Number: nVid
.head 5 -  Date/Time: dDat
.head 5 -  String: sSel
.head 5 -  !
.head 5 -  Number: nRec
.head 5 -  Number: nNumODB
.head 5 -  Number: nNum9
.head 5 -  Number: nSumODB
.head 5 -  Number: nSum9
.head 4 +  Instance Variables
.head 5 -  String: sBankMfo
.head 5 -  : fileSigner
.head 6 -  Class: cSignFile
.head 4 +  Functions
.head 5 +  Function: CaseSqlSelect		! с файлом BS*.A*
.head 6 -  Description: Подготовка SELECT-ов
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Date/Time: dDat
.head 7 -  Number: nTip
.head 7 -  Receive String: sSel
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: fReturn
.head 6 +  Actions
.head 7 -  Set sSel = ''
.head 7 -  Set fReturn = TRUE
.head 7 -  Call SqlPrepareAndExecute(hSql(),
"SELECT nn_file INTO :nVid 
 FROM nbu_int WHERE id=:nTip")
.head 7 -  Call SqlFetchNext(hSql(),nFetchRes)
.head 7 -  ! Початковий перелiк вiдкритих рахункiв
.head 7 +  If nVid = 1
.head 8 +  If nTip = 1
.head 9 -  Set sSel   = 
"SELECT nls, kv, nms, pap, 1, daos 
 INTO :colNLSA, :colKV, :colNMS, :colPAP, :colPO, :colDat
 FROM accounts 
 WHERE nbs is not null AND nls not like '0%' 
   AND daos<=:dDat AND (dazs is null OR dazs>:dDat) 
 ORDER BY nls, kv"
.head 8 +  Else If nTip = 2
.head 9 -  Set sSel = 
"SELECT a.nls, a.kv, a.nms, a.pap, decode(a.chgaction,0,1,a.chgaction), a.chgdate 
   INTO :colNLSA, :colKV, :colNMS, :colPAP, :colPO, :colDat
   FROM accounts_update a 
  WHERE to_char(a.chgdate,'dd/MM/yyyy')=to_char(:dDat,'dd/MM/yyyy') 
    AND a.nbs is not null AND a.nls not like '0%' 
    AND (   (a.chgaction=2 AND
            (  a.acc=( SELECT acc FROM accounts_update u 
                        WHERE a.acc=u.acc AND (a.nms<>u.nms OR a.pap<>u.pap ) 
                          AND u.idupd=(SELECT max(b.idupd) FROM accounts_update b 
                                        WHERE b.acc=a.acc 
                                          AND b.chgdate<=a.chgdate and b.idupd<a.idupd) ) 
             OR a.idupd=(SELECT min(idupd) FROM accounts_update WHERE acc=a.acc))
            )
         OR 
            (a.chgaction=1 OR a.chgaction=3 OR a.chgaction=0) 
        ) 
  ORDER BY a.nls, a.kv, a.idupd"
.head 7 -  ! Файл проводок
.head 7 +  Else If nVid = 2
.head 8 -  Set sSel = "SELECT 
v.vob, 
decode(o.mfoa,o.mfob,1,
       decode(d1.tt,o.tt,decode(o.mfoa,:sBankMfo,o.dk,
                                abs(o.dk-1)),
              1)) DK,
decode(o.mfoa,o.mfob,1,
       decode(d1.tt,o.tt,decode(o.mfoa,:sBankMfo,2,
                                3),
              1)) NM, 
decode(d1.tt,o.tt,decode(o.mfoa,:sBankMfo,decode(o.mfob,null,0,o.mfob),
                         decode(o.mfoa,null,0,o.mfoa)),
       :sBankMfo) MFO, 
decode(o.mfoa,o.mfob,decode(o.tt,'R00',decode(o.dk,0,k2.nls,d2.nls),
                            decode(o.tt,'R01',decode(o.dk,0,o.nlsb,o.nlsa),
                                   d2.nls)),
       decode(o.mfoa,:sBankMfo,decode(d1.tt,o.tt,o.nlsa,
                                        decode(o.dk,0,k2.nls,d2.nls)),
              decode(d1.tt,o.tt,decode(o.dk,0,d2.nls,k2.nls),
                     d2.nls))) NLSA, 
decode(o.mfoa,o.mfob,decode(o.tt,'R00',decode(o.dk,1,k2.nls,d2.nls),
                            decode(o.tt,'R01',decode(o.dk,1,o.nlsb,o.nlsa),
                                   k2.nls)),
       decode(o.mfoa,:sBankMfo,decode(d1.tt,o.tt,o.nlsb,
                                        decode(o.dk,0,d2.nls,k2.nls)),
              decode(d1.tt,o.tt,o.nlsa,
                     decode(o.dk,0,d2.nls,k2.nls)))) NLSB, 
d2.kv, least(d1.S,k1.S) S, least(d1.SQ,k1.SQ) SQ, 
decode(o.mfoa,o.mfob,'',
       decode(d1.tt,o.tt,decode(mfoa,:sBankMfo,o.nam_b,o.nam_a),
              '')) NAM, 
decode(d1.tt,o.tt,o.nazn,t.name) NAZN, v.name 
INTO :colVOB,  :colDK,   :colNM, :colMFO,
     :colNLSA, :colNLSB, :colKV, :colOstV, :colOst,
     :colNamB, :colNazn, :colVOBs 
FROM oper o, tts t,
     ( select p.ref, p.tt, p.dk,
              case when a.nbs is not null then a.acc
                   else a.accc
              end acc,
              p.fdat, p.s, p.sq, p.txt, p.stmt, p.sos
         from opldok p, accounts a
        where p.acc = a.acc and p.fdat = :dDat
      ) d1,
      ( select p.ref, p.tt, p.dk,
              case when a.nbs is not null then a.acc
                   else a.accc
              end acc,
              p.fdat, p.s, p.sq, p.txt, p.stmt, p.sos
         from opldok p, accounts a
        where p.acc = a.acc and p.fdat = :dDat
      ) k1, accounts d2, accounts k2, vob v 
WHERE o.ref=d1.ref    AND t.tt=d1.tt AND d1.sos=5 AND d1.dk=0 AND
      d1.fdat=k1.fdat AND k1.sos=5   AND k1.dk=1  AND d1.ref=k1.ref AND
      d1.tt=k1.tt     AND d1.fdat=k1.fdat AND d1.stmt=k1.stmt AND d1.acc=d2.acc AND
      k1.acc=k2.acc   AND d2.kv=k2.kv AND o.vob=v.vob AND d1.fdat=:dDat AND
      d2.nbs is not null and k2.nbs is not null " || 
      IifS( nTip=10, " AND t.tt not like 'ZG%' ", "" ) || "
ORDER BY 5,6,3,4,7,8,9,1 "
.head 7 -  ! Файл залишкiв
.head 7 +  Else
.head 8 +  If SqlPLSQLCommand(hSql(), "bars.p_bs(dDat,nTip)")
.head 9 -  Call SqlCommit(hSql())
.head 9 -  ! Файл залишкiв на грн. рахунках
.head 9 +  If nVid = 3
.head 10 -  Set sSel = 
"SELECT n.nls, n.ostv, n.dosv, n.kosv, n.dk 
 INTO :colNLSA, :colOst, :colDOS, :colKOS, :colDK 
 FROM tmp_nbubs n, accounts a 
 WHERE n.acc=a.acc and a.nbs is not null 
 ORDER BY n.nls"
.head 9 -  ! Файл залишкiв на вал. рахунках
.head 9 +  Else If nVid = 4
.head 10 -  Set sSel = 
"select nls, to_number(kv), abs(ostv), dosv, kosv, abs(ost), dos, kos, decode(sign(ost),1,1,0) dk
   into :colNLSA, :colKV, :colOstV, :colDOSV, :colKOSV, 
        :colOst, :colDOS, :colKOS, :colDK 
   from (SELECT n.nls, substr(' '||to_char(a.kv),-3) kv, 
                sum(n.ostv*decode(n.dk,0,-1,1)) ostv, sum(n.dosv) dosv, sum(n.kosv) kosv,
                sum(n.ost*decode(n.dk,0,-1,1)) ost, sum(n.dos) dos, sum(n.kos) kos 
           FROM tmp_nbubs n, accounts a 
          WHERE n.acc=a.acc and a.nbs is not null
          group by n.nls, substr(' '||to_char(a.kv),-3) )
  ORDER BY nls, kv"
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  Return fReturn
.head 5 +  Function: Populate
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: nTip_
.head 7 -  Date/Time: dDat_
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nTip = nTip_
.head 7 -  Set dDat = dDat_
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 5 +  Function: SaveStrToFile
.head 6 -  Description: Создаем файл
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sFPath
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sFName
.head 7 -  Number: nRow
.head 7 -  Number: nLength
.head 7 -  String: sStr
.head 7 -  File Handle: hDelFile
.head 7 -  Long String: szLineSign
.head 7 -  Number: nSignLen
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  ! Set hFile = _sopen( sFPath, O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
				_SH_DENYRW, _S_IREAD | _S_IWRITE )
.head 7 -  Set hFile = _sopen(sFPath, 0x00008302, 0x00000010, 0x00000180)
.head 7 +  If hFile != -1
.head 8 -  Set sFName = Right(sFPath, 12)
.head 8 -  ! Служебная строка
.head 8 -  Call _write(hFile, SalStrRepeatX( ' ', 100 ) || PutCrLf(), 102)
.head 8 -  ! Заголовок
.head 8 +  If GetSignType()='NBU'
.head 9 -  Set nSignLen = 64
.head 8 +  Else If GetSignType()='UNI'
.head 9 -  Set nSignLen = 88
.head 8 -  Set nLength = 35+2*nSignLen
.head 8 -  Set sStr = Right(sFName, 12) ||
     SalFmtFormatDateTime(SalDateCurrent(), 'yyMMdd') ||
     SalStrRightX('0' || SalFmtFormatDateTime(SalDateCurrent(), 'hhhhmm'), 4) ||
     PadL(Str(nRec), 5) || 
     SalStrRepeatX(' ', 6+2*nSignLen) || PutCrLf()
.head 8 -  Call _write( hFile, sStr, nLength )
.head 8 -  Set nRow = TBL_MinRow ! Сохранение информационных строк
.head 8 +  If nVid = 1
.head 9 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 10 -  Call SalTblSetContext(hWndForm, nRow)
.head 10 -  Call ToFileBS_1(colDat, hFile, nLength)
.head 8 +  Else If nVid = 2
.head 9 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 10 -  Call SalTblSetContext(hWndForm, nRow)
.head 10 -  Call ToFileBS_2(dDat, hFile, nLength)
.head 8 +  Else If nVid = 3
.head 9 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 10 -  Call SalTblSetContext(hWndForm, nRow)
.head 10 -  Call ToFileBS_3(dDat, hFile, nLength)
.head 8 +  Else If nVid = 4
.head 9 +  While SalTblFindNextRow(hWndForm, nRow, 0, 0)
.head 10 -  Call SalTblSetContext(hWndForm, nRow)
.head 10 -  Call ToFileBS_4(dDat, hFile, nLength)
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 +  If GetSignOn()
.head 9 +  If NOT sFile(hFile, nLength)
.head 10 -  Call SalMessageBox('Не удалось подписать файл', 'Ошибка', MB_IconStop)
.head 10 -  Call _close(hFile)
.head 10 -  Call SalFileOpen(hDelFile, strFileName, OF_Delete)
.head 10 -  Return FALSE
.head 8 -  !
.head 8 -  Call _close(hFile)
.head 8 -  Return TRUE
.head 7 +  Else
.head 8 -  Call MessageInfoEx('Ошибка создания файла ' || sFPath)
.head 8 -  Return FALSE
.head 5 +  Function: ToFileBS_1
.head 6 -  Description: Записываем строку в файл
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Date/Time: dDat
.head 7 -  Number: nhFile
.head 7 -  Receive Number: nLength
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sStr
.head 6 +  Actions
.head 7 -  Set nLength = 65
.head 7 -  Set sStr = 
  Right(' ' || Str( colPO ), 1) ||
  Right(SalStrRepeatX(' ', 14) || colNLSA, 14) ||
  Right(SalStrRepeatX(' ',  3) || Str(colKV), 3) ||
  Left(StrWinToDosX(colNMS) || SalStrRepeatX(' ',  38), 38) ||
  Right(' ' || Str(colPAP), 1) ||
  Right('00' || Str(SalDateYear(dDat)),  2) ||
  Right('00' || Str(SalDateMonth(dDat)), 2) ||
  Right('00' || Str(SalDateDay(dDat)),   2)
.head 7 -  Set sStr = sStr || PutCrLf()
.head 7 -  Call _write(nhFile, sStr, nLength)
.head 5 +  Function: ToFileBS_2
.head 6 -  Description: Записываем строку в файл
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Date/Time: dDat
.head 7 -  Number: nhFile
.head 7 -  Receive Number: nLength
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sStr
.head 6 +  Actions
.head 7 -  Set nLength = 276
.head 7 -  Set sStr = 
  Right(SalStrRepeatX(' ', 2) || Str(colVOB), 2) ||
  Right(' ' || Str(colDK), 1) ||
  Right(' ' || Str(colNM), 1) ||
  Right(SalStrRepeatX(' ',  9) || colMFO, 9) ||
  Right(SalStrRepeatX(' ', 14) || colNLSA, 14) ||
  Right(SalStrRepeatX(' ', 14) || colNLSB, 14) ||
  Right(SalStrRepeatX(' ',  3) || Str(colKV), 3) ||
  Right(SalStrRepeatX(' ', 16) || Str(colOstV), 16) ||
  Right(SalStrRepeatX(' ', 16) || Str(colOst), 16) ||
  Left(StrWinToDosX(colNamB) || SalStrRepeatX(' ', 38 ), 38) ||
  Left(StrWinToDosX(colNazn) || SalStrRepeatX(' ', 160), 160)
.head 7 -  Set sStr = sStr || PutCrLf()
.head 7 -  Call _write(nhFile, sStr, nLength)
.head 5 +  Function: ToFileBS_3
.head 6 -  Description: Записываем строку в файл
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Date/Time: dDat
.head 7 -  Number: nhFile
.head 7 -  Receive Number: nLength
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sStr
.head 6 +  Actions
.head 7 -  Set nLength = 64
.head 7 -  Set sStr = 
  Right(SalStrRepeatX(' ', 14) || colNLSA, 14) ||
  Right(SalStrRepeatX(' ', 15) || IifS(colDK=0, IifS(colOst=0, '','-'), '') || Str(colOst), 16) ||
  Right(SalStrRepeatX(' ', 16) || Str(colDOS), 16) ||
  Right(SalStrRepeatX(' ', 16) || Str(colKOS), 16)
.head 7 -  Set sStr = sStr || PutCrLf()
.head 7 -  Call _write(nhFile, sStr, nLength)
.head 5 +  Function: ToFileBS_4
.head 6 -  Description: Записываем строку в файл
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Date/Time: dDat
.head 7 -  Number: nhFile
.head 7 -  Receive Number: nLength
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sStr
.head 6 +  Actions
.head 7 -  Set nLength = 115
.head 7 -  Set sStr = 
  Right(SalStrRepeatX(' ', 14) || colNLSA, 14) ||
  Right(SalStrRepeatX(' ',  3) || Str(colKV), 3) ||
  Right(SalStrRepeatX(' ', 16) || IifS(colDK=0, IifS(colOstV=0, '','-'), '' ) || Str(colOstV), 16) ||
  Right(SalStrRepeatX(' ', 16) || Str(colDOSV), 16) ||
  Right(SalStrRepeatX(' ', 16) || Str(colKOSV), 16) ||
  Right(SalStrRepeatX(' ', 16) || IifS(colDK=0, IifS(colOst=0, '','-'), '') || Str(colOst), 16) ||
  Right(SalStrRepeatX(' ', 16) || Str(colDOS), 16) ||
  Right(SalStrRepeatX(' ', 16) || Str(colKOS), 16)
.head 7 -  Set sStr = sStr || PutCrLf()
.head 7 -  Call _write( nhFile, sStr, nLength )
.head 5 +  Function: SaveToBD
.head 6 -  Description: Сохраняем данные в БД
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  String: sFName
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 +  If SqlPrepareAndExecute(hSql(), 
"INSERT INTO nbu_zag_bs(fn,dat,datf,nums,numODB,num9,sumODB,sum9)
 VALUES(:sFName,:dDat,sysdate,:nRec,:nNumODB,:nNum9,:nSumODB,:nSum9)")
.head 8 -  Return TRUE
.head 7 -  Return FALSE
.head 5 +  Function: sFile         ! Подписать файл
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nFile
.head 7 -  Number: nLength
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Long String: lsSignF
.head 7 -  Long String: lsSignZ
.head 7 -  Number: nSignLen
.head 7 -  !
.head 7 -  Number: nErrorSign
.head 7 -  String: strErrorSign
.head 7 -  Number: nN
.head 7 -  String: sN
.head 6 +  Actions
.head 7 -  Set lsSignF = SalStrRepeatX(' ', 88)
.head 7 -  Set lsSignZ = SalStrRepeatX(' ', 88)
.head 7 +  If NOT GetSignOn()	!  ЭЦП отключена - вернуть Пусто
.head 8 -  Return TRUE
.head 7 +  If GetSignType()='NBU'
.head 8 -  Set nSignLen = 64
.head 7 +  Else If GetSignType()='UNI'
.head 8 -  Set nSignLen = 88 
.head 7 +  Else
.head 8 -  Set nSignLen = 0 
.head 7 -  Set sN = '     '
.head 7 -  Call _lseek(nFile, 102+22, FILE_SeekBegin)
.head 7 -  ! вычитываем sN из файла (кол-во строк)
.head 7 -  Call _read(nFile, sN, 5)
.head 7 -  Set nN = SalStrToNumber(sN)
.head 7 -  ! посмотреть, куда записать ЕЦП
.head 7 +  If nN > 0		! Подписываем файл со строками
.head 8 -  Set nErrorSign = fileSigner.SignFile(
	nFile,
	nN,
	102+35+2*nSignLen, 
	nLength, 
	nLength,
	nSignLen,
	lsSignF
	)
.head 8 -  ! Call Debug( 'nSignLen='||SalNumberToStrX( nSignLen, 0 ) )
.head 8 +  If nErrorSign = 0    ! 0=ok, ЕЦП файла
.head 9 -  Call _lseek(nFile, 102+27, FILE_SeekBegin)
.head 9 -  Call _write(nFile, lsSignF, nSignLen)
.head 7 +  If nErrorSign = 0      ! 0=ok, ид-р ключа ЕЦП
.head 8 -  Call _lseek(nFile, 102+27+nSignLen, FILE_SeekBegin)
.head 8 +  If GetSignType() = 'NBU' 
.head 9 -  Call _write(nFile, strOperId, 6)
.head 9 -  Call _commit(nFile)
.head 8 +  Else If GetSignType() = 'UNI'
.head 9 -  Call _write(nFile, strOperId_UNI, 6 )
.head 9 -  Call _commit(nFile)
.head 8 -  Set nErrorSign = fileSigner.SignFile(
	nFile,
	1,
	102, 
	33+nSignLen,
	33+nSignLen,
	nSignLen,
	lsSignZ
	)
.head 8 +  If nErrorSign = 0       ! 0=ok, ЕЦП заголовного рядку
.head 9 -  Call _lseek(nFile, 102+27+nSignLen+6, FILE_SeekBegin)
.head 9 -  Call _write(nFile, lsSignZ, nSignLen)
.head 7 +  If nErrorSign = 0
.head 8 -  Return TRUE
.head 7 +  Else
.head 8 -  Set strErrorSign = '>> RSA. Ошибка наложения ЭЦП: ' || NumberToStr( nErrorSign )
.head 8 -  Call MessageAttention(strErrorSign)
.head 7 -  Return FALSE
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set sBankMfo = GetBankMfo()
.head 6 -  Set nTip = 0
.head 6 -  Set nVid = 0
.head 5 +  On UM_Populate
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTblDefineSplitWindow(hWndForm, 0, FALSE)
.head 6 -  Set nRec = 0
.head 6 -  Set nNumODB = 0
.head 6 -  Set nNum9 = 0
.head 6 -  Set nSumODB = 0
.head 6 -  Set nSum9 = 0
.head 6 +  If CaseSqlSelect(dDat, nTip, sStrSel) AND sStrSel
.head 7 -  Call SalTblPopulate(hWndForm, hSql(), T(sStrSel) , TBL_FillAll)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set nRec = nRec + 1
.head 6 +  If Subs(colNLSA,0,1) != '9'
.head 7 -  Set nNumODB = nNumODB + 1
.head 7 -  Set nSumODB = nSumODB + IifN(nTip=3, colOst, IifN(colDK=0, colOst, 0))
.head 6 +  Else
.head 7 -  Set nNum9 = nNum9 + 1
.head 7 -  Set nSum9 = nSum9 + IifN(nTip=3, colOst, IifN(colDK=0, colOst, 0))
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: cTimer
.head 3 -  Radio Button:
.head 3 -  Option Button:
.head 3 -  Check Box:
.head 3 -  Child Table:
.head 3 -  Quest Child Window: cQuickDatabase
.head 3 -  List Box:
.head 3 -  Combo Box: cGenComboBox_DatId
.head 3 -  Picture:
.head 3 -  Vertical Scroll Bar:
.head 3 -  Horizontal Scroll Bar:
.head 3 -  Column:
.head 3 -  Background Text:
.head 3 -  Group Box:
.head 3 -  Line:
.head 3 -  Frame:
.head 3 -  Custom Control:
.head 2 -  Application Actions
.head 1 +  Form Window: frm_BSFiles	! с файлом BS*.A*
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   -0.01"
.head 4 -  Top:    0.183"
.head 4 -  Width:  14.4"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 7.25"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Формирование BS-файлов для НБУ
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.667"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 -  Group Box: Дата файлу
.head 5 -  Resource Id: 46586
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.133"
.head 6 -  Top:    0.107"
.head 6 -  Width:  2.229"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.521"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: 3D Shadow Color
.head 5 -  Background Color: Default
.head 4 +  Combo Box: dfDat
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenComboBox_DatId
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.35"
.head 6 -  Top:    0.298"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 2.583"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Editable? Class Default
.head 5 -  String Type: Class Default
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Sorted? Class Default
.head 5 -  Always Show List? Class Default
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 5 -  List Initialization
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Call dfDat.Init(hWndItem)
.head 7 -  Call dfDat.Populate(hSql(), "fdat", "to_char(fdat,'dd/MM/yyyy')", "fdat", "ORDER BY fdat desc")
.head 7 -  Call dfDat.SetSelectById(dDat)
.head 7 -  Call SalSendMsg(dfDat, SAM_Click, 0, 0)
.head 6 +  On SAM_Click
.head 7 -  Call SalTblReset(tblD)
.head 7 -  Call SalDisableWindow(pbFormF)
.head 7 -  Set dDat = SalStrToDate(dfDat)
.head 4 -  Group Box: Файл 
.head 5 -  Resource Id: 46587
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.5"
.head 6 -  Top:    0.104"
.head 6 -  Width:  6.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.524"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: 3D Shadow Color
.head 5 -  Background Color: Default
.head 4 +  Combo Box: cmbTip
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenComboBox_NumId
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.6"
.head 6 -  Top:    0.292"
.head 6 -  Width:  6.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.048"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Editable? No
.head 5 -  String Type: String
.head 5 -  Maximum Data Length: Default
.head 5 -  Sorted? No
.head 5 -  Always Show List? No
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Font Name: Courier
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: System Window Color
.head 5 -  Input Mask: Unformatted
.head 5 -  List Initialization
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 +  If cmbTip.Init(hWndItem)
.head 8 -  Call cmbTip.Populate(hSql(), 'ID', 'NAME', 'NBU_INT', 'ORDER BY id')
.head 8 -  Call cmbTip.SetSelectById(tblD.nTip)
.head 7 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 6 +  On SAM_Click
.head 7 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 7 -  Call SalTblReset(tblD)
.head 7 -  Set tblD.nTip = cmbTip.nCurrentId
.head 7 +  If tblD.nTip = NUMBER_Null
.head 8 -  Call SalDisableWindow(pbExecute)
.head 7 +  Else
.head 8 -  Call SalEnableWindow(pbExecute)
.head 7 -  Call SalDisableWindow(pbFormF)
.head 4 +  Pushbutton: pbExecute
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbExecute
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   9.429"
.head 6 -  Top:    0.25"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Наповнити таблицю даними для файлу'
.head 6 +  On SAM_Click
.head 7 -  Call SalSetWindowText(hWndForm, sTitle || ': ' || cmbTip.GetNameById(tblD.nTip))
.head 7 -  Call tblD.Populate(tblD.nTip, dDat)
.head 7 -  Call SetEditCol()
.head 7 -  Call SalEnableWindow(pbFormF)
.head 4 +  Pushbutton: pbFormF
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbUpdate
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   9.883"
.head 6 -  Top:    0.25"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \Bars98\RESOURCE\BMP\Tomail.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Сформувати файл'
.head 6 +  On SAM_Click
.head 7 +  If GetSignType()='NBU'
.head 8 -  Set strOperId = SalStrReplaceX(GetIdOper(), 3, 1, 'B')
.head 7 +  Else If GetSignType()='UNI'
.head 8 -  Set strOperId = GetIdOper()
.head 7 -  Call tblD.fileSigner.SetVariables( 
  GetSignType(),
  GetOpenKeyDir(),
  GetSecretKeyDrv(),
  strOperId,
  GetKeyDate(),
  5
 )
.head 7 +  If NOT tblD.fileSigner.Init()
.head 8 -  Return FALSE
.head 7 -  Call FCreate(Path_BSF, tblD.nTip, dDat)
.head 7 -  Call tblD.fileSigner.Deinit()
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   10.333"
.head 6 -  Top:    0.25"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Завершити роботу'
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow (hWndForm)
.head 2 +  Contents
.head 3 +  Child Table: tblD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTableBS
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  10.714"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 3.573"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  View: Class Default
.head 5 -  Allow Row Sizing? Class Default
.head 5 -  Lines Per Row: Class Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Class Default
.head 5 -  Discardable? Class Default
.head 4 +  Contents
.head 5 +  Column: colNLSA
.head 6 -  Class Child Ref Key: 1
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKV
.head 6 -  Class Child Ref Key: 2
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNMS
.head 6 -  Class Child Ref Key: 3
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colPAP
.head 6 -  Class Child Ref Key: 4
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDat
.head 6 -  Class Child Ref Key: 24
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colPO
.head 6 -  Class Child Ref Key: 6
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colVOB
.head 6 -  Class Child Ref Key: 7
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colVOBs
.head 6 -  Class Child Ref Key: 25
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDK
.head 6 -  Class Child Ref Key: 9
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNM
.head 6 -  Class Child Ref Key: 10
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colMFO
.head 6 -  Class Child Ref Key: 11
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNLSB
.head 6 -  Class Child Ref Key: 12
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colOstV
.head 6 -  Class Child Ref Key: 17
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDOSV
.head 6 -  Class Child Ref Key: 18
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKOSV
.head 6 -  Class Child Ref Key: 19
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colOst
.head 6 -  Class Child Ref Key: 20
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDOS
.head 6 -  Class Child Ref Key: 21
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKOS
.head 6 -  Class Child Ref Key: 22
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNamB
.head 6 -  Class Child Ref Key: 15
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNazn
.head 6 -  Class Child Ref Key: 16
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: SetEditCol
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call SalTblReset( tblD )
.head 5 -  Call SalTblSetColumnTitle(tblD.colNLSA, 'Рахунок')
.head 5 -  Call SalTblSetColumnTitle(tblD.colDat, 'Дата
операцii')
.head 5 -  Call SalTblSetColumnTitle(tblD.colOstV, 'Залишок
в вал.')
.head 5 -  Call SalTblSetColumnTitle(tblD.colOst, 'Залишок')
.head 5 -  Call SalHideWindow(tblD.colKV)
.head 5 -  Call SalHideWindow(tblD.colNMS)
.head 5 -  Call SalHideWindow(tblD.colPAP)
.head 5 -  Call SalHideWindow(tblD.colDat)
.head 5 -  Call SalHideWindow(tblD.colPO)
.head 5 -  Call SalHideWindow(tblD.colVOBs)
.head 5 -  Call SalHideWindow(tblD.colDK)
.head 5 -  Call SalHideWindow(tblD.colNM)
.head 5 -  Call SalHideWindow(tblD.colMFO)
.head 5 -  Call SalHideWindow(tblD.colNLSB)
.head 5 -  Call SalHideWindow(tblD.colNamB)
.head 5 -  Call SalHideWindow(tblD.colNazn)
.head 5 -  Call SalHideWindow(tblD.colOstV)
.head 5 -  Call SalHideWindow(tblD.colDOSV)
.head 5 -  Call SalHideWindow(tblD.colKOSV)
.head 5 -  Call SalHideWindow(tblD.colOst)
.head 5 -  Call SalHideWindow(tblD.colDOS)
.head 5 -  Call SalHideWindow(tblD.colKOS)
.head 5 +  Select Case tblD.nVid
.head 6 -  ! Рахунки
.head 6 +  Case 1
.head 7 +  If tblD.nTip = 1
.head 8 -  Call SalTblSetColumnTitle(tblD.colDat, 'Дата
вiдкриття
рахунку')
.head 8 -  Call SalShowWindow(tblD.colDat)
.head 7 -  Call SalShowWindow(tblD.colKV)
.head 7 -  Call SalShowWindow(tblD.colNMS)
.head 7 -  Call SalShowWindow(tblD.colPAP)
.head 7 -  Call SalShowWindow(tblD.colPO)
.head 7 -  Break
.head 6 -  ! Проводки
.head 6 +  Case 2
.head 7 -  Call SalTblSetColumnTitle(tblD.colNLSA, 'Рахунок А')
.head 7 -  Call SalTblSetColumnTitle(tblD.colOstV, 'Сума
в валютi')
.head 7 -  Call SalTblSetColumnTitle(tblD.colOst, 'Сума
в екв.')
.head 7 -  Call SalShowWindow(tblD.colVOBs)
.head 7 -  Call SalShowWindow(tblD.colDK)
.head 7 -  Call SalShowWindow(tblD.colNM)
.head 7 -  Call SalShowWindow(tblD.colMFO)
.head 7 -  Call SalShowWindow(tblD.colNLSB)
.head 7 -  Call SalShowWindow(tblD.colKV)
.head 7 -  Call SalShowWindow(tblD.colOstV)
.head 7 -  Call SalShowWindow(tblD.colOst)
.head 7 -  Call SalShowWindow(tblD.colNamB)
.head 7 -  Call SalShowWindow(tblD.colNazn)
.head 7 -  Break
.head 6 -  ! грн.
.head 6 +  Case 3
.head 7 -  Call SalShowWindow(tblD.colOst)
.head 7 -  Call SalShowWindow(tblD.colDOS)
.head 7 -  Call SalShowWindow(tblD.colKOS)
.head 7 -  Call SalShowWindow(tblD.colDK)
.head 7 -  Break
.head 6 -  ! вал.
.head 6 +  Case 4
.head 7 -  Call SalShowWindow(tblD.colKV)
.head 7 -  Call SalShowWindow(tblD.colOstV)
.head 7 -  Call SalShowWindow(tblD.colDOSV)
.head 7 -  Call SalShowWindow(tblD.colKOSV)
.head 7 -  Call SalShowWindow(tblD.colOst)
.head 7 -  Call SalShowWindow(tblD.colDOS)
.head 7 -  Call SalShowWindow(tblD.colKOS)
.head 7 -  Call SalShowWindow(tblD.colDK)
.head 7 -  Call SalShowWindow(tblD.colKV)
.head 7 -  Break
.head 6 +  Default
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Break
.head 3 +  Function: FCreate   ! nbu_zag_bs
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: sFPath
.head 5 -  Number: nTip
.head 5 -  Date/Time: dDat
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nFileNum
.head 5 -  String: sFName
.head 4 +  Actions
.head 5 -  Set nFileNum = 0
.head 5 -  ! указать путь
.head 5 -  Set sFName = GetFileName(nTip, dDat, nFileNum)
.head 5 -  Set sFPath = Path_BSF || '\\' || sFName
.head 5 -  ! Get confirmation from user
.head 5 +  If MessageQuestion('Сформувати файл ' || sFPath || ' ?') = IDNO
.head 6 -  Return FALSE
.head 5 -  ! Create files
.head 5 +  If tblD.SaveStrToFile(sFPath)
.head 6 -  ! Update file number sequence
.head 6 -  Call MessageInfoEx('Файл ' || sFPath || ' сформований.')
.head 6 -  Call FunBackUpFile(sFPath, Path_Backup, FALSE)
.head 6 +  If tblD.SaveToBD(sFName)
.head 7 -  Call SqlCommit(hSql())
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: dDat
.head 3 -  String: strSignType
.head 3 -  String: strFileName
.head 3 -  String: sTipRF
.head 3 -  String: sTitle
.head 3 -  Number: i
.head 3 -  String: sTmp
.head 3 -  !
.head 3 -  Number: nX
.head 3 -  Number: nY
.head 3 -  Number: nW
.head 3 -  Number: nH
.head 3 -  Number: nWW
.head 3 -  Number: nWH
.head 3 -  Number: nCX
.head 3 -  Number: nCY
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set sTitle = 'Формування файлiв BS'
.head 4 -  Call SalSetWindowText(hWndForm, sTitle)
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call SalDisableWindow(pbFormF)
.head 4 -  Set dDat = GetBankDate()
.head 3 +  On WM_Size
.head 4 -  Call SalGetWindowSize(hWndForm, nWW, nWH)
.head 4 +  If nWW >= 12
.head 5 +  If nWH < 4
.head 6 -  Call SalSetWindowSize(hWndForm, nWW, 4)
.head 4 +  Else
.head 5 +  If nWH < 4
.head 6 -  Call SalSetWindowSize(hWndForm, 12, 4)
.head 5 +  Else
.head 6 -  Call SalSetWindowSize(hWndForm, 12, nWH)
.head 4 -  Call GetClientRect(hWndForm, nX, nY, nW, nH)
.head 4 -  Call SalSetWindowSize(hWndForm.frm_BSFiles.tblD,
	SalPixelsToFormUnits(hWndForm.frm_BSFiles.tblD, nW-nX, FALSE),
	SalPixelsToFormUnits(hWndForm.frm_BSFiles.tblD, nH-nY, TRUE))
.head 4 -  Call SalUpdateWindow(hWndForm)
.head 1 +  Form Window: frm_L     ! с файлом P
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   0.66"
.head 4 -  Top:    0.708"
.head 4 -  Width:  12.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.438"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Формирование L-файлов для НБУ
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.5"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Radio Button: rb1
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Обновленные
.head 5 -  Window Location and Size
.head 6 -  Left:   0.171"
.head 6 -  Top:    0.021"
.head 6 -  Width:  1.857"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Radio Button: rbAll
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Все
.head 5 -  Window Location and Size
.head 6 -  Left:   0.171"
.head 6 -  Top:    0.281"
.head 6 -  Width:  1.857"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Check Box: cbF0
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: L0-файл
.head 5 -  Window Location and Size
.head 6 -  Left:   2.471"
.head 6 -  Top:    0.156"
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbRefresh
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.3"
.head 6 -  Top:    0.115"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Перечитать записи'
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbFilter
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.729"
.head 6 -  Top:    0.115"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Фильтр'
.head 6 +  On SAM_Click
.head 7 +  If SetQueryFilter(cF)
.head 8 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSearch
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.157"
.head 6 -  Top:    0.115"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Поиск'
.head 6 +  On SAM_Click
.head 7 -  Call TblFindString(tblD, DFIND_First)
.head 4 +  Pushbutton: pbFormF
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbUpdate
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   5.786"
.head 6 -  Top:    0.115"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Tomail.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Сохранить данные'
.head 6 +  On SAM_Click
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  If cbF0
.head 8 -  Set rbAll = 1
.head 7 -  ! Сохранение информационных строк
.head 7 -  Set nRow = TBL_MinRow
.head 7 -  ! обновленные
.head 7 +  If rb1
.head 8 +  Loop
.head 9 +  If SalTblFindNextRow(tblD, nRow, 0, 0)
.head 10 -  Call SalTblSetContext(tblD, nRow)
.head 10 -  ! сравниваем, поменялось ли значение
.head 10 +  If tblD.colFBS    != mF[nRow,0] 
or tblD.colFBSNew != mF[nRow,1] 
or tblD.colFLTK   != mF[nRow,2] 
or tblD.colLTK    != mL[nRow,0] 
or tblD.colFLNO   != mF[nRow,3] 
or tblD.colLNO    != mL[nRow,1]
.head 11 -  ! выставляем признак edit=1 только для для тех МФО,
  у кот. изменились значения
.head 11 +  If NOT SqlPrepareAndExecute(hSql(), 
"UPDATE rrp
 SET flag_bs=:tblD.colFBS,   flag_bsnew=:tblD.colFBSNew,
     flag_ltk=:tblD.colFLTK, ltk=:tblD.colLTK,
     flag_lno=:tblD.colFLNO, lno=:tblD.colLNO,
     edit=1
 WHERE mfo=:tblD.colMFO AND ts=:tblD.colTS")
.head 12 -  Call SqlRollback(hSql())
.head 12 -  Call SalMessageBox('Ошибка UPDATE RRP...', 'Внимение!', MB_Ok)
.head 12 -  Return FALSE
.head 11 -  Call SaveInfoToLog("$L. Сохранение лимитов для МФО " || tblD.colMFO || 
": флаг установки ЛТК='" || tblD.colFLTK || "', ЛТК=" || Str(tblD.colLTK) || 
"; флаг установки ЛНО='" || tblD.colFLNO || "', ЛНО=" || Str(tblD.colLNO) || ".")
.head 9 +  Else
.head 10 -  Break
.head 7 -  ! все
.head 7 +  If rbAll
.head 8 +  Loop
.head 9 +  If SalTblFindNextRow(tblD, nRow, 0, 0)
.head 10 -  Call SalTblSetContext(tblD, nRow)
.head 10 -  ! выставляем признак edit=1 для всех МФО
.head 10 +  If NOT SqlPrepareAndExecute(hSql(), 
"UPDATE rrp
 SET flag_bs=:tblD.colFBS,   flag_bsnew=:tblD.colFBSNew,
     flag_ltk=:tblD.colFLTK, ltk=:tblD.colLTK,
     flag_lno=:tblD.colFLNO, lno=:tblD.colLNO,
     edit=1
 WHERE mfo=:tblD.colMFO AND ts=:tblD.colTS")
.head 11 -  Call SqlRollback(hSql())
.head 11 -  Call SalMessageBox('Ошибка UPDATE RRP...', 'Внимение!', MB_Ok)
.head 11 -  Return FALSE
.head 10 -  Call SaveInfoToLog("$L. Сохранение лимитов для МФО " || tblD.colMFO || 
": флаг установки ЛТК='" || tblD.colFLTK || "', ЛТК=" || Str(tblD.colLTK) || 
"; флаг установки ЛНО='" || tblD.colFLNO || "', ЛНО=" || Str(tblD.colLNO) || ".")
.head 9 +  Else
.head 10 -  Break
.head 8 +  If cbF0
.head 9 +  If NOT SqlPrepareAndExecute(hSqlAux(), "UPDATE rrp SET edit=1")
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Call SalMessageBox('Ошибка UPDATE RRP...', 'Внимение!', MB_Ok)
.head 10 -  Return FALSE
.head 7 -  ! Создание файла-флажка
.head 7 -  Set fRet = FunCreateFile(Path_LF)
.head 7 -  ! Если файл создан, commit (save info)
.head 7 +  If fRet
.head 8 -  Call SaveInfoToLog('$L. Выставлен флаг ' || IifS(cbF0,'L0.','L для ' || IifS(rb1,'обновленных','всех') || ' МФО.'))
.head 8 -  Call SqlCommit(hSql())
.head 7 +  Else
.head 8 -  Call SqlRollback(hSql())
.head 7 -  Set rb1 = 1
.head 7 +  If nPar != 2
.head 8 -  Set cbF0 = 0
.head 7 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.214"
.head 6 -  Top:    0.115"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Esc
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Завершить работу и выйти'
.head 6 +  On SAM_Click
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 2 +  Contents
.head 3 +  Child Table: tblD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.014"
.head 6 -  Top:    0.021"
.head 6 -  Width:  6.929"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.042"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 30000
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: colMFO
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: МФО
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.8"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colBName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Название банка
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colRP
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Расч.
пал.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.7"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colTS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Тип
сч.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.4"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNLSK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Счет К
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNLSD
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Счет Д
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKV
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вал
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colOST
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Остаток
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colOSTs
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Остаток
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Right
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDig
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: dig
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colFBS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Флаг
блокировки
счета
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colFBSNew
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Флаг
блокировки
счета (нов.)
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colFLTK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Флаг
установки
лим. ЛТП
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colLTK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ЛТП
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colFLNO
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Флаг
установки
лим. ЛНО
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colLNO
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ЛНО
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 -  !
.head 5 +  Column: colP_OSTD
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_OSTD
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_OSTK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_OSTK
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_DOS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_DOS
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_KOS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_KOS
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_FBLK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_FBLK
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_LTK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_LTK
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_LNO
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_LNP
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_SKOS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_SKOS
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_NDOS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_NDOS
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_NKOS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_NKOS
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_NSKOS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: P_NSKOS
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_FName
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colP_FDat
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Left
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  String: s
.head 5 -  Number: nWin
.head 5 -  Number: nF
.head 5 -  Window Handle: hWin
.head 4 +  Message Actions
.head 5 +  On SAM_RowSetContext
.head 6 -  Set nRow = SalTblQueryContext(hWndForm)
.head 6 -  Call SalSetWindowText(cHSpl, ';' || tblD.colP_FName || ' ' || SalFmtFormatDateTime(tblD.colP_FDat, 'dd/MM/yyyy hhhh:mm:ss'))
.head 6 +  If FL_Edit = '1'
.head 7 -  Set dfFBS = colFBS
.head 7 -  Call cmbFBS.SetCurrentKey(colFBS)
.head 7 -  Set cmbFBS = cmbFBS.GetNameById(cmbFBS.strCurrentId)
.head 7 -  Set dfFBSNew = colFBSNew
.head 7 -  Call cmbFBSNew.SetCurrentKey(tblD.colFBSNew)
.head 7 -  Set cmbFBSNew = cmbFBSNew.GetNameById(cmbFBSNew.strCurrentId)
.head 6 -  Set dfFLTK = colFLTK
.head 6 -  Call cmbFLTK.SetCurrentKey(colFLTK)
.head 6 -  Set cmbFLTK = cmbFLTK.GetNameById(cmbFLTK.strCurrentId)
.head 6 -  ! Set dfLTK  = tblD.colLTK
.head 6 -  Set dfLTKs = Dig4(colLTK/100, colDig, colDig)
.head 6 -  Set dfFLNO = colFLNO
.head 6 -  Call cmbFLNO.SetCurrentKey(colFLNO)
.head 6 -  Set cmbFLNO = cmbFLNO.GetNameById(cmbFLNO.strCurrentId)
.head 6 -  ! Set dfLNO  = tblD.colLNO
.head 6 -  Set dfLNOs = Dig4(colLNO/100, colDig, colDig)
.head 6 -  Call SalSendMsg(tblP, UM_Populate, 0, 0)
.head 3 +  Data Field: dfNameFBS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.486"
.head 6 -  Top:    0.115"
.head 6 -  Width:  4.157"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfFBS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.143"
.head 6 -  Top:    0.436"
.head 6 -  Width:  0.286"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbFBS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.486"
.head 5 -  Top:    0.406"
.head 5 -  Width:  4.157"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 1.427"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If FL_Edit = '1'
.head 7 -  Call cmbFBS.Init(hWndItem)
.head 7 -  Call cmbFBS.Populate(hSql(), 'CODE', 'COMM', 'FLAG_LIM', '')
.head 5 +  On SAM_Click
.head 6 -  Call cmbFBS.SetCurrentKey(cmbFBS.GetKey(SalListQuerySelection(hWndItem)))
.head 6 -  Set dfFBS = cmbFBS.strCurrentId
.head 6 -  Set tblD.colFBS = cmbFBS.strCurrentId
.head 6 +  ! If cmbFBS.strCurrentId = ' '
.head 7 -   Call cmbFBSNew.SetSelectById( mF[nRow,1] )
.head 7 -   Set cmbFBSNew = cmbFBSNew.GetNameById( cmbFBSNew.strCurrentId )
.head 6 +  ! If cmbFBS.strCurrentId = 'O'
.head 7 -   Call cmbFBSNew.SetSelectById( ' ' )
.head 7 -   Set cmbFBSNew = cmbFBSNew.GetNameById( cmbFBSNew.strCurrentId )
.head 6 +  If cmbFBS.strCurrentId = sFlag_
.head 7 -  Call cmbFBSNew.SetSelectById(mF[nRow,1])
.head 7 -  Set cmbFBSNew = cmbFBSNew.GetNameById(cmbFBSNew.strCurrentId)
.head 6 +  If cmbFBS.strCurrentId = sFlagO
.head 7 -  Call cmbFBSNew.SetSelectById(' ')
.head 7 -  Set cmbFBSNew = cmbFBSNew.GetNameById(cmbFBSNew.strCurrentId)
.head 6 -  Call SalSendMsg(cmbFBSNew, SAM_User, 0, 0)
.head 5 +  On SAM_User
.head 6 -  Call cmbFBS.SetCurrentKey(cmbFBS.GetKey(SalListQuerySelection(hWndItem)))
.head 6 -  Set dfFBS = cmbFBS.strCurrentId
.head 6 -  Set tblD.colFBS = cmbFBS.strCurrentId
.head 3 +  Data Field: dfNameFBSNew
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.486"
.head 6 -  Top:    0.823"
.head 6 -  Width:  4.157"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfFBSNew
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.171"
.head 6 -  Top:    1.145"
.head 6 -  Width:  0.286"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbFBSNew
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.486"
.head 5 -  Top:    1.115"
.head 5 -  Width:  4.157"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 1.427"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If FL_Edit = '1'
.head 7 -  Call cmbFBSNew.Init(hWndItem)
.head 7 -  Call cmbFBSNew.Populate(hSql(), 'CODE', 'COMM', 'FLAG_K', '')
.head 5 +  On SAM_Click
.head 6 -  Call cmbFBSNew.SetCurrentKey(cmbFBSNew.GetKey(SalListQuerySelection(hWndItem)))
.head 6 -  Set dfFBSNew = cmbFBSNew.strCurrentId
.head 6 -  Set tblD.colFBSNew = cmbFBSNew.strCurrentId
.head 6 -  !
.head 6 -  Call cmbFBS.SetSelectById(sFlagU)
.head 6 -  Set cmbFBS = cmbFBS.GetNameById(cmbFBS.strCurrentId)
.head 6 +  If cmbFBSNew.strCurrentId = sFlag_
.head 7 -  Call cmbFBS.SetSelectById(sFlagO)
.head 7 -  Set cmbFBS = cmbFBS.GetNameById(cmbFBS.strCurrentId)
.head 6 +  If cmbFBSNew.strCurrentId = mF[nRow,1]
.head 7 -  Call cmbFBS.SetSelectById(sFlag_)
.head 7 -  Set cmbFBS = cmbFBS.GetNameById(cmbFBS.strCurrentId)
.head 6 -  Call SalSendMsg(cmbFBS, SAM_User, 0, 0)
.head 5 +  On SAM_User
.head 6 -  Call cmbFBSNew.SetCurrentKey(cmbFBSNew.GetKey(SalListQuerySelection(hWndItem)))
.head 6 -  Set dfFBSNew = cmbFBSNew.strCurrentId
.head 6 -  Set tblD.colFBSNew = cmbFBSNew.strCurrentId
.head 3 +  Data Field: dfNameFLTK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.486"
.head 6 -  Top:    1.521"
.head 6 -  Width:  4.157"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfFLTK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.186"
.head 6 -  Top:    1.822"
.head 6 -  Width:  0.286"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbFLTK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.486"
.head 5 -  Top:    1.792"
.head 5 -  Width:  4.157"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 1.26"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call cmbFLTK.Init(hWndItem)
.head 6 -  Call cmbFLTK.Populate(hSql(), 'CODE', 'COMM', 'FLAG_LIM', '')
.head 5 +  On SAM_Click
.head 6 -  Call cmbFLTK.SetCurrentKey(cmbFLTK.GetKey(SalListQuerySelection(hWndItem)))
.head 6 -  Set dfFLTK = cmbFLTK.strCurrentId
.head 6 -  Set tblD.colFLTK = cmbFLTK.strCurrentId
.head 6 +  If cmbFLTK.strCurrentId = sFlagO
.head 7 -  Set dfLTKs = SalNumberToStrX(0, tblD.colDig)
.head 7 -  Set tblD.colLTK = SalStrToNumber(dfLTKs) * SalNumberPower(10, tblD.colDig)
.head 6 +  If cmbFLTK.strCurrentId = sFlag_
.head 7 -  Set dfLTKs = Dig4(mL[nRow,0]/100, tblD.colDig, tblD.colDig)
.head 7 -  Set tblD.colLTK = SalStrToNumber(dfLTKs) * SalNumberPower(10, tblD.colDig)
.head 5 +  On SAM_User
.head 6 -  Call cmbFLTK.SetCurrentKey(cmbFLTK.GetKey(SalListQuerySelection(hWndItem)))
.head 6 -  Set dfFLTK = cmbFLTK.strCurrentId
.head 6 -  Set tblD.colFLTK = cmbFLTK.strCurrentId
.head 3 +  Data Field: dfSltk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.486"
.head 6 -  Top:    2.134"
.head 6 -  Width:  1.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  ! Data Field: dfLTK
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 16
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.843"
.head 6 -  Top:    2.104"
.head 6 -  Width:  2.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +   Message Actions 
.head 5 +   On SAM_Validate   ! old
.head 6 -   Set tblD.colLTK = dfLTK
.head 6 -  ! If not (cmbFLTK.strCurrentId = ' ' and dfLTK = Val(mD[nRow,3]))
.head 6 -   Call cmbFLTK.SetSelectById( 'U' )
.head 6 -   Set cmbFLTK = cmbFLTK.GetNameById( cmbFLTK.strCurrentId )
.head 6 -   Call SalSendMsg( cmbFLTK, SAM_User, 0, 0 )
.head 3 +  Data Field: dfLTKs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 21
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.843"
.head 6 -  Top:    2.104"
.head 6 -  Width:  2.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If SalStrIsValidNumber(dfLTKs)
.head 7 -  Set tblD.colLTK = SalStrToNumber(dfLTKs) * SalNumberPower(10, tblD.colDig)
.head 7 -  Set dfLTKs = Dig4(tblD.colLTK/100, tblD.colDig, tblD.colDig)
.head 7 -  Call cmbFLTK.SetSelectById(sFlagU)
.head 7 -  Set cmbFLTK = cmbFLTK.GetNameById(cmbFLTK.strCurrentId)
.head 7 -  Call SalSendMsg(cmbFLTK, SAM_User, 0, 0)
.head 3 +  Data Field: dfNameFLNO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.486"
.head 6 -  Top:    2.479"
.head 6 -  Width:  4.157"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfFLNO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.157"
.head 6 -  Top:    2.811"
.head 6 -  Width:  0.286"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbFLNO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_StrId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.486"
.head 5 -  Top:    2.781"
.head 5 -  Width:  4.157"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 1.094"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call cmbFLNO.Init(hWndItem)
.head 6 -  Call cmbFLNO.Populate(hSql(), 'CODE', 'COMM', 'FLAG_LIM', '')
.head 5 +  On SAM_Click
.head 6 -  Call cmbFLNO.SetCurrentKey(cmbFLNO.GetKey(SalListQuerySelection(hWndItem)))
.head 6 -  Set dfFLNO = cmbFLNO.strCurrentId
.head 6 -  Set tblD.colFLNO = cmbFLNO.strCurrentId
.head 6 +  If cmbFLNO.strCurrentId = sFlagO
.head 7 -  Set dfLNOs = SalNumberToStrX(0, tblD.colDig)
.head 7 -  Set tblD.colLNO = SalStrToNumber(dfLNOs) * SalNumberPower(10, tblD.colDig)
.head 6 +  If cmbFLNO.strCurrentId = sFlag_
.head 7 -  Set dfLNOs = Dig4(mL[nRow,1]/100, tblD.colDig, tblD.colDig)
.head 7 -  Set tblD.colLNO = SalStrToNumber(dfLNOs) * SalNumberPower(10, tblD.colDig)
.head 5 +  On SAM_User
.head 6 -  Call cmbFLNO.SetCurrentKey(cmbFLNO.GetKey(SalListQuerySelection(hWndItem)))
.head 6 -  Set dfFLNO = cmbFLNO.strCurrentId
.head 6 -  Set tblD.colFLNO = cmbFLNO.strCurrentId
.head 3 +  Data Field: dfSlno
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.486"
.head 6 -  Top:    3.103"
.head 6 -  Width:  1.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  ! Data Field: dfLNO
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 16
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.843"
.head 6 -  Top:    3.073"
.head 6 -  Width:  2.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 +   Message Actions 
.head 5 +  ! On SAM_Validate
.head 6 -    Set tblD.colLNO = dfLNO
.head 6 +    If dfLNO != 0
.head 7 -    Call cmbFLNO.SetSelectById( 'U' )
.head 7 -    Set cmbFLNO = cmbFLNO.GetNameById( cmbFLNO.strCurrentId )
.head 6 +    Else 
.head 7 +    If cmbFLNO.strCurrentId = ' '
.head 8 +    If dfLNO = Val(mD[i,5])
.head 9 -    Call cmbFLNO.SetSelectById( ' ' )
.head 9 -    Set cmbFLNO = cmbFLNO.GetNameById( cmbFLNO.strCurrentId )
.head 8 +    Else 
.head 9 -    Call cmbFLNO.SetSelectById( 'O' )
.head 9 -    Set cmbFLNO = cmbFLNO.GetNameById( cmbFLNO.strCurrentId )
.head 7 +    Else 
.head 8 -    Call cmbFLNO.SetSelectById( 'O' )
.head 8 -    Set cmbFLNO = cmbFLNO.GetNameById( cmbFLNO.strCurrentId )
.head 6 -    Call SalSendMsg( cmbFLNO, SAM_User, 0, 0 )
.head 5 +  ! On SAM_Validate
.head 6 -    Set tblD.colLNO = dfLNO
.head 6 +    If dfLNO != 0
.head 7 +    If not (cmbFLNO.strCurrentId = ' ' and dfLNO = Val(mD[nRow,5]))
.head 8 -    Call cmbFLNO.SetSelectById( 'U' )
.head 8 -    Set cmbFLNO = cmbFLNO.GetNameById( cmbFLNO.strCurrentId )
.head 6 +    Else 
.head 7 +    If not (cmbFLNO.strCurrentId = ' ' and dfLNO = Val(mD[nRow,5]))
.head 8 -    Call cmbFLNO.SetSelectById( 'U' )
.head 8 -  ! Call cmbFLNO.SetSelectById( 'O' )
.head 8 -    Set cmbFLNO = cmbFLNO.GetNameById( cmbFLNO.strCurrentId )
.head 6 -    Call SalSendMsg( cmbFLNO, SAM_User, 0, 0 )
.head 5 +   On SAM_Validate
.head 6 -   Set tblD.colLNO = dfLNO
.head 6 -  ! If not (cmbFLNO.strCurrentId = ' ' and dfLNO = Val(mD[nRow,5]))
.head 6 -   Call cmbFLNO.SetSelectById( 'U' )
.head 6 -   Set cmbFLNO = cmbFLNO.GetNameById( cmbFLNO.strCurrentId )
.head 6 -   Call SalSendMsg( cmbFLNO, SAM_User, 0, 0 )
.head 5 +  ! On SAM_KillFocus
.head 6 -    Call SalSendMsg( dfLNO, SAM_Validate, 0, 0 )
.head 3 +  Data Field: dfLNOs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 21
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.843"
.head 6 -  Top:    3.073"
.head 6 -  Width:  2.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If SalStrIsValidNumber(dfLTKs)
.head 7 -  Set tblD.colLNO = SalStrToNumber(dfLNOs ) * SalNumberPower(10, tblD.colDig)
.head 7 -  Set dfLNOs = Dig4(tblD.colLNO/100, tblD.colDig, tblD.colDig)
.head 7 -  Call cmbFLNO.SetSelectById(sFlagU)
.head 7 -  Set cmbFLNO = cmbFLNO.GetNameById(cmbFLNO.strCurrentId)
.head 7 -  Call SalSendMsg(cmbFLNO, SAM_User, 0, 0)
.head 3 +  Child Table: tblP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.014"
.head 6 -  Top:    2.646"
.head 6 -  Width:  6.014"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.813"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Default
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: colPar
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Информация по файлу  P
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colVal
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Значение
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Right
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 +  Functions
.head 5 +  Function: FPopPar
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Receive Number: nRow
.head 7 -  String: sPar
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalTblInsertRow(hWndForm, nRow)
.head 7 -  Call SalTblSetContext(hWndForm, nRow)
.head 7 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 7 -  Set colPar = sPar
.head 7 -  Set nRow = nRow + 1
.head 5 +  Function: FPopVal
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Receive Number: nRow
.head 7 -  String: sVal
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalTblSetContext(hWndForm, nRow)
.head 7 -  Set colVal = sVal
.head 7 -  Set nRow = nRow + 1
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set nRowP = 0
.head 6 -  Call FPopPar(nRowP, 'Остаток на счете по дебету')
.head 6 -  Call FPopPar(nRowP, 'Остаток на счете по кредиту')
.head 6 -  Call FPopPar(nRowP, 'Обороты счета по дебету')
.head 6 -  Call FPopPar(nRowP, 'Обороты счета по кредиту')
.head 6 -  Call FPopPar(nRowP, 'Значение флага блокировки счета')
.head 6 -  Call FPopPar(nRowP, 'Значение лимита ЛТК')
.head 6 -  Call FPopPar(nRowP, 'Значение лимита ЛНО')
.head 6 -  Call FPopPar(nRowP, 'Сумма начальных кредитовых оборотов')
.head 6 -  Call FPopPar(nRowP, 'Обороты счета по дебету  вне СЭП')
.head 6 -  Call FPopPar(nRowP, 'Обороты счета по кредиту вне СЭП')
.head 6 -  Call FPopPar(nRowP, 'Начальные кредитовые обороты вне СЭП')
.head 5 +  On UM_Populate
.head 6 -  Set nRowP = 0
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_OSTD/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_OSTK/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_DOS/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_KOS/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, tblD.colP_FBLK)
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_LTK/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_LNO/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_SKOS/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_NDOS/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_NKOS/100, tblD.colDig, tblD.colDig)))
.head 6 -  Call FPopVal(nRowP, IifS(tblD.colP_OSTD = NUMBER_Null, '', Dig4(tblD.colP_NSKOS/100, tblD.colDig, tblD.colDig)))
.head 6 -  Set dfSDS = Dig4((tblD.colP_DOS - tblD.colP_SKOS)/100, tblD.colDig, tblD.colDig)
.head 3 +  Data Field: dfNameSDS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.486"
.head 6 -  Top:    3.521"
.head 6 -  Width:  4.157"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Purple
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfSDS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.486"
.head 6 -  Top:    3.781"
.head 6 -  Width:  4.157"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Purple
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Custom Control: cHSpl
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cXSalHSplitter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  6.7"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 4.521"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Etched Border? Class Default
.head 5 -  Hollow? Class Default
.head 5 -  Vertical Scroll? Class Default
.head 5 -  Horizontal Scroll? Class Default
.head 5 -  Tab Stop? Class Default
.head 5 -  Tile To Parent? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: White
.head 5 -  Background Color: Dark Blue
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: FunCreateFile      !создание
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sFPath
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hF
.head 5 -  String: sF
.head 5 -  File Handle: hDelFile
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If cbF0
.head 6 -  Set sF = sFPath || '\\L0'
.head 5 +  Else
.head 6 -  Set sF = sFPath || '\\L'
.head 5 +  If SalFileOpen(hF, sF, OF_Binary | OF_Create)
.head 6 -  Call SalFileClose(hF)
.head 6 -  Return TRUE
.head 5 +  Else
.head 6 -  Call SalFileOpen(hDelFile, sF, OF_Delete)
.head 6 -  Call MessageInfoEx('Ошибка создания файла ' || sF)
.head 6 -  Return FALSE
.head 2 +  Window Parameters
.head 3 -  Number: nPar
.head 3 -  ! 0 - формирование любого L-файла
  1 - просмотр
  2 - формирование L0
  3 - формирование L* (не L0)
.head 2 +  Window Variables
.head 3 -  String: sTitle
.head 3 -  String: sStrPopulate
.head 3 -  String: sSel
.head 3 -  String: sSel1
.head 3 -  String: sSel1_
.head 3 -  String: sSel2
.head 3 -  String: sStrW
.head 3 -  : cF
.head 4 -  Class: cGenFilter
.head 3 -  Number: nFetchRes
.head 3 -  Date/Time: dDat
.head 3 -  String: Path_LF
.head 3 -  String: FL_Edit
.head 3 -  Date/Time: dLastTime
.head 3 -  Number: nFileNum
.head 3 -  Boolean: fRet
.head 3 -  Number: nRow
.head 3 -  !
.head 3 -  String: sMFO
.head 3 -  String: sBName
.head 3 -  String: sTS
.head 3 -  Number: nKV
.head 3 -  Number: nOST
.head 3 -  Number: nDig
.head 3 -  String: sFBS
.head 3 -  String: sFBSNew
.head 3 -  String: sFLTK
.head 3 -  Number: nLTK
.head 3 -  String: sFLNO
.head 3 -  Number: nLNO
.head 3 -  String: sRP
.head 3 -  String: sNLSK
.head 3 -  String: sNLSD
.head 3 -  String: mF[*,4]
.head 3 -  Number: mL[*,2]
.head 3 -  Number: i
.head 3 -  !
.head 3 -  Number: nRowP
.head 3 -  Number: nP_OSTD
.head 3 -  Number: nP_OSTK
.head 3 -  Number: nP_DOS
.head 3 -  Number: nP_KOS
.head 3 -  String: sP_FBLK
.head 3 -  Number: nP_LTK
.head 3 -  Number: nP_LNO
.head 3 -  Number: nP_SKOS
.head 3 -  Number: nP_NDOS
.head 3 -  Number: nP_NKOS
.head 3 -  Number: nP_NSKOS
.head 3 -  String: sP_FName
.head 3 -  Date/Time: dP_FDat
.head 3 -  !
.head 3 -  Number: nWW
.head 3 -  Number: nWH
.head 3 -  Number: nX
.head 3 -  Number: nY
.head 3 -  Number: nW
.head 3 -  Number: nH
.head 3 -  Number: nCX
.head 3 -  Number: nCY
.head 2 +  Message Actions
.head 3 +  On SAM_Create		! с проверкой на блок. МФО и закр. счета
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set sTitle = 'Формирование файлов L'
.head 4 -  Call SalSetWindowText(hWndForm, sTitle)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  Call cHSpl.setBarPosition(480)
.head 4 -  ! Call cH.setStyle( XSalSplitter_NotResizable, TRUE )
.head 4 -  Call cHSpl.setTopFrame(tblD)
.head 4 -  Call cHSpl.setBottomFrame(tblP)
.head 4 -  !
.head 4 +  If nPar = 1
.head 5 -  Call SalDisableWindow(rb1)
.head 5 -  Call SalDisableWindow(rbAll)
.head 5 -  Call SalDisableWindow(cbF0)
.head 5 -  Call SalDisableWindow(pbFormF)
.head 5 -  Call SalDisableWindow(cmbFLTK)
.head 5 -  Call SalDisableWindow(dfLTKs)
.head 5 -  Call SalDisableWindow(cmbFLNO)
.head 5 -  Call SalDisableWindow(dfLNOs)
.head 4 +  If nPar = 2
.head 5 -  Call SalDisableWindow(cbF0)
.head 5 -  Set cbF0 = TRUE
.head 4 +  If nPar = 3
.head 5 -  Call SalDisableWindow(cbF0)
.head 5 -  Set cbF0 = FALSE
.head 4 -  !
.head 4 -  Set dfNameFBS = 'Флаг установки блокировки счета'
.head 4 -  Set dfNameFBSNew = 'Новый флаг установки блокировки счета'
.head 4 -  Set dfNameFLTK = 'Флаг установки лимита ЛТК'
.head 4 -  Set dfSltk = 'Сумма ЛТК:'
.head 4 -  Set dfNameFLNO = 'Флаг установки лимита ЛНО'
.head 4 -  Set dfSlno = 'Сумма ЛНО:'
.head 4 -  Set dfNameSDS = 'Сумма дебетовых списаний:'
.head 4 -  Set rb1 = 1
.head 4 -  Set dDat = GetBankDate()
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  ! dir флагов
.head 4 -  Call SalGetProfileString(INI_CommonParameters, 'ExternalFlagsDir', GetPrnDir(), Path_LF, GetIniFileName())
.head 4 -  Call SalGetProfileString('FILES', 'FLAGS_L_EDIT', '0', FL_Edit, GetIniFileName())
.head 4 +  If FL_Edit = '1'
.head 5 -  Call SalEnableWindow(cmbFBS)
.head 5 -  Call SalEnableWindow(cmbFBSNew)
.head 4 +  Else
.head 5 -  Call SalDisableWindow(cmbFBS)
.head 5 -  Call SalDisableWindow(cmbFBSNew)
.head 4 -  Call cF.Init('RRP', 'R')
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSendMsg(hWndForm, UM_Populate, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SalTblReset(tblD)
.head 4 -  Set sStrW = cF.GetFilterWhereClause(TRUE)
.head 4 -  Set sSel = 
"SELECT r.mfo, s.nb, r.ts, a.kv, a.ostc+decode(b.ostc,null,0,b.ostc), t.dig, 
        r.flag_bs, r.flag_bsnew, r.flag_ltk, r.ltk, 
        r.flag_lno, r.lno, r.rp, a.nls, b.nls,
        r.p_ostd, r.p_ostk, r.p_dos, r.p_kos, 
        r.p_flag_blk, r.p_ltk, r.p_lno, 
        r.p_start_kos, r.p_nosep_dos, r.p_nosep_kos, r.p_nosep_skos, 
        r.p_fn, r.p_dat
 INTO :sMFO, :sBName :sTS, :nKV, :nOST, :nDig, 
      :sFBS, :sFBSNew, :sFLTK, :nLTK,
      :sFLNO, :nLNO, :sRP, :sNLSK, :sNLSD, 
      :nP_OSTD, :nP_OSTK, :nP_DOS, :nP_KOS, 
      :sP_FBLK, :nP_LTK,  :nP_LNO, 
      :nP_SKOS, :nP_NDOS, :nP_NKOS, :nP_NSKOS, 
      :sP_FName, :dP_FDat
 FROM rrp r, accounts a, acc_over o, accounts b, banks s, tabval t
 WHERE r.acck=a.acc AND a.dazs is null AND r.acck=o.acc(+) 
   AND o.acco=b.acc(+) AND b.dazs is null 
   AND r.ts='1' AND r.mfo=s.mfo AND s.blk<>4 AND a.kv=t.kv " || 
       IifS(sStrW="", "", " AND " || sStrW) || "
 ORDER BY r.mfo"
.head 4 -  Set i = 0
.head 4 +  If NOT SqlPrepareAndExecute(hSql(), sSel)
.head 5 -  Return FALSE
.head 4 +  While SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set mF[i,0] = sFBS
.head 5 -  Set mF[i,1] = sFBSNew
.head 5 -  Set mF[i,2] = sFLTK
.head 5 -  Set mL[i,0] = nLTK
.head 5 -  Set mF[i,3] = sFLNO
.head 5 -  Set mL[i,1] = nLNO
.head 5 -  !
.head 5 -  Call SalTblInsertRow(tblD, i)
.head 5 -  Call SalTblSetRowFlags(tblD, i, ROW_New, FALSE)
.head 5 -  Set tblD.colMFO = sMFO
.head 5 -  Set tblD.colBName = sBName
.head 5 -  Set tblD.colTS  = sTS
.head 5 -  Set tblD.colKV  = nKV
.head 5 -  Set tblD.colOST = nOST
.head 5 -  Set tblD.colOSTs = Dig4(nOST/100, nDig, nDig)
.head 5 -  Set tblD.colDig = nDig
.head 5 -  Set tblD.colFBS    = mF[i,0]
.head 5 -  Set tblD.colFBSNew = mF[i,1]
.head 5 -  Set tblD.colFLTK   = mF[i,2]
.head 5 -  Set tblD.colLTK    = mL[i,0]
.head 5 -  Set tblD.colFLNO   = mF[i,3]
.head 5 -  Set tblD.colLNO    = mL[i,1]
.head 5 -  Set tblD.colRP  = sRP
.head 5 -  Set tblD.colNLSK = sNLSK
.head 5 -  Set tblD.colNLSD = sNLSD
.head 5 -  !
.head 5 -  Set tblD.colP_OSTD  = nP_OSTD
.head 5 -  Set tblD.colP_OSTK  = nP_OSTK
.head 5 -  Set tblD.colP_DOS   = nP_DOS
.head 5 -  Set tblD.colP_KOS   = nP_KOS
.head 5 -  Set tblD.colP_FBLK  = sP_FBLK
.head 5 -  Set tblD.colP_LTK   = nP_LTK
.head 5 -  Set tblD.colP_LNO   = nP_LNO
.head 5 -  Set tblD.colP_SKOS  = nP_SKOS
.head 5 -  Set tblD.colP_NDOS  = nP_NDOS
.head 5 -  Set tblD.colP_NKOS  = nP_NKOS
.head 5 -  Set tblD.colP_NSKOS = nP_NSKOS
.head 5 -  Set tblD.colP_FName = sP_FName
.head 5 -  Set tblD.colP_FDat  = dP_FDat
.head 5 -  Set i = i + 1
.head 4 -  Call SalTblSetLockedColumns(tblD, 1)
.head 4 -  Call SalTblSetFocusRow(tblD, 0)
.head 4 -  Call SalSendMsg(tblD, SAM_RowSetContext, 0, 0)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On WM_Size
.head 4 -  Call SalGetWindowSize(hWndForm, nWW, nWH)
.head 4 +  If nWW >= 9
.head 5 +  If nWH < 5
.head 6 -  Call SalSetWindowSize(hWndForm, nWW, 5)
.head 4 +  Else
.head 5 +  If nWH < 5
.head 6 -  Call SalSetWindowSize(hWndForm, 9, 5)
.head 5 +  Else
.head 6 -  Call SalSetWindowSize(hWndForm, 9, nWH)
.head 4 -  Call GetClientRect(hWndForm, nX, nY, nW, nH)
.head 4 -  Call SalSetWindowSize(hWndForm.frm_L.cHSpl,
	SalPixelsToFormUnits(hWndForm.frm_L.cHSpl, nW, FALSE)-5,
	SalPixelsToFormUnits(hWndForm.frm_L.cHSpl, nH, TRUE)-0.01)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfNameFBS, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfNameFBS,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfFBS, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfFBS,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.7, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.cmbFBS, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.cmbFBS,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfNameFBSNew, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfNameFBSNew,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfFBSNew, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfFBSNew,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.7, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.cmbFBSNew, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.cmbFBSNew,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfNameFLTK, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfNameFLTK,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfFLTK, nCX, nCY )
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfFLTK,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.7, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.cmbFLTK, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.cmbFLTK,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfSltk, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfSltk,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfLTKs, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfLTKs,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-3, nCY)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfNameFLNO, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfNameFLNO,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfFLNO, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfFLNO,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.7, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.cmbFLNO, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.cmbFLNO,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfSlno, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfSlno,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfLNOs, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfLNOs,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-3, nCY)
.head 4 -  !
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfNameSDS, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfNameSDS,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  Call SalGetWindowLoc(hWndForm.frm_L.dfSDS, nCX, nCY)
.head 4 -  Call SalSetWindowLoc(hWndForm.frm_L.dfSDS,
        SalPixelsToFormUnits(hWndForm, nW, FALSE)-4.37, nCY)
.head 4 -  !
.head 4 -  Call SalInvalidateWindow(hWndForm)
.head 1 +  Dialog Box: dlg_BS
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  6.7"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.0"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Формирование BS-файлов для НБУ
(по параметрам :
  4 - за день,
  2 - за месяц)
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Combo Box: cmbMonth
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_NumId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.7"
.head 5 -  Top:    0.104"
.head 5 -  Width:  2.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 2.385"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 +  If cmbMonth.Init(hWndItem)
.head 7 -  Call cmbMonth.Populate(hSql(), 'N', 'NAME_PLAIN', 'META_MONTH', '')
.head 7 -  Set nMonth = SalDateMonth(dBankD)
.head 7 -  Call cmbMonth.SetSelectById(nMonth)
.head 5 +  On SAM_Click
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Set nMonth = cmbMonth.nCurrentId
.head 3 +  Data Field: dfDat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.2"
.head 6 -  Top:    0.104"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set dfDat = dBankD
.head 6 -  Call SalSendMsg(hWndItem, SAM_Validate, 0, 0)
.head 5 +  On SAM_Validate
.head 6 +  If SalIsValidDateTime(dfDat)
.head 7 -  Set dDat = dfDat
.head 7 -  Return VALIDATE_Ok
.head 6 -  Return VALIDATE_Cancel
.head 3 +  Data Field: dfText
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.146"
.head 6 -  Width:  3.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Multiline Field: mlMes
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  String Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.043"
.head 6 -  Top:    0.552"
.head 6 -  Width:  6.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.3"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Зформувати
.head 4 -  Window Location and Size
.head 5 -  Left:   0.729"
.head 5 -  Top:    2.021"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set mlMes = ''
.head 6 +  If GetSignType() = 'NBU'
.head 7 -  Set strOperId = SalStrReplaceX(GetIdOper(), 3, 1, 'B')
.head 6 +  Else If GetSignType() = 'UNI'
.head 7 -  Set strOperId = GetIdOper()
.head 6 -  Call tblD.fileSigner.SetVariables(
  GetSignType(),
  GetOpenKeyDir(),
  GetSecretKeyDrv(),
  strOperId,
  GetKeyDate(),
  5
 )
.head 6 +  If NOT tblD.fileSigner.Init()
.head 7 -  Return FALSE
.head 6 +  If nPar = 4
.head 7 -  Call FCreate(Path_BSF, 2, dDat)
.head 7 -  Call FCreate(Path_BSF, 3, dDat)
.head 7 -  Call FCreate(Path_BSF, 4, dDat)
.head 7 -  Call FCreate(Path_BSF, 6, dDat)
.head 6 +  If nPar = 2
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT max(fdat) INTO :dDat FROM fdat 
 WHERE to_char(fdat,'MM')=" || SalStrRightX('00' || SalNumberToStrX(nMonth, 0), 2 ))
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 7 +  If dDat != DATETIME_Null
.head 8 -  Call FCreate(Path_BSF, 5, dDat)
.head 8 -  Call FCreate(Path_BSF, 7, dDat)
.head 7 +  Else
.head 8 -  Set mlMes = 'Вiдсутнi робочi дати за ' || cmbMonth
.head 6 -  Call tblD.fileSigner.Deinit()
.head 3 +  Pushbutton: pbCansel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вiдмiнити
.head 4 -  Window Location and Size
.head 5 -  Left:   4.314"
.head 5 -  Top:    2.021"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 3 +  Child Table: tblD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTableBS
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  View: Class Default
.head 5 -  Allow Row Sizing? Class Default
.head 5 -  Lines Per Row: Class Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Class Default
.head 5 -  Discardable? Class Default
.head 4 +  Contents
.head 5 +  Column: colNLSA
.head 6 -  Class Child Ref Key: 1
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKV
.head 6 -  Class Child Ref Key: 2
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNMS
.head 6 -  Class Child Ref Key: 3
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colPAP
.head 6 -  Class Child Ref Key: 4
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDat
.head 6 -  Class Child Ref Key: 24
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colPO
.head 6 -  Class Child Ref Key: 6
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colVOB
.head 6 -  Class Child Ref Key: 7
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colVOBs
.head 6 -  Class Child Ref Key: 25
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDK
.head 6 -  Class Child Ref Key: 9
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNM
.head 6 -  Class Child Ref Key: 10
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colMFO
.head 6 -  Class Child Ref Key: 11
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNLSB
.head 6 -  Class Child Ref Key: 12
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colOstV
.head 6 -  Class Child Ref Key: 17
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDOSV
.head 6 -  Class Child Ref Key: 18
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKOSV
.head 6 -  Class Child Ref Key: 19
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colOst
.head 6 -  Class Child Ref Key: 20
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDOS
.head 6 -  Class Child Ref Key: 21
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colKOS
.head 6 -  Class Child Ref Key: 22
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNamB
.head 6 -  Class Child Ref Key: 15
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNazn
.head 6 -  Class Child Ref Key: 16
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cTableBS
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: FCreate   ! nbu_zag_bs
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: sFPath
.head 5 -  Number: nTip
.head 5 -  Date/Time: dDat
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nFileNum
.head 5 -  String: sFName
.head 4 +  Actions
.head 5 -  Call tblD.Populate(nTip, dDat)
.head 5 -  Set nFileNum = 0
.head 5 -  ! указать путь
.head 5 -  Set sFName = GetFileName(nTip, dDat, nFileNum)
.head 5 -  Set sFPath = Path_BSF || '\\' || sFName
.head 5 -  ! Create files
.head 5 +  If tblD.SaveStrToFile(sFPath)
.head 6 -  ! Update file number sequence
.head 6 -  Set mlMes = mlMes || 'Файл ' || sFPath ||' зформований.
'
.head 6 -  Call FunBackUpFile(sFPath, Path_Backup, FALSE)
.head 6 +  If tblD.SaveToBD(sFName)
.head 7 -  Call SqlCommit(hSql())
.head 2 +  Window Parameters
.head 3 -  Number: nPar
.head 2 +  Window Variables
.head 3 -  String: strMonth[12]              !! Наименов. месяце для календаря
.head 3 -  String: strWeekDays[7]         !! Дни недели для календаря
.head 3 -  String: sDat
.head 3 -  Date/Time: dDat
.head 3 -  Date/Time: dSelect                !!
.head 3 -  Date/Time: dBankD
.head 3 -  Number: i
.head 3 -  Number: nMonth
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Set dBankD = GetBankDate()
.head 4 -  Call SalSetWindowText(hWndForm, 'Формування файлiв BS')
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSetFocus(pbOk)
.head 4 +  If nPar = 4
.head 5 -  Set dfText = 'Файли за день'
.head 5 -  Call SalShowWindow(dfDat)
.head 5 -  Call SalHideWindow(cmbMonth)
.head 4 +  If nPar = 2
.head 5 -  Set dfText = 'Файли за мiсяць'
.head 5 -  Call SalShowWindow(cmbMonth)
.head 5 -  Call SalHideWindow(dfDat)
.head 1 +  Form Window: frm_BT
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Yes
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? No
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  6.0"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.0"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 -  Background Text: за дату
.head 4 -  Resource Id: 46588
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.843"
.head 5 -  Top:    0.25"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.3"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.629"
.head 6 -  Top:    0.219"
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.3"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set dfD = SalDateCurrent()
.head 6 -  ! Set dfD = SalStrToDate('14-mar-2002')
.head 6 -  Call SalSendMsg(hWndItem, SAM_Validate, 0, 0)
.head 5 +  On SAM_Validate
.head 6 +  If SalIsNull(dfD)
.head 7 -  Return VALIDATE_Ok
.head 6 +  If SalIsValidDateTime(dfD)
.head 7 -  Return VALIDATE_Ok
.head 6 -  Return VALIDATE_Cancel
.head 3 +  Multiline Field: mlMes
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  String Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Border? No
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.2"
.head 6 -  Top:    0.969"
.head 6 -  Width:  5.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.6"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обработать
.head 4 -  Window Location and Size
.head 5 -  Left:   0.571"
.head 5 -  Top:    1.938"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If NOT SalIsNull(dfD)
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set mlMes = ''
.head 7 +  If F_File(dfDatBT, nC_BT, msBT, nC_BOT, msBOT)
.head 8 -  Set nInd = 0
.head 8 -  Set strDir = GetTemplateDir() || '\\QRP31.QRP'
.head 8 -  Set sFile  = sPathPrint || '\\protbt' ||
    GetCharForDigit(SalDateMonth(dfD)) ||
    GetCharForDigit(SalDateDay(dfD)) ||'.txt'
.head 8 +  If NOT VisDosExist(sPathPrint)
.head 9 +  If VisDosMakeAllDir(sPathPrint) != VTERR_Ok
.head 10 -  Call SalMessageBox('Невозможно создать каталог - ' || sPathPrint, 'Ошибка', MB_Ok)
.head 10 -  Return FALSE
.head 8 -  Call SalReportPrintToFile(hWndForm, strDir, sFile,
     'dfDatBT,dfD,sfBT,sfBS,sfKErr',
     'DATBT,DATBS,FBT,FBS,STATUS',
     1, RPT_PrintAll, 1, 1, FALSE, nInd)
.head 8 +  If nInd > 0
.head 9 -  Call Debug('Файл ' || sFile || ' Ош' || Str(nInd))
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Return FALSE
.head 8 -  Set mlMes = 'Протокол обработки квитанций '|| sFile || ' сформирован'
.head 8 -  Set i = 0
.head 8 +  While i < nC_BT
.head 9 +  If SalFileCopy(sPathFrom || '\\' || msBT[i], 
               sPathPrint|| '\\' || msBT[i], TRUE ) = FILE_CopyOK
.head 10 -  Call SalFileOpen(hF, sPathFrom || '\\' || msBT[i], OF_Delete)
.head 9 -  Set i = i + 1
.head 8 -  Set i = 0
.head 8 +  While i < nC_BOT
.head 9 +  If SalFileCopy(sPathFrom || '\\' || msBOT[i], 
               sPathPrint|| '\\' || msBOT[i], TRUE) = FILE_CopyOK
.head 10 -  Call SalFileOpen(hF, sPathFrom || '\\' || msBOT[i], OF_Delete)
.head 9 -  Set i = i + 1
.head 7 +  Else
.head 8 -  Set mlMes = 'Нет квитанций  в '||sPathFrom||' за '||SalFmtFormatDateTime( dfD, 'dd/MM/yyyy' )
.head 7 -  Call SalWaitCursor(FALSE)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.757"
.head 5 -  Top:    1.938"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 3 -  Frame
.head 4 -  Resource Id: 46589
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.065"
.head 5 -  Top:    0.063"
.head 5 -  Width:  5.7"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.688"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 46590
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.071"
.head 5 -  Top:    1.802"
.head 5 -  Width:  5.7"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.719"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 2 +  Functions
.head 3 +  Function: F_File
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Receive Date/Time: dDatBT
.head 5 -  Receive Number: nCount
.head 5 -  Receive String: sBTFiles[*]
.head 5 -  Receive Number: nCountBOT
.head 5 -  Receive String: sBOTFiles[*]
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: i
.head 5 -  Number: j
.head 5 -  File Handle: hF
.head 5 -  File Handle: hFBOT
.head 5 -  String: sTmp
.head 5 -  String: sBT
.head 5 -  String: sDatBT
.head 5 -  String: sDatBOT
.head 5 -  String: sBS
.head 5 -  String: sDatBS
.head 5 -  Date/Time: dDatBS
.head 5 -  String: sStr
.head 5 -  String: sKErr
.head 5 -  Number: nKStr
.head 5 -  Number: nLength
.head 5 -  Boolean: bFlag
.head 5 -  Boolean: bFlBOT
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(), "DELETE FROM tmp_bt WHERE id=:nUserId")
.head 6 -  Call SqlRollback(hSql())
.head 6 -  Return FALSE
.head 5 -  Call SqlCommit(hSql())
.head 5 -  Set dDatBT = dfD
.head 5 -  Set nCount = VisDosEnumFiles(sPathFrom || '\\BT????' || 
     GetCharForDigit(SalDateMonth(dfD)) ||
     GetCharForDigit(SalDateDay(dfD)) || '.*', FA_Standard, sBTFiles)
.head 5 -  Set bFlag = FALSE
.head 5 -  Set i = 0
.head 5 +  While i < nCount
.head 6 -  Call SalFileOpen(hF, sPathFrom || '\\' || sBTFiles[i], OF_Read)
.head 6 -  Call SalFileSeek(hF, 101, FILE_SeekBegin)
.head 6 -  Call SalFileRead(hF, sTmp, 60)
.head 6 -  Set sDatBT = SalStrMidX(sTmp, 17, 2) || '-' || SalStrMidX(sTmp, 15, 2) || '-' || SalStrMidX(sTmp, 13, 2)
.head 6 -  !
.head 6 -  Set bFlag  = TRUE
.head 6 -  Set sBT    = SalStrMidX(sTmp, 1, 12)
.head 6 -  Set dDatBT = SalStrToDate(sDatBT)
.head 6 -  Set sBS    = SalStrMidX(sTmp, 23, 12)
.head 6 -  Set sDatBS = SalStrMidX(sTmp, 39, 2) || '-' || SalStrMidX(sTmp, 37, 2) || '-' || SalStrMidX(sTmp, 35, 2)
.head 6 -  Set dDatBS = SalStrToDate(sDatBS)
.head 6 -  Set sStr   = SalStrMidX(sTmp, 45, 5)
.head 6 -  ! Код ошибки
.head 6 -  Set sKErr  = SalStrMidX(sTmp, 50, 10)
.head 6 +  If SqlPrepareAndExecute(hSql(), 
"INSERT INTO tmp_bt(id,f_bt,f_bs,err_code)
 VALUES (:nUserId, :sBT, :sBS, :sKErr)" )
.head 7 -  Call SqlCommit(hSql())
.head 6 -  !
.head 6 -  Call SalFileClose(hF)
.head 6 -  Set i = i + 1
.head 5 -  ! !!!!!!!!!!!!!!!!
.head 5 -  Set nCountBOT = VisDosEnumFiles(sPathFrom || '\\BOT???' || 
     GetCharForDigit(SalDateMonth(dfD)) ||
     GetCharForDigit(SalDateDay(dfD)) || '.*', FA_Standard, sBOTFiles)
.head 5 -  Set i = 0
.head 5 +  While i < nCountBOT
.head 6 -  Call SalFileOpen(hFBOT, sPathFrom || '\\' || sBOTFiles[i], OF_Read)
.head 6 -  Call SalFileSeek(hFBOT, 101, FILE_SeekBegin)
.head 6 -  Call SalFileRead(hFBOT, sTmp, 329)
.head 6 -  Set sDatBT = SalStrMidX(sTmp, 17, 2) || '-' || SalStrMidX(sTmp, 15, 2) || '-' || SalStrMidX(sTmp, 13, 2)
.head 6 -  Set dDatBT = SalStrToDate(sDatBT)
.head 6 -  Set bFlBOT = FALSE
.head 6 -  !
.head 6 -  Set j = 0
.head 6 +  While j < nCount
.head 7 +  If SalStrMidX(sTmp, 131, 12) = sBTFiles[j]
.head 8 -  Set bFlBOT = TRUE
.head 7 -  Set j = j + 1
.head 6 +  If not bFlBOT    ! нет квитанции bt* (а есть bot*), значит файл bt принят с ошибкой
.head 7 -  Set bFlag = TRUE
.head 7 -  Set sBT   = SalStrMidX(sTmp, 131, 12)
.head 7 -  Set sBS   = ''
.head 7 -  ! Код ошибки
.head 7 -  Set sKErr = SalStrMidX(sTmp, 261, 4)
.head 7 +  If SqlPrepareAndExecute(hSql(), 
"INSERT INTO tmp_bt(id,f_bt,f_bs,err_code)
 VALUES (:nUserId, :sBT, :sBS, :sKErr)")
.head 8 -  Call SqlCommit(hSql())
.head 6 -  !
.head 6 -  Call SalFileClose(hF)
.head 6 -  Set i = i + 1
.head 5 -  ! !!!!!!!!!!!!!!
.head 5 -  ! Теперь формируем отчет
.head 5 +  If bFlag
.head 6 -  Return TRUE
.head 5 -  Return FALSE
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nUserId
.head 3 -  String: sfBT
.head 3 -  String: sfBS
.head 3 -  String: sfKErr
.head 3 -  Number: nInd
.head 3 -  String: strDir
.head 3 -  String: sFile
.head 3 -  String: sPathFrom
.head 3 -  String: sPathPrint
.head 3 -  Date/Time: dfDatBT
.head 3 -  Number: nC_BT
.head 3 -  String: msBT[*]
.head 3 -  Number: nC_BOT
.head 3 -  String: msBOT[*]
.head 3 -  Number: i
.head 3 -  File Handle: hF
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SalSetWindowText(hWndForm, 'Обработка квитанций BT*')
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  Set nUserId = GetUserId()
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString(INI_Directory, 'TicketsDir', GetPrnDir(), sPathFrom,  GetIniFileName())
.head 4 -  Call SalGetProfileString(INI_Directory, 'BackUpDir',  GetPrnDir(), sPathPrint, GetIniFileName())
.head 4 -  Set sPathPrint = sPathPrint || '\\' || SalFmtFormatDateTime(GetBankDate(), 'yyMMdd') || '\\OK!'
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSetFocus(pbOk)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_ReportStart
.head 4 -  Return SqlPrepare(hSql(), 
"SELECT t.f_bt, t.f_bs, s.n_er
 INTO :sfBT, :sfBS, :sfKErr
 FROM tmp_bt t, s_er s
 WHERE t.id=:nUserId and substr(t.err_code,-4)=s.k_er(+)")
.head 3 +  On SAM_ReportFetchInit
.head 4 -  Return SqlExecute(hSql())
.head 3 +  On SAM_ReportFetchNext
.head 4 +  If SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Return TRUE
.head 4 -  Return FALSE
.head 3 +  On SAM_ReportNotify
.head 4 +  If lParam = RPT_BeforeReportHeader
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'OUR_BANK_NAME', GetGlobalOption('NAME'))
.head 1 +  Table Window: tbl_G
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Файлы $G за день
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? No
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  8.0"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 4.0"
.head 4 -  Height Editable? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 3 -  View: Class Default
.head 3 -  Allow Row Sizing? Class Default
.head 3 -  Lines Per Row: Class Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: Class Default
.head 3 -  Discardable? Class Default
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: Class Default
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.014"
.head 6 -  Top:    0.063"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 57286
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   8.771"
.head 6 -  Top:    0.031"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 57287
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.529"
.head 6 -  Top:    0.063"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 57288
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  5.843"
.head 6 -  Begin Y:  0.021"
.head 6 -  End X:  5.843"
.head 6 -  End Y:  0.479"
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Data Field: dfDat
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   0.386"
.head 7 -  Top:    0.083"
.head 7 -  Width:  1.2"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.25"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Center
.head 6 -  Format: Date
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set dfDat = GetBankDate()
.head 7 -  Call SalSendMsg(hWndItem, SAM_Validate, 0, 0)
.head 6 +  On SAM_Validate
.head 7 +  If SalIsValidDateTime(dfDat)
.head 8 -  Set dDat = dfDat
.head 8 -  Return VALIDATE_Ok
.head 7 -  Return VALIDATE_Cancel
.head 4 +  Pushbutton: pbTimer
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cTimer
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.429"
.head 6 -  Top:    0.073"
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.292"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Call pbTimer.Init(300, 0, TRUE)
.head 6 +  On UM_TimerFired
.head 7 -  Call SalSendMsg(pbRefresh,SAM_Click , 0, 0)
.head 2 +  Contents
.head 3 +  Column: colFN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Файл
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colDat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  2.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: DateTime
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: colOtm
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Принят
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Center
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Check Box
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value: 1
.head 6 -  Uncheck Value: 2
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: sSab
.head 3 -  String: sSymb
.head 3 -  Number: nRow
.head 3 -  Number: i
.head 3 -  String: msFN[*]
.head 3 -  String: sFN
.head 3 -  Date/Time: dDat
.head 3 -  Boolean: bOK
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Set sSab = GetBankSab()
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On UM_Populate
.head 4 -  Call SalTblReset(hWndForm)
.head 4 -  Set nRow = 0
.head 4 -  Call SalTblPopulate(hWndForm, hSql(), 
"SELECT upper(fn), dat 
 INTO :colFN, :colDat
 FROM zag_g 
 WHERE dat >= :dfDat and dat <  to_date(:dfDat)+1
 ORDER BY 1", TBL_FillAll)
.head 4 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT substr(sab,1,1) INTO :sSymb 
 FROM rrp_sab 
 WHERE valid=1 ORDER BY sab")
.head 4 +  While SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set bOK = 0
.head 5 -  Set i = TBL_MinRow
.head 5 +  While SalTblFindNextRow(hWndForm, i, 0, 0)
.head 6 -  Call SalTblSetContext(hWndForm, i)
.head 6 +  If SalStrMidX(colFN,0,10) = SalStrUpperX('$G' || sSab || GetCharForDigit(SalDateMonth(dfDat)) || GetCharForDigit(SalDateDay(dfDat)) || '.' || sSymb)
.head 7 -  Set bOK = 1
.head 7 -  Break
.head 5 +  If NOT bOK
.head 6 -  Call SalTblInsertRow(hWndForm, nRow)
.head 6 -  Call SalTblSetRowFlags(hWndForm, nRow, ROW_New, FALSE)
.head 6 -  Set colFN = SalStrUpperX('$G' || sSab || GetCharForDigit(SalDateMonth(dfDat)) || GetCharForDigit(SalDateDay(dfDat)) || '.' || sSymb || '**')
.head 6 -  Set colOtm = 0
.head 6 -  Set nRow = nRow + 1
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set colOtm = 1
.head 4 -  Call VisTblSetRowColor(hWndForm, nRow, COLOR_DarkGreen)
.head 4 -  Set nRow = nRow + 1
