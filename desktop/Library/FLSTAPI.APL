.head 0 +  Application Description: Библиотека работы со списком функций, выполняемых автоматически.
(С) Унити-БАРС, 1999-2011
Created:	Самойленко В.С.
Last modified:  31.03.2000 (work with sets of functions)
                Самойленко В.С.
Last modified:  07.04.2000 (Небольшая корректировка интерфейса списков)
                DEN
Last modified:  27.09.2000 (Добавлен фильтр на список доступных функций)
                DEN
Last modified:  08.02.2001 (Добавлена ф-я переоц. инвал. остатков)
                MIK
Last modified:  12.04.2001 (Приехала из absapi ф-я оплаты на старте дня)
                MIK
Last modified:  18.06.2001 (Добавлена функция обработки задач)
                EVE
Last modified:  03.09.2001 (Добавлена ф-ия вызова любой процедуры PLSQL)
                MIK    (!)  Добавил String параметр в F1_Select (!)
Last modified:  28.03.2002 (Добавлена возможность редактирования наименования и
                VICTOR (!)  комментария множ-ва в fwListFuncSetAPI)
Last modified:  02.06.2011 (Добавлен приём коммерческих курсов)
                MOM    (!)
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B20000 002C000000020000 0003000000000000 0077020000FCFFFF
0040: FFE2FFFFFF010000 00000000002D0300 0047020000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D0100000012496E 7465726E616C2046
0080: 756E6374696F6E73
.enddata
.data DT_MAKERUNDLG
0000: 0200000023513A5C 4241525339385C52 45534F555243455C 49434F5C4170706C
0020: 696361742E69636F 34443A5C4D792044 6F63756D656E7473 5C576F726B206F6E
0040: 204F70656E26436C 6F7365206461795C 20464C7374456469 742E65786534443A
0060: 5C4D7920446F6375 6D656E74735C576F 726B206F6E204F70 656E26436C6F7365
0080: 206461795C4F2643 5F61646D696E2E64 6C6C34443A5C4D79 20446F63756D656E
00A0: 74735C576F726B20 6F6E204F70656E26 436C6F7365206461 795C4F26435F6164
00C0: 6D696E2E61706300 0101010134443A5C 4D7920446F63756D 656E74735C576F72
00E0: 6B206F6E204F7065 6E26436C6F736520 6461795C4F26435F 61646D696E2E7275
0100: 6E34443A5C4D7920 446F63756D656E74 735C576F726B206F 6E204F70656E2643
0120: 6C6F736520646179 5C4F26435F61646D 696E2E646C6C3444 3A5C4D7920446F63
0140: 756D656E74735C57 6F726B206F6E204F 70656E26436C6F73 65206461795C4F26
0160: 435F61646D696E2E 6170630000010101 185C426172733938 5C62696E5C464C69
0180: 73744170692E6170 64195C4261727339 385C62696E5C4F26 435F61646D696E2E
01A0: 646C6C195C426172 7339385C62696E5C 4F26435F61646D69 6E2E617063000001
01C0: 010130443A5C4D79 20446F63756D656E 74735C576F726B20 6F6E204F70656E26
01E0: 436C6F7365206461 795C464C6973742E 61706C34443A5C4D 7920446F63756D65
0200: 6E74735C576F726B 206F6E204F70656E 26436C6F73652064 61795C4F26435F61
0220: 646D696E2E646C6C 34443A5C4D792044 6F63756D656E7473 5C576F726B206F6E
0240: 204F70656E26436C 6F7365206461795C 4F26435F61646D69 6E2E617063000001
0260: 0101
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
0000: 001CB80BB80B2500
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
.head 2 -  Dynalib: Absapi.apd
.head 2 -  Dynalib: Global.apd
.head 2 -  Dynalib: Klop_tex.apd
.head 2 -  Dynalib: CustAcnt.apd
.head 2 -  Dynalib: BARS000.APD
.head 2 -  Dynalib: BARS001.APD
.head 2 -  Dynalib: BARS010.APD
.head 2 -  Dynalib: NSIAPI.APD
.head 2 -  Dynalib: OTCN.APD
.head 2 -  Dynalib: OBANKPC.APD
.head 2 -  Dynalib: IMPEXP.APD
.head 2 -  Dynalib: DEBREG.APD
.head 2 -  Dynalib: REP_DKU.APD
.head 2 -  Dynalib: REPBANK.APD
.head 2 -  File Include: XSALIMG.APL
.head 2 -  File Include: Xsalcpt.apl
.head 2 -  File Include: Constant.apl
.head 2 -  File Include: GenButn.apl
.head 2 -  File Include: Gentbl.apl
.head 2 -  File Include: GentblD.apl
.head 2 -  File Include: Genemnu.apl
.head 2 -  File Include: Genfcls.apl
.head 2 -  File Include: Ttp32.apl
.head 2 -  File Include: Rs_objs.apl
.head 2 -  File Include: Lfscls.apl
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: GENTIMER.APL
.head 2 -  File Include: Vtmeter.apl
.head 2 -  File Include: Vttblwin.apl
.head 2 -  File Include: Vtdos.apl
.head 2 -  File Include: Vtfile.apl
.head 2 -  File Include: Vtcal.apl
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
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
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
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
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
.head 3 -  Input: BARS
.head 3 -  Date/Time: dd/MM/yyyy hh:mm:ss
.head 3 -  Date/Time: dd/MM/yyyy hh:mm:ss AMPM
.head 3 -  Date/Time: dd/MM/yyyy hh:mm
.head 3 -  Date/Time: dd/MM/yyyy hhhh:mm
.head 2 +  External Functions
.head 3 +  ! Library name: vti11.dll
.head 4 -  ! !
.head 4 -  ! ! ***** Visual Toolchest - VTDOS.APL
.head 4 -  ! !
.head 4 -  ! ! ***** DOS functions
.head 4 +      Function: VisDosBuildFullName
.head 5 -      Description: sFullName VisDosBuildFullName( sModuleName, sFileName )
.head 5 -      Export Ordinal: 186
.head 5 +      Returns 
.head 6 -      String: HSTRING
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosEnumDirInfo
.head 5 -      Description: nNumDirs VisDosEnumDirInfo( sDirSpec, sDirs[*], dtDateTimes[*], nAttributes[*] )
.head 5 -      Export Ordinal: 206
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: HARRAY
.head 6 -      Date/Time: HARRAY
.head 6 -      Number: HARRAY
.head 4 +      Function: VisDosEnumDirs
.head 5 -      Description: 
.head 5 -      Export Ordinal: 32
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: HARRAY
.head 4 +      Function: VisDosEnumDrives
.head 5 -      Description: 
.head 5 -      Export Ordinal: 29
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: HARRAY
.head 4 +      Function: VisDosEnumFileInfo
.head 5 -      Description: nNumFiles VisDosEnumFileInfo( sFileSpec, nAttributes, sFiles[*], nSizes[*], dtDateTimes[*], nAttributes[*] )
.head 5 -      Export Ordinal: 207
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      Number: WORD
.head 6 -      String: HARRAY
.head 6 -      Number: HARRAY
.head 6 -      Date/Time: HARRAY
.head 6 -      Number: HARRAY
.head 4 +      Function: VisDosEnumFiles
.head 5 -      Description: 
.head 5 -      Export Ordinal: 34
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      Number: WORD
.head 6 -      String: HARRAY
.head 4 +      Function: VisDosEnumNetConnections
.head 5 -      Description: nNumLinks VisDosEnumNetConnections( sDevices, sNetNames )
.head 5 -      Export Ordinal: 105
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: HARRAY
.head 6 -      String: HARRAY
.head 4 +      Function: VisDosEnumPath
.head 5 -      Description: 
.head 5 -      Export Ordinal: 35
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: HARRAY
.head 4 +      Function: VisDosExist
.head 5 -      Description: 
.head 5 -      Export Ordinal: 22
.head 5 +      Returns 
.head 6 -      Boolean: BOOL
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosIsParent
.head 5 -      Description: 
.head 5 -      Export Ordinal: 325
.head 5 +      Returns 
.head 6 -      Boolean: BOOL
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosGetCurDir
.head 5 -      Description: 
.head 5 -      Export Ordinal: 18
.head 5 +      Returns 
.head 6 -      String: HSTRING
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosGetDriveSize
.head 5 -      Description: 
.head 5 -      Export Ordinal: 26
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      Receive Number: LPDWORD
.head 6 -      Receive Number: LPDWORD
.head 4 +      Function: VisDosGetDriveType
.head 5 -      Description: 
.head 5 -      Export Ordinal: 45
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosGetEnvString
.head 5 -      Description: 
.head 5 -      Export Ordinal: 25
.head 5 +      Returns 
.head 6 -      String: HSTRING
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosGetFlags
.head 5 -      Description: 
.head 5 -      Export Ordinal: 46
.head 5 +      Returns 
.head 6 -      Number: WORD
.head 5 -      Parameters 
.head 4 +      Function: VisDosGetNetName
.head 5 -      Description: sNetName VisDosGetNetName( sDevice )
.head 5 -      Export Ordinal: 134
.head 5 +      Returns 
.head 6 -      String: HSTRING
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosGetVersion
.head 5 -      Description: bVersionNumber VisDosGetVersion( )
.head 5 -      Export Ordinal: 24
.head 5 +      Returns 
.head 6 -      Number: NUMBER
.head 5 -      Parameters 
.head 4 +      Function: VisDosGetVolumeLabel
.head 5 -      Description: 
.head 5 -      Export Ordinal: 31
.head 5 +      Returns 
.head 6 -      String: HSTRING
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosMakeAllDir
.head 5 -      Description: nErrCode VisDosMakeAllDir( sDir )
.head 5 -      Export Ordinal: 241
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosMakePath
.head 5 -      Description: 
.head 5 -      Export Ordinal: 30
.head 5 +      Returns 
.head 6 -      String: HSTRING
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosNetConnect
.head 5 -      Description: nErrCode VisDosNetConnect( sDevice, sNetName, sPassword )
.head 5 -      Export Ordinal: 103
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 4 +      Function: VisDosNetDisconnect
.head 5 -      Description: nErrCode VisDosNetDisconnect( sDevice, bForce )
.head 5 -      Export Ordinal: 104
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      Boolean: BOOL
.head 4 +      Function: VisDosSetFlags
.head 5 -      Description: 
.head 5 -      Export Ordinal: 47
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      Number: WORD
.head 6 -      Boolean: BOOL
.head 4 +      Function: VisDosSplitPath
.head 5 -      Description: 
.head 5 -      Export Ordinal: 28
.head 5 -      Returns 
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      Receive String: LPHSTRING
.head 6 -      Receive String: LPHSTRING
.head 6 -      Receive String: LPHSTRING
.head 6 -      Receive String: LPHSTRING
.head 4 +      Function: VisDosSetVolumeLabel
.head 5 -      Description: 
.head 5 -      Export Ordinal: 43
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 4 -  ! !
.head 4 -  ! ! ***** Visual Toolchest - VTFILE.APL
.head 4 -  ! !
.head 4 -  ! ! ***** File functions
.head 4 +      Function: VisFileAppend
.head 5 -      Description: nErrCode VisFileAppend( sSourceFile, sTargetFile )
.head 5 -      Export Ordinal: 51
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileClose
.head 5 -      Description: nErrCode VisFileClose( hFile )
.head 5 -      Export Ordinal: 188
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      File Handle: HFILE
.head 4 +      Function: VisFileCopy
.head 5 -      Description: nErrCode VisFileCopy( sSourceFile, sTargetFile )
.head 5 -      Export Ordinal: 37
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileCreateTemp
.head 5 -      Description: sTempName VisDosGetTempFileName( sPrefix )
.head 5 -      Export Ordinal: 23
.head 5 +      Returns 
.head 6 -      String: HSTRING
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileDelete
.head 5 -      Description: nNumDeleted VisFileDelete( sFileName )
.head 5 -      Export Ordinal: 39
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileExpand
.head 5 -      Description: nErrCode VisFileExpand( sSourceFile, sTargetFile )
.head 5 -      Export Ordinal: 53
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileFind
.head 5 -      Description: 
.head 5 -      Export Ordinal: 36
.head 5 +      Returns 
.head 6 -      String: HSTRING
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileGetAttribute
.head 5 -      Description: nAttribute VisFileGetAttribute( sFileName )
.head 5 -      Export Ordinal: 48
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileGetSize
.head 5 -      Description: nFileSize VisFileGetSize( sFileName )
.head 5 -      Export Ordinal: 49
.head 5 +      Returns 
.head 6 -      Number: LONG
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileGetType
.head 5 -      Description: nFileType VisFileGetType( sFileName )
.head 5 -      Export Ordinal: 189
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileOpen
.head 5 -      Description: nErrCode VisFileOpen( hFile, sFileName, nFlags )
.head 5 -      Export Ordinal: 190
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      Receive File Handle: LPHFILE
.head 6 -      String: LPSTR
.head 6 -      Number: WORD
.head 4 +      Function: VisFileRead
.head 5 -      Description: nBytesRead VisFileRead( hFile, sBuffer, nSize )
.head 5 -      Export Ordinal: 191
.head 5 +      Returns 
.head 6 -      Number: LONG
.head 5 +      Parameters 
.head 6 -      File Handle: HFILE
.head 6 -      Receive String: LPHSTRING
.head 6 -      Number: DWORD
.head 4 +      Function: VisFileReadString
.head 5 -      Description: nErrCode VisFileReadString( hFile, sLine )
.head 5 -      Export Ordinal: 192
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      File Handle: HFILE
.head 6 -      Receive String: LPHSTRING
.head 4 +      Function: VisFileRename
.head 5 -      Description: nErrCode VisFileRename( sSourceFile, sTargetFile )
.head 5 -      Export Ordinal: 52
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      String: LPSTR
.head 4 +      Function: VisFileSetAttribute
.head 5 -      Description: nErrCode VisFileSetAttribute( sFileName, nAttributes, bState )
.head 5 -      Export Ordinal: 50
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      Number: WORD
.head 6 -      Boolean: BOOL
.head 4 +      Function: VisFileSetDateTime
.head 5 -      Description: nErrCode VisFileSetDateTime( sFileName, dtDateTime )
.head 5 -      Export Ordinal: 27
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      String: LPSTR
.head 6 -      Date/Time: DATETIME
.head 4 +      Function: VisFileSeek
.head 5 -      Description: nErrCode VisFileSeek( hFile, nOffset, nOrigin )
.head 5 -      Export Ordinal: 193
.head 5 +      Returns 
.head 6 -      Number: LONG
.head 5 +      Parameters 
.head 6 -      File Handle: HFILE
.head 6 -      Number: LONG
.head 6 -      Number: INT
.head 4 +      Function: VisFileTell
.head 5 -      Description: nOffset VisFileTell( hFile )
.head 5 -      Export Ordinal: 194
.head 5 +      Returns 
.head 6 -      Number: LONG
.head 5 +      Parameters 
.head 6 -      File Handle: HFILE
.head 4 +      Function: VisFileWrite
.head 5 -      Description: nErrCode VisFileWrite( hFile, sBuffer, sSize )
.head 5 -      Export Ordinal: 195
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      File Handle: HFILE
.head 6 -      String: HSTRING
.head 6 -      Number: DWORD
.head 4 +      Function: VisFileWriteString
.head 5 -      Description: nErrCode VisFileWriteString( hFile, sLine )
.head 5 -      Export Ordinal: 196
.head 5 +      Returns 
.head 6 -      Number: INT
.head 5 +      Parameters 
.head 6 -      File Handle: HFILE
.head 6 -      String: LPSTR
.head 3 +  Library name: hex2bin.dll
.head 4 +  ! Function: ConcatBufs
.head 5 -  Description: char* ConcatBufs(char* szResult,
         const char* szBuf1,
	 unsigned long nSize1,
	 const char* szBuf2,
	 unsigned long nSize2)
.head 5 -  Export Ordinal: 0
.head 5 -  Returns 
.head 5 +  Parameters 
.head 6 -  String: LPSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: LONG
.head 6 -  String: LPCSTR
.head 6 -  Number: LONG
.head 4 +  Function: InsertBuf
.head 5 -  Description: void InsertBuf(
char*szTarget,       // результирующий BLOB
longnTargetOffset,   // смещение в результирующем BLOBе
const char*szSource, // исходный сырой BLOB
longnSourceOffset,   // смещение в исходном BLOBеlong
nCopySize            // размер копируемого буфера)
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 +  Parameters
.head 6 -  Receive String: LPVOID
.head 6 -  Number: LONG
.head 6 -  String: LPVOID
.head 6 -  Number: LONG
.head 6 -  Number: LONG
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 4 -  Number: AM_MtrMove = SAM_User + 150
.head 3 +  User
.head 4 -  String: MSG_CustomerLockWarnP1  = 'Блокированных прямых участников: '
.head 4 -  String: MSG_NonQuitDocsCheck    = 'Проверка "незаквитованых" документов СЭП...'
.head 4 -  String: MSG_BanksInitFail       = 'Ошибка при инициализации таблицы "Участники СЭП" (Banks)'
.head 4 -  String: MSG_DirCustomerSelect   = ' [ Выбор прямых участников СЭП ]'
.head 4 -  String: MSG_CustomerWillBeLockWarnP1 = 'Участник СЭП - МФО банка: '
.head 4 -  String: MSG_CustomerWillBeLockWarnP2 = ' будет блокирован'
.head 4 -  !
.head 4 -  String: MSG_TableClean_Z        = 'Очистка таблицы: Z'
.head 4 -  String: MSG_TableClean_SALDOH   = 'Очистка таблицы SALDOH'
.head 4 -  String: MSG_TableClean_REF_LST  = 'Очистка таблицы REF_LST'
.head 4 -  String: MSG_TmpTableInitFail    = 'Ошибка при инициализации таблицы БД: '
.head 4 -  !
.head 4 -  String: MSG_FlagsSetting        = 'Установка флагов в таблице PARAMS'
.head 2 +  Resources
.head 2 +  Variables
.data RESOURCE 0 0 1 2300180055
0000: F600000069000000 0000000000000000 02000009000000B7 000000E0010D0000
0020: 00FF3FC400800000 0204000000FFFFE0 C800000002FE00FF 83CC00000002FB00
0040: FF0FD0000000EE02 00FF3FD400B80000 0100FFFFE0E10000 0001FE00FF83EE00
0060: 0000028300010000 007F80F001000000 0FF2000000EC010D 00FF3F
.enddata
.head 3 -  !
.head 3 -  Number: nError
.head 3 -  Number: nErrorPos
.head 3 -  Number: nReturn
.head 3 -  String: strReturn
.head 3 -  Date/Time: dtReturn
.head 3 -  ! Status variable for fwFuncSetListAPI
.head 3 -  ! 0-noncreated, 1-created, 2- active
.head 3 -  Boolean: stListFuncSetAPI
.head 3 -  ! Флаг запуска Журнализатора
.head 3 -  Boolean: fTaskShed
.head 3 -  ! Флаг запуска редактора задач
.head 3 -  Boolean: fTaskEdit
.head 3 -  Window Handle: hFinis
.head 3 -  Window Handle: hVBNK
.head 3 -  Window Handle: hOrv
.head 3 -  Window Handle: hTv
.head 3 -  Window Handle: hWin15
.head 3 -  Window Handle: hWin16
.head 3 -  Window Handle: hWin17
.head 3 -  Number: nFetchRes
.head 2 +  Internal Functions
.head 3 +  Function: FIsNDoc            ! __exported
.head 4 -  Description: Проверка на наличие незавизированных документов
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: num
.head 5 -  Number: nC
.head 5 -  Date/Time: dBD
.head 4 +  Actions
.head 5 -  Set dBD = GetBankDate()
.head 5 +  If not SqlPrepareAndExecute(hSql(), "
   SELECT count(*)
   INTO :nC
   FROM ref_que r, oper o 
   WHERE r.ref=o.ref and o.sos<5 and o.vdat=:dBD")
.head 6 -  Return FALSE
.head 5 +  If not SqlFetchNext(hSql(), num)
.head 6 -  Return FALSE
.head 5 +  If nC > 0
.head 6 -  Call SalMessageBox('Имеются незавизированные документы.', 'Внимание !', MB_Ok)
.head 6 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: FListEdit          ! __exported
.head 4 -  Description: Run API for managing sets of functions
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hWin
.head 5 -  Number: nListID
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If NOT stListFuncSetAPI
.head 6 -  Call SalCreateWindow(fwListFuncSetAPI, hWin)
.head 6 -  Call SalCenterWindow(fwListFuncSetAPI)
.head 6 -  Set stListFuncSetAPI = 1
.head 5 +  Else
.head 6 -  Call SalBringWindowToTop(fwListFuncSetAPI)
.head 5 -  ! Call SalCreateWindow(FuncListForm, hWin, nListID)
.head 3 +  Function: FListRun           ! __exported
.head 4 -  Description: Run Executor of functions' sets 
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nListID
.head 5 -  Boolean: fAutoRun
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return SalModalDialog(fwListFuncExecutor, hWndForm, nListID, fAutoRun)
.head 5 -  ! Return SalModalDialog(FuncListExecutor, hWndForm, nListID, fAutoRun)
.head 3 -  !
.head 3 -  ! Здесь размещать функции автоматического выполнения
.head 3 -  !
.head 3 +  Function: SEPFiles_Reform        
.head 4 -  Description: Переформирование файлов СЕП НБУ
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: fRet
.head 5 -  !
.head 5 -  String: strDirMfoEx[*]
.head 5 -  String: strBankMfo
.head 5 -  String: strDirMfo
.head 5 -  String: strMfoTmp
.head 5 -  Number: nMfo
.head 5 -  Number: nCount
.head 5 -  ! Number: nFetchRes
.head 4 +  Actions
.head 5 -  Set strBankMfo = GetBankMfo()
.head 5 +  If SqlPrepareAndExecute(hSql(), T("
   SELECT mfo FROM Banks INTO :strDirMfo
   WHERE mfop=:strBankMfo and mfo<>:strBankMfo ORDER BY mfo"))
.head 6 -  Set nMfo=0
.head 6 +  While SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set strDirMfoEx[nMfo] = strDirMfo
.head 7 -  Set nMfo = nMfo + 1
.head 6 +  If SqlPrepareAndExecute(hSql(), T("UPDATE lkl_rrp SET blk=0 WHERE blk=9"))
.head 7 +  When SqlError
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Return FALSE
.head 7 -  !
.head 7 -  Call SqlCommitEx(hSql(), 'Блокировка банков СЭП')
.head 7 -  Call SqlPrepareAndExecute(hSql(), T("
       SELECT count(*) INTO :nCount FROM Banks
       WHERE mfop=:strBankMfo and mfo<>:strBankMfo and blk<>0"))
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 7 +  If nCount > 0
.head 8 -  Call MessageAttention(MSG_CustomerLockWarnP1 || SalNumberToStrX(nCount, 0))
.head 7 -  !
.head 7 +  If nMfo > 0
.head 8 -  Set nCount = 0
.head 8 -  Call SalCreateWindow(win_meter, hWndForm, MSG_NonQuitDocsCheck, nMfo)
.head 8 +  While nCount < nMfo
.head 9 -  Set strMfoTmp = SalStrTrimX(strDirMfoEx[nCount])
.head 9 +  When SqlError
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Return FALSE
.head 9 +  If Not pn_grc(strMfoTmp)
.head 10 -  Call MessageWarning(MSG_CustomerWillBeLockWarnP1 || strMfoTmp || MSG_CustomerWillBeLockWarnP2)
.head 10 +  When SqlError
.head 11 -  Call SqlRollback(hSql())
.head 11 -  Return FALSE
.head 10 -  Call SqlPrepareAndExecute(hSql(), T("UPDATE lkl_rrp SET blk=3 WHERE mfo=:strMfoTmp)"))
.head 10 -  Call SqlCommitEx(hSql(), 'Блокировка банка СЭП: ' || strMfoTmp)
.head 9 -  Call SqlCommitEx(hSql(), '')
.head 9 -  Call SaveInfoToLog('Контроль платежей банка: ' || strMfoTmp || ' - успешно.')
.head 9 -  Set nCount = nCount + 1
.head 9 -  Call SalSendMsg(win_meter, AM_MtrMove, 0, nCount)
.head 8 -  Call SalDestroyWindow(win_meter)
.head 7 -  Call SaveInfoToLog(MSG_FlagsSetting)
.head 6 +  Else
.head 7 -  Call MessageError(MSG_BanksInitFail)
.head 5 +  Else
.head 6 -  Call MessageError(MSG_BanksInitFail || MSG_DirCustomerSelect)
.head 5 -  !
.head 5 -  Return fRet
.head 3 +  Function: CurBalanceReval       
.head 4 -  Description: Переоценка остатков в инвалюте 02-08-2001 (MIK)
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nPar
.head 5 -  String: sPar
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: aKv[*]
.head 5 -  String: sKv[*]
.head 5 -  String: sLcv
.head 5 -  String: sErrTxt
.head 5 -  Number: i
.head 5 -  Number: nCount
.head 5 -  Number: nKv
.head 5 -  Number: nKvBas
.head 5 -  Number: nMode
.head 5 -  Date/Time: dDat
.head 5 -  ! Number: nFetchRes
.head 4 +  Actions
.head 5 -  Set nKvBas=GetBaseVal()
.head 5 -  Set dDat = GetBankDate()
.head 5 -  Set sErrTxt='Переоцінка залишків в інвалюті '|| Str(nMode) 
.head 5 -  Set nMode=Val(sPar)
.head 5 +  If SqlPrepareAndExecute(hSql(), 
  "SELECT kv,lcv FROM tabval INTO :nKv,:sLcv WHERE kv<>:nKvBas ORDER BY kv")
.head 6 -  Set i=0
.head 6 +  While SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set aKv[i] = nKv
.head 7 -  Set sKv[i] = sLcv
.head 7 -  Set i = i + 1
.head 6 +  If i > 0
.head 7 -  Set nCount = 0
.head 7 -  Call SalCreateWindow(win_meter, hWndForm, sErrTxt, i)
.head 7 +  While nCount < i
.head 8 -  Set nKv = aKv[nCount]
.head 8 -  Call SalStatusSetText( hWndForm, 'Валюта '||sKv[nCount] )
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 -  Call SalWaitCursor( TRUE )
.head 9 +  If SqlPLSQLCommand(hSql(), "p_rev(" || IifS (nPar=5, ""," nMode, ") || "nKv, dDat)")
.head 10 -  Call SqlCommitEx(hSql(), sErrTxt ||' по '|| Str(nKv) )
.head 10 -  Call SaveInfoToLog(sErrTxt||' по '|| SalNumberToStrX( nKv, 0 ) || ' - успешно.')
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Call SaveInfoToLog(sErrTxt||' по '|| SalNumberToStrX( nKv, 0 ) || ' - ошибка.')
.head 9 -  Call SalWaitCursor( FALSE )
.head 8 +  Else
.head 9 -  Call MessageWarning('Для INFORMIX пока не реализовано')
.head 9 -  Return TRUE
.head 8 -  Set nCount = nCount + 1
.head 8 -  Call SalSendMsg(win_meter, AM_MtrMove, 0, nCount)
.head 7 -  Call SalStatusSetText( hWndForm, 'Готово' )
.head 7 -  Call SalDestroyWindow(win_meter)
.head 7 -  Return TRUE
.head 5 -  Call MessageError('Не описаны инвалюты')
.head 5 -  Return FALSE
.head 3 +  Function: PayStartDay		
.head 4 -  Description: Вызов процедуры PAY_DATE
Оплата документов по дате валютирования
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Date/Time: currDate
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRetCode
.head 5 -  ! Number: nFetchRes
.head 4 +  Actions
.head 5 +  While TRUE
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If SalStrUpperX(SalStrTrimX(GetDBMS())) = 'INFORMIX'
.head 7 +  If not SqlRetrieve(hSql(),
    "informix.startday", ':currDate', ':nRetCode')
.head 8 -  Break
.head 7 +  If not SqlExecute(hSql())
.head 8 -  Break
.head 7 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Break
.head 7 -  !
.head 7 +  If nRetCode != 0
.head 8 -  Break
.head 6 +  Else If SalStrUpperX(SalStrTrimX(GetDBMS())) = 'ORACLE'
.head 7 -  ! Call SqlPrepareAndExecute( hSql(), 'select gl.bd into :currDate from dual')
.head 7 -  ! Call SqlFetchNext( hSql(), nFetchRes )
.head 7 -  ! Call SalMessageBox(SalFmtFormatDateTime(currDate, 'dd/MM/yyyy hhhh:mm:ss'), 'Debug', 0 )
.head 7 +  If SqlPLSQLCommand(hSql(), "pay_date(currDate)")
.head 8 -  Call SqlCommitEx(hSql(), 'pay_date - OK' )
.head 8 -  Call SaveInfoToLog('Оплата документов на старте дня - успешно.')
.head 7 +  Else
.head 8 -  Break
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return TRUE
.head 5 -  Call SqlRollbackEx(hSql(),'Неуспех при pay_date')
.head 5 -  Call MessageError('Ош. оплаты док. по наступившей дате валютирования')
.head 5 -  Return FALSE
.head 3 +  Function: BakStartDay		
.head 4 -  Description: Вызов процедуры NOPAY_DATE
Сторнирование "устаревших" документов по дате валютирования
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nAmountDay
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nDay
.head 5 -  Date/Time: dDate
.head 5 -  String: sDate
.head 5 -  Number: nRet
.head 4 +  Actions
.head 5 -  Set nDay = IifN(nAmountDay=0 or nAmountDay=NUMBER_Null, GetGlobalOptionEx('BakStart'), nAmountDay)
.head 5 -  Set nDay = IifN(nDay=0, 30, nDay)
.head 5 -  Set sDate = GetValueStr("
    select substr(to_char(fdat,'DD/MM/YYYY'),1,10)
    from   (select fdat, rownum r
            from   (select fdat
                    from   fdat
                    where  fdat between bankdate-" || Str(nDay) || "-10 and bankdate
                    order by 1 desc))
    where  r=" || Str(nDay))
.head 5 +  If Len(sDate) = 10
.head 6 -  Set dDate = SalDateConstruct(Val(Right(sDate, 4)), Val(Subs(sDate, 4, 2)), Val(Left(sDate, 2)), 0, 0, 0)
.head 6 +  While TRUE
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  If SqlPLSQLCommand(hSql(), "nopay_date(dDate,nRet)")
.head 8 +  If nRet > 0
.head 9 -  Call SqlCommitEx(hSql(), 'nopay_date - OK')
.head 9 -  Call SaveInfoToLog('Сторно "устаревших" документов на старте дня - успешно. (' ||  Str(nRet) || ')')
.head 9 -  Call SalWaitCursor(FALSE)
.head 8 +  Else
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Отсутствуют "устаревшие" документы.', 'Сообщение!', 3, 0)
.head 8 -  Return TRUE
.head 7 +  Else
.head 8 -  Break
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return TRUE
.head 6 -  Call SqlRollbackEx(hSql(),'Неуспех при nopay_date')
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageError('Ош. сторно "устаревших" документов...')
.head 6 -  Return FALSE
.head 5 +  Else
.head 6 -  Call MessageNoWait('Отсутствует банковская дата для "устаревших" документов.', 'Сообщение!', 3, 0)
.head 6 -  Return FALSE
.head 3 +  ! Function: M_Mega
.head 4 -      Description: Процедура Днепр казначейства
.head 4 +      Returns 
.head 5 -      Boolean: 
.head 4 +      Parameters 
.head 5 -      Date/Time: currDate
.head 4 -      Static Variables 
.head 4 +      Local variables 
.head 5 -      Number: nRetCode
.head 4 +      Actions 
.head 5 +      While TRUE
.head 6 -      Call SalWaitCursor(TRUE)
.head 6 +      If SalStrUpperX(SalStrTrimX(GetDBMS())) = 'ORACLE'
.head 7 +      If SqlPLSQLCommand(hSql(), "M_Mega(currDate)")
.head 8 -      Call SqlCommitEx(hSql(), 'M_Mega - OK' )
.head 8 -      Call SaveInfoToLog('M_Mega - успешно.')
.head 7 +      Else 
.head 8 -      Break 
.head 6 -      Call SalWaitCursor(FALSE)
.head 6 -      Return TRUE
.head 5 -      Call SqlRollbackEx(hSql(),'Неуспех при M_Mega')
.head 5 -      Call MessageError('Ош. вызова процедуры M_Mega')
.head 5 -      Return FALSE
.head 3 +  Function: ZTable_Clear
.head 4 -  Description: Чистка таблицы Z
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Set fRet= TRUE
.head 5 +  When SqlError
.head 6 -  Set fRet = FALSE
.head 6 -  Return SqlRollback(hSql())
.head 5 +  If NOT SqlPrepareAndExecute(hSql(), T("DELETE FROM z"))
.head 6 -  Call MessageError(MSG_TmpTableInitFail || 'Z')
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), MSG_TableClean_Z)
.head 5 -  !
.head 5 -  Return fRet
.head 3 +  Function: SaldoH_Clear
.head 4 -  Description: Чистка Таблицы SALDOH
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strSQL
.head 5 -  Boolean: fRet
.head 4 +  Actions
.head 5 -  Set fRet = TRUE
.head 5 +  When SqlError
.head 6 -  Set fRet = FALSE
.head 6 -  Return SqlRollback(hSql())
.head 5 -  Set strSQL = T("DELETE FROM Saldoh WHERE (DATE(dat) - TODAY)>=10")
.head 5 +  If NOT SqlPrepareAndExecute(hSql(), strSQL)
.head 6 -  Call MessageError(MSG_TmpTableInitFail || 'SALDOH')
.head 5 +  Else
.head 6 -  Call SqlCommitEx(hSql(), MSG_TableClean_SALDOH)
.head 5 -  !
.head 5 -  Return fRet
.head 3 +  Function: InitRefLstTable
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRecCount
.head 5 -  ! Number: nFetchRes
.head 4 +  Actions
.head 5 +  While TRUE
.head 6 -  Call SaveInfoToLog('Контроль числа записей в таблице REF_LST')
.head 6 -  !
.head 6 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT count(*)
   FROM Ref_lst
   INTO :nRecCount')) = FALSE
.head 7 -  Call SaveInfoToLog(
      'Ошибка получения числа записей в таблице REF_LST')
.head 7 -  Break
.head 6 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Break
.head 6 +  If nRecCount > 1000000
.head 7 +  If MessageQuestion('Выполнить очистку таблицы ' ||
   'Контроля уникальности платежей СЭП - REF_LST?')
   = IDNO
.head 8 -  Return FALSE
.head 6 +  Else
.head 7 -  Return TRUE
.head 6 +  If NOT SqlPrepareAndExecute(hSql(), T('DROP TABLE Ref_lst'))
.head 7 -  Call SaveInfoToLog('Ошибка удаления таблицы REF_LST')
.head 7 -  Break
.head 6 -  Call SaveInfoToLog('Таблица REF_LST удалена')
.head 6 +  If NOT SqlPrepareAndExecute(hSql(), T('
   CREATE TABLE Ref_lst (mfoa varchar(12),
                         data date,
                         datp date,
                         ref_a varchar(9),
                         rec integer,
                         unique (mfoa, datp, ref_a)
   CONSTRAINT uniq_doc)
   IN ' || GetDefDbs() || ' EXTENT size 10000 NEXT size 10000 lock mode row'))
.head 7 -  Call SaveInfoToLog('Ошибка создания таблицы REF_LST')
.head 7 -  Break
.head 6 +  If NOT SqlCommitEx(hSql(), MSG_TableClean_REF_LST)
.head 7 -  Break
.head 6 -  Call SaveInfoToLog('Таблица REF_LST создана')
.head 6 +  If NOT SqlPrepareAndExecute(hSql(), T('UPDATE STATISTICS for table Ref_lst'))
.head 7 -  Call SaveInfoToLog('Ошибка выполнения SQL-оператора ' ||
      'UPDATE STATISTICS для таблицы REF_LST')
.head 7 -  Break
.head 6 -  Call SaveInfoToLog('Выполнен SQL-оператор UPDATE ' || 'STATISTICS для таблицы REF_LST')
.head 6 -  Return TRUE
.head 5 -  Call SqlRollback(hSql())
.head 5 -  Return MessageError(MSG_TmpTableInitFail || 'REF_LST')
.head 3 +  ! Function: GetMonthNameRus
.head 4 -      Description: Возвращает имя месяца (И.П. или Р.П.)
.head 4 +      Returns 
.head 5 -      String: 
.head 4 +      Parameters 
.head 5 -      Number: nMonthNum
.head 5 -      Boolean: bPadegh
.head 4 -      Static Variables 
.head 4 +      Local variables 
.head 5 -      String: szRes
.head 5 -      String: szColName1[13]
.head 5 -      String: szColName2[13]
.head 4 +      Actions 
.head 5 -      Set szColName1[0] = 'эхаль'
.head 5 -      Set szColName1[1] = 'январь'
.head 5 -      Set szColName1[2] = 'февраль'
.head 5 -      Set szColName1[3] = 'март'
.head 5 -      Set szColName1[4] = 'апрель'
.head 5 -      Set szColName1[5] = 'май'
.head 5 -      Set szColName1[6] = 'июнь'
.head 5 -      Set szColName1[7] = 'июль'
.head 5 -      Set szColName1[8] = 'август'
.head 5 -      Set szColName1[9] = 'сентябрь'
.head 5 -      Set szColName1[10] = 'октябрь'
.head 5 -      Set szColName1[11] = 'ноябрь'
.head 5 -      Set szColName1[12] = 'декабрь'
.head 5 -      Set szColName2[0] = 'эхаля'
.head 5 -      Set szColName2[1] = 'января'
.head 5 -      Set szColName2[2] = 'февраля'
.head 5 -      Set szColName2[3] = 'марта'
.head 5 -      Set szColName2[4] = 'апреля'
.head 5 -      Set szColName2[5] = 'мая'
.head 5 -      Set szColName2[6] = 'июня'
.head 5 -      Set szColName2[7] = 'июля'
.head 5 -      Set szColName2[8] = 'августа'
.head 5 -      Set szColName2[9] = 'сентября'
.head 5 -      Set szColName2[10] = 'октября'
.head 5 -      Set szColName2[11] = 'ноября'
.head 5 -      Set szColName2[12] = 'декабря'
.head 5 -      Return IifS(bPadegh, szColName2[nMonthNum],
       szColName1[nMonthNum])
.head 3 -  ! By Ivan
.head 3 +  Function: SheduleSWIFTStatements	! __exported
.head 4 -  Description: Формирование SWIFT выписок на закрытии дня.
(Только для счетов клиентов-банков в соответствии с периодичностью выписок)
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SaveInfoToLog( 'Формирование SWIFT выписок начато' )
.head 5 +  If SqlPrepareAndExecute(hSql(), "BEGIN SWIFT.SheduleStatementMessages;END;")
.head 6 -  Call SqlCommitEx( hSql(), 'Формирование SWIFT выписок успешно завершено' )
.head 5 +  Else
.head 6 -  Call SqlRollbackEx( hSql(),'Формирование SWIFT выписок завершено с ошибкой' )
.head 3 -  ! Not by Ivan
.head 3 +  Function: F1_Select			! __exported
.head 4 -  Description: Селектор по вызову разных функций
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nPar
.head 5 -  String: sPar
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sProc
.head 5 -  String: sTable
.head 5 -  Number: nTmp
.head 5 -  String: sTmp
.head 5 -  Number: nS
.head 5 -  !
.head 5 -  String: sdat
.head 5 -  String: sid
.head 5 -  String: sSql
.head 5 -  Boolean: bFL
.head 5 -  String: sOdir
.head 5 -  String: sPath
.head 5 -  String: sFile
.head 5 -  String: sFile1
.head 5 -  Sql Handle: hSqlA
.head 5 -  File Handle: hFile
.head 5 -  String: sNLS
.head 5 -  Number: nRNK
.head 5 -  Number: nISP
.head 5 -  Date/Time: dDAT
.head 5 -  Number: nK
.head 5 -  Number: nZamok
.head 5 -  Date/Time: dZamok
.head 5 -  Number: RET
.head 5 -  Date/Time: DAT
.head 5 -  Boolean: bU
.head 5 -  String: sMFO
.head 5 -  String: sMFOU
.head 5 -  Number: nMFO
.head 5 -  Number: nMFOU
.head 5 -  Number: nNull
.head 5 -  String: sNB
.head 5 -  String: sSAB
.head 5 -  !
.head 5 -  String: sParArgs[5]
.head 5 -  Number: nParArgs
.head 4 +  Actions
.head 5 +  If nPar      =   1  !  Формирование SWIFT выписок на закрытии дня.
                    !  (Только для счетов клиентов-банков в соответствии с периодичностью выписок)
.head 6 +  If SqlPrepareAndExecute(hSql(), "BEGIN SWIFT.SheduleStatementMessages;END;")
.head 7 -  Call SqlCommit(hSql())
.head 6 +  Else
.head 7 -  Call SqlRollback(hSql())
.head 5 +  Else If nPar =   2  !  Авто-закрытие счетов
.head 6 -  Call SalCreateWindow(AS2, hWndMDI,sPar)
.head 6 -  ! Return SalModalDialog(AS, hWndMDI, sPar )
.head 5 +  Else If nPar =   3  !  Обновление таблицы актуальных курсов
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set sTmp = SalStrTrimX(SalStrUpperX(GetDBMS()))
.head 6 -  Set sid = 'KURS1'
.head 6 -  Set sdat = GetBankDateEx()
.head 6 -  ! Вычитали из системной таблицы имя временной таблицы
.head 6 -  Set sSql = "
    SELECT " || IifS(sTmp ='ORACLE', "table_name
    FROM user_tables
    WHERE table_name", "tabname
    FROM systables
    WHERE tabname") || "=:sid "
.head 6 -  Set bFL = SqlPrepareAndExecute(hSqlAux(), sSql)
.head 6 -  ! Удалить если есть
.head 6 +  If bFL
.head 7 +  If SqlFetchNext(hSqlAux(), nTmp)
.head 8 -  Set bFL = SqlPrepareAndExecute(hSqlAux(), "
    DROP table " || sid)
.head 6 -  ! Создать временную и Населить временную
.head 6 +  If bFL
.head 7 -  Set sSql = "
    INSERT
    INTO " || sid || "(kv,kurs) 
    SELECT c.kv,c.rate_o/c.bsum
    FROM cur_rates c
    WHERE "
.head 7 +  If sTmp = 'ORACLE'
.head 8 -  Set sSql = sSql || "(c.kv,c.vdate)=(
    SELECT u.kv,max(u.vdate)
    FROM cur_rates u
    WHERE u.kv=c.kv and u.vdate<=TO_DATE('" || sdat || "','mm-dd-yyyy')
    GROUP BY u.kv)"
.head 7 +  Else
.head 8 -  Set sSql = sSql || "c.vdate=(
    SELECT max(u.vdate)
    FROM cur_rates u
    WHERE u.kv=c.kv and u.vdate<= :sdat)"
.head 7 -  Set bFL = SqlPrepareAndExecute(hSqlAux(), "
    CREATE table " || sid || "(kv int PRIMARY KEY,kurs decimal(20,10))") and
    SqlPrepareAndExecute(hSqlAux(), sSql) and
    SqlPrepareAndExecute(hSqlAux(), "commit")
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return bFL
.head 5 +  Else If nPar =   4  !  Формирование файлов расширенной технической выписки (Сбербанк)
.head 6 +  If hTv
.head 7 -  Call SalBringWindowToTop(TechVip)
.head 6 +  Else
.head 7 -  Call SalCreateWindow(TechVip, hWndMDI, sPar)
.head 5 +  Else If nPar =   5
     or nPar =  15  !  Переоц зал в інвал:  5-обычная всех сч (КБ),15-по коду переоценки сч (НБУ)
.head 6 -  Return CurBalanceReval( nPar, sPar)
.head 5 +  Else If nPar =  10  !  Формирование стартовой таблицы остатков для казначейства
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  ! запомнить текущий каталог в sOdir
.head 6 -  Call SalFileGetCurrentDirectory(sOdir)
.head 6 -  ! Вычитать из .ini имя каталога для формирования файла
  Syymmdd.dbf в sPath
.head 6 -  Call SalUseRegistry(FALSE, '')
.head 6 -  Call SalGetProfileString('ElektroKlients', 'TreasuryPath', GetPrnDir(), sPath,
     GetIniFileName())
.head 6 -  ! Создать (если нет) и сделать текущим каталог sPath
.head 6 -  Call SalFileCreateDirectory(sPath)
.head 6 -  Call SalFileSetCurrentDirectory(sPath)
.head 6 -  ! Краткое имя файла sFile и полное sFile1
.head 6 -  Set sFile = 'S' || SalFmtFormatDateTime(GetBankDate(), 'yyMMdd')
.head 6 -  Set sFile1 = sPath || IifS(Right(sPath,1)!='\\', '\\','') || sFile || '.dbf'
.head 6 -  ! Удаление sFile1 (если есть)
.head 6 +  If File(sFile1)
.head 7 +  If SalMessageBox("Выполнить повторное формирование ?", "Файл " || sFile1 ||
   " уже существует !", MB_IconQuestion | MB_YesNo) = IDYES
.head 8 -  Call SalFileOpen (hFile, sFile1, OF_Delete)
.head 7 +  Else
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Return TRUE
.head 6 -  ! Работа с БД через ODBC
.head 6 -  Set SqlDatabase = 'dBase_Files'
.head 6 +  If SqlConnect(hSqlA)
.head 7 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    CREATE
    TABLE " || sFile || " (NLS CHAR(14),
                           ISS NUMBER(16,0),
                           RNK NUMBER(6,0),
                           ISP NUMBER(6,0),
                           DAPP DATE)")
and SqlPrepareAndExecute(hSql(), "
    SELECT a.nls,-a.ostc,u.rnk,a.isp,a.dapp
    INTO :sNLS,:nS,:nRNK,:nISP,:dDAT
    FROM accounts a, cust_acc u, bank_acc b
    WHERE a.tip in ('RKZ','DKZ') and a.acc=b.acc and a.acc=u.acc and a.ostc<>0")
.head 7 +  If bFL
.head 8 -  Set nK = 1
.head 8 -  Set nZamok = 0
.head 8 -  Set dZamok = GetBankDate()
.head 8 +  While SqlFetchNext(hSql(), nTmp)
.head 9 -  Set nZamok = nZamok + Abs(nS)*nK + Int(Val(sNLS)/nK) +
    Int(nRNK*SalNumberSqrt(nK)) + Int(nISP/SalNumberSqrt(nK))
.head 9 -  Set nK = nK + 1
.head 9 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile || "
    VALUES (:sNLS,:nS,:nRNK,:nISP,:dDAT)")
.head 9 -  Call SalStatusSetText(hWndForm, 'Счет ' || sNLS || ', остаток = ' ||
     SalNumberToStrX(Abs(nS)/100, 2))
.head 9 +  If not bFL
.head 10 -  Break
.head 8 +  If bFL
.head 9 -  Set nZamok = Mod(nZamok, 1000000000000000) 
.head 9 -  Call SqlPrepareAndExecute(hSqlA, "
     INSERT
     INTO " || sFile || "
     VALUES ('',:nZamok,0,0,:dZamok)")
.head 9 -  Call SqlCommit(hSqlA)
.head 9 -  Call MessageNoWait('Создание ' || sFile1 || ' успешно завершено !', 'Сообщение',
     1, 0)
.head 8 +  Else
.head 9 -  Call SqlRollback(hSqlA)
.head 8 -  Call SalStatusSetText(hWndForm, '')
.head 7 -  Call SqlDisconnect(hSqlA)
.head 6 -  ! Восстановление первичного текущего каталога
.head 6 -  Call SalFileSetCurrentDirectory(sOdir)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return bFL
.head 5 +  Else If nPar =  11  !  Отбор выписок эл.клиентам (районы) для казначейства и НБУ
.head 6 +  If sPar = ''
.head 7 -  Call SalModalDialog(FormVWa, hWndForm)
.head 6 +  Else If sPar = 'V'
.head 7 -  Call SalModalDialog(FormVWaV, hWndForm)
.head 6 +  Else If sPar = 'N'
.head 7 -  Call SalModalDialog(FormVWaN, hWndForm)
.head 5 +  Else If nPar =  12  !  Виклик PLSQL + Процедури з переглядом баблиці
.head 6 -  Set sProc = STRING_Null
.head 6 -  Set sTable= STRING_Null
.head 6 -  Set nS = At('*', sPar )
.head 6 +  If nS > 0
.head 7 -  Set sProc  = Subs(sPar, 1, nS-1 )
.head 7 -  Set sTable = Subs(sPar, nS+1, SalStrLength( sPar ) - nS  )
.head 6 +  Else
.head 7 -  Set sProc = sPar
.head 6 -  ! Call Debug (sProc)
.head 6 -  ! Call Debug (sTable)
.head 6 -  ! !!!!!!!!
.head 6 +  While TRUE
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set RET = 0    ! Pre-set Procedure return code
.head 7 -  Set DAT = GetBankDate()
.head 7 +  If SqlPLSQLCommand(hSql(), sProc )
.head 8 +  If RET = 0
.head 9 -  Call SqlCommitEx(hSql(), sProc || '- OK')
.head 9 -  Call SaveInfoToLog( sProc || '- OK')
.head 8 +  Else
.head 9 -  Break
.head 7 +  Else
.head 8 -  Break
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call SalStatusSetText(hWndForm, sProc || '- OK')
.head 7 -  Call MessageNoWait('Выполнена процедура ' || sProc , 'Сообщение', 3, 0)
.head 7 +  If sTable != STRING_Null 
.head 8 -  Call FunNSIEditF(sTable,1)
.head 7 -  Return TRUE
.head 6 -  Call SqlRollbackEx(hSql(), 'Err ' || sProc )
.head 6 -  Call MessageError('Помилка при виклику ' || sProc )
.head 6 -  Return FALSE
.head 5 +  Else If nPar =  13  !  Виклик PLSQL - Процедуры с управляющими сообщениями
.head 6 -  Set nParArgs = SalStrTokenize( sPar, '', ';', sParArgs )
.head 6 +  If NOT nParArgs
.head 7 -  Call SalMessageBeep( MB_IconStop )
.head 7 -  Call SalMessageBox( 'Ошибка анализа строки вызова процедуры!','Ошибка!', MB_Ok | MB_IconAsterisk )
.head 7 -  Return FALSE
.head 6 +  While TRUE
.head 7 +  If sParArgs[1]
.head 8 -  Call SalMessageBeep( MB_IconQuestion )
.head 8 +  If SalMessageBox( sParArgs[1], 'Внимание!', MB_YesNo | MB_IconQuestion ) = IDNO
.head 9 -  Return FALSE
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set RET = 0    ! Pre-set Procedure return code
.head 7 -  Set DAT = GetBankDate()
.head 7 +  If SalStrUpperX(SalStrTrimX(GetDBMS())) = 'ORACLE'
.head 8 +  If SqlPLSQLCommand(hSql(), sPar)
.head 9 +  If RET = 0
.head 10 -  Call SqlCommitEx(hSql(), sPar || '- OK')
.head 10 -  Call SaveInfoToLog(sPar || '- OK')
.head 9 +  Else
.head 10 -  Break
.head 8 +  Else
.head 9 -  Break
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 +  If sParArgs[2]
.head 8 -  Call MessageNoWait(sParArgs[2], 'Сообщение', 3, 0)
.head 7 -  Call SalStatusSetText(hWndForm, sPar || '- OK')
.head 7 -  Return TRUE
.head 6 -  Call SqlRollbackEx(hSql(), 'Err ' || sPar)
.head 6 -  Call MessageError('Помилка при виклику ' || sPar)
.head 6 -  Return FALSE
.head 5 +  Else If nPar =  14  !  Экспорт сведенных док-тов дня в ОДБ ВаБанка
.head 6 -  Call SalModalDialog(dlgVBNK, hWndForm)
.head 5 +  Else If nPar = 189  !  Прийом XML-файлів реєстру інсайдерів (ОщадБанк)
.head 6 -  Call GetRIxml()
.head 5 +  Else If nPar =  19  !  Прийом DBF-файлів реєстру інсайдерів (ОщадБанк)
.head 6 -  Call GetRI()
.head 5 +  Else If nPar =  20
     or nPar =  21  !  Форм итог табл нал учета для НБУ (20)  или  КБ (21)
.head 6 -  Call SalModalDialog(NAL_IT, hWndForm, nPar)
.head 5 +  ! Else If nPar= 30  !  Формирование выписок для NOKK
.head 6 -      Call SalCreateWindow(frm_NOK, hWndMDI, 4)
.head 6 -      Return TRUE
.head 5 +  Else If nPar =  44  !  REZAK=TAIL
.head 6 -  Return SalModalDialog(REZAK, hWndMDI)
.head 5 +  Else If nPar =  50  !  insert into s_uch.dbf
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  ! запомнить текущий каталог в sOdir
.head 6 -  Call SalFileGetCurrentDirectory(sOdir)
.head 6 -  ! Вычитать из .ini имя каталога для формирования файла
  Syymmdd.dbf в sPath
.head 6 -  Call SalUseRegistry(FALSE, '')
.head 6 -  Call SalGetProfileString('ElektroKlients',
     'S_UchPath', GetPrnDir(), sPath,
     GetIniFileName())
.head 6 -  ! Создать (если нет) и сделать текущим каталог sPath
.head 6 -  Call SalFileCreateDirectory(sPath)
.head 6 -  Call SalFileSetCurrentDirectory(sPath)
.head 6 -  ! Краткое имя файла sFile и полное sFile1
.head 6 -  Set sFile = 'S_Uch'
.head 6 -  Set sFile1 = sPath || IifS(Right(sPath,1)!='\\', '\\',
    '') || sFile || '.dbf'
.head 6 -  ! Удаление sFile1 (если есть)
.head 6 +  If File(sFile1)
.head 7 -  Call SalFileOpen(hFile, sFile1, OF_Delete)
.head 6 -  ! Работа с БД через ODBC
.head 6 -  Set SqlDatabase = 'dBase_Files'
.head 6 +  If SqlConnect(hSqlA)
.head 7 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    CREATE
    TABLE " || sFile || " (MFO   NUMBER(6,0),
                           NCKS  CHAR(4),
                           NCKSO CHAR(4),
                           NB    CHAR(38),
                           KORSH NUMBER(14,0),
                           N_MO  CHAR(1),
                           U_MO  CHAR(1),
                           MFO_G NUMBER(6),
                           M_UR  NUMBER(6),
                           F_BL  CHAR(1),
                           F_VA  CHAR(1),
                           F_SL  CHAR(1),
                           S_SS  CHAR(10))")
and SqlPrepareAndExecute(hSql(), "
    SELECT mfo,sab,nb,mfou
    INTO :sMFO,:sSAB,:sNB,:sMFOU
    FROM banks
    WHERE blk<>4")
.head 7 +  If bFL
.head 8 -  Set bU = TRUE
.head 8 -  Set nNull = NUMBER_Null
.head 8 +  While SqlFetchNext(hSql(), nTmp)
.head 9 -  Set nMFO = Val(sMFO)
.head 9 -  Set sNB = StrWinToDosX(sNB)
.head 9 -  Set nMFOU = Val(sMFOU)
.head 9 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile || "
    VALUES (:nMFO,:sSAB,'',:sNB,:nNull,'','',
            :nNull,:nMFOU,'','','','')")
.head 9 +  If bU
.head 10 -  Set bU = bFL
.head 8 +  If bU
.head 9 -  Call SqlCommit(hSqlA)
.head 9 -  Call MessageNoWait('Создание ' || sFile1 ||
     ' успешно завершено !', 'Сообщение', 17, 0)
.head 8 +  Else
.head 9 -  Call SqlRollback(hSqlA)
.head 7 -  Call SqlDisconnect(hSqlA)
.head 6 -  ! Восстановление первичного текущего каталога
.head 6 -  Call SalFileSetCurrentDirectory(sOdir)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return bU
.head 5 +  Else If nPar =  99  !  Функция обработки файлов курсов ВАЛЮТ (#99)
.head 6 -  Call GetRates()
.head 5 +  Else If nPar = 101  !  Функция обработки журнала заданий
.head 6 +  If fTaskShed
.head 7 -  Call SalBringWindowToTop(frm_Tasks)
.head 6 +  Else
.head 7 -  Call SalCreateWindow(frm_Tasks, hWndMDI)
.head 5 +  Else If nPar = 102  !  Функция редактирования журнала заданий
.head 6 +  If fTaskEdit
.head 7 -  Call SalBringWindowToTop(frm_TaskEdit)
.head 6 +  Else
.head 7 -  Call SalCreateWindow(frm_TaskEdit, hWndMDI)
.head 5 +  Else If nPar = 111  !  Отбор перечня ЗАКРЫТЫХ счетов эл.клиентам (районы) для казначейства
.head 6 -  Call SalModalDialog(FormNlsZ, hWndForm)
.head 5 +  Else If nPar = 115  !  Анализ и раччет клиентов АЖИО- по постановке Рябоштан
.head 6 -  Call Sel001 (hWndMDI, 115, 0, "", "" ) 
.head 5 +  Else If nPar = 116  !  Анализ клиентов АЖИО- по постановке Рябоштан -  Переехали в BARS001
.head 6 -  Call Sel001 (hWndMDI, 116, 0, "", "" ) 
.head 5 +  Else If nPar = 117  !  Межфилиальный FOREX -  В BARS001
.head 6 -  Call Sel001( hWndMDI, 10, 0, "FX1", "FXX" ) 
.head 5 +  Else If nPar = 118  !  Межфилиальный FOREX (через другую ВП) -  В BARS001
.head 6 -  Call Sel001( hWndMDI, 10, 0, "FX0", "FXY" ) 
.head 5 +  Else If nPar = 120  !  Портфель послуг клієнтам -  В BARS001
.head 6 -  Call Sel001( hWndMDI, 0, 45, "013", "4309105001" ) 
.head 5 +  Else If nPar = 121  !  Протокол финиша (НБУ-Сигида)
.head 6 +  If hFinis
.head 7 -  Call SalBringWindowToTop(tFinis)
.head 6 +  Else
.head 7 -  Call SalCreateWindow(tFinis, hWndMDI)
.head 5 +  Else If nPar = 122  !  Протокол овердрата
.head 6 +  If hOrv
.head 7 -  Call SalBringWindowToTop(tOvr)
.head 6 +  Else
.head 7 -  Call SalCreateWindow(tOvr, hWndMDI)
.head 5 +  Else If nPar = 125  !  Портфель послуг клієнтам. Для КБ "столиця" -  В BARS001
.head 6 -  Call Sel001( hWndMDI, 0, 100, "ELT", "43098001" ) 
.head 5 +  Else If nPar = 130  !  Только для банка СЭБ ! Формирование пачки xml-отчетов
.head 6 -  Call Otcn(hWndMDI, 0, 0, 0, sPar, '')
.head 5 +  Else If nPar = 191  !  Бізнес-напрямки. Прийом вхідного файлу
.head 6 -  Call GetBUSS()
.head 5 +  Else If nPar = 192  !  Бізнес-напрямки. Встановлення додаткових реквізитів
.head 6 -  Call MakeBUSS()
.head 5 +  Else If nPar = 193  !  Бізнес-напрямки. Прийом вхідного файлу та встановлення додаткових реквізитів
.head 6 +  If GetBUSS()
.head 7 -  Call MakeBUSS()
.head 5 +  Else If nPar = 200  !  Функция обработки файлов регламента (сообщений ВПС)
.head 6 -  Call ProcMsgFiles()
.head 5 +  Else If nPar = 840  !  Функция "Перевірка з'єднання з сервером валютообміну"
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set strReturn = GetValueStr("
    SELECT substr(check_vo,1,200)
    FROM   dual")
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait(strReturn, 'Повідомлення', IifN(At('(', strReturn)>0, 17, 7), IifN(At('(', strReturn)>0, 1, 0))
.head 5 +  Else If nPar = 999  !  Функция обработки файлов курсов ВАЛЮТ (ZMR - dbf)
.head 6 -  Call GetZMR()
.head 5 +  Else If nPar = 307  !  Функция обработки файлов VIP (txt)
.head 6 -  Call GetVIP()
.head 5 +  Else If nPar = 308  !  Функция обработки файлов Приналежність до працівників Банку (dbf)
.head 6 -  Call GetWORKB()
.head 5 +  Else If nPar = 403  !  Механизм
.head 6 -  Call SalModalDialog(dlg_In3, hWndForm)
.head 5 -  Return TRUE
.head 3 +  Function: GetRates
.head 4 -  Description: Прием курсов НБУ из файлов #99
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  String: sDat
.head 5 -  Number: nkv
.head 5 -  Number: nbsum
.head 5 -  Number: nrate_o
.head 5 -  String: srab
.head 5 -  Boolean: byn
.head 5 -  Boolean: bpovtor
.head 5 -  Number: naa
.head 5 -  ! Number: nFetchRes
.head 5 -  String: sFA
.head 5 -  String: ss
.head 5 -  String: bk
.head 5 -  String: sFileSimv[*]
.head 5 -  Number: nNumFiles
.head 5 -  Number: nI
.head 5 -  String: sDD
.head 5 -  Boolean: bYa
.head 5 -  String: sDirs[*]
.head 5 -  Number: nCount
.head 5 -  Number: nD
.head 5 -  Boolean: bZag
.head 5 -  String: smElem[*]
.head 5 -  String: snKV
.head 5 -  String: sLCV
.head 5 -  String: snBsum
.head 5 -  Number: nA
.head 5 -  Number: nR
.head 5 -  String: snRate
.head 5 -  !
.head 5 -  Number: nNumTokens
.head 5 -  Number: nRet
.head 5 -  Date/Time: dkKURS
.head 5 -  !
.head 5 -  String: sTime[*]
.head 5 -  String: smElem2[*]
.head 5 -  Number: nNumTokens2
.head 5 -  String: sHHMMSS
.head 5 -  Number: nI2
.head 5 -  !
.head 5 -  String: sRet
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalArraySetUpperBound(sFileSimv, 1, -1)
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('common parameters', 'curratesdir', '\\BARS98\\RATES', ss, GetIniFileName())
.head 5 -  Call SalGetProfileString('common parameters', 'arcratesdir', ss || '\\BACKUP', bk, GetIniFileName())
.head 5 -  Set sFA = ss || '\\#990h0??.v??'
.head 5 -  Set nNumFiles = VisDosEnumFiles(sFA, FA_Standard, sFileSimv)
.head 5 +  If nNumFiles > 0
.head 6 -  Set nI = 0
.head 6 +  While nI < nNumFiles
.head 7 -  Set sFA = ss || '\\' || sFileSimv[nI]
.head 7 -  Set byn = FALSE
.head 7 -  Set bpovtor = FALSE
.head 7 +  If SalFileOpen(hFile, sFA, 0)
.head 8 -  Set bZag = FALSE
.head 8 +  Loop
.head 9 +  If not SalFileGetStr(hFile, srab, 256) ! конец файла
.head 10 -  Break
.head 9 -  Set srab = SalStrTrimX(srab)
.head 9 +  If Len(srab) > 0
.head 10 +  If not bZag
.head 11 -  ! прочитать заголовок (дату курсов)
.head 11 -  Call SalStrTokenize(srab, '', '=', smElem)
.head 11 +  If smElem[0] = '26'
.head 12 -  Set sDD = smElem[1] !! дата курсов ДДММГГГГ
.head 12 -  Set sDD = Left(sDD, 2) || '/' || Subs(sDD, 3, 2) || '/' || Right(sDD, 4)
.head 12 -  Set sDat = Subs(sDD, 4, 3) || Left(sDD, 3) || Right(sDD, 4)
.head 12 -  Set bZag = TRUE
.head 11 +  Else
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call MessageNoWait('Помилка в ЗАГОЛОВНОМУ рядку файла ' || sFileSimv[nI] || ', курси НЕ приймаються.',
     'УВАГА !!!', 17, 1)
.head 12 -  Call SalWaitCursor(TRUE)
.head 12 -  Break
.head 10 +  Else
.head 11 -  ! прочитать строку курсов
.head 11 -  Call SalStrTokenize(srab, '', '=', smElem)
.head 11 +  If smElem[0] = 'A' and smElem[1] = '1'
.head 12 -  Set snKV = smElem[2]
.head 12 -  Set sLCV = smElem[3]
.head 12 -  Set snBsum = smElem[4]
.head 12 -  Set snRate = smElem[5]
.head 12 -  Set nkv = Val(snKV)
.head 12 -  Set nA = At('.', snRate)
.head 12 -  Set nR = Len(snRate) - nA
.head 12 -  Set snRate = Stuff(snRate, nA, 1, '')
.head 12 -  ! Set nrate_o = Val(snRate) / SalNumberPower(10, nR)
.head 12 +  If nkv > 0
.head 13 -  Set nbsum = 0
.head 13 +  If SqlPrepareAndExecute(hSql(), T("
   SELECT count(*)
   INTO   :nbsum
   FROM   tabval
   WHERE  kv=:nkv"))
.head 14 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 13 +  If nbsum > 0
.head 14 -  Set naa = 0
.head 14 +  If GetGlobalOption('HAVETOBO') = '2' and GetGlobalOption('BANKTYPE') != 'NBU'
.head 15 +  If SqlPrepareAndExecute(hSql(), T("
   SELECT count(*)
   INTO   :naa
   FROM   cur_rates
   WHERE  kv=:nkv and vdate=:sDat  and OFFICIAL='Y'"))
.head 16 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 14 +  Else
.head 15 +  If SqlPrepareAndExecute(hSql(), T("
   SELECT count(*)
   INTO   :naa
   FROM   cur_rates
   WHERE  kv=:nkv and vdate=:sDat "))
.head 16 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 14 +  If naa > 0 and not bpovtor and File(bk || '\\' || Right(sFA, 12))
.head 15 -  Set bpovtor = TRUE
.head 15 -  Call SalWaitCursor(FALSE)
.head 15 +  If SalMessageBox("Файл курсів з іменем " || Right(sFA, 12) ||
   " раніше ВЖЕ приймався ! ПРОДОВЖИТИ ?", "УВАГА !!!", MB_YesNo | MB_IconHand) = IDNO
.head 16 -  Call SalWaitCursor(TRUE)
.head 16 -  Break
.head 15 -  Call SalWaitCursor(TRUE)
.head 14 -  Set nbsum = Val(snBsum)
.head 14 -  Set nrate_o = Val(snRate) / SalNumberPower(10, nR)
.head 14 -  Call SalUpdateWindow(hWndForm)
.head 14 -  !
.head 14 +  If GetGlobalOption('HAVETOBO') = '2' and GetGlobalOption('BANKTYPE') != 'NBU'
.head 15 -  ! принять курс валюты по иному
.head 15 +  If SqlPLSQLCommand(hSql(), 'p_rates(sDD,nkv,nbsum,nrate_o)')
.head 16 -  Call SqlCommit(hSql())
.head 16 -  Call SaveFInfoToLog('Добавлений курс: ' || Right(Str(nkv+1000), 3) || '-' || sDD || '-' || PadL(
     Str(nbsum), 4) || '-' || Str(nrate_o))
.head 16 -  Set byn = TRUE
.head 15 +  Else
.head 16 -  Call SqlRollback(hSql())
.head 16 -  Call SalWaitCursor(FALSE)
.head 16 -  Call MessageNoWait('Не вдалося добавити курс: ' || Right(Str(nkv+1000), 3) || '-' || sDD || '-' ||
     Str(nbsum) || '-' || Str(nrate_o), 'ПОМИЛКА !', 7, 1)
.head 16 -  Call SalWaitCursor(TRUE)
.head 14 +  Else
.head 15 +  If naa = 0
.head 16 +  If SqlPrepareAndExecute(hSql(), T("
   INSERT
   INTO   cur_rates (kv,vdate,bsum,rate_o)
   VALUES (:nkv,:sDat ,:nbsum,:nrate_o)"))
.head 17 -  Call SqlCommit(hSql())
.head 17 -  Call SaveFInfoToLog('Добавлений курс: ' || Right(Str(nkv+1000), 3) || '-' || sDD || '-' || PadL(
     Str(nbsum), 4) || '-' || Str(nrate_o))
.head 16 +  Else
.head 17 -  Call SqlRollback(hSql())
.head 17 -  ! Call SaveErrorToLog('Не вдалося добавити курс: ' || Right(Str(nkv+1000), 3) || '-' || sDD ||
     '-' || PadL(Str(nbsum), 4) || '-' || Str(nrate_o))
.head 17 -  Call SalWaitCursor(FALSE)
.head 17 -  Call MessageNoWait('Не вдалося добавити курс: ' || Right(Str(nkv+1000), 3) || '-' || sDD || '-'
     || Str(nbsum) || '-' || Str(nrate_o), 'ПОМИЛКА !', 7, 1)
.head 17 -  Call SalWaitCursor(TRUE)
.head 15 +  Else
.head 16 -  ! If SqlPrepareAndExecute(hSql(), T("
   UPDATE cur_rates
   SET    bsum=:nbsum,rate_o=:nrate_o
   WHERE  kv=:nkv and vdate=:sDat "))
.head 16 +  If SqlPrepareAndExecute(hSql(), T("
   UPDATE cur_rates
   SET    bsum=:nbsum,rate_o=:nrate_o
   WHERE  kv=:nkv and (vdate=:sDat or (vdate>:sDat and vdate-3<=:sDat and rate_b is not null and
          rate_s is not null))"))
.head 17 -  Call SqlCommit(hSql())
.head 17 -  Call SaveFInfoToLog('Змінений курс: ' || Right(Str(nkv+1000), 3) || '-' || sDD || '-' || PadL(
     Str(nbsum), 4) || '-' || Str(nrate_o))
.head 16 +  Else
.head 17 -  Call SqlRollback(hSql())
.head 17 -  ! Call SaveErrorToLog('Не вдалося змінити курс: ' || Right(Str(nkv+1000), 3) || '-' || sDD ||
     '-' || PadL(Str(nbsum), 4) || '-' || Str(nrate_o))
.head 17 -  Call SalWaitCursor(FALSE)
.head 17 -  Call MessageNoWait('Не вдалося змінити курс: ' || Right(Str(nkv+1000), 3) || '-' || sDD || '-' ||
     Str(nbsum) || '-' || Str(nrate_o), 'ПОМИЛКА !', 7, 1)
.head 17 -  Call SalWaitCursor(TRUE)
.head 15 -  Set byn = TRUE
.head 15 -  Call SalStatusSetText(hWndForm, sFileSimv[nI] || ': ' || sLCV || '(' || Right(Str(nkv+1000), 3) ||
     ') дата ' || sDD || ' ' || smElem[5] || ' (за ' || Str(nbsum) || ')')
.head 14 -  !
.head 14 -  Call SalUpdateWindow(hWndForm)
.head 8 -  Call SalFileClose(hFile)
.head 8 +  If byn
.head 9 -  ! Call SqlCommit(hSql())
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Курси за ' || sDD || ' - прийняті.', 'ПОВІДОМЛЕННЯ', 1, 0)
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  Set bYa = FALSE
.head 9 +  If not VisDosExist(bk)
.head 10 +  If not SalFileCreateDirectory(bk)
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call SalMessageBox('Неможливо створити каталог:' || bk, 'Увага!', MB_IconStop)
.head 11 -  Call SalWaitCursor(TRUE)
.head 9 +  If VisDosExist(bk)
.head 10 +  If File(bk || '\\' || sFileSimv[nI])
.head 11 -  Call VisFileDelete(bk || '\\' || sFileSimv[nI])
.head 10 -  Call SalFileCopy(sFA, bk || '\\' || sFileSimv[nI], TRUE)
.head 10 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 10 -  Call SalFileOpen(hFile, sFA, OF_Delete)
.head 10 -  Call SalFileClose(hFile)
.head 8 +  Else
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Курси за ' || sDD || ' - НЕ прийняті.', 'УВАГА!', 3, 1)
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  !
.head 9 +  If not VisDosExist(ss || '\\bad')
.head 10 +  If not SalFileCreateDirectory(ss || '\\bad')
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call SalMessageBox('Неможливо створити каталог:' || ss || '\\bad', 'Увага!', MB_IconStop)
.head 11 -  Call SalWaitCursor(TRUE)
.head 9 +  If VisDosExist(ss || '\\bad')
.head 10 +  If File(ss || '\\bad\\' || sFileSimv[nI])
.head 11 -  Call VisFileDelete(ss || '\\bad\\' || sFileSimv[nI])
.head 10 -  Call SalFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI], TRUE)
.head 10 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 10 -  Call SalFileOpen(hFile, sFA, OF_Delete)
.head 10 -  Call SalFileClose(hFile)
.head 7 +  Else
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call MessageNoWait('Файл курсів ' || sFA || ' не знайдений чи зайнятий іншим користувачем !', 'Попередження!', 0, 1)
.head 8 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nI = nI + 1
.head 6 -  Call SalStatusSetText(hWndForm, 'Курси НБУ прийняті.')
.head 5 +  Else
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('Файли курсів ' || ss || '\\#990h0??.v?? не знайдені !', 'УВАГА !', 3, 1)
.head 6 -  Call SalWaitCursor(TRUE)
.head 5 -  ! дополнительный приём файлов коммерческих курсов
.head 5 -  Set sFA = ss || '\\KURS*.VAL'
.head 5 -  Set nNumFiles = VisDosEnumFiles(sFA, FA_Standard, sFileSimv)
.head 5 +  If nNumFiles > 0
.head 6 +  If NOT SqlPrepareAndExecute(hSql(), 'begin p_trunc_tmp_sgi; end;')
.head 7 -  Set nRet = -1
.head 7 -  Call SalStatusSetText(hWndForm, 'Комерційні курси НЕ прийняті. Помилка очищення тимчасової таблиці.')
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Комерційні курси НЕ прийняті. Помилка очищення тимчасової таблиці.', 'УВАГА !', 3, 1)
.head 7 -  Call SalWaitCursor(TRUE)
.head 6 +  Else
.head 7 -  Set nI = 0
.head 7 +  While nI < nNumFiles
.head 8 -  Set nRet = 0
.head 8 -  Set sFA = ss || '\\' || sFileSimv[nI]
.head 8 -  ! приём по старому
.head 8 +  ! If hCode(sFA)
.head 9 +  If SalFileOpen(hFile, sFA, 0)
.head 10 -  Set bZag = FALSE
.head 10 +  Loop 
.head 11 +  If not SalFileGetStr(hFile, srab, 256) ! конец файла
.head 12 -  Break 
.head 11 -  Set srab = SalStrTrimX(srab)
.head 11 +  If Len(srab) > 0
.head 12 +  If not bZag
.head 13 -  ! прочитать заголовок (дату курсов)
.head 13 -  Set nNumTokens = SalStrTokenize(srab, '', '.', smElem) ! 02.11.2010
.head 13 +  If nNumTokens = 3
.head 14 -  Set dkKURS = SalDateConstruct(Val(smElem[2]), Val(smElem[1]), Val(smElem[0]), 0, 0, 0)
.head 14 -  Set bZag = TRUE
.head 13 +  Else 
.head 14 -  Call SalWaitCursor(FALSE)
.head 14 -  Call MessageNoWait('Ошибка в ЗАГЛАВНОЙ строке файла ' || sFileSimv[nI] || ', курсы НЕ принимаются.',
     'ВНИМАНИЕ !!!', 17, 1)
.head 14 -  Call SalWaitCursor(TRUE)
.head 14 -  Break 
.head 12 +  Else 
.head 13 -  ! прочитать строку курсов
.head 13 -  Set nNumTokens = SalStrTokenize(srab, '', '|', smElem)
.head 13 +  If nNumTokens = 6
.head 14 +  If SqlPLSQLCommand(hSql(), "CENTR_KURS(dkKURS,smElem[1],smElem[2],smElem[3],smElem[4],smElem[5],nRet)")
.head 15 +  If nRet = 0
.head 16 -  Call SqlCommit(hSql())
.head 15 +  Else 
.head 16 -  Call SqlRollback(hSql())
.head 16 -  Break 
.head 14 +  Else 
.head 15 -  Set nRet = -1
.head 15 -  Call SqlRollback(hSql())
.head 15 -  Break 
.head 10 -  Call SalFileClose(hFile)
.head 10 -  !
.head 10 +  If nRet = 0
.head 11 -  Call MessageNoWait('Приняты коммерческие курсы за ' || SalFmtFormatDateTime(dkKURS, 'dd-MM-yyyy'),
     'СООБЩЕНИЕ', 3, 0)
.head 11 +  If not VisDosExist(bk)
.head 12 +  If not SalFileCreateDirectory(bk)
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call SalMessageBox('Не могу создать каталог:' || bk, 'Внимание', MB_IconStop)
.head 13 -  Call SalWaitCursor(TRUE)
.head 11 +  If VisDosExist(bk)
.head 12 +  If File(bk || '\\' || sFileSimv[nI])
.head 13 -  Call VisFileDelete(bk || '\\' || sFileSimv[nI])
.head 12 -  Call SalFileCopy(sFA, bk || '\\' || sFileSimv[nI], TRUE)
.head 12 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 12 -  Call SalFileOpen(hFile, sFA, OF_Delete)
.head 12 -  Call SalFileClose(hFile)
.head 10 +  Else 
.head 11 +  If not VisDosExist(ss || '\\bad')
.head 12 +  If not SalFileCreateDirectory(ss || '\\bad')
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call SalMessageBox('Не могу создать каталог:' || ss || '\\bad', 'Внимание', MB_IconStop)
.head 13 -  Call SalWaitCursor(TRUE)
.head 11 +  If VisDosExist(ss || '\\bad')
.head 12 +  If File(ss || '\\bad\\' || sFileSimv[nI])
.head 13 -  Call VisFileDelete(ss || '\\bad\\' || sFileSimv[nI])
.head 12 -  Call SalFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI], TRUE)
.head 12 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 12 -  Call SalFileOpen(hFile, sFA, OF_Delete)
.head 12 -  Call SalFileClose(hFile)
.head 8 +  ! Else
.head 9 -  Call MessageNoWait('Файл ' || sFileSimv[nI] || ' искажён !!! Помещается в подкаталог BAD.', 'ОШИБКА!!!', 3, 1)
.head 9 +  If not VisDosExist(ss || '\\bad')
.head 10 +  If not SalFileCreateDirectory(ss || '\\bad')
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call SalMessageBox('Не могу создать каталог:' || ss || '\\bad', 'Внимание', MB_IconStop)
.head 11 -  Call SalWaitCursor(TRUE)
.head 9 +  If VisDosExist(ss || '\\bad')
.head 10 +  If File(ss || '\\bad\\' || sFileSimv[nI])
.head 11 -  Call VisFileDelete(ss || '\\bad\\' || sFileSimv[nI])
.head 10 -  Call SalFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI], TRUE)
.head 10 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 10 -  Call SalFileOpen(hFile, sFA, OF_Delete)
.head 10 -  Call SalFileClose(hFile)
.head 9 -  Set nRet = -1
.head 8 -  ! приём по новому (заявка 4595)
.head 8 +  If not PutFileToClob(hSql(), sFA, 'tmp_sgi', 'id', 'txt_data', nI, '', '', 1)
.head 9 -  Set nRet = -2
.head 9 -  Call SalStatusSetText(hWndForm, 'Комерційні курси НЕ прийняті. Помилка запису в тимчасову таблицю.')
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Комерційні курси НЕ прийняті. Помилка запису в тимчасову таблицю.', 'УВАГА !', 3, 1)
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  Break
.head 8 -  ! If not SqlPrepareAndExecute(hSql(), 'begin rates.kurs_val(:sRet); end;')
.head 8 +  If not SqlPLSQLCommand(hSql(), 'rates.kurs_val(nI,sRet)')
.head 9 -  Set nRet = -3
.head 9 -  Call SalStatusSetText(hWndForm, 'Комерційні курси НЕ прийняті. Помилка виклику процедури обробки файлу ' ||
     sFileSimv[nI] || '.')
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('НЕ прийняті комерційні курси з файлу ' || sFileSimv[nI] ||
     '. Помилка виклику процедури обробки.', 'УВАГА !', 3, 1)
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  ! Break 
.head 8 +  Else
.head 9 +  If sRet != 'Ok'
.head 10 -  Set nRet = -4
.head 10 -  Call SalStatusSetText(hWndForm, 'Комерційні курси з файлу ' || sFileSimv[nI] || ' НЕ прийняті. ' || sRet)
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('НЕ прийняті комерційні курси з файлу ' || sFileSimv[nI] || '. ' || sRet, 'УВАГА !', 3, 1)
.head 10 -  Call SalWaitCursor(TRUE)
.head 8 +  If nRet = 0
.head 9 -  Call SalStatusSetText(hWndForm, 'Комерційні курси з файлу ' || sFileSimv[nI] || ' прийняті.')
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Прийняті комерційні курси з файлу ' || sFileSimv[nI] || '.', 'ПОВІДОМЛЕННЯ', 3, 0)
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 +  If not VisDosExist(bk)
.head 10 +  If not SalFileCreateDirectory(bk)
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call SalMessageBox('Неможливо створити каталог:' || bk, 'Увага!', MB_IconStop)
.head 11 -  Call SalWaitCursor(TRUE)
.head 9 +  If VisDosExist(bk)
.head 10 +  If File(bk || '\\' || sFileSimv[nI])
.head 11 -  Call VisFileDelete(bk || '\\' || sFileSimv[nI])
.head 10 -  ! Call SalFileCopy(sFA, bk || '\\' || sFileSimv[nI], TRUE)
.head 10 -  Call VisFileCopy(sFA, bk || '\\' || sFileSimv[nI])
.head 10 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 10 -  ! Call SalFileOpen(hFile, sFA, OF_Delete)
.head 10 -  ! Call SalFileClose(hFile)
.head 10 -  Call VisFileDelete(sFA)
.head 8 +  Else
.head 9 +  If not VisDosExist(ss || '\\bad')
.head 10 +  If not SalFileCreateDirectory(ss || '\\bad')
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call SalMessageBox('Неможливо створити каталог:' || ss || '\\bad', 'Увага!', MB_IconStop)
.head 11 -  Call SalWaitCursor(TRUE)
.head 9 +  If VisDosExist(ss || '\\bad')
.head 10 +  If File(ss || '\\bad\\' || sFileSimv[nI])
.head 11 -  Call VisFileDelete(ss || '\\bad\\' || sFileSimv[nI])
.head 10 -  ! Call SalFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI], TRUE)
.head 10 -  Call VisFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI])
.head 10 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 10 -  ! Call SalFileOpen(hFile, sFA, OF_Delete)
.head 10 -  ! Call SalFileClose(hFile)
.head 10 -  Call VisFileDelete(sFA)
.head 8 -  Set nI = nI + 1
.head 5 +  Else
.head 6 +  If GetValueStr("
   SELECT mfou
   FROM   banks
   WHERE  mfo=f_ourmfo_g")='300465'
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Файли курсів ' || ss || '\\KURS*.VAL не знайдені !', 'УВАГА !', 3, 1)
.head 7 -  Call SalWaitCursor(TRUE)
.head 5 -  ! дополнительный приём файлов коммерческих курсов по БМ
.head 5 -  Set sFA = ss || '\\KURS*.BMT'
.head 5 -  Set nNumFiles = VisDosEnumFiles(sFA, FA_Standard, sFileSimv)
.head 5 +  If nNumFiles > 0
.head 6 -  Set nI = 0
.head 6 +  While nI < nNumFiles
.head 7 -  Set sFA = ss || '\\' || sFileSimv[nI]
.head 7 +  If hCode(sFA)
.head 8 +  If SalFileOpen(hFile, sFA, 0)
.head 9 -  Set bZag = FALSE
.head 9 +  Loop
.head 10 +  If not SalFileGetStr(hFile, srab, 512) ! конец файла
.head 11 -  Break
.head 10 -  Set srab = SalStrTrimX(srab)
.head 10 +  If Len(srab) > 0
.head 11 +  If not bZag
.head 12 -  ! прочитать заголовок (дату курсов)
.head 12 -  Set nNumTokens = SalStrTokenize(Left(srab, 10), '', '.', smElem) ! 02.11.2010
.head 12 +  If nNumTokens = 3
.head 13 +  If Len(SalStrTrimX(srab))>10
.head 14 -  Set sHHMMSS = SalStrTrimX(Subs(srab, 11, Len(srab)-10))
.head 14 -  Set nNumTokens2 = SalStrTokenize(sHHMMSS, '', ':', smElem2) ! 09:30:00
.head 14 -  Set sTime[0] = '0'
.head 14 -  Set sTime[1] = '0'
.head 14 -  Set sTime[2] = '0'
.head 14 -  Set nI2 = 0
.head 14 +  While nI2 < nNumTokens2
.head 15 -  Set sTime[nI2] = smElem2[nI2]
.head 15 -  Set nI2 = nI2 + 1
.head 13 -  Set dkKURS = SalDateConstruct(Val(smElem[2]), Val(smElem[1]), Val(smElem[0]), Val(sTime[0]),
    Val(sTime[1]), Val(sTime[2]))
.head 13 -  Set bZag = TRUE
.head 12 +  Else
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call MessageNoWait('Помилка в ЗАГОЛОВНОМУ рядку файла ' || sFileSimv[nI] || ', курси БМ НЕ приймаються.',
     'ВНИМАНИЕ !!!', 17, 1)
.head 13 -  Call SalWaitCursor(TRUE)
.head 13 -  Set nRet = -1
.head 13 -  Break
.head 11 +  Else
.head 12 -  ! прочитать строку курсов
.head 12 -  Set nNumTokens = SalStrTokenize(srab, '', '|', smElem)
.head 12 +  If nNumTokens >= 5
.head 13 +  If nNumTokens = 5
.head 14 -  Set smElem[5] = ''
.head 13 +  If SqlPLSQLCommand(hSql(), "CENTR_KUBM(dkKURS,smElem[1],smElem[2],smElem[3],smElem[4],smElem[5],nRet)")
.head 14 +  If nRet = 0
.head 15 -  Call SqlCommit(hSql())
.head 14 +  Else
.head 15 -  Call SqlRollback(hSql())
.head 15 -  Break
.head 13 +  Else
.head 14 -  ! Call Debug('-1')
.head 14 -  Set nRet = -1
.head 14 -  Call SqlRollback(hSql())
.head 14 -  Break
.head 9 -  Call SalFileClose(hFile)
.head 9 -  !
.head 9 +  If nRet = 0
.head 10 -  Call MessageNoWait('Прийняті комерційні курси БМ за ' || SalFmtFormatDateTime(dkKURS, 'dd-MM-yyyy'),
     'ПОВІДОМЛЕННЯ', 3, 0)
.head 10 +  If not VisDosExist(bk)
.head 11 +  If not SalFileCreateDirectory(bk)
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call SalMessageBox('Неможливо створити каталог:' || bk, 'Увага!', MB_IconStop)
.head 12 -  Call SalWaitCursor(TRUE)
.head 10 +  If VisDosExist(bk)
.head 11 +  If File(bk || '\\' || sFileSimv[nI])
.head 12 -  Call VisFileDelete(bk || '\\' || sFileSimv[nI])
.head 11 -  ! Call SalFileCopy(sFA, bk || '\\' || sFileSimv[nI], TRUE)
.head 11 -  Call VisFileCopy(sFA, bk || '\\' || sFileSimv[nI])
.head 11 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 11 -  ! Call SalFileOpen(hFile, sFA, OF_Delete)
.head 11 -  ! Call SalFileClose(hFile)
.head 11 -  Call VisFileDelete(sFA)
.head 9 +  Else
.head 10 +  If not VisDosExist(ss || '\\bad')
.head 11 +  If not SalFileCreateDirectory(ss || '\\bad')
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call SalMessageBox('Неможливо створити каталог:' || ss || '\\bad', 'Увага!', MB_IconStop)
.head 12 -  Call SalWaitCursor(TRUE)
.head 10 +  If VisDosExist(ss || '\\bad')
.head 11 +  If File(ss || '\\bad\\' || sFileSimv[nI])
.head 12 -  Call VisFileDelete(ss || '\\bad\\' || sFileSimv[nI])
.head 11 -  ! Call SalFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI], TRUE)
.head 11 -  Call VisFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI])
.head 11 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 11 -  ! Call SalFileOpen(hFile, sFA, OF_Delete)
.head 11 -  ! Call SalFileClose(hFile)
.head 11 -  Call VisFileDelete(sFA)
.head 7 +  Else
.head 8 -  Call MessageNoWait('Файл ' || sFileSimv[nI] || ' спотворений !!! Поміщається в підкаталог BAD.', 'ПОМИЛКА!!!', 3, 1)
.head 8 +  If not VisDosExist(ss || '\\bad')
.head 9 +  If not SalFileCreateDirectory(ss || '\\bad')
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call SalMessageBox('Неможливо створити каталог:' || ss || '\\bad', 'Увага!', MB_IconStop)
.head 10 -  Call SalWaitCursor(TRUE)
.head 8 +  If VisDosExist(ss || '\\bad')
.head 9 +  If File(ss || '\\bad\\' || sFileSimv[nI])
.head 10 -  Call VisFileDelete(ss || '\\bad\\' || sFileSimv[nI])
.head 9 -  ! Call SalFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI], TRUE)
.head 9 -  Call VisFileCopy(sFA, ss || '\\bad\\' || sFileSimv[nI])
.head 9 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 9 -  ! Call SalFileOpen(hFile, sFA, OF_Delete)
.head 9 -  ! Call SalFileClose(hFile)
.head 9 -  Call VisFileDelete(sFA)
.head 8 -  Set nRet = -1
.head 7 -  Set nI = nI + 1
.head 6 +  If nRet = 0
.head 7 -  Call SalStatusSetText(hWndForm, 'Комерційні курси БМ прийняті.')
.head 5 +  Else
.head 6 +  If GetValueStr("
   SELECT mfou
   FROM   banks
   WHERE  mfo=f_ourmfo_g")='300465'
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Файли курсів ' || ss || '\\KURS*.BMT не знайдені !', 'УВАГА !', 3, 1)
.head 7 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  ! Call Debug('egege')
.head 5 -  Return nRet=0
.head 3 +  Function: GetRIkvt    ! GetRIkvt   (0, bv, Right(sFA, 12), sReestrTime, sLoadTime)
.head 4 -  Description: Создание квитанции приёма файла реестра инсайдеров
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nCode
.head 5 -  String: sKat
.head 5 -  String: sFileIn
.head 5 -  String: sReestrTime
.head 5 -  String: sLoadTime
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hFile
.head 5 -  Number: nI
.head 5 -  Number: nS
.head 5 -  String: sTmp
.head 4 +  Actions
.head 5 +  If SalFileOpen(hFile, sKat || '\\' || Left(sFileIn, 9) || 'kvt', OF_Create | OF_Write)
.head 6 -  Set sTmp = sFileIn || sReestrTime || sLoadTime || GetBankMfo() || Str(nCode)
.head 6 -  Set nI = 1
.head 6 -  Set nS = 0
.head 6 +  While nI <= Len(sTmp)
.head 7 -  Set nS = nS + Asc(Subs(sTmp, nI, 1))
.head 7 -  Set nI = nI + 1
.head 6 -  Set sTmp = 'ReestrName=' || sFileIn || PutCrLf() || 'ReestrTime=' || sReestrTime || PutCrLf() || 'LoadTime=' || sLoadTime
    || PutCrLf() || 'LoadToMfo=' || GetBankMfo() || PutCrLf() || 'LoadStatus=' || Str(nCode) || PutCrLf() || 'CheckSum='
    || Str(nS) || PutCrLf()
.head 6 +  If SalFileWrite(hFile, sTmp, Len(sTmp)) = Len(sTmp)
.head 7 -  Call SalFileClose(hFile)
.head 7 -  Return TRUE
.head 6 +  Else
.head 7 -  Call SalFileClose(hFile)
.head 7 -  Return FALSE
.head 5 +  Else
.head 6 -  Return FALSE
.head 3 +  ! Function: GetRIkvtxml ! GetRIkvtxml(0, bv, Right(sFA, 12), sReestrTime, sLoadTime)
.head 4 -  Description: Создание квитанции приёма файла реестра инсайдеров (XML)
.head 4 +  Returns 
.head 5 -  Boolean: 
.head 4 +  Parameters 
.head 5 -  Number: nCode
.head 5 -  String: sKat
.head 5 -  String: sFileIn
.head 5 -  String: sReestrTime
.head 5 -  String: sLoadTime
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  File Handle: hFile
.head 5 -  Number: nI
.head 5 -  Number: nS
.head 5 -  String: sTmp
.head 4 +  Actions 
.head 5 +  If SalFileOpen(hFile, sKat || '\\' || Left(sFileIn, 9) || 'kvt', OF_Create | OF_Write)
.head 6 -  Set sTmp = sFileIn || sReestrTime || sLoadTime || GetBankMfo() || Str(nCode)
.head 6 -  Set nI = 1
.head 6 -  Set nS = 0
.head 6 +  While nI <= Len(sTmp)
.head 7 -  Set nS = nS + Asc(Subs(sTmp, nI, 1))
.head 7 -  Set nI = nI + 1
.head 6 -  Set sTmp = 'ReestrName=' || sFileIn || PutCrLf() || 'ReestrTime=' || sReestrTime || PutCrLf() || 'LoadTime=' || sLoadTime
    || PutCrLf() || 'LoadToMfo=' || GetBankMfo() || PutCrLf() || 'LoadStatus=' || Str(nCode) || PutCrLf() || 'CheckSum='
    || Str(nS) || PutCrLf()
.head 6 +  If SalFileWrite(hFile, sTmp, Len(sTmp)) = Len(sTmp)
.head 7 -  Call SalFileClose(hFile)
.head 7 -  Return TRUE
.head 6 +  Else 
.head 7 -  Call SalFileClose(hFile)
.head 7 -  Return FALSE
.head 5 +  Else 
.head 6 -  Return FALSE
.head 3 +  Function: GetRI
.head 4 -  Description: Прийом файлів реєстру інсайдерів
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sFA
.head 5 -  String: ss
.head 5 -  String: bk
.head 5 -  String: bn
.head 5 -  String: bv
.head 5 -  String: sFileSimv[*]
.head 5 -  Number: nSizes[*]
.head 5 -  Date/Time: dDateTimes[*]
.head 5 -  Date/Time: dDateTime
.head 5 -  Number: nAttributes[*]
.head 5 -  Number: nNumFiles
.head 5 -  Number: nI
.head 5 -  !
.head 5 -  Number: nNumTokens
.head 5 -  Number: nRet
.head 5 -  !
.head 5 -  String: sCurDir
.head 5 -  String: sDbf
.head 5 -  String: sSelect
.head 5 -  Sql Handle: hSqlA
.head 5 -  String: sErr
.head 5 -  String: sIDCODE
.head 5 -  String: sPASPSN
.head 5 -  Number: nINSFORM
.head 5 -  !
.head 5 -  Number: nKSfile
.head 5 -  File Handle: hF
.head 5 -  Number: nKSsumm
.head 5 -  Number: nRecc
.head 5 -  String: sBuf
.head 5 -  String: sb1
.head 5 -  String: sb2
.head 5 -  String: sb3
.head 5 -  String: sb4
.head 5 -  String: sb5
.head 5 -  String: sb6
.head 5 -  String: sb7
.head 5 -  String: sb8
.head 5 -  String: sb9
.head 5 -  String: sbA
.head 5 -  String: sbB
.head 5 -  String: sbC
.head 5 -  Number: nInfo
.head 5 -  Number: nLrec
.head 5 -  Number: nJ
.head 5 -  !
.head 5 -  Boolean: bF
.head 5 -  Boolean: bFk
.head 5 -  String: sReestrTime
.head 5 -  String: sLoadTime
.head 5 -  !
.head 5 -  Boolean: bRet
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalArraySetUpperBound(sFileSimv, 1, -1)
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('IMPORT', 'RIPath', '\\BARS98\\RI', ss, GetIniFileName())
.head 5 -  Set ss = IifS(Right(ss, 1)='\\', Left(ss, Len(ss)-1), ss)
.head 5 -  Call SalGetProfileString('IMPORT', 'RIArc', '\\BARS98\\RI\\ARC', bk, GetIniFileName())
.head 5 -  Set bk = IifS(Right(bk, 1)='\\', Left(bk, Len(bk)-1), bk)
.head 5 -  Call SalGetProfileString('IMPORT', 'RINot', '\\BARS98\\RI\\NOT', bn, GetIniFileName())
.head 5 -  Set bn = IifS(Right(bn, 1)='\\', Left(bn, Len(bn)-1), bn)
.head 5 -  Call SalGetProfileString('IMPORT', 'RIKvt', '\\BARS98\\RI\\KVT', bv, GetIniFileName())
.head 5 -  Set bv = IifS(Right(bv, 1)='\\', Left(bv, Len(bv)-1), bv)
.head 5 -  Set sFA = ss || '\\RI??????.DBF'
.head 5 -  ! Set nNumFiles = VisDosEnumFiles(sFA, FA_Standard, sFileSimv)
.head 5 -  Set nNumFiles = VisDosEnumFileInfo(sFA, FA_Standard, sFileSimv, nSizes, dDateTimes, nAttributes)
.head 5 +  If nNumFiles > 0
.head 6 -  Call SalFileGetCurrentDirectory(sCurDir)
.head 6 -  Set nI = 0
.head 6 +  While nI < nNumFiles
.head 7 -  Set bF = FALSE
.head 7 -  Set bFk = TRUE
.head 7 -  Set sFA = ss || '\\' || sFileSimv[nI]
.head 7 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 7 -  Call VisFileSetAttribute(sFA, FA_Hidden, FALSE)
.head 7 -  Call VisFileSetAttribute(sFA, FA_System, FALSE)
.head 7 -  ! проверка контрольной суммы файла
.head 7 +  If SalFileOpen(hF, sFA, 0)
.head 8 -  Set sBuf = '    '
.head 8 +  If SalFileRead(hF, sBuf, 4) = 4
.head 9 -  Set sBuf = '    '
.head 9 +  If SalFileRead(hF, sBuf, 4) = 4
.head 10 -  Set sb1 = ' '
.head 10 -  Set sb2 = ' '
.head 10 -  Set sb3 = ' '
.head 10 -  Set sb4 = ' '
.head 10 -  Call InsertBuf(sb1, 0, sBuf, 0, 1) !! char*szTarget       // результирующий BLOB
                                   !! longnTargetOffset   // смещение в результирующем BLOBе
                                   !! const char*szSource // исходный сырой BLOB
                                   !! longnSourceOffset   // смещение в исходном BLOBеlong
                                   !! nCopySize           // размер копируемого буфера
.head 10 -  Call InsertBuf(sb2, 0, sBuf, 1, 1)
.head 10 -  Call InsertBuf(sb3, 0, sBuf, 2, 1)
.head 10 -  Call InsertBuf(sb4, 0, sBuf, 3, 1)
.head 10 -  Set nRecc = Asc(sb1) + Asc(sb2)*256 + Asc(sb3)*4096 + Asc(sb4)*65536
.head 10 -  Set sBuf = Spac(8)
.head 10 +  If SalFileRead(hF, sBuf, 8) = 8
.head 11 -  Set sb1 = ' '
.head 11 -  Set sb2 = ' '
.head 11 -  Set sb3 = ' '
.head 11 -  Set sb4 = ' '
.head 11 -  Call InsertBuf(sb1, 0, sBuf, 0, 1)
.head 11 -  Call InsertBuf(sb2, 0, sBuf, 1, 1)
.head 11 -  Call InsertBuf(sb3, 0, sBuf, 2, 1)
.head 11 -  Call InsertBuf(sb4, 0, sBuf, 3, 1)
.head 11 -  Set nInfo = Asc(sb1) + Asc(sb2)*256
.head 11 -  Set nLrec = Asc(sb3) + Asc(sb4)*256
.head 11 -  Set sBuf = Spac(12)
.head 11 +  If SalFileRead(hF, sBuf, 12) = 12
.head 12 -  ! Set nKSfile = Val(sBuf)
.head 12 -  Set sb1 = ' '
.head 12 -  Set sb2 = ' '
.head 12 -  Set sb3 = ' '
.head 12 -  Set sb4 = ' '
.head 12 -  Set sb5 = ' '
.head 12 -  Set sb6 = ' '
.head 12 -  Set sb7 = ' '
.head 12 -  Set sb8 = ' '
.head 12 -  Set sb9 = ' '
.head 12 -  Set sbA = ' '
.head 12 -  Set sbB = ' '
.head 12 -  Set sbC = ' '
.head 12 -  Call InsertBuf(sb1, 0, sBuf,  0, 1)
.head 12 -  Call InsertBuf(sb2, 0, sBuf,  1, 1)
.head 12 -  Call InsertBuf(sb3, 0, sBuf,  2, 1)
.head 12 -  Call InsertBuf(sb4, 0, sBuf,  3, 1)
.head 12 -  Call InsertBuf(sb5, 0, sBuf,  4, 1)
.head 12 -  Call InsertBuf(sb6, 0, sBuf,  5, 1)
.head 12 -  Call InsertBuf(sb7, 0, sBuf,  6, 1)
.head 12 -  Call InsertBuf(sb8, 0, sBuf,  7, 1)
.head 12 -  Call InsertBuf(sb9, 0, sBuf,  8, 1)
.head 12 -  Call InsertBuf(sbA, 0, sBuf,  9, 1)
.head 12 -  Call InsertBuf(sbB, 0, sBuf, 10, 1)
.head 12 -  Call InsertBuf(sbC, 0, sBuf, 11, 1)
.head 12 -  Set nKSfile = Val(Str(Val(sb1)) || Str(Val(sb2)) || Str(Val(sb3)) || Str(Val(sb4)) || Str(Val(sb5)) ||
    Str(Val(sb6)) || Str(Val(sb7)) || Str(Val(sb8)) || Str(Val(sb9)) || Str(Val(sbA)) || Str(Val(sbB)) ||
    Str(Val(sbC)))
.head 12 +  If SalFileSeek(hF, nInfo, 0)
.head 13 -  ! Call Debug('Seek2: ' || Str(SalFileTell(hF)))
.head 13 -  Set nJ = 0
.head 13 -  Set nKSsumm = 0
.head 13 +  While nJ < nRecc
.head 14 -  Set sBuf = Spac(nLrec)
.head 14 +  If SalFileRead(hF, sBuf, Len(sBuf)) = Len(sBuf)
.head 15 +  While Len(sBuf)>0
.head 16 -  Set nKSsumm = nKSsumm + SalStrLop(sBuf)
.head 14 -  Set nJ = nJ + 1
.head 13 -  Call SalFileClose(hF)
.head 13 -  ! Call Debug('nKSfile=' || Str(nKSfile) || ', nKSsumm=' || Str(nKSsumm))
.head 13 +  If nKSfile != nKSsumm
.head 14 -  Call SalWaitCursor(FALSE)
.head 14 -  Call MessageNoWait('Ошибка контрольной суммы файла реестра инсайдеров ' || Right(sFA, 12),
     'ВНИМАНИЕ!!!', 0, 1)
.head 14 -  Call SalWaitCursor(TRUE)
.head 14 -  Set bFk = FALSE
.head 12 +  Else
.head 13 -  Call SalFileClose(hF)
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call MessageNoWait('Ошибка чтения(5) файла реестра инсайдеров ' || Right(sFA, 12), 'ВНИМАНИЕ!!!', 0, 1)
.head 13 -  Call SalWaitCursor(TRUE)
.head 13 -  Set bFk = FALSE
.head 11 +  Else
.head 12 -  Call SalFileClose(hF)
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call MessageNoWait('Ошибка чтения(4) файла реестра инсайдеров ' || Right(sFA, 12), 'ВНИМАНИЕ!!!', 0, 1)
.head 12 -  Call SalWaitCursor(TRUE)
.head 12 -  Set bFk = FALSE
.head 10 +  Else
.head 11 -  Call SalFileClose(hF)
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call MessageNoWait('Ошибка чтения(3) файла реестра инсайдеров ' || Right(sFA, 12), 'ВНИМАНИЕ!!!', 0, 1)
.head 11 -  Call SalWaitCursor(TRUE)
.head 11 -  Set bFk = FALSE
.head 9 +  Else
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('Ошибка чтения(2) файла реестра инсайдеров ' || Right(sFA, 12), 'ВНИМАНИЕ!!!', 0, 1)
.head 10 -  Call SalWaitCursor(TRUE)
.head 10 -  Set bFk = FALSE
.head 8 +  Else
.head 9 -  Call SalFileClose(hF)
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Ошибка чтения(1) файла реестра инсайдеров ' || Right(sFA, 12), 'ВНИМАНИЕ!!!', 0, 1)
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  Set bFk = FALSE
.head 7 +  Else
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call MessageNoWait('Ошибка открытия файла реестра инсайдеров ' || Right(sFA, 12), 'ВНИМАНИЕ!!!', 0, 1)
.head 8 -  Call SalWaitCursor(TRUE)
.head 8 -  Set bFk = FALSE
.head 7 -  !
.head 7 -  Call SalFileGetDateTime(sFA, dDateTime)
.head 7 -  Set sReestrTime = SalFmtFormatDateTime(dDateTime, 'dd.MM.yyyy hhhh:mm:ss')
.head 7 +  If bFk
.head 8 -  Set sDbf = sFileSimv[nI]
.head 8 +  If SalFileSetCurrentDirectory(ss)
.head 9 -  Call SalFileCreateDirectory(ss || '\\Temp')
.head 9 -  Call VisFileCopy(sFA, ss || '\\Temp\\' || Right(sFA, 12))
.head 9 -  Call SalFileSetCurrentDirectory(ss || '\\Temp')
.head 9 -  Set SqlDatabase = 'dBase_Files'
.head 9 +  If SqlConnect(hSqlA)
.head 10 -  Set sSelect = "
    SELECT IDCODE,PASPSN,INSFORM
    INTO   :sIDCODE,:sPASPSN,:nINSFORM
    FROM   " || sDbf
.head 10 +  If not SqlPrepare(hSqlA, sSelect)
.head 11 -  Call SqlDisconnect(hSqlA)
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call MessageNoWait('Ошибка обработки файла реестра инсайдеров ' || Right(sFA, 12), 'ВНИМАНИЕ!!!', 0, 1)
.head 11 -  Call SalWaitCursor(TRUE)
.head 11 -  Break
.head 10 -  Call SqlOpen(hSqlA, sDbf)
.head 10 -  Set bRet = TRUE
.head 10 +  If SqlPLSQLCommand(hSql(), "GET_RI('','',-1,'',nRet,sErr)")
.head 11 +  While SqlFetchNext(hSqlA, nFetchRes)
.head 12 +  If SqlPLSQLCommand(hSql(), "GET_RI(sIDCODE,sPASPSN,nINSFORM,sDbf,nRet,sErr)")
.head 13 +  If nRet != 0
.head 14 -  Set bRet = FALSE
.head 14 -  Call SqlRollback(hSql())
.head 14 -  Call SalWaitCursor(FALSE)
.head 14 -  Call MessageNoWait('Ошибка при обработке файла ' || Right(sFA, 12) || ' : ' || PutCrLf() || sErr,
     'ВНИМАНИЕ!!!', 0, 1)
.head 14 -  ! создать ПЛОХУЮ квитанцию (в каталог bv)
.head 14 -  Set sLoadTime = GetValueStr("
    SELECT to_char(sysdate,'DD.MM.YYYY HH24:MI:SS')
    FROM   DUAL")
.head 14 -  Call GetRIkvt(0, bv, Right(sFA, 12), sReestrTime, sLoadTime)
.head 14 -  Call SalWaitCursor(TRUE)
.head 14 -  Break
.head 12 +  Else
.head 13 -  Set bRet = FALSE
.head 13 -  Call SqlRollback(hSql())
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call MessageNoWait('Ошибка при обработке файла ' || Right(sFA, 12) || ' : ' || PutCrLf() ||
     ' невозможно выполнить продедуру GET_RI (0) ...', 'ВНИМАНИЕ!!!', 0, 1)
.head 13 -  ! создать ПЛОХУЮ квитанцию (в каталог bv)
.head 13 -  Set sLoadTime = GetValueStr("
    SELECT to_char(sysdate,'DD.MM.YYYY HH24:MI:SS')
    FROM   DUAL")
.head 13 -  Call GetRIkvt(0, bv, Right(sFA, 12), sReestrTime, sLoadTime)
.head 13 -  Call SalWaitCursor(TRUE)
.head 13 -  Break
.head 11 +  If bRet
.head 12 -  Call SqlCommit(hSql())
.head 12 -  Set sLoadTime = GetValueStr("
    SELECT to_char(sysdate,'DD.MM.YYYY HH24:MI:SS')
    FROM   DUAL")
.head 12 -  Set bF = TRUE
.head 12 -  ! создать ХОРОШУЮ квитанцию (в каталог bv)
.head 12 -  Call GetRIkvt(1, bv, Right(sFA, 12), sReestrTime, sLoadTime)
.head 10 +  Else
.head 11 -  Set bRet = FALSE
.head 11 -  Call SqlRollback(hSql())
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call MessageNoWait('Ошибка при обработке файла ' || Right(sFA, 12) || ' : ' || PutCrLf() ||
     ' невозможно выполнить продедуру GET_RI (1) ...', 'ВНИМАНИЕ!!!', 0, 1)
.head 11 -  ! создать ПЛОХУЮ квитанцию (в каталог bv)
.head 11 -  Set sLoadTime = GetValueStr("
    SELECT to_char(sysdate,'DD.MM.YYYY HH24:MI:SS')
    FROM   DUAL")
.head 11 -  Call GetRIkvt(0, bv, Right(sFA, 12), sReestrTime, sLoadTime)
.head 11 -  Call SalWaitCursor(TRUE)
.head 10 -  Call SqlDisconnect(hSqlA)
.head 10 -  Call VisFileCopy(sFA, IifS(bF, bk, bn) || '\\' || Right(sFA, 12))
.head 10 -  Call VisFileDelete(ss || '\\Temp\\' || Right(sFA, 12))
.head 10 -  Call VisFileDelete(sFA)
.head 10 -  Call SalStatusSetText(hWndForm, 'Файл реестра инсайдеров ' || Right(sFA, 12) || IifS(bF, '', ' НЕ') || ' принят.')
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 +  If bF
.head 11 -  Call MessageNoWait('Файл реестра инсайдеров ' || Right(sFA, 12) || ' принят.', 'СООБЩЕНИЕ!', 7, 0)
.head 10 +  Else
.head 11 -  Call MessageNoWait('Файл реестра инсайдеров ' || Right(sFA, 12) || ' НЕ принят.', 'ВНИМАНИЕ!', 7, 1)
.head 10 -  Call SalWaitCursor(TRUE)
.head 7 +  Else
.head 8 -  Call VisFileCopy(sFA, bn || '\\' || Right(sFA, 12))
.head 8 -  ! Call VisFileDelete(ss || '\\Temp\\' || Right(sFA, 12))
.head 8 -  Call VisFileDelete(sFA)
.head 8 -  Call SalStatusSetText(hWndForm, 'Файл реестра инсайдеров ' || Right(sFA, 12) || ' НЕ принят.')
.head 8 -  ! создать ПЛОХУЮ квитанцию (в каталог bv)
.head 8 -  Set sLoadTime = GetValueStr("
    SELECT to_char(sysdate,'DD.MM.YYYY HH24:MI:SS')
    FROM   DUAL")
.head 8 -  Call GetRIkvt(0, bv, Right(sFA, 12), sReestrTime, sLoadTime)
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call MessageNoWait('Файл реестра инсайдеров ' || Right(sFA, 12) || ' НЕ принят.', 'ВНИМАНИЕ!', 7, 1)
.head 8 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nI = nI + 1
.head 6 -  Call SalFileSetCurrentDirectory(sCurDir)
.head 6 -  Call SalStatusSetText(hWndForm, 'Файлы реестра инсайдеров приняты.')
.head 5 +  Else
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('Файлы реестра инсайдеров ' || ss || '\\RI??????.DBF не найдены !', 'ВНИМАНИЕ !', 37, 1)
.head 5 -  Call SalWaitCursor(FALSE)
.head 3 +  Function: GetRIxml
.head 4 -  Description: Прийом файлів реєстру інсайдерів (XML)
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sFA
.head 5 -  String: ss
.head 5 -  String: bk
.head 5 -  String: bn
.head 5 -  String: bv
.head 5 -  String: sFileSimv[*]
.head 5 -  Number: nSizes[*]
.head 5 -  Date/Time: dDateTimes[*]
.head 5 -  Date/Time: dDateTime
.head 5 -  Number: nAttributes[*]
.head 5 -  Number: nNumFiles
.head 5 -  Number: nI
.head 5 -  !
.head 5 -  Number: nNumTokens
.head 5 -  Number: nRet
.head 5 -  !
.head 5 -  ! String: sCurDir
.head 5 -  ! String: sDbf
.head 5 -  ! String: sSelect
.head 5 -  ! Sql Handle: hSqlA
.head 5 -  String: sErr
.head 5 -  ! String: sIDCODE
.head 5 -  ! String: sPASPSN
.head 5 -  ! Number: nINSFORM
.head 5 -  !
.head 5 -  ! Number: nKSfile
.head 5 -  ! File Handle: hF
.head 5 -  ! Number: nKSsumm
.head 5 -  ! Number: nRecc
.head 5 -  ! String: sBuf
.head 5 -  ! String: sb1
.head 5 -  ! String: sb2
.head 5 -  ! String: sb3
.head 5 -  ! String: sb4
.head 5 -  ! String: sb5
.head 5 -  ! String: sb6
.head 5 -  ! String: sb7
.head 5 -  ! String: sb8
.head 5 -  ! String: sb9
.head 5 -  ! String: sbA
.head 5 -  ! String: sbB
.head 5 -  ! String: sbC
.head 5 -  ! Number: nInfo
.head 5 -  ! Number: nLrec
.head 5 -  ! Number: nJ
.head 5 -  !
.head 5 -  Boolean: bF
.head 5 -  ! Boolean: bFk
.head 5 -  ! String: sReestrTime
.head 5 -  ! String: sLoadTime
.head 5 -  !
.head 5 -  ! Boolean: bRet
.head 5 -  !
.head 5 -  String: sRR
.head 5 -  String: sFAkvt
.head 5 -  String: sFAkvtPure
.head 5 -  String: sKU
.head 5 -  String: sFAPure
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalArraySetUpperBound(sFileSimv, 1, -1)
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('IMPORT', 'RIPath', '\\BARS98\\RI', ss, GetIniFileName())
.head 5 -  Set ss = IifS(Right(ss, 1)='\\', Left(ss, Len(ss)-1), ss)
.head 5 -  Call SalGetProfileString('IMPORT', 'RIArc', '\\BARS98\\RI\\ARC', bk, GetIniFileName())
.head 5 -  Set bk = IifS(Right(bk, 1)='\\', Left(bk, Len(bk)-1), bk)
.head 5 -  Call SalGetProfileString('IMPORT', 'RINot', '\\BARS98\\RI\\NOT', bn, GetIniFileName())
.head 5 -  Set bn = IifS(Right(bn, 1)='\\', Left(bn, Len(bn)-1), bn)
.head 5 -  Call SalGetProfileString('IMPORT', 'RIKvt', '\\BARS98\\RI\\KVT', bv, GetIniFileName())
.head 5 -  Set bv = IifS(Right(bv, 1)='\\', Left(bv, Len(bv)-1), bv)
.head 5 -  Set sFA = ss || '\\RI*.XML'
.head 5 -  ! Set nNumFiles = VisDosEnumFiles(sFA, FA_Standard, sFileSimv)
.head 5 -  Set nNumFiles = VisDosEnumFileInfo(sFA, FA_Standard, sFileSimv, nSizes, dDateTimes, nAttributes)
.head 5 +  If nNumFiles > 0
.head 6 -  Set nI = 0
.head 6 +  While nI < nNumFiles
.head 7 -  Set bF = TRUE
.head 7 -  ! Set bFk = TRUE
.head 7 -  Set sRR = GetValueStr("
    SELECT decode(mfo,'300465','27',substr(to_char(ku+100),-2))
    FROM   rcukru
    WHERE  mfo=f_ourmfo_g")
.head 7 -  Set sKU = Str(Val(sRR))
.head 7 -  Set sFAPure = sFileSimv[nI]
.head 7 -  Set sFA = ss || '\\' || sFAPure
.head 7 -  Set sFAkvtPure = Left(sFileSimv[nI], 8) || 'P' || sRR || Right(sFileSimv[nI], 4)
.head 7 -  Set sFAkvt = bv || '\\' || sFAkvtPure
.head 7 -  Call VisFileSetAttribute(sFA, FA_ReadOnly, FALSE)
.head 7 -  Call VisFileSetAttribute(sFA, FA_Hidden, FALSE)
.head 7 -  Call VisFileSetAttribute(sFA, FA_System, FALSE)
.head 7 -  !
.head 7 -  Call SqlPrepareAndExecute(hSql(), "
     DELETE
     FROM   tmp_ri_clob")
.head 7 -  ! запись файла в CLOB
.head 7 +  If not PutFileToClob(hSql(), sFA, 'tmp_ri_clob', 'NAMEF', 'C', 1, sFAPure, STRING_Null, 1)
.head 8 -  Call SqlRollback(hSql())
.head 8 -  ! Call SaveErrorToLog('RI - Реєстр інсайдерів, файл ' || sFA || ': помилка на PutFileToClob')
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call MessageNoWait('RI - Реєстр інсайдерів, файл ' || sFA || ': помилка на PutFileToClob', 'ВНИМАНИЕ!', 7, 1)
.head 8 -  Return FALSE
.head 7 +  Else
.head 8 -  ! процедура обработки XML
.head 8 -  Set nRet = 0
.head 8 -  Set sErr = STRING_Null
.head 8 +  If SqlPLSQLCommand(hSql(), "GET_XML_RI(sFAPure,sFAkvtPure,sKU,1,nRet,sErr)")
.head 9 -  ! обработать файл NAMEF из таблицы tmp_ri_clob и записать в таблицу tmp_ri_clob файл квитанции (процедура)
.head 9 +  If not PutClobToFile(hSql(), sFAkvt, 'tmp_ri_clob', 'NAMEF', 'C', 2, sFAkvtPure, STRING_Null)
.head 10 -  ! Call SaveErrorToLog('RI - Реєстр інсайдерів, файл ' || sFA || ': помилка на PutClobToFile')
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Set bF = FALSE
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('RI - Реєстр інсайдерів, файл ' || sFA || ': помилка на PutClobToFile', 'ВНИМАНИЕ!', 7, 1)
.head 9 +  Else
.head 10 -  Set bF = nRet=0
.head 10 -  ! Call SaveInfoToLog('Реєстр інсайдерів, файл ' || sFA || ': GET_XML_RI, код повернення = ' || Str(nRet))
.head 10 -  ! Call MessageNoWait('Реєстр інсайдерів, файл ' || sFA || ': GET_XML_RI, код повернення = ' || Str(nRet),
     IifS(nRet=0, 'СООБЩЕНИЕ!', 'ВНИМАНИЕ!'), 7, IifN(nRet=0, 0, 1))
.head 8 +  Else
.head 9 -  ! Call SaveErrorToLog('RI - Реєстр інсайдерів, файл ' || sFA || ': помилка на GET_XML_RI')
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('RI - Реєстр інсайдерів, файл ' || sFA || ': помилка на GET_XML_RI', 'ВНИМАНИЕ!', 7, 1)
.head 9 -  Set bF = FALSE
.head 7 -  !
.head 7 -  ! Call VisFileCopy(sFA, IifS(bF, bk, bn) || '\\' || Right(sFA, 12))
.head 7 +  If bF
.head 8 +  If bk != '\\BARS98\\RI\\ARC'
.head 9 -  Call VisFileCopy(sFA, bk || '\\' || Right(sFA, 12))
.head 7 +  Else
.head 8 +  If bn != '\\BARS98\\RI\\NOT'
.head 9 -  Call VisFileCopy(sFA, bn || '\\' || Right(sFA, 12))
.head 7 -  Call VisFileDelete(sFA)
.head 7 -  Call SalStatusSetText(hWndForm, 'Файл реестра инсайдеров ' || Right(sFA, 12) || IifS(bF, '', ' НЕ') || ' принят.')
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 +  If bF
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Call MessageNoWait('Файл реестра инсайдеров ' || Right(sFA, 12) || ' принят.', 'СООБЩЕНИЕ!', 7, 0)
.head 7 +  Else
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Call MessageNoWait('Файл реестра инсайдеров ' || Right(sFA, 12) || ' НЕ принят.', 'ВНИМАНИЕ!', 7, 1)
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set nI = nI + 1
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  ! Call SalStatusSetText(hWndForm, 'Файлы реестра инсайдеров приняты.')
.head 5 +  Else
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('Файлы реестра инсайдеров ' || ss || '\\RI*.XML не найдены !', 'ВНИМАНИЕ !', 37, 1)
.head 3 +  Function: GetBUSS
.head 4 -  Description: Прийом файлу Бізнес-напрямків
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nBuss
.head 5 -  Number: nRet
.head 5 -  String: sErr
.head 5 -  String: sBuf
.head 5 -  !
.head 5 -  String: sFilters[0:5]
.head 5 -  Number: nFilters
.head 5 -  String: sFileName
.head 5 -  String: sFilePathName
.head 5 -  Number: nIndex
.head 5 -  File Handle: hF
.head 5 -  String: smToken[*]
.head 5 -  Number: nT
.head 5 -  String: sEDRPOU
.head 5 -  Number: nMFO
.head 5 -  Number: nRNK
.head 5 -  String: sBUSSLINE
.head 4 +  Actions
.head 5 -  Set sFilters[0] = 'CSV files'
.head 5 -  Set sFilters[1] = '*.csv'
.head 5 -  Set sFilters[2] = 'TXT files'
.head 5 -  Set sFilters[3] = '*.txt'
.head 5 -  Set sFilters[4] = 'ALL files'
.head 5 -  Set sFilters[5] = '*.*'
.head 5 -  Set nFilters = 6
.head 5 -  !
.head 5 +  If SalDlgOpenFile(hWndForm, 'Вибір файлу "Бізнес-напрямки клієнтів ДКБ і ММСБ"', sFilters, nFilters, nIndex, sFileName,
   sFilePathName)
.head 6 -  Set nBuss = 0
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If VisFileOpen(hF, sFilePathName, 0) = VTERR_Ok
.head 7 +  While TRUE
.head 8 -  Set sBuf = Spac(1024)
.head 8 +  If VisFileReadString(hF, sBuf) = VTERR_Ok
.head 9 -  If Left(sBuf, 1) = 'E' 
.head 9 +  Else
.head 10 -  ! разобрать sBuf
.head 10 -  Set nT = SalStrTokenize(sBuf, '', ';', smToken)
.head 10 -  ! Call Debug(sBuf)
.head 10 -  ! Call DebugN(nT)
.head 10 +  If nT = 4
.head 11 -  Set sEDRPOU = IifS(Len(smToken[0])>0, smToken[0],      STRING_Null)
.head 11 -  Set nMFO    = IifN(Len(smToken[1])>0, Val(smToken[1]), NUMBER_Null)
.head 11 -  Set nRNK    = IifN(Len(smToken[2])>0, Val(smToken[2]), NUMBER_Null)
.head 11 -  Set sBUSSLINE = SalStrTrimX(smToken[3])
.head 11 +  ! If nBuss = 7
.head 12 -  Call Debug(sBUSSLINE)
.head 12 -  Call DebugN(Len(sBUSSLINE))
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 11 -  Call VisFileClose(hF)
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call MessageNoWait('Помилка структури файлу Бізнес-напрямків ' || sFileName || '.', 'УВАГА!!!', 0, 1)
.head 11 -  Return FALSE
.head 10 +  If nBuss = 0
.head 11 +  If SqlPLSQLCommand(hSql(), "BUSS_GET(0,sEDRPOU,nMFO,nRNK,sBUSSLINE,nRet,sErr)")
.head 12 -  If nRet = 0
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 13 -  Call VisFileClose(hF)
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call MessageNoWait('Помилка 0 запису в базу даних файлу Бізнес-напрямків ' || sFileName || '. ' || sErr,
     'УВАГА!!!', 0, 1)
.head 13 -  Return FALSE
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 12 -  Call VisFileClose(hF)
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call MessageNoWait('Помилка 0 запису в базу даних файлу Бізнес-напрямків ' || sFileName ||
     '. Неможливо виконати процедуру BUSS_GET.', 'УВАГА!!!', 0, 1)
.head 12 -  Return FALSE
.head 10 +  If SqlPLSQLCommand(hSql(), "BUSS_GET(1,sEDRPOU,nMFO,nRNK,sBUSSLINE,nRet,sErr)")
.head 11 +  If nRet = 0
.head 12 -  Set nBuss = nBuss + 1
.head 11 +  Else
.head 12 -  Call VisFileClose(hF)
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call MessageNoWait('Помилка 1 запису в базу даних файлу Бізнес-напрямків ' || sFileName || '. ' || sErr,
     'УВАГА!!!', 0, 1)
.head 12 -  Return FALSE
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 11 -  Call VisFileClose(hF)
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call MessageNoWait('Помилка 1 запису в базу даних файлу Бізнес-напрямків ' || sFileName ||
     '. Неможливо виконати процедуру BUSS_GET.', 'УВАГА!!!', 0, 1)
.head 11 -  Return FALSE
.head 8 +  Else
.head 9 -  Call VisFileClose(hF)
.head 9 -  Call SqlCommit(hSql())
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Обробка файлу Бізнес-напрямків ' || sFileName || ' закінчена. Збережено записів - ' ||
     Str(nBuss) || '.', 'ПОВІДОМЛЕННЯ!!!', 3711, 0)
.head 9 -  ! Call Debug('the end')
.head 9 -  Return TRUE
.head 6 +  Else
.head 7 -  Call MessageNoWait('Помилка відкриття файлу Бізнес-напрямків ' || sFileName || '.', 'УВАГА!!!', 0, 1)
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Return FALSE
.head 5 +  Else
.head 6 -  Call MessageNoWait('Відмова від обробки файлу Бізнес-напрямків.', 'УВАГА!!!', 0, 1)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return FALSE
.head 3 +  Function: MakeBUSS
.head 4 -  Description: Встановлення додаткових реквізитів Бізнес-напрямків
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nI
.head 5 -  Number: nRet
.head 5 -  String: sErr
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If SqlPLSQLCommand(hSql(), "BUSS_MAKE(nI,nRet,sErr)")
.head 6 +  If nRet = 0
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Встановлення додаткових реквізитів Бізнес-напрямків завершене. Кількість - ' || Str(nI) || '.',
     'ПОВІДОМЛЕННЯ!!!', 3711, 0)
.head 7 -  Return TRUE
.head 6 +  Else
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Помилка встановлення додаткових реквізитів Бізнес-напрямків - ' || sErr, 'УВАГА!!!', 0, 1)
.head 7 -  Return FALSE
.head 3 +  Function: hCode
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sFile
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  File Handle: hF
.head 5 -  String: sStr
.head 5 -  String: sFinStr
.head 5 -  Number: nH
.head 5 -  Number: nHashCode
.head 4 +  Actions
.head 5 +  If SalFileOpen(hF, sFile, OF_Read)
.head 6 -  Set nHashCode = 0
.head 6 +  Loop
.head 7 -  Set sStr = Spac(256)
.head 7 +  If not SalFileGetStr(hF, sStr, 256) ! конец файла
.head 8 -  Call SalFileClose(hF)
.head 8 -  ! Set nHashCode = nHashCode - nH
.head 8 -  ! Call Debug('nHashCode=' || Str(nHashCode))
.head 8 -  ! Call Debug('sFinStr=' || sFinStr)
.head 8 -  Return nHashCode-nH=Val(sFinStr)
.head 7 -  Set sFinStr = sStr
.head 7 -  Set nH = hStr(sStr) !! hStr(StrWinToDosX(sStr))
.head 7 -  Set nHashCode = nHashCode + nH
.head 5 +  Else
.head 6 -  Return FALSE
.head 3 +  Function: hStr
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  String: sStr
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nC
.head 5 -  Number: nI
.head 4 +  Actions
.head 5 -  Set nC = 0
.head 5 -  Set nI = 1
.head 5 +  While nI <= Len(sStr)
.head 6 +  If Asc(Subs(sStr, nI, 1))>=32
.head 7 -  Set nC = nC + Asc(Subs(sStr, nI, 1))
.head 6 -  Set nI = nI + 1
.head 5 -  Return nC
.head 3 +  Function: GetZMR
.head 4 -  Description: Прием курсов ВАЛЮТ (ZMR - dbf)
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  ! String: sDat
.head 5 -  Number: naa
.head 5 -  String: sFA
.head 5 -  String: ss
.head 5 -  String: sFileSimv[*]
.head 5 -  Number: nNumFiles
.head 5 -  Number: nI
.head 5 -  !
.head 5 -  Boolean: bF
.head 5 -  Number: nNOMIN
.head 5 -  Number: nKOD_NUM
.head 5 -  Date/Time: dDDAT
.head 5 -  Number: nKURS_KYP
.head 5 -  Number: nKURS_PROD
.head 5 -  Number: nmNOMIN[*]
.head 5 -  Number: nmKOD_NUM[*]
.head 5 -  Date/Time: dmDDAT[*]
.head 5 -  Number: nmKURS_KYP[*]
.head 5 -  Number: nmKURS_PROD[*]
.head 5 -  Number: nC
.head 5 -  String: sCurDir
.head 5 -  Sql Handle: hSqlA
.head 5 -  Boolean: bK
.head 5 -  Boolean: byn
.head 5 -  Boolean: bYa
.head 5 -  String: sDirs[*]
.head 5 -  Number: nCount
.head 5 -  Number: nD
.head 5 -  Boolean: bPovtor
.head 5 -  Number: nQ
.head 5 -  Number: nDbf
.head 5 -  Number: nPri
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalArraySetUpperBound(sFileSimv, 1, -1)
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('common parameters', 'curratesdir', '\\BARS98\\RATES', ss,
     GetIniFileName())
.head 5 -  Set sFA = ss || '\\ZMR????.dbf'
.head 5 -  Set nNumFiles = VisDosEnumFiles(sFA, FA_Standard, sFileSimv)
.head 5 -  Call SalFileGetCurrentDirectory(sCurDir)
.head 5 +  If nNumFiles > 0
.head 6 -  Set SqlDatabase = 'dBase_Files'
.head 6 -  Call SalFileSetCurrentDirectory(ss)
.head 6 +  If SqlConnect(hSqlA)
.head 7 -  Call SqlDisconnect(hSqlA)
.head 7 -  Set nI = 0
.head 7 -  Set bK = FALSE
.head 7 +  While nI < nNumFiles
.head 8 -  Call SqlConnect(hSqlA)
.head 8 -  Set bF = TRUE
.head 8 -  Set bPovtor = TRUE
.head 8 -  Set byn = FALSE
.head 8 -  Call SqlPrepareAndExecute(hSqlA, "
     SELECT KOD_NUM,NOMIN,DDAT,KURS_KYP,KURS_PROD
     FROM " || Right(sFileSimv[nI], 12) || "
     INTO :nKOD_NUM,:nNOMIN,:dDDAT,:nKURS_KYP,:nKURS_PROD")
.head 8 -  Set nPri = 0
.head 8 -  Set nDbf = 0
.head 8 +  While SqlFetchNext(hSqlA, nFetchRes)
.head 9 -  Set nmKOD_NUM[nDbf] = nKOD_NUM
.head 9 -  Set nmNOMIN[nDbf] = nNOMIN
.head 9 -  Set dmDDAT[nDbf] = dDDAT
.head 9 -  Set nmKURS_KYP[nDbf] = nKURS_KYP
.head 9 -  Set nmKURS_PROD[nDbf] = nKURS_PROD
.head 9 -  Set nDbf = nDbf + 1
.head 8 -  Call SqlDisconnect(hSqlA)
.head 8 -  Set nQ = 0
.head 8 +  While nQ < nDbf
.head 9 -  Set nKOD_NUM = nmKOD_NUM[nQ]
.head 9 -  Set nNOMIN = nmNOMIN[nQ]
.head 9 -  Set dDDAT = dmDDAT[nQ]
.head 9 -  Set nKURS_KYP = nmKURS_KYP[nQ]
.head 9 -  Set nKURS_PROD = nmKURS_PROD[nQ]
.head 9 +  If bF
.head 10 +  If SqlPrepareAndExecute(hSql(), T("
   SELECT count(*)
   INTO :naa
   FROM cur_rates
   WHERE kv=:nKOD_NUM and vdate=:dDDAT and (rate_b>0 or rate_s>0)"))
.head 11 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 12 -  Set naa = 0
.head 10 +  Else
.head 11 -  Set naa = 0
.head 10 +  If naa > 0 ! повторно
.head 11 -  Set bF = FALSE
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Set bPovtor = SalMessageBox("ЗАМЕНИТЬ ?", "Файл " || Right(sFileSimv[nI], 12)
    || " Принимается повторно !", MB_YesNo | MB_IconHand) = IDYES
.head 11 -  Call SalWaitCursor(TRUE)
.head 9 +  If bPovtor
.head 10 +  If nNOMIN > 0
.head 11 -  If SqlPrepareAndExecute(hSql(), T("
   SELECT count(*)
   INTO :nC
   FROM cur_rates
   WHERE kv=:nKOD_NUM and vdate=:dDDAT")) and
   SqlFetchNext(hSql(), nFetchRes)
.head 11 +  Else
.head 12 -  Set nC = 0
.head 11 +  If nC > 0
.head 12 +  If SqlPrepareAndExecute(hSql(), T("
   UPDATE cur_rates
   SET bsum=:nNOMIN,rate_b=:nKURS_KYP,rate_s=:nKURS_PROD
   WHERE kv=:nKOD_NUM and vdate=:dDDAT"))
.head 13 -  Call SqlCommit(hSql())
.head 13 -  Set nPri = nPri + 1
.head 13 -  Call SalStatusSetText(hWndForm, sFileSimv[nI] || ': ' ||
     GetLcv(nKOD_NUM) || '(' || Right(Str(nKOD_NUM+1000), 3) ||
     ') дата ' || SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy') || ' ' ||
     Str(nKURS_KYP) || ' - ' || Str(nKURS_PROD) || ' (за ' ||
     Str(nNOMIN) || ')')
.head 13 -  Call SaveFInfoToLog('Установлен курс покупки: ' || Str(nKOD_NUM) || '-'
     || SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy') || '-' || Str(nNOMIN)
     || '-' || Str(nKURS_KYP))
.head 13 -  Call SaveFInfoToLog('Установлен курс продажи: ' || Str(nKOD_NUM) || '-'
     || SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy') || '-' || Str(nNOMIN)
     || '-' || Str(nKURS_PROD))
.head 13 -  Set byn = TRUE
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 13 -  Call SaveErrorToLog('Не удалось установить курс покупки: ' ||
     Str(nKOD_NUM) || '-' || SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy')
     || '-' || Str(nNOMIN) || '-' || Str(nKURS_KYP))
.head 13 -  Call SaveErrorToLog('Не удалось установить курс продажи: ' ||
     Str(nKOD_NUM) || '-' || SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy')
     || '-' || Str(nNOMIN) || '-' || Str(nKURS_PROD))
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call MessageNoWait('Не удалось установить курсы покупки и продажи: ' ||
     GetLcv(nKOD_NUM) || '(' || Right(Str(nKOD_NUM+1000), 3) || ')-' ||
     SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy') || '-' || Str(nNOMIN) ||
     '-' || Str(nKURS_KYP) || '-' || Str(nKURS_PROD), 'ОШИБКА !', 7, 1)
.head 13 -  Call SalWaitCursor(TRUE)
.head 9 -  Call SalUpdateWindow(hWndForm)
.head 9 -  Set nQ = nQ + 1
.head 8 +  If byn
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 +  If nDbf = nPri
.head 10 -  Call MessageNoWait('Курсы ZMR за ' ||
     SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy') || ' - приняты.', 'СООБЩЕНИЕ',
     3, 0)
.head 9 +  Else
.head 10 -  Call MessageNoWait('Курсы ZMR за ' ||
     SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy') || ' - приняты ЧАСТИЧНО (' ||
     Str(nPri) || ' из ' || Str(nDbf) ||
     ') - присутствуют НЕ ВСЕ официальные курсы.', 'СООБЩЕНИЕ', 17, 1)
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  Set bYa = FALSE
.head 9 -  Call SalArraySetUpperBound(sDirs, 1, -1)
.head 9 -  Set nCount = VisDosEnumDirs(ss, sDirs)
.head 9 +  If nCount > 0
.head 10 -  Set nD = 0
.head 10 +  While nD < nCount
.head 11 +  If not bYa
.head 12 +  If SalStrUpperX(sDirs[nD]) = 'BACKUP'
.head 13 -  Set bYa = TRUE
.head 11 -  Set nD = nD + 1
.head 9 +  If not bYa
.head 10 -  Call SalFileCreateDirectory(ss || '\\BACKUP')
.head 9 +  If File(ss || '\\BACKUP\\' || sFileSimv[nI])
.head 10 -  Call VisFileDelete(ss || '\\BACKUP\\' || sFileSimv[nI])
.head 9 -  Set nD = VisFileRename(ss || '\\' || sFileSimv[nI],
    ss || '\\BACKUP\\' || sFileSimv[nI])
.head 9 +  If nD < 0
.head 10 -  Call SalMessageBox('Не удалось перенести в BACKUP файл ' || ss || '\\' ||
     sFileSimv[nI], 'Ошибка !', MB_Ok)
.head 8 +  Else
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Курсы ZMR за ' || SalFmtFormatDateTime(dDDAT, 'dd/MM/yyyy')
     || ' - НЕ приняты (отсутствуют официальные курсы).', 'ВНИМАНИЕ !', 0, 1)
.head 9 -  Call SalWaitCursor(TRUE)
.head 8 -  Set nI = nI + 1
.head 7 -  Call SalStatusSetText(hWndForm, 'Курсы ZMR приняты.')
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Невозможно принять файлы курсов ZMR????.dbf (ошибка ODBC).',
     'ВНИМАНИЕ !', 0, 1)
.head 7 -  Call SalWaitCursor(TRUE)
.head 5 +  Else
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('Файлы курсов ' || ss || '\\ZMR????.dbf не найдены !',
     'ВНИМАНИЕ !', 0, 1)
.head 6 -  Call SalWaitCursor(TRUE)
.head 5 -  Call SalFileSetCurrentDirectory(sCurDir)
.head 5 -  Call SalWaitCursor(FALSE)
.head 3 +  Function: GetVIP
.head 4 -  Description: Прием файлов VIP (txt)
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  ! String: sDat
.head 5 -  ! Number: naa
.head 5 -  String: sFA
.head 5 -  String: ss
.head 5 -  String: sFileSimv[*]
.head 5 -  Number: nNumFiles
.head 5 -  Number: nI
.head 5 -  !
.head 5 -  ! Boolean: bF
.head 5 -  ! Number: nNOMIN
.head 5 -  ! Number: nKOD_NUM
.head 5 -  ! Date/Time: dDDAT
.head 5 -  ! Number: nKURS_KYP
.head 5 -  ! Number: nKURS_PROD
.head 5 -  ! Number: nmNOMIN[*]
.head 5 -  ! Number: nmKOD_NUM[*]
.head 5 -  ! Date/Time: dmDDAT[*]
.head 5 -  ! Number: nmKURS_KYP[*]
.head 5 -  ! Number: nmKURS_PROD[*]
.head 5 -  ! Number: nC
.head 5 -  ! String: sDirs[*]
.head 5 -  ! Number: nCount
.head 5 -  ! Number: nD
.head 5 -  ! Number: nQ
.head 5 -  ! Number: nDbf
.head 5 -  ! Number: nPri
.head 5 -  !
.head 5 -  File Handle: hF
.head 5 -  Boolean: bY
.head 5 -  String: smToken[*]
.head 5 -  Number: nToken
.head 5 -  String: smToken1[*]
.head 5 -  Number: nToken1
.head 5 -  String: sBuffer
.head 5 -  String: sReturn
.head 5 -  String: sMFO
.head 5 -  String: sRNK
.head 5 -  String: sVIP
.head 5 -  String: sKVIP
.head 5 -  String: sDATBEG
.head 5 -  String: sDATEND
.head 5 -  Date/Time: dDATBEG
.head 5 -  Date/Time: dDATEND
.head 5 -  Number: nJ
.head 5 -  String: sBuf1
.head 5 -  String: sBufin
.head 5 -  Number: nPos
.head 5 -  Number: n1
.head 5 -  Number: n8
.head 4 +  Actions
.head 5 -  ! F1_Select(307,'')
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Set n8 = Val(GetValueStr("
    SELECT to_char(nvl(max(SEQUENCE),0))
    FROM   ALL_ARGUMENTS
    WHERE  owner='BARS' and OBJECT_NAME='LOAD_VIP' and PACKAGE_NAME is null"))
.head 5 +  If n8 = 0
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('Отсутствует процедура LOAD_VIP ...', 'ВНИМАНИЕ !', 0, 1)
.head 6 -  ! Call SalWaitCursor(TRUE)
.head 5 +  Else If n8 != 8
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call MessageNoWait('Процедура LOAD_VIP содержит неверное количество параметров (ожидается 8) ...', 'ВНИМАНИЕ !', 0, 1)
.head 5 +  Else
.head 6 -  Call SalArraySetUpperBound(sFileSimv, 1, -1)
.head 6 -  Call SalUseRegistry(FALSE, '')
.head 6 -  Call SalGetProfileString('Import', 'VIP', '\\BARS98\\VIP', ss, GetIniFileName())
.head 6 +  If Right(ss, 1) = '\\'
.head 7 -  Set ss = Left(ss, Len(ss)-1)
.head 6 -  Set sFA = ss || '\\*vip.txt'
.head 6 -  Set nNumFiles = VisDosEnumFiles(sFA, FA_Standard, sFileSimv)
.head 6 +  If nNumFiles > 0
.head 7 -  Set nI = 0
.head 7 +  While nI < nNumFiles
.head 8 -  ! Call Debug(ss || '\\' || sFileSimv[nI])
.head 8 +  If SalFileOpen(hF, ss || '\\' || sFileSimv[nI], OF_Read)
.head 9 -  Call SalFileSeek(hF, 0, FILE_SeekEnd)
.head 9 -  Set nPos = SalFileTell(hF)
.head 9 -  Set sBufin = Spac(nPos)
.head 9 -  Call SalFileSeek(hF, 0, FILE_SeekBegin)
.head 9 -  Call SalFileRead(hF, sBufin, nPos)
.head 9 -  Set sBuf1 = ' '
.head 9 -  Set n1 = 0
.head 9 +  While n1 < nPos
.head 10 -  Call InsertBuf(sBuf1, 0, sBufin, n1, 1)
.head 10 +  If sBuf1 = Chr(0)
.head 11 -  Set sBuf1 = ' '
.head 10 -  Call InsertBuf(sBufin, n1, sBuf1, 0, 1)
.head 10 -  Set n1 = n1 + 1
.head 9 -  !
.head 9 -  Set bY = TRUE
.head 9 -  Set nToken1 = SalStrTokenize(sBufin, Chr(10), Chr(10), smToken1)
.head 9 -  Set nJ = 0
.head 9 +  While nJ < nToken1
.head 10 +  If Left(smToken1[nJ], 1) <= '9' and Left(smToken1[nJ], 1) >= '0'
.head 11 -  Set nToken = SalStrTokenize(smToken1[nJ], Chr(9), Chr(9), smToken)
.head 11 -  Set sMFO    = SalStrTrimX(smToken[0])
.head 11 -  Set sRNK    = SalStrTrimX(smToken[1])
.head 11 -  Set sVIP    = SalStrTrimX(smToken[2])
.head 11 -  Set sKVIP   = SalStrTrimX(smToken[3])
.head 11 -  Set sDATBEG = SalStrTrimX(smToken[4])
.head 11 -  Set sDATEND = SalStrTrimX(smToken[5])
.head 11 -  !
.head 11 -  ! Call Debug(sMFO)
.head 11 -  ! Call Debug(sRNK)
.head 11 -  ! Call Debug(sKVIP)
.head 11 -  ! Call Debug(sDATBEG)
.head 11 -  ! Call Debug(sDATEND)
.head 11 -  !
.head 11 -  Set dDATBEG = SalDateConstruct(Val(Left(sDATBEG, 4)), Val(Subs(sDATBEG, 6, 2)), Val(Subs(sDATBEG, 9, 2)), 0,
    0, 0)
.head 11 -  Set dDATEND = SalDateConstruct(Val(Left(sDATEND, 4)), Val(Subs(sDATEND, 6, 2)), Val(Subs(sDATEND, 9, 2)), 0,
    0, 0)
.head 11 -  Set sReturn = ''
.head 11 -  Set sBuf1 = ''
.head 11 +  If SqlPLSQLCommand(hSql(), "load_vip(sMFO, sRNK, sVIP, sKVIP, dDATBEG, dDATEND, sReturn, sBuf1)")
.head 12 +  If sReturn != STRING_Null
.head 13 -  Set bY = FALSE
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call MessageNoWait(sReturn, 'ОШИБКА, файл ' || sFileSimv[nI], 0, 1)
.head 13 -  Call SalWaitCursor(TRUE)
.head 13 -  Break
.head 11 +  Else
.head 12 -  Set bY = FALSE
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call MessageNoWait('Ошибка вызова процедуры LOAD_VIP...', 'ОШИБКА, файл ' || sFileSimv[nI], 0, 1)
.head 12 -  Call SalWaitCursor(TRUE)
.head 12 -  Break
.head 10 -  Set nJ = nJ + 1
.head 9 -  !
.head 9 +  If bY
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SalFileCreateDirectory(ss || '\\ARC')
.head 10 -  Call SalFileCopy(ss || '\\' || sFileSimv[nI], ss || '\\ARC\\' || sFileSimv[nI], TRUE)
.head 10 +  If File(ss || '\\ARC\\' || sFileSimv[nI])
.head 11 -  Call VisFileDelete(ss || '\\' || sFileSimv[nI])
.head 10 -  ! Call Debug('SqlCommit')
.head 10 -  Call SqlCommit(hSql())
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('Файл ' || sFileSimv[nI] || ' успешно принят!', 'СООБЩЕНИЕ !', 5, 0)
.head 10 -  Call SalWaitCursor(TRUE)
.head 9 +  Else
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('Ошибка (1) обработки файла ' || sFileSimv[nI] || ' ...', 'ВНИМАНИЕ !', 0, 1)
.head 10 -  Call SalWaitCursor(TRUE)
.head 9 -  !
.head 9 +  ! Loop
.head 10 -  Set sBuffer = Spac(254)
.head 10 +  If SalFileGetStr(hF, sBuffer, 254)
.head 11 -  ! Call DebugN(Len(sBuffer))
.head 11 +  If Len(sBuffer) > 0
.head 12 -  Set sBuf1 = ' '
.head 12 -  Set sBuf2 = Spac(Len(sBuffer))
.head 12 -  Set nJ = 0
.head 12 -  Call DebugN(Len(sBuffer) )
.head 12 +  While nJ < Len(sBuffer) 
.head 13 -  Call InsertBuf(sBuf1, 0, sBuffer, nJ, 1)
.head 13 +  If sBuf1 = Chr(0)
.head 14 -  Set sBuf1 = ' '
.head 13 -  Call InsertBuf(sBuf2, nJ, sBuf1, 0, 1)
.head 13 -  Set nJ = nJ + 1
.head 12 +  If Left(sBuf2, 1) <= '9' and Left(sBuf2, 1) >= '0'
.head 13 -  Set nToken = SalStrTokenize(sBuf2, Chr(9), Chr(9), smToken)
.head 13 -  Set sMFO    = SalStrTrimX(smToken[0])
.head 13 -  Set sRNK    = SalStrTrimX(smToken[1])
.head 13 -  Set sVIP    = SalStrTrimX(smToken[2])
.head 13 -  Set sKVIP   = SalStrTrimX(smToken[3])
.head 13 -  Set sDATBEG = SalStrTrimX(smToken[4])
.head 13 -  Set sDATEND = SalStrTrimX(smToken[5])
.head 13 -  Set dDATBEG = SalDateConstruct(Val(Left(sDATBEG, 4)), Val(Subs(sDATBEG, 6, 2)), Val(Subs(sDATBEG, 9, 2)),
    0, 0, 0)
.head 13 -  Set dDATEND = SalDateConstruct(Val(Left(sDATEND, 4)), Val(Subs(sDATEND, 6, 2)), Val(Subs(sDATEND, 9, 2)),
    0, 0, 0)
.head 13 -  ! Call Debug(sMFO)
.head 13 -  ! Call Debug(sRNK)
.head 13 -  ! Call Debug(sDATBEG)
.head 13 -  ! Call Debug(sDATEND)
.head 13 -  Set sReturn = ''
.head 13 -  Call SqlPLSQLCommand(hSql(), "load_vip(sMFO, sRNK, sVIP, sKVIP, dDATBEG, dDATEND, sReturn)")
.head 13 +  If sReturn = ''
.head 14 +  If bY
.head 15 -  Set bY = TRUE
.head 13 +  Else 
.head 14 -  Set bY = FALSE
.head 14 -  Call SalWaitCursor(FALSE)
.head 14 -  Call MessageNoWait(sReturn, 'Файл ' || sFileSimv[nI], 0, 1)
.head 14 -  Call SalWaitCursor(TRUE)
.head 14 -  Break 
.head 12 +  ! Else 
.head 13 -  ! пропускаем строку
.head 11 +  Else 
.head 12 -  Break 
.head 10 +  Else 
.head 11 +  If not bY
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call MessageNoWait('Ошибка (2) обработки файла ' || sFileSimv[nI] || ' ...', 'ВНИМАНИЕ !', 0, 1)
.head 12 -  Call SalWaitCursor(TRUE)
.head 11 +  Else 
.head 12 -  Break 
.head 9 +  ! If bY
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SalFileCreateDirectory(ss || '\\ARC')
.head 10 -  Call SalFileCopy(ss || '\\' || sFileSimv[nI], ss || '\\ARC\\' || sFileSimv[nI], TRUE)
.head 10 +  If File(ss || '\\ARC\\' || sFileSimv[nI])
.head 11 -  Call VisFileDelete(ss || '\\' || sFileSimv[nI])
.head 10 -  Call SqlCommit(hSql())
.head 9 +  ! Else
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('Ошибка (1) обработки файла ' || sFileSimv[nI] || ' ...', 'ВНИМАНИЕ !', 0, 1)
.head 10 -  Call SalWaitCursor(TRUE)
.head 9 -  !
.head 8 +  Else
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Файл ' || sFileSimv[nI] || ' не может быть открыт!', 'ВНИМАНИЕ !', 0, 1)
.head 9 -  Call SalWaitCursor(TRUE)
.head 8 -  Set nI = nI + 1
.head 7 +  If bY
.head 8 -  Call SalStatusSetText(hWndForm, 'Файлы VIP приняты.')
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Файлы VIP ' || ss || '\\*vip.txt не найдены !', 'ВНИМАНИЕ !', 0, 1)
.head 7 -  ! Call SalWaitCursor(TRUE)
.head 6 -  !
.head 6 -  Set sFA = ss || '\\*vip_monthly.txt'
.head 6 -  Set nNumFiles = VisDosEnumFiles(sFA, FA_Standard, sFileSimv)
.head 6 +  If nNumFiles > 0
.head 7 -  Set nI = 0
.head 7 +  While nI < nNumFiles
.head 8 -  ! Call Debug(ss || '\\' || sFileSimv[nI])
.head 8 +  If SalFileOpen(hF, ss || '\\' || sFileSimv[nI], OF_Read)
.head 9 -  Call SalFileSeek(hF, 0, FILE_SeekEnd)
.head 9 -  Set nPos = SalFileTell(hF)
.head 9 -  Set sBufin = Spac(nPos)
.head 9 -  Call SalFileSeek(hF, 0, FILE_SeekBegin)
.head 9 -  Call SalFileRead(hF, sBufin, nPos)
.head 9 -  Set sBuf1 = ' '
.head 9 -  Set n1 = 0
.head 9 +  While n1 < nPos
.head 10 -  Call InsertBuf(sBuf1, 0, sBufin, n1, 1)
.head 10 +  If sBuf1 = Chr(0)
.head 11 -  Set sBuf1 = ' '
.head 10 -  Call InsertBuf(sBufin, n1, sBuf1, 0, 1)
.head 10 -  Set n1 = n1 + 1
.head 9 -  !
.head 9 -  Set bY = TRUE
.head 9 -  Set nToken1 = SalStrTokenize(sBufin, Chr(10), Chr(10), smToken1)
.head 9 -  Set nJ = 0
.head 9 +  While nJ < nToken1
.head 10 +  If Left(smToken1[nJ], 1) <= '9' and Left(smToken1[nJ], 1) >= '0'
.head 11 -  Set nToken = SalStrTokenize(smToken1[nJ], Chr(9), Chr(9), smToken)
.head 11 -  Set sMFO    = SalStrTrimX(smToken[0])
.head 11 -  Set sRNK    = SalStrTrimX(smToken[1])
.head 11 -  Set sVIP    = SalStrTrimX(smToken[2])
.head 11 -  Set sKVIP   = SalStrTrimX(smToken[3])
.head 11 -  Set sDATBEG = SalStrTrimX(smToken[4])
.head 11 -  Set sDATEND = SalStrTrimX(smToken[5])
.head 11 -  !
.head 11 -  ! Call Debug(sMFO)
.head 11 -  ! Call Debug(sRNK)
.head 11 -  ! Call Debug(sKVIP)
.head 11 -  ! Call Debug(sDATBEG)
.head 11 -  ! Call Debug(sDATEND)
.head 11 -  !
.head 11 -  Set dDATBEG = SalDateConstruct(Val(Left(sDATBEG, 4)), Val(Subs(sDATBEG, 6, 2)), Val(Subs(sDATBEG, 9, 2)), 0,
    0, 0)
.head 11 -  Set dDATEND = SalDateConstruct(Val(Left(sDATEND, 4)), Val(Subs(sDATEND, 6, 2)), Val(Subs(sDATEND, 9, 2)), 0,
    0, 0)
.head 11 -  Set sReturn = ''
.head 11 -  Set sBuf1 = ''
.head 11 +  If SqlPLSQLCommand(hSql(), "load_vip(sMFO, sRNK, sVIP, sKVIP, dDATBEG, dDATEND, sReturn, sBuf1)")
.head 12 +  If sReturn != STRING_Null
.head 13 -  Set bY = FALSE
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call MessageNoWait(sReturn, 'ОШИБКА, файл ' || sFileSimv[nI], 0, 1)
.head 13 -  Call SalWaitCursor(TRUE)
.head 13 -  Break
.head 11 +  Else
.head 12 -  Set bY = FALSE
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call MessageNoWait('Ошибка вызова процедуры LOAD_VIP...', 'ОШИБКА, файл ' || sFileSimv[nI], 0, 1)
.head 12 -  Call SalWaitCursor(TRUE)
.head 12 -  Break
.head 10 -  Set nJ = nJ + 1
.head 9 -  !
.head 9 +  If bY
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SalFileCreateDirectory(ss || '\\ARC')
.head 10 -  Call SalFileCopy(ss || '\\' || sFileSimv[nI], ss || '\\ARC\\' || sFileSimv[nI], TRUE)
.head 10 +  If File(ss || '\\ARC\\' || sFileSimv[nI])
.head 11 -  Call VisFileDelete(ss || '\\' || sFileSimv[nI])
.head 10 -  ! Call Debug('SqlCommit')
.head 10 -  Call SqlCommit(hSql())
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('Файл ' || sFileSimv[nI] || ' успешно принят!', 'СООБЩЕНИЕ !', 5, 0)
.head 10 -  Call SalWaitCursor(TRUE)
.head 9 +  Else
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('Ошибка (1) обработки файла ' || sFileSimv[nI] || ' ...', 'ВНИМАНИЕ !', 0, 1)
.head 10 -  Call SalWaitCursor(TRUE)
.head 8 +  Else
.head 9 -  Call SalWaitCursor(FALSE)
.head 9 -  Call MessageNoWait('Файл ' || sFileSimv[nI] || ' не может быть открыт!', 'ВНИМАНИЕ !', 0, 1)
.head 9 -  Call SalWaitCursor(TRUE)
.head 8 -  Set nI = nI + 1
.head 7 +  If bY
.head 8 -  Call SalStatusSetText(hWndForm, 'Файлы VIP_MONTHLY приняты.')
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Файлы VIP ' || ss || '\\*vip_monthly.txt не найдены !', 'ВНИМАНИЕ !', 7, 0)
.head 7 -  ! Call SalWaitCursor(TRUE)
.head 5 -  Call SalWaitCursor(FALSE)
.head 3 +  Function: GetWORKB
.head 4 -  Description: Прием файлов Приналежність до працівників Банку (dbf)
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: ss
.head 5 -  Number: nI
.head 5 -  String: sFiltIn[*]
.head 5 -  String: sFileIn
.head 5 -  String: sPathIn
.head 5 -  String: sErrMsg
.head 4 +  Actions
.head 5 -  ! F1_Select(308,'')
.head 5 -  Call SalUseRegistry(FALSE, '')
.head 5 -  Call SalGetProfileString('Import', 'WORKB', '\\BARS98\\WORKB', ss, GetIniFileName())
.head 5 +  If Right(ss, 1) = '\\'
.head 6 -  Set ss = Left(ss, Len(ss)-1)
.head 5 -  ! диалог выбора файла
.head 5 -  Set sFiltIn[0] = 'ALL files'
.head 5 -  Set sFiltIn[1] = '*.*'
.head 5 -  Set sFiltIn[2] = 'DBF files'
.head 5 -  Set sFiltIn[3] = '*.dbf'
.head 5 -  Set sPathIn = ss
.head 5 +  If SalDlgOpenFile(hWndForm, 'Выберите файл для приёма ...', sFiltIn, 4, nI, sFileIn, sPathIn)
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If ImportDbf(Left(sPathIn, Len(sPathIn)-Len(sFileIn)-1),
             sFileIn,
             'TMP_BANK_EMPLOYEE',
             'WIN',
             1,
             1,
             0,
             sErrMsg)
.head 7 -  Set nI = 0
.head 7 +  If SqlPLSQLCommand(hSql(), 'bank_employee(nI)')
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 +  If nI = -1
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Call MessageNoWait('Ошибка чтения исходных данных, возможно неверна структура файла ' || sFileIn, 'Ошибка!', 17, 1)
.head 8 +  Else
.head 9 -  Call SqlCommit(hSql())
.head 9 -  Call MessageNoWait('Успешно выполнена загрузка файла ' || sFileIn || ' (обработано ' || Str(nI) || ' зап.)',
     'Сообщение!', 7, 0)
.head 7 +  Else
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call MessageNoWait('(2) - невозможно выполнить процедуру bank_employee', 'Ошибка!', 17, 1)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('(1) - невозможно выполнить загрузку файла ' || sFileIn, sErrMsg, 17, 1)
.head 5 -  !
.head 3 +  Function: ShowMessage
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: sParam
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call MessageNoWait(sParam, 'Message', 3, 0)
.head 3 +  Function: ProcMsgFiles
.head 4 -  Description: Функция обработки файлов регламента(сообщений ВПС)
.head 4 -  Returns
.head 4 -  Parameters
.head 4 +  Static Variables
.head 5 -  Boolean: bInit
.head 5 -  String: sIniFile
.head 5 -  String: strMsgDir
.head 5 -  String: strMsgAudioFile
.head 5 -  String: szMsgFilePath
.head 5 -  Number: nIter
.head 5 -  Number: nCount
.head 5 -  String: sFiles[*] ! массив имен файлов
.head 5 -  Number: nPlayWAV  ! проигрывать wav-файлы
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If bInit=FALSE ! ф-ция выполняется 1-вый раз ? ==> проинициализироваться
.head 6 -  Set strMsgDir = GetMsgDir()
.head 6 -  ! Call Debug( 'MsgDir='|| strMsgDir )
.head 6 -  Set sIniFile = GetIniFileName()
.head 6 -  Call SalUseRegistry( FALSE, sIniFile )
.head 6 -  Call SalGetProfileString(
   'Media', 'MsgAudioFile', '', strMsgAudioFile, sIniFile )
.head 6 -  Set nPlayWAV = SalGetProfileInt( 'Media', 'PlayWAV', 0, sIniFile )
.head 6 -  ! Call Debug( 'MsgAudioFile='|| strMsgAudioFile )
.head 6 -  ! Call PlaySound( strMsgAudioFile, NUMBER_Null, 
	SND_NOWAIT | SND_ASYNC | SND_FILENAME | SND_NOSTOP )
.head 6 -  Set bInit = TRUE
.head 5 +  If VisDosExist( strMsgDir ||'\\(R*' )
.head 6 -  ! Call Debug( 'Надены файлы регламента' )
.head 6 -  Set nCount = VisDosEnumFiles (strMsgDir ||'\\(R*', FA_Standard, sFiles)
.head 6 -  Set nIter = 0
.head 6 +  While nIter<nCount
.head 7 -  Set szMsgFilePath = strMsgDir||'\\'||sFiles[nIter]
.head 7 -  ! Call Debug( szMsgFilePath )
.head 7 -  Call SalCreateWindow( frm_MsgFileViewer, hWndMDI, sFiles[nIter],
szMsgFilePath, nPlayWAV, strMsgAudioFile)
.head 7 -  Set nIter = nIter + 1
.head 2 +  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 2270177389
0000: 070200000B010000 0000000000000000 0200000400FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F04003C00 0007520073546974
0040: 6C651E00C0000001 000000A302040000 FFFF0001801D0000 0001000100074C69
0060: 7374530065748600 00000500BC000002 FB00FF6F0400EE02 00FF3F0800B80000
0080: 0200FFFF000C0000 00010D0000FE00FF 03190000000304FA 0000FF0F01802200
00A0: 000000020000000A 630047656E46696C 7465C07274000000 049E000204D10001
00C0: 00003F8001F80000 0037040001F60D00 FF1F110000DC0002 00FF7F1570000000
00E0: 0100FFFF31018022 0003C00000000B63 47F8444669B30004 00770200F4010000
0100: 4F800100FE008D04 00010DFD00FF3711 0002F700FFDF15DC 000100FF7F
.enddata
.head 2 +  Default Classes
.head 3 -  MDI Window:
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: cpbExecute
.head 3 -  Radio Button:
.head 3 -  Option Button:
.head 3 -  Check Box:
.head 3 -  Child Table:
.head 3 -  Quest Child Window: cQuickDatabase
.head 3 -  List Box:
.head 3 -  Combo Box:
.head 3 -  Picture:
.head 3 -  Vertical Scroll Bar:
.head 3 -  Horizontal Scroll Bar:
.head 3 -  Column: cColumnLabeled
.head 3 -  Background Text:
.head 3 -  Group Box:
.head 3 -  Line:
.head 3 -  Frame:
.head 3 -  Custom Control: cCalendar
.head 2 -  Application Actions
.head 1 +  Dialog Box: NAL_IT
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Дата накопления (конец квартала)
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   3.54"
.head 4 -  Top:    1.417"
.head 4 -  Width:  4.843"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.406"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
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
.head 3 +  Data Field: dDat1
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
.head 6 -  Left:   0.371"
.head 6 -  Top:    0.073"
.head 6 -  Width:  2.957"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Утвердить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.329"
.head 5 -  Top:    0.417"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  ! НБУ дб реальна дата (одна из банковских)
.head 6 +  If nPar=20 
and SqlPrepareAndExecute( hSql(),
    "SELECT fdat FROM fdat WHERE fdat=:dDat1")
   and SqlFetchNext(hSql(), nFetchRes )
.head 7 -  Call F_Nak(dDat1)
.head 6 -  ! КБ дб одна из банковских квартальніх
.head 6 +  Else If nPar=21 
and SqlPrepareAndExecute( hSql(),
    "SELECT To_number(to_char(min(fdat),'Q'))
     INTO :nKV2 FROM fdat WHERE fdat>:dDat1")
   and SqlFetchNext(hSql(), nFetchRes )
   and nKV2 != SalDateQuarter( dDat1 )
.head 7 -  Call F_Nak(dDat1)
.head 6 +  Else
.head 7 -  ! Call SalMessageBox('Ош.квартальная дата !','Внимание!', MB_IconStop|MB_Ok)
.head 7 +  If SalMessageBox('Не последняя квартальная дата ! Выполнять  накопление ?', 'В Н И М А Н И Е !',
   MB_IconQuestion | MB_YesNo) = IDYES
.head 8 -  Call F_Nak(dDat1)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выйти
.head 4 -  Window Location and Size
.head 5 -  Left:   1.843"
.head 5 -  Top:    0.417"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 +  Functions
.head 3 +  Function: F_Nak
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Date/Time: dDat1
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 6 +  If not SqlPLSQLCommand(hSql(), "NAL.P_NAL_IT(dDat1)")
.head 7 -  Call SalMessageBox('Ош.при выполнении наколления !','Внимание!', MB_IconStop)
.head 6 +  Else
.head 7 -  Call SalMessageBox("Показатели УСПЕШНО накоплены","Хорошо", MB_Ok)
.head 5 -  Call SalWaitCursor(FALSE)
.head 2 +  Window Parameters
.head 3 -  Number: nPar
.head 2 +  Window Variables
.head 3 -  Number: nKV2
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 +  If nPar=20 
.head 5 -  Set dDat1=GetBankDate()
.head 4 +  Else
.head 5 -  If SqlPrepareAndExecute( hSql(),
  "SELECT max(fdat) INTO :dDat1 FROM fdat 
   WHERE to_char(fdat,'Q')<>to_char(BANKDATE,'Q') and
         fdat<BANKDATE ")
and SqlFetchNext(hSql(), nFetchRes )
.head 1 +  ! cGenericTable: AN
.winattr class Table Window:
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Аналіз русурсів, динаміки, доходності клієттів банку по місяцям
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   0.225"
.head 4 -  Top:    0.229"
.head 4 -  Width:  6.967"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.781"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: Default
.head 3 -  Discardable? No
.end
.head 2 -  Description: 
.head 2 -  Named Menus 
.head 2 -  Menu 
.head 2 +  Tool Bar 
.winattr
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.427"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 3 +  Contents 
.head 4 +  Pushbutton: pbIns
.winattr
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbDel
.winattr
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.514"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Delrec.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbRefresh
.winattr
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.943"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Refresh.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbUpdate
.winattr
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.383"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Save.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  4.557"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  4.557"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 4 +  Pushbutton: pbSearch
.winattr
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.417"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\search.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbFilter
.winattr
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.883"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Filter.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbDetails
.winattr
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.35"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\open.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 +  Message Actions 
.head 6 +  On SAM_Click
.head 7 +  If not IsWindow(hWin15)
.head 8 -  Set hWin15 = SalCreateWindow
(AN_KL, 
 hWndMDI, 
 117, 
 IifS(AN.VIP=STRING_Null,'','VIP='|| AN.VIP ||' ') || AN.NMK,
 '',
 AN.KLI, 
 AN.RNKP )
.head 8 -  ! Set hWin15 = SalCreateWindow
(hWndForm.AN_KL, 
 hWndMDI, 
 117, 
 IifS(hWndForm.AN.VIP=STRING_Null,'','VIP='|| hWndForm.AN.VIP ||' ') || hWndForm.AN.NMK,
 '',
 hWndForm.AN.KLI, 
 hWndForm.AN.RNKP )
.head 7 +  Else 
.head 8 -  Call SalBringWindowToTop(AN_KL)
.head 4 +  Pushbutton: pbPrint
.winattr
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.817"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: F5
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  3.886"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  3.886"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 4 +  Pushbutton: pbExit
.winattr
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.283"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Esc
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.9"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  1.9"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 2 +  Contents 
.head 3 +  Column: VIP
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Гр.
VIP
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.417"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: RNKP
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реєст.
№ холд
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.733"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: KLI
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реєст.
№ кл
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.767"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NMK
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Найменування
кл
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  4.133"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 -  !
.head 2 -  Functions 
.head 2 +  Window Parameters 
.head 3 -  Number: nPar
.head 3 -  String: strPar01
.head 3 -  String: strPar02
.head 2 -  Window Variables 
.head 2 +  Message Actions 
.head 3 +  On SAM_Create
.head 4 -  Set AN.strPrintFileName = 'AN'
.head 4 -  Set AN.strFilterTblName ='CUSTOMER'
.head 4 -  Set AN.nTabInstance= 1
.head 4 -  !
.head 4 -  Set AN.strSqlPopulate =
"SELECT CUSTOMER.RNK, CUSTOMER.NMK, substr(w.value,1,3) , CUSTOMER.RNKP  
 INTO :AN.KLI  , :AN.NMK  ,  :AN.VIP  , :AN.RNKP 
 FROM  CUSTOMERW w, CUSTOMER 
 WHERE w.tag (+)='VIP_K' and w.rnk(+)=CUSTOMER.rnk  and
  CUSTOMER.rnk in (select rnk from tmp_an_kl where nmk is not null) 
 ORDER BY  CUSTOMER.RNKP,  CUSTOMER.RNK "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_DoubleClick
.head 4 -  Call SalSendMsg( AN.pbDetails, SAM_Click, 0, 0 )
.head 1 +  ! cGenericTable: AN_KL
.winattr class Table Window:
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Аналіз клієнтів банку
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   0.05"
.head 4 -  Top:    0.76"
.head 4 -  Width:  17.267"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.655"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 5000
.head 3 -  Discardable? No
.end
.head 2 -  Description: 
.head 2 -  Named Menus 
.head 2 -  Menu 
.head 2 +  Tool Bar 
.winattr
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.452"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 3 +  Contents 
.head 4 +  Pushbutton: pbIns
.winattr
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 +  Message Actions 
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Выполнить формирование в архив за месяц первой даты '
.head 6 +  On SAM_Click
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  If SqlPLSQLCommand(hSql(), 
"BARS.an_kl_p( AN_KL.nID, AN_KL.DAT1, AN_KL.DAT2, AN_KL.nRnk1, AN_KL.nRnk2, AN_KL.sNls, AN_KL.cb1, 1 )" )
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call SqlCommit( hSql() )
.head 8 -  Call MessageNoWait( 'Выполнение процедуры завершено!', 'AN_KL_P', 30, 0 )
.head 7 +  Else 
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call MessageNoWait( 'Ошибка при выполнении процедуры !', 'AN_KL_P', 30, 1 )
.head 4 +  ! Pushbutton: pbGrf
.winattr
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.55"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Chartl.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 +  Message Actions 
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'График '
.head 6 +  On SAM_Click
.head 7 -  Call SalWaitCursor ( TRUE )
.head 7 +  If not IsWindow(hWin17)
.head 8 -  ! Set hWin15 = SalCreateWindow (ANG, hWndMDI, AN_KL, AN_KL.strPar01 )
.head 8 -  Set hWin15 = SalCreateWindow (ANG, hWndMDI,  AN_KL.strPar01 )
.head 7 +  Else 
.head 8 -  Call SalBringWindowToTop(ANG)
.head 7 -  Call SalWaitCursor ( FALSE )
.head 4 -  Background Text: Дати:
.winattr
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.55"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.767"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Right
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold-Underline
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 4 +  Data Field: DAT1
.winattr
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
.head 7 -  Left:   1.333"
.head 7 -  Top:    0.071"
.head 7 -  Width:  1.1"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.321"
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
.end
.head 5 -  Message Actions 
.head 4 +  Data Field: DAT2
.winattr
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
.head 7 -  Left:   2.45"
.head 7 -  Top:    0.071"
.head 7 -  Width:  1.1"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.321"
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
.end
.head 5 -  Message Actions 
.head 4 -  Background Text: Маска рах.:
.winattr
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.6"
.head 6 -  Top:    0.071"
.head 6 -  Width:  1.333"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Right
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold-Underline
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 4 +  Data Field: sNls
.winattr
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   4.95"
.head 7 -  Top:    0.071"
.head 7 -  Width:  2.7"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.321"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Left
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.end
.head 5 +  Message Actions 
.head 6 +  On SAM_Validate
.head 7 -  Set AN_KL.sNls=SalStrTrimX( AN_KL.sNls )
.head 4 -  Background Text: №:
.winattr
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.683"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Justify: Right
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold-Underline
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 4 +  Data Field: nRnk1
.winattr
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   8.35"
.head 7 -  Top:    0.071"
.head 7 -  Width:  0.833"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.321"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Right
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.end
.head 5 -  Message Actions 
.head 4 +  Data Field: nRnk2
.winattr
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Editable? Yes
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   9.2"
.head 7 -  Top:    0.071"
.head 7 -  Width:  0.833"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.321"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Right
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.end
.head 5 -  Message Actions 
.head 4 +  Check Box: cb1
.winattr
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Только по VIP
.head 5 -  Window Location and Size
.head 6 -  Left:   10.05"
.head 6 -  Top:    0.071"
.head 6 -  Width:  1.833"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  !
.head 4 +  Pushbutton: pbDel
.winattr
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.514"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Delrec.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbRefresh
.winattr
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   13.283"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Refresh.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbUpdate
.winattr
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   12.35"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Save.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 +  Message Actions 
.head 6 +  On SAM_Create
.head 7 -  Set strTip = 'Выполнить текущее формирование в интервале дат '
.head 6 +  On SAM_Click
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Call SalSetWindowText( hWndForm, 'Анализ клиентов c '||
 SalFmtFormatDateTime( AN_KL.DAT1, 'dd-MM-yyyy' ) ||' по '||
 SalFmtFormatDateTime( AN_KL.DAT2, 'dd-MM-yyyy')||'.   ( Маска '||
 AN_KL.sNls||'. Рег № >='||Str(AN_KL.nRnk1)||' и Рег № <='||Str(AN_KL.nRnk2)|| ' )' )
.head 7 +  If SqlPLSQLCommand(hSql(), "BARS.an_kl_p
(AN_KL.nID, AN_KL.DAT1, AN_KL.DAT2, AN_KL.nRnk1, AN_KL.nRnk2, AN_KL.sNls, AN_KL.cb1, 0 )" )
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call SqlCommit( hSql() )
.head 8 -  Call MessageNoWait( 'Выполнение процедуры завершено!', 'AN_KL_P', 30, 0 )
.head 7 +  Else 
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Call MessageNoWait( 'Ошибка при выполнении процедуры !', 'AN_KL_P', 30, 1 )
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  4.557"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  4.557"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 4 +  Pushbutton: pbSearch
.winattr
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   14.217"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\search.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbFilter
.winattr
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   12.817"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Filter.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbDetails
.winattr
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.917"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\open.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbPrint
.winattr
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   13.75"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: F5
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  3.886"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  3.886"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 4 +  Pushbutton: pbExit
.winattr
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   14.683"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Esc
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.9"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  1.9"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? No
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 2 +  Contents 
.head 3 +  Column: ISP
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вик
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.5"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: VIP
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Гр.
VIP
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  0.417"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: RNKP
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реєст.
№ холд
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.733"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: KLI
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реєст.
№ кл
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.767"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NMK
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Найменування
кл
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  Default
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NLS
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Особ.рах
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  Default
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: KOL
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кіл.
вал
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.517"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 -  !
.head 3 +  Column: S_980
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Срд.зал
980
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.1"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: S_840
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Срд.зал
840
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.133"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: S_978
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Срд.зал.
978
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.083"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: S_810
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Срд.зал
810
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.067"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: Q_840
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Срд.зал
екв-840
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.117"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: Q_978
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Срд.зал
екв-978
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.117"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: Q_810
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Срд.зал
екв-810
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.117"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: C_EQV
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Чисті
кр.об/екв
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.067"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 -  !
.head 3 +  Column: K_980
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кр.об
980
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.017"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: K_840
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кр.об
840
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.983"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: K_978
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кр.об
978
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: K_810
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Кр.об
810
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.983"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 -  !
.head 3 +  Column: NNK
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Почат.
не ел
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.533"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NYK
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Почат
ел
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.533"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NMB
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Почат
СЕП
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.517"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: OMB
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Відп
СЕП
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.517"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 -  !
.head 3 +  Column: D01
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
1
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D02
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
2
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D03
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
3
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.75"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D04
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
4
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D05
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
5
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D06
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
6
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D07
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
7
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.75"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D08
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
8
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D09
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
9
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D10
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
10
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D11
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
11
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.75"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D12
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
12
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D13
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
13
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D14
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
14
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.75"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D15
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
15
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D16
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
16
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D17
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
17
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.75"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D18
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
18
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D19
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
19
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D20
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
20
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.75"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D21
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
21
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D22
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
22
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D23
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: приб
23
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.75"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: D24
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Приб
24
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.767"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 -  !
.head 3 +  Column: R01
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Видат
1
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.783"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 +  Message Actions 
.head 5 -  On SAM_AnyEdit
.head 3 +  Column: R02
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Видат
2
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.783"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 +  Message Actions 
.head 5 -  On SAM_AnyEdit
.head 3 +  Column: R03
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Видат
3
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.783"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 +  Message Actions 
.head 5 -  On SAM_AnyEdit
.head 3 +  Column: R04
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Видат
4
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.783"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.end
.head 4 -  List Values 
.head 4 +  Message Actions 
.head 5 -  On SAM_AnyEdit
.head 3 -  !
.head 2 +  Functions 
.head 3 +  Function: F_TITL
.head 4 -  Description: 
.head 4 -  Returns 
.head 4 -  Parameters 
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  Number: nColID
.head 5 -  Window Handle: hWndCol
.head 5 -  String: strColName
.head 5 -  Number: nColAppId
.head 5 -  String: strTitl
.head 4 +  Actions 
.head 5 -  Set nColID = 15
.head 5 +  Loop 
.head 6 -  Set hWndCol = SalTblGetColumnWindow ( hWndForm, nColID, COL_GetID )
.head 6 +  If hWndCol = hWndNULL
.head 7 -  Return TRUE
.head 6 -  Call SalGetItemName( hWndCol, strColName )
.head 6 +  If SalStrLeftX( strColName, 1 ) = 'D' or SalStrLeftX( strColName, 1 ) = 'R'
.head 7 +  If SqlPrepareAndExecute( hSql(), 
"SELECT name INTO :strTitl FROM an_kl_GRF WHERE grf=:strColName " )
and SqlFetchNext( hSql(), nFetchRes) 
.head 8 -  Call SalTblSetColumnTitle( hWndCol, strTitl )
.head 6 -  Set nColID = nColID + 1
.head 2 +  Window Parameters 
.head 3 -  Number: nPar
.head 3 -  String: strPar01
.head 3 -  String: strPar02
.head 3 -  Number: pRNK
.head 3 -  Number: pRNKP
.head 2 +  Window Variables 
.head 3 -  Number: nID
.head 3 -  Number: nColD
.head 3 -  Number: nColR
.head 3 -  Number: nCol
.head 3 -  Boolean: FL
.head 3 -  Number: nCol_980
.head 3 -  Number: nCol_840
.head 3 -  Number: nCol_978
.head 3 -  Number: nCol_810
.head 2 +  Message Actions 
.head 3 +  On SAM_Create
.head 4 -  ! Call PrepareWindow( hWndForm )
.head 4 -  Set AN_KL.nCol_980 = SalColorFromRGB( 255,255,180)  !  желтій
.head 4 -  Set AN_KL.nTabInstance= 1
.head 4 -  Set AN_KL.nCol_840 = SalColorFromRGB( 230,255,230 ) ! бледнозеленый
.head 4 -  Set AN_KL.nCol_978 = COLOR_Sky  ! бледноголубой
.head 4 -  Set AN_KL.nCol_810 = COLOR_LightGray ! серый
.head 4 -  !
.head 4 -  Set AN_KL.nColD = COLOR_LightAqua  ! ДОХОДЫ голубой
.head 4 -  Set AN_KL.nColR = SalColorFromRGB( 255,210,250 )   ! расходы - розовый
.head 4 -  Set AN_KL.nCol  = COLOR_LightGreen  ! операции - ЗЕЛЕНЫЙ  
.head 4 -  Call AN_KL.F_TITL()
.head 4 -  Set AN_KL.nID=GetUserId()
.head 4 -  Set AN_KL.cb1 = FALSE
.head 4 +  If AN_KL.nPar = 115
.head 5 -  ! Set AN_KL.FL=TRUE
.head 5 -  ! Call SalTblSetLockedColumns(hWndForm, 4)
.head 5 -  ! Call SalHideWindow( AN_KL.ccGraf) 
.head 5 -  Set AN_KL.strPrintFileName = 'AN_KL'
.head 5 -  Set AN_KL.strFilterTblName ='TMP_AN_KL'
.head 5 -  Set AN_KL.fFilterAtStart = TRUE
.head 5 -  !
.head 5 -  Set AN_KL.DAT2= GetBankDate()
.head 5 -  Set AN_KL.DAT1= GetBankDate() +1 -SalDateDay( GetBankDate())
.head 5 -  Set AN_KL.nRnk1=1
.head 5 -  Set AN_KL.nRnk2=999999
.head 5 -  Set AN_KL.sNls='2600_%'
.head 5 -  Set AN_KL.strSqlPopulate =
"SELECT TMP_AN_KL.ISP, TMP_AN_KL.RNK, CUSTOMER.NMK,  TMP_AN_KL.NLS  ,
        S_980/100, S_840/100, S_978/100, S_810/100,  
        C_EQV/100, Q_840/100, Q_978/100, Q_810/100,       
        K_980/100, K_840/100, K_978/100, K_810/100, 
        NNK      , NYK      , NMB      , OMB      ,
        d1/100   , d2/100   , d3/100   , d4/100   ,
        d5/100   , d6/100   , d7/100   , d8/100   ,
        d9/100   , d10/100  , d11/100  , d12/100  ,
        d13/100  , d14/100  , d15/100  , d16/100  ,
        d17/100  , d18/100  , d19/100  , d20/100  ,
        d21/100  , d22/100  , d23/100  , d24/100  ,
        r1/100   , r2/100   , r3/100   , r4/100,
        substr(w.value,1,3) , CUSTOMER.RNKP  
 INTO :AN_KL.ISP  , :AN_KL.KLI  , :AN_KL.NMK  , :AN_KL.NLS  , 
      :AN_KL.S_980, :AN_KL.S_840, :AN_KL.S_978, :AN_KL.S_810,
      :AN_KL.C_EQV, :AN_KL.Q_840, :AN_KL.Q_978, :AN_KL.Q_810, 
      :AN_KL.K_980, :AN_KL.K_840, :AN_KL.K_978, :AN_KL.K_810, 
      :AN_KL.NNK  , :AN_KL.NYK  , :AN_KL.NMB  , :AN_KL.OMB  ,
      :AN_KL.D01  , :AN_KL.D02  , :AN_KL.D03  , :AN_KL.D04  ,
      :AN_KL.D05  , :AN_KL.D06  , :AN_KL.D07  , :AN_KL.D08  ,
      :AN_KL.D09  , :AN_KL.D10  , :AN_KL.D11  , :AN_KL.D12  ,
      :AN_KL.D13  , :AN_KL.D14  , :AN_KL.D15  , :AN_KL.D16  ,
      :AN_KL.D17  , :AN_KL.D18  , :AN_KL.D19  , :AN_KL.D20  ,
      :AN_KL.D21  , :AN_KL.D22  , :AN_KL.D23  , :AN_KL.D24  ,
      :AN_KL.R01  , :AN_KL.R02  , :AN_KL.R03  , :AN_KL.R04, 
      :AN_KL.VIP  , :AN_KL.RNKP 
 FROM TMP_AN_KL, CUSTOMERW w, customer 
 WHERE TMP_AN_KL.nmk is null  and 
       w.tag (+)='VIP_K' and w.rnk(+)=TMP_AN_KL.rnk and CUSTOMER.rnk=TMP_AN_KL.rnk 
 ORDER BY  CUSTOMER.RNKP,  TMP_AN_KL.RNK "
.head 4 +  Else If AN_KL.nPar = 117
.head 5 -  Call SalHideWindow( AN_KL.cb1 )
.head 5 -  Call SalHideWindow( AN_KL.pbUpdate )
.head 5 -  Call SalHideWindow( AN_KL.pbIns )
.head 5 -  Call SalHideWindow( AN_KL.DAT1 )
.head 5 -  Call SalHideWindow( AN_KL.DAT2 )
.head 5 -  Call SalTblSetColumnTitle( AN_KL.NMK, "Рік Міс" )
.head 5 -  Set AN_KL.nRnk1 = AN_KL.pRNK
.head 5 -  Set AN_KL.nRnk2 = AN_KL.pRNKP
.head 5 -  Set AN_KL.sNls  = AN_KL.strPar01
.head 5 -  Set AN_KL.strSqlPopulate =
"SELECT TMP_AN_KL.ISP, TMP_AN_KL.NLS  , substr(TMP_AN_KL.NMK,1,4)||' '|| substr(TMP_AN_KL.NMK,5,2),
        S_980/100, S_840/100, S_978/100, S_810/100,  
        C_EQV/100, Q_840/100, Q_978/100, Q_810/100,       
        K_980/100, K_840/100, K_978/100, K_810/100,
        NNK      , NYK      , NMB      , OMB      ,
        d1/100   , d2/100   , d3/100   , d4/100   ,
        d5/100   , d6/100   , d7/100   , d8/100   ,
        d9/100   , d10/100  , d11/100  , d12/100  ,
        d13/100  , d14/100  , d15/100  , d16/100  ,
        d17/100  , d18/100  , d19/100  , d20/100  ,
        d21/100  , d22/100  , d23/100  , d24/100  ,
        r1/100   , r2/100   , r3/100   , r4/100        
 INTO :AN_KL.ISP ,  :AN_KL.NLS, :AN_KL.NMK, 
      :AN_KL.S_980, :AN_KL.S_840, :AN_KL.S_978, :AN_KL.S_810,
      :AN_KL.C_EQV, :AN_KL.Q_840, :AN_KL.Q_978, :AN_KL.Q_810, 
      :AN_KL.K_980, :AN_KL.K_840, :AN_KL.K_978, :AN_KL.K_810,
      :AN_KL.NNK  , :AN_KL.NYK  , :AN_KL.NMB  , :AN_KL.OMB  ,
      :AN_KL.D01  , :AN_KL.D02  , :AN_KL.D03  , :AN_KL.D04  ,
      :AN_KL.D05  , :AN_KL.D06  , :AN_KL.D07  , :AN_KL.D08  ,
      :AN_KL.D09  , :AN_KL.D10  , :AN_KL.D11  , :AN_KL.D12  ,
      :AN_KL.D13  , :AN_KL.D14  , :AN_KL.D15  , :AN_KL.D16  ,
      :AN_KL.D17  , :AN_KL.D18  , :AN_KL.D19  , :AN_KL.D20  ,
      :AN_KL.D21  , :AN_KL.D22  , :AN_KL.D23  , :AN_KL.D24  ,
      :AN_KL.R01  , :AN_KL.R02  , :AN_KL.R03  , :AN_KL.R04
 FROM TMP_AN_KL
 WHERE TMP_AN_KL.nmk is not null and rnk=:AN_KL.pRNK
 ORDER BY  nmk  "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_CreateComplete
.head 4 +  If AN_KL.nPar = 117
.head 5 -  Call SalWaitCursor ( TRUE )
.head 5 -  Call SalSendClassMessage( UM_Populate, 0, 0)
.head 5 -  Call SalHideWindow( AN_KL.VIP )
.head 5 -  Call SalHideWindow( AN_KL.RNKP )
.head 5 -  Call SalHideWindow( AN_KL.KLI )
.head 5 -  ! Call AN_KL.ccGraf.Draw()
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_FetchRowDone
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D01, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D02, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D03, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D04, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D05, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D06, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D07, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D08, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D09, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D10, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D11, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D12, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D13, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D14, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D15, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D16, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D17, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D18, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D19, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D20, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D21, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D22, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D23, AN_KL.nColD )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.D24, AN_KL.nColD )
.head 4 -  !
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.R01, AN_KL.nColR )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.R02, AN_KL.nColR )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.R03, AN_KL.nColR )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.R04, AN_KL.nColR )
.head 4 -  !
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.NNK, AN_KL.nCol )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.NYK, AN_KL.nCol )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.NMB, AN_KL.nCol )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.OMB, AN_KL.nCol )
.head 4 -  !
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.S_980, AN_KL.nCol_980 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.K_980, AN_KL.nCol_980 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.S_840, AN_KL.nCol_840 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.K_840, AN_KL.nCol_840 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.Q_840, AN_KL.nCol_840 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.S_978, AN_KL.nCol_978 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.K_978, AN_KL.nCol_978 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.Q_978, AN_KL.nCol_978 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.K_810, AN_KL.nCol_810 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.Q_810, AN_KL.nCol_810 )
.head 4 -  Call XSalTblSetCellBackColor( AN_KL.S_810, AN_KL.nCol_810 )
.head 4 -  !
.head 1 +  Form Window: win_meter
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Etched
.head 3 -  Visible at Design time? No
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? No
.head 3 -  Minimizable? No
.head 3 -  System Menu? Yes
.head 3 -  Resizable? No
.head 3 -  Window Location and Size
.head 4 -  Left:   2.763"
.head 4 -  Top:    2.073"
.head 4 -  Width:  5.2"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.262"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: 0
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Bold
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Process indicator dialog
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
.head 3 +  Custom Control: ProcIndicator
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cMeter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.329"
.head 6 -  Top:    0.25"
.head 6 -  Width:  4.429"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.333"
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
.head 5 -  Text Color: 3D Shadow Color
.head 5 -  Background Color: System Window Color
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: PIndTitle
.head 3 -  Number: Bound
.head 2 +  Window Variables
.head 3 -  Number: nPerCent
.head 3 -  !
.head 3 -  Number: nX
.head 3 -  Number: nY
.head 3 -  Number: nW
.head 3 -  Number: nH
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm, PIndTitle)
.head 4 -  !
.head 4 -  Call SalCenterWindow(hWndForm)
.head 3 +  On SAM_Close
.head 4 -  Return FALSE
.head 3 +  On AM_MtrMove
.head 4 -  Set nPerCent = SalNumberRound((lParam / Bound) * 100)
.head 4 -  Call ProcIndicator.SetProgress(nPerCent)
.head 4 -  Return TRUE
.head 1 +  Table Window: AS2
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: АВТО - ЗАКРЫТИЕ лицевых счетов
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   0.138"
.head 4 -  Top:    0.844"
.head 4 -  Width:  14.8"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
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
.head 3 -  Maximum Rows in Memory: 1000
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
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
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
.head 7 -  Set strTip = 'Закрыть отмеченные счета'
.head 6 +  On SAM_Click
.head 7 -  Call Close()
.head 4 -  Line
.head 5 -  Resource Id: 56426
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
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
.head 7 -  Set strTip = 'Карточка счета'
.head 6 +  On SAM_Click
.head 7 +  ! If SqlPrepareAndExecute(hSql(),
  "SELECT rnk INTO :nRnk FROM cust_acc WHERE acc=:AS2.tbl.ACC ")
.head 8 -    Call SqlFetchNext(hSql(), nTmp) 
.head 8 -    Call OperWithAccount(AVIEW_ALL, AS2.ACC, nRnk, ACCESS_READONLY)
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
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
.head 5 -  Resource Id: 56427
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
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
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
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
.head 5 -  Resource Id: 56428
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: ISP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Исп
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.667"
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
.head 3 +  Column: KV
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.65"
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
.head 3 +  Column: NMS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  Default
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
.head 3 +  Column: NLS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Осн
ЛС
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  Default
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
.head 3 +  Column: DAPP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
посл.дв.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.05"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: MDATE
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
окончания
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.183"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: OSTC
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Остаток
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.667"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.head 3 +  Column: ACC
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ACC
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.65"
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
.head 3 +  Column: ACC_
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ACC_
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.65"
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
.head 3 +  Column: NLS_
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сч.нач.
%
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  Default
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
.head 3 +  Column: ACR_DAT_
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
посл.нач.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.117"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: DAPP_
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
посл.дв.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Center
.head 4 -  Width:  1.083"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.head 3 +  Column: OSTC_
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Остаток
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.head 3 +  Column: OTM
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отм
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.65"
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
.head 6 -  Uncheck Value: 0
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Set AS2.OTM_old = AS2.OTM
.head 5 +  On SAM_Validate
.head 6 -  ! закрыть по требованию
.head 6 +  If AS2.OTM = 1 and AS2.OTM_old  = 0 
.head 7 -  ! плохо
.head 7 +  If AS2.OSTC !=0 
.head 8 -  Call SalMessageBox( " Остаток осн.сч. НЕ = 0 !" ,"О Ш И Б К А  ! ", MB_IconStop)
.head 8 -  Set AS2.OTM =0
.head 8 -  Return VALIDATE_Cancel
.head 7 +  If AS2.OSTC_ != NUMBER_Null 
.head 8 +  If AS2.OSTC_ !=0 
.head 9 -  Call SalMessageBox( " Остаток нач.% НЕ = 0 !" ,"О Ш И Б К А  ! ", MB_IconStop)
.head 9 -  Set AS2.OTM =0
.head 9 -  Return VALIDATE_Cancel
.head 8 +  If AS2.DAPP_ != DATETIME_Null and AS2.DAPP_ >= AS2.bDat 
.head 9 -  Call SalMessageBox( " Дата посл.движ. РАВНА (или БОЛЬШЕ) ТЕКУЩЕЙ  !" ,"О Ш И Б К А  ! ", MB_IconStop)
.head 9 -  Set AS2.OTM =0
.head 9 -  Return VALIDATE_Cancel
.head 7 +  If AS2.OTM = 1
.head 8 -  If AS2.MDATE > AS2.bDat and 
   SalMessageBox(" Внимание ! Дата закрытия еще НЕ НАСТУПИЛА ", " Однако, Закрыть ? ",
 MB_YesNo | MB_IconHand) = IDYES
.head 8 +  Else
.head 9 -  Set AS2.OTM =0
.head 8 -  !
.head 8 -  If AS2.NLS_ != STRING_Null and AS2.ACR_DAT_ < AS2.DAPP and 
   SalMessageBox(" Внимание ! Дата нач.%  НЕ последняя ", " Однако, Закрыть ? ",
 MB_YesNo | MB_IconHand) = IDYES
.head 8 +  Else
.head 9 -  Set AS2.OTM =0
.head 3 -  !
.head 2 +  Functions
.head 3 +  Function: Close
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nKOL
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Set nTmp=TBL_MinRow
.head 5 -  ! Set nKOL=0
.head 5 +  Loop
.head 6 +  If SalTblFindNextRow (hWndForm, nTmp, 0, 0)
.head 7 -  Call SalTblSetContext(hWndForm,nTmp)
.head 7 +  If nTmp >=0
.head 8 +  If AS2.OTM=1
.head 9 -  If SqlPrepareAndExecute(hSql(),
"UPDATE accounts SET dazs=BANKDATE WHERE acc=:AS2.ACC")
.head 6 +  Else
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Call SaveFInfoToLog('Авто-закрытие счетов')
.head 7 -  Call SalMessageBox('Закрытие отмеченных счетов','Выполнено успешно',MB_IconInformation)
.head 7 -  Break
.head 5 -  !
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Call SalSendMsg(pbRefresh, SAM_Click, 0, 0)
.head 2 +  Window Parameters
.head 3 -  String: sPar
.head 2 +  Window Variables
.head 3 -  Number: nRnk
.head 3 -  Number: nTmp
.head 3 -  Number: OTM_old
.head 3 -  Date/Time: bDat
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set AS2.strPrintFileName = 'AS2'
.head 4 -  Set AS2.nTabInstance = 1
.head 4 -  Call cF.Init('ACCOUNTS', 'a')
.head 4 -  Set AS2.bDat = GetBankDate()
.head 4 -  Set AS2.strSqlPopulate =
"SELECT A.isp, A.kv, A.nls, A.nms, A.dapp, A.mdate, A.acc, A.ostc/100,
        i.acra, i.ACR_DAT 
 INTO  :AS2.ISP , :AS2.KV,     :AS2.NLS, :AS2.NMS,
       :AS2.DAPP, :AS2.MDATE,  :AS2.ACC, :AS2.OSTC, 
       :AS2.ACC_, :AS2.ACR_DAT_
 FROM   ACCOUNTS a, int_accN i 
 WHERE (A.ostc=0 and A.ostb=0 and A.ostf=0 OR 
        nvl(A.mdate, bankdate) <= bankdate ) and 
        A.dazs IS NULL AND A.dapp < bankdate  and 
        A.acc = i.acc(+) " || AS2.sPar || " 
 ORDER BY A.nls "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 -  Call SalEnableWindow(pbFilter)
.head 3 +  On SAM_FetchRowDone
.head 4 -  If AS2.ACC_ != NUMBER_Null 
and SqlPrepareAndExecute( hSqlAux2(), 
  "SELECT nls, dapp, ostc/100  INTO :AS2.NLS_, :AS2.DAPP_, :AS2.OSTC_ 
   FROM accounts WHERE acc=:AS2.ACC_ " ) 
and SqlFetchNext( hSqlAux2(),  nTmp )
.head 4 -  !
.head 4 +  If AS2.OSTC = 0 and AS2.MDATE <= AS2.bDat and 
 ( AS2.NLS_ = STRING_Null or AS2.OSTC_ = 0 and AS2.DAPP_ < AS2.bDat )
.head 5 -  Set AS2.OTM = 1
.head 4 +  Else
.head 5 -  Set AS2.OTM = 0
.head 1 -  ! API для  работы со списками функций
.head 1 +  Form Window: fwListFuncSetAPI
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Редактирование списков функций
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
.head 4 -  Left:   0.0"
.head 4 -  Top:    0.0"
.head 4 -  Width:  11.617"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.381"
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
.head 2 -  Description: Main form window for function managing interface
.head 2 +  Named Menus
.head 3 +  Menu: menuListFuncSetAPI
.head 4 -  Resource Id: 6507
.head 4 -  Title: API для работы со списками функций
.head 4 -  Description:
.head 4 -  Enabled when:
.head 4 -  Status Text:
.head 4 -  Menu Item Name:
.head 4 +  Popup Menu: &Списки
.head 5 -  Resource Id: 6508
.head 5 -  Enabled when:
.head 5 -  Status Text:
.head 5 -  Menu Item Name:
.head 5 +  Menu Item: &Выполнить
.head 6 -  Resource Id: 6509
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(tbSetExecution, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 5 +  Menu Item: &Сохранить
.head 6 -  Resource Id: 6510
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(tbSetAjustion, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 5 +  Menu Item: &Новый...
.head 6 -  Resource Id: 6512
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(tbSetNew, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 5 +  Menu Item: &Удалить
.head 6 -  Resource Id: 6514
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(tbSetDelete, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 4 +  Popup Menu: &Функции
.head 5 -  Resource Id: 6515
.head 5 -  Enabled when:
.head 5 -  Status Text:
.head 5 -  Menu Item Name:
.head 5 +  Menu Item: Переместить в &лево
.head 6 -  Resource Id: 6516
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(pbMoveToLeft, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 5 +  Menu Item: Переместить в &право
.head 6 -  Resource Id: 6517
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(pbMoveToRight, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 5 +  Menu Item: &Найти среди доступных...
.head 6 -  Resource Id: 6518
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(tbFuncSearch, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 5 +  Menu Item: &Фильтр доступных...
.head 6 -  Resource Id: 45874
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(tbFilter, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 5 +  Menu Item: &Удалить
.head 6 -  Resource Id: 6519
.head 6 -  Keyboard Accelerator: (none)
.head 6 -  Status Text:
.head 6 +  Menu Settings
.head 7 -  Enabled when:
.head 7 -  Checked when:
.head 6 +  Menu Actions
.head 7 -  Call SalSendMsg(pbDelete, SAM_Click, 0, 0)
.head 6 -  Menu Item Name:
.head 4 -  Menu Separator
.head 4 +  Menu Item: &Выход
.head 5 -  Resource Id: 6520
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Status Text:
.head 5 +  Menu Settings
.head 6 -  Enabled when:
.head 6 -  Checked when:
.head 5 +  Menu Actions
.head 6 -  Call SalSendMsg(tbExit, SAM_Click, 0, 0)
.head 5 -  Menu Item Name:
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.438"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Contents
.head 4 +  Pushbutton: tbSetExecution
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbExecute
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Call SalDisableWindow(tbSetAjustion)
.head 7 -  Call SalDisableWindow(tbSetExecution)
.head 7 -  Call SalDisableWindow(tbSetNew)
.head 7 -  Call SalDisableWindow(tbSetDelete)
.head 7 -  Call SalDisableWindow(tbFuncSearch)
.head 7 -  Call SalDisableWindow(tbExit)
.head 7 -  Call SalHideWindow(tblAvailable)
.head 7 -  Call SalHideWindow(pbMoveToRight)
.head 7 -  Call SalHideWindow(pbMoveToLeft)
.head 7 -  Call SalHideWindow(pbMark)
.head 7 -  Call SalHideWindow(pbDelete)
.head 7 -  Call SalHideWindow(pbMoveUp)
.head 7 -  Call SalHideWindow(pbMoveDown)
.head 7 -  Call SalHideWindow(tblEditable.FuncComments)
.head 7 -  Call SalShowWindow(tblEditable.FuncStatus)
.head 7 -  Set bFlag = TRUE
.head 7 -  Call SalGetWindowLoc(tblAvailable, nx, ny)
.head 7 -  Call SalGetWindowSize(tblSets, nw, nh)
.head 7 -  Call SalSetWindowLoc(ProgressMeter, nx, ny)
.head 7 -  Call SalSetWindowSize(ProgressMeter, nw-nx , 0.4)
.head 7 -  Call SalSetWindowLoc(pbStop, nx + (nw-nx)/2 - 0.6  , ny+nh/3+nh/15)
.head 7 -  Call SalSetWindowSize(pbStop, 1.3, 0.5)
.head 7 -  Call SalShowWindow(pbStop)
.head 7 -  Call SalShowWindow(ProgressMeter)
.head 7 -  Set nMax = TBL_MinRow
.head 7 +  Loop
.head 8 +  If NOT SalTblFindNextRow(tblEditable, nMax, 0, 0)
.head 9 -  Break
.head 7 +  If nMax > 0
.head 8 -  Set nIndex = TBL_MinRow
.head 8 +  Loop
.head 9 +  If bFlag = TRUE
.head 10 +  If SalTblFindNextRow(tblEditable, nIndex, 0, 0)
.head 11 -  Call SalTblSetFocusRow(tblEditable, nIndex)
.head 11 -  Call SalTblSetContext(tblEditable , nIndex)
.head 11 +  If tblEditable.FuncActivity
.head 12 -  Call SaveInfoToLog('Старт выполнения функции списка ' || tblEditable.FuncName)
.head 12 -  Call SalTblSetCellTextColor(tblEditable.FuncStatus, COLOR_Blue, FALSE)
.head 12 -  Set tblEditable.FuncStatus = 'Running...'
.head 12 +  If tblEditable.FuncRoleName != ''
.head 13 -  Call XRoleSet( tblEditable.DB.hSql(), tblEditable.FuncName, tblEditable.FuncRoleName )
.head 12 +  If SalCompileAndEvaluate(tblEditable.FuncCallString , nError , nErrorPos, nReturn, strReturn, dtReturn, hWndReturn, FALSE, SalContextCurrent ())
.head 13 -  Call SqlCommitEx(tblEditable.DB.hSql(), 'Функция - ' || tblEditable.FuncName)
.head 13 -  Call SalTblSetCellTextColor(tblEditable.FuncStatus, COLOR_DarkGreen, FALSE)
.head 13 -  Set tblEditable.FuncStatus = 'Done'
.head 12 +  Else
.head 13 -  Call SalTblSetCellTextColor(tblEditable.FuncStatus, COLOR_DarkRed, FALSE)
.head 13 -  Set tblEditable.FuncStatus = 'Failed'
.head 11 +  Else
.head 12 -  Call SalTblSetCellTextColor(tblEditable.FuncStatus, COLOR_Magenta, FALSE)
.head 12 -  Set tblEditable.FuncStatus = 'Ignore'
.head 11 -  Call ProgressMeter.SetProgress(SalNumberRound((nIndex+1)*100/nMax))
.head 10 +  Else
.head 11 -  Break
.head 9 +  Else
.head 10 +  Loop
.head 11 +  If SalTblFindNextRow(tblEditable, nIndex, 0, 0)
.head 12 -  Call SalTblSetFocusRow(tblEditable, nIndex)
.head 12 -  Call SalTblSetContext(tblEditable , nIndex)
.head 12 -  Call SalTblSetCellTextColor(tblEditable.FuncStatus, COLOR_Magenta, FALSE)
.head 12 -  Set tblEditable.FuncStatus = 'Ignore'
.head 12 -  Call ProgressMeter.SetProgress(SalNumberRound((nIndex+1)*100/nMax))
.head 11 +  Else
.head 12 -  Break
.head 10 -  Break
.head 7 -  Call SalHideWindow(pbStop)
.head 7 -  Call SalSetWindowLoc(pbAccept, nx + nw/8  , ny+nh/3+nh/15)
.head 7 -  Call SalSetWindowSize(pbAccept, 1.2, 0.5)
.head 7 -  Call SalShowWindow(pbAccept)
.head 6 +  On SAM_TooltipSetText
.head 7 -  Call XSalTooltipShow(tbSetExecution,'Выполнить множество функций')
.head 4 -  Line
.head 5 -  Resource Id: 45870
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  0.571"
.head 6 -  Begin Y:  0.021"
.head 6 -  End X:  0.571"
.head 6 -  End Y:  0.469"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: tbSetAjustion
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbUpdate
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.643"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Call tblEditable.Adjust()
.head 7 -  Call SalTblSetFlagsAnyRows(tblEditable, ROW_Edited, FALSE, 0, 0)
.head 7 -  Call SalTblSetFlagsAnyRows(tblEditable, ROW_New, FALSE, 0, 0)
.head 7 -  Call SalTblSetRowFlags (tblAvailable, 0, ROW_Selected, TRUE)
.head 7 -  Call SalSetFocus(tblAvailable)
.head 6 +  On SAM_TooltipSetText
.head 7 -  Call XSalTooltipShow(tbSetAjustion,'Сохранить изменения')
.head 4 +  Pushbutton: tbSetNew
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbBrowse
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.071"
.head 6 -  Top:    0.073"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Set strTextName = ''
.head 7 -  Set strTextComments = ''
.head 7 -  Call SalModalDialog(dbSetCreating, fwListFuncSetAPI,strTextName,strTextComments,nActionCode)
.head 7 +  Select Case nActionCode
.head 8 +  Case 1
.head 9 -  Set nNumber = tblSets.New(strTextName,strTextComments)
.head 9 -  Call tblEditable.Destructor()
.head 9 -  Call tblEditable.Constructor(nNumber)
.head 9 -  Call tblEditable.Fill()
.head 9 -  Call tblAvailable.Destructor()
.head 9 -  Call tblAvailable.Constructor(1)
.head 9 -  Call tblAvailable.FillMinusSet(nNumber)
.head 9 -  Call tblSets.Destructor()
.head 9 -  Call tblSets.Constructor()
.head 9 -  Set nIndex = TBL_MinRow
.head 9 +  Loop
.head 10 +  If SalTblFindNextRow(tblSets, nIndex, 0, 0)
.head 11 -  Call SalTblSetContext(tblSets,nIndex)
.head 11 +  If tblSets.SetId = nNumber
.head 12 -  Call SalTblSetRowFlags (tblSets, nIndex, ROW_Selected, TRUE)
.head 12 -  Call SalTblSetFocusRow(tblSets, nIndex)
.head 12 -  Break
.head 11 +  Else
.head 12 -  Call SalTblSetRowFlags (tblSets, nIndex, ROW_Selected, FALSE)
.head 10 +  Else
.head 11 -  Break
.head 9 -  Call SalTblSetRowFlags (tblAvailable, 0, ROW_Selected, TRUE)
.head 9 -  Call SalSetFocus(tblAvailable)
.head 9 -  Set nActionCode = 0
.head 6 +  On SAM_TooltipSetText
.head 7 -  Call XSalTooltipShow(tbSetNew,'Создать множество')
.head 4 +  Pushbutton: tbSetDelete
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbDelete
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.5"
.head 6 -  Top:    0.073"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Set nIndex = TBL_MinRow
.head 7 -  Call SalTblFindNextRow(tblSets, nIndex, ROW_Selected, 0)
.head 7 -  Call SalTblSetContext(tblSets, nIndex)
.head 7 -  Call SalTblGetColumnText(tblSets, 1, strText)
.head 7 -  Set nNumber = SalStrToNumber(strText)
.head 7 -  Call tblSets.Delete(nNumber)
.head 7 -  Call SalTblSetContext(tblSets, 0)
.head 7 -  Call SalTblGetColumnText(tblSets, 1, strText)
.head 7 -  Set nNumber = SalStrToNumber(strText)
.head 7 -  Call tblEditable.Destructor()
.head 7 -  Call tblEditable.Constructor(nNumber)
.head 7 -  Call tblEditable.Fill()
.head 7 -  Call tblAvailable.Destructor()
.head 7 -  Call tblAvailable.Constructor(1)
.head 7 -  Call tblAvailable.FillMinusSet(nNumber)
.head 7 -  Call tblSets.Destructor()
.head 7 -  Call tblSets.Constructor()
.head 7 -  Call SalTblSetRowFlags (tblSets, 0, ROW_Selected, TRUE)
.head 7 -  Call SalTblSetRowFlags (tblAvailable, 0, ROW_Selected, TRUE)
.head 7 -  Call SalSetFocus(tblAvailable)
.head 6 +  On SAM_TooltipSetText
.head 7 -  Call XSalTooltipShow(tbSetDelete,'Удалить множество')
.head 4 -  Line
.head 5 -  Resource Id: 45871
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  1.971"
.head 6 -  Begin Y:  0.01"
.head 6 -  End X:  1.971"
.head 6 -  End Y:  0.458"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: tbFilter
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbFilter
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.043"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.414"
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
.head 7 -  Set strTip = 'Наложить фильтр на список доступных функций'
.head 6 +  On SAM_Click
.head 7 +  If SetQueryFilter(tblAvailable.ListFilter)
.head 8 -  Call tblAvailable.FillMinusSet(tblSets.SetId)
.head 4 -  Line
.head 5 -  Resource Id: 45872
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  2.943"
.head 6 -  Begin Y:  0.01"
.head 6 -  End X:  2.943"
.head 6 -  End Y:  0.458"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 4 +  Pushbutton: tbFuncSearch
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbSearch
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.457"
.head 6 -  Top:    0.071"
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
.head 6 +  On SAM_Click
.head 7 -  Call TblFindString(tblAvailable,DFIND_First)
.head 7 -  Call SalTblSetFlagsAnyRows(tblAvailable, ROW_Selected, FALSE,ROW_Selected ,0)
.head 7 -  Call SalTblSetRowFlags(tblAvailable, SalTblQueryContext(tblAvailable), ROW_Selected, TRUE)
.head 6 +  On SAM_TooltipSetText
.head 7 -  Call XSalTooltipShow(tbFuncSearch,'Поиск функции в списке доступных')
.head 4 +  Pushbutton: tbExit
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbCancel
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.029"
.head 6 -  Top:    0.071"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Call SalSendMsg(fwListFuncSetAPI, SAM_Close, 0, 0)
.head 6 +  On SAM_TooltipSetText
.head 7 -  Call XSalTooltipShow(tbExit,'Выход')
.head 4 -  Line
.head 5 -  Resource Id: 45873
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Coordinates
.head 6 -  Begin X:  3.514"
.head 6 -  Begin Y:  0.01"
.head 6 -  End X:  3.514"
.head 6 -  End Y:  0.458"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.head 2 +  Contents
.head 3 +  Child Table: tblSets
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ListSet
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.043"
.head 6 -  Top:    0.042"
.head 6 -  Width:  11.143"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 1.365"
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
.head 5 +  Column: SetId
.head 6 -  Class Child Ref Key: 1
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
.head 6 -  Visible? Yes
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  1.067"
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
.head 5 +  Column: SetName
.head 6 -  Class Child Ref Key: 2
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование списка
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 50
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  3.767"
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
.head 6 +  Message Actions
.head 7 +  On SAM_FieldEdit
.head 8 -  Call SqlPrepareAndExecute( hSql(), " UPDATE BARS.LIST_SET SET (Name) = (:tblSets.SetName) WHERE ID=:tblSets.SetId" )
.head 8 -  Call SqlCommit( hSql() )
.head 8 -  Call SalTblSetFlagsAnyRows(tblSets, ROW_Edited, FALSE, 0, 0)
.head 5 +  Column: SetComments
.head 6 -  Class Child Ref Key: 3
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 100
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  7.171"
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
.head 6 +  Message Actions
.head 7 +  On SAM_FieldEdit
.head 8 -  Call SqlPrepareAndExecute( hSql(), " UPDATE BARS.LIST_SET SET (Comments) = (:tblSets.SetComments) WHERE ID=:tblSets.SetId" )
.head 8 -  Call SqlCommit( hSql() )
.head 8 -  Call SalTblSetFlagsAnyRows(tblSets, ROW_Edited, FALSE, 0, 0)
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_TblDoDetails
.head 6 -  Set nIndex = SalTblQueryContext(tblSets)
.head 6 -  Call SalTblSetFlagsAnyRows(tblSets, ROW_Selected , FALSE, ROW_Selected, 0)
.head 6 -  Call SalTblSetRowFlags(tblSets,nIndex, ROW_Selected, TRUE)
.head 6 -  Call tblEditable.Destructor()
.head 6 -  Call tblAvailable.Destructor()
.head 6 -  Call tblEditable.Constructor(SetId)
.head 6 -  Call tblEditable.Fill()
.head 6 -  Call tblAvailable.Constructor(-1)
.head 6 -  Call tblAvailable.FillMinusSet(SetId)
.head 6 -  Call SalTblSetRowFlags (tblAvailable, 0, ROW_Selected, TRUE)
.head 6 -  Call SalSetFocus(tblAvailable)
.head 3 +  Child Table: tblEditable
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ListFncSet
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.043"
.head 6 -  Top:    1.488"
.head 6 -  Width:  5.943"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 3.906"
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
.head 5 +  Column: FuncId
.head 6 -  Class Child Ref Key: 3
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 5 +  Column: FuncName
.head 6 -  Class Child Ref Key: 9
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  2.583"
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
.head 5 +  Column: FuncActivity
.head 6 -  Class Child Ref Key: 4
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  0.333"
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
.head 5 +  Column: FuncPosition
.head 6 -  Class Child Ref Key: 5
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 5 +  Column: FuncComments
.head 6 -  Class Child Ref Key: 6
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  2.383"
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
.head 5 +  Column: FuncCallString
.head 6 -  Class Child Ref Key: 8
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 5 +  Column: FuncStatus
.head 6 -  Class Child Ref Key: 7
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  0.733"
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
.head 5 +  Column: FuncRoleName
.head 6 -  Class Child Ref Key: 13
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalTblSetFlagsAnyRows(tblAvailable ,ROW_Selected , FALSE, ROW_Selected, 0)
.head 5 +  On SAM_DragDrop
.head 6 -  Call SalSendMsg(pbMoveToLeft, SAM_Click, 0, 0)
.head 5 +  On SAM_DragCanAutoStart
.head 6 -  Set nIndex = TBL_MinRow
.head 6 +  If SalTblFindNextRow(tblEditable, nIndex, ROW_Selected, 0)
.head 7 -  Return TRUE
.head 6 +  Else
.head 7 -  Return FALSE
.head 3 +  Child Table: tblAvailable
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ListFncSet
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.683"
.head 6 -  Top:    1.488"
.head 6 -  Width:  4.529"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 3.906"
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
.head 5 +  Column: FuncId
.head 6 -  Class Child Ref Key: 3
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 5 +  Column: FuncName
.head 6 -  Class Child Ref Key: 9
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Доступные функции
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  3.857"
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
.head 5 +  Column: FuncActivity
.head 6 -  Class Child Ref Key: 4
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 5 +  Column: FuncPosition
.head 6 -  Class Child Ref Key: 5
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
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
.head 5 +  Column: FuncComments
.head 6 -  Class Child Ref Key: 6
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 5 +  Column: FuncCallString
.head 6 -  Class Child Ref Key: 8
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 5 +  Column: FuncStatus
.head 6 -  Class Child Ref Key: 7
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
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
.head 5 +  Column: FuncRoleName
.head 6 -  Class Child Ref Key: 13
.head 6 -  Class ChildKey: 0
.head 6 -  Class: ListFncSet
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalTblSetFlagsAnyRows(tblEditable ,ROW_Selected , FALSE, ROW_Selected, 0)
.head 5 +  On SAM_DragCanAutoStart
.head 6 -  Set nIndex = TBL_MinRow
.head 6 +  If SalTblFindNextRow(tblAvailable, nIndex, ROW_Selected, 0)
.head 7 -  Return TRUE
.head 6 +  Else
.head 7 -  Return FALSE
.head 5 +  On SAM_DragDrop
.head 6 -  Call SalSendMsg(pbMoveToRight, SAM_Click, 0, 0)
.head 3 +  Pushbutton: pbMoveToLeft
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: RsButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.114"
.head 5 -  Top:    2.208"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\ARR1TOL.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nIndex = TBL_MinRow
.head 6 +  Loop
.head 7 +  If SalTblFindNextRow(tblAvailable, nIndex, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(tblAvailable, nIndex)
.head 8 -  Call SalTblGetColumnText(tblAvailable,1, strText)
.head 8 -  Set nNumber = SalStrToNumber(strText)
.head 8 -  Call tblEditable.AddFunc(nNumber)
.head 8 -  Call tblAvailable.RemFunc(nIndex)
.head 8 -  Set nIndex = TBL_MinRow
.head 7 +  Else
.head 8 -  Break
.head 6 -  Call tblEditable.RestorePosition()
.head 6 -  Call SalTblSetRowFlags (tblAvailable, 0, ROW_Selected, TRUE)
.head 6 -  Call SalTblSetFocusRow(tblAvailable,0)
.head 5 +  ! On SAM_TooltipSetText
.head 6 -      Call XSalTooltipShow(pbMoveToLeft,'Переместить в лево')
.head 3 +  Pushbutton: pbMoveToRight
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: RsButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.114"
.head 5 -  Top:    2.521"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\ARR1TOR.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nIndex = TBL_MinRow
.head 6 +  Loop
.head 7 +  If SalTblFindNextRow(tblEditable, nIndex, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(tblEditable, nIndex)
.head 8 -  Call SalTblGetColumnText(tblEditable,1, strText)
.head 8 -  Set nNumber = SalStrToNumber(strText)
.head 8 -  Call tblAvailable.AddFunc(nNumber)
.head 8 -  Call tblEditable.RemFunc(nIndex)
.head 8 -  Call SqlPrepareAndExecute(tblAvailable.DB.hSql(), '
SELECT 	Func_Position
INTO 	:nPos
FROM	List_FuncSet
WHERE	Func_Id = :nNumber
	AND
	Set_Id = 1')
.head 8 -  Call SqlFetchNext(tblAvailable.DB.hSql(),nFetchRes)
.head 8 -  Call SalTblSetColumnText(tblAvailable,4, SalNumberToStrX(nPos,0))
.head 8 -  Set nIndex = TBL_MinRow
.head 7 +  Else
.head 8 -  Break
.head 6 -  Call SalTblSortRows(tblAvailable, 4 , TBL_SortIncreasing)
.head 6 -  Call SalSetFocus(tblEditable)
.head 6 -  Call SalTblSetRowFlags (tblEditable, 0, ROW_Selected, TRUE)
.head 6 -  Call SalTblSetFocusRow(tblEditable,0)
.head 6 -  Call SalTblSetFlagsAnyRows(tblAvailable ,ROW_New , FALSE, ROW_New, 0)
.head 5 +  ! On SAM_TooltipSetText
.head 6 -      Call XSalTooltipShow(pbMoveToRight,'Переместить в право')
.head 3 +  Pushbutton: pbMoveUp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: RsButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.114"
.head 5 -  Top:    3.125"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\ARR1TOU.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call tblEditable.MoveUp()
.head 5 +  ! On SAM_TooltipSetText
.head 6 -      Call XSalTooltipShow(pbMoveUp,'Переместить выше')
.head 3 +  Pushbutton: pbMoveDown
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: RsButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.114"
.head 5 -  Top:    3.438"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\ARR1TOD.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call tblEditable.MoveDown()
.head 5 +  ! On SAM_TooltipSetText
.head 6 -      Call XSalTooltipShow(pbMoveDown,'Переместить ниже')
.head 3 +  Pushbutton: pbMark
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: RsButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.114"
.head 5 -  Top:    4.354"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\APP1.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nIndex = TBL_MinRow
.head 6 +  Loop
.head 7 +  If SalTblFindNextRow(tblEditable, nIndex, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(tblEditable, nIndex)
.head 8 -  Set tblEditable.FuncActivity = 1
.head 7 +  Else
.head 8 -  Break
.head 5 +  ! On SAM_TooltipSetText
.head 6 -      Call XSalTooltipShow(pbMark,'Отметить выделенные')
.head 3 +  Pushbutton: pbDelete
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: RsButton
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.114"
.head 5 -  Top:    4.042"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Delrec.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nIndex = TBL_MinRow
.head 6 +  Loop
.head 7 +  If SalTblFindNextRow(tblEditable, nIndex, ROW_Selected, 0)
.head 8 -  Call SalTblDeleteRow(tblEditable, nIndex, TBL_NoAdjust)
.head 8 -  Set nIndex = nIndex - 1
.head 7 +  Else
.head 8 -  Break
.head 6 -  Call SalSetFocus(tblEditable)
.head 6 -  Call SalTblSetRowFlags (tblEditable, 0, ROW_Selected, TRUE)
.head 6 -  Call SalTblSetFocusRow(tblEditable,0)
.head 5 +  ! On SAM_TooltipSetText
.head 6 -      Call XSalTooltipShow(pbMark,'Отметить выделенные')
.head 3 +  Custom Control: ProgressMeter
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cMeter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title: Прогресс выполнения списка функий
.head 5 -  Window Location and Size
.head 6 -  Left:   6.683"
.head 6 -  Top:    1.155"
.head 6 -  Width:  3.5"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.5"
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
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
.head 5 -  Text Color: 3D Shadow Color
.head 5 -  Background Color: Class Default
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbStop
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Остановить
.head 4 -  Window Location and Size
.head 5 -  Left:   7.8"
.head 5 -  Top:    1.833"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set bFlag = FALSE
.head 3 +  Pushbutton: pbAccept
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: OK
.head 4 -  Window Location and Size
.head 5 -  Left:   7.8"
.head 5 -  Top:    1.833"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalHideWindow(pbAccept)
.head 6 -  Call SalHideWindow(ProgressMeter)
.head 6 -  Call SalShowWindow(tblAvailable)
.head 6 -  Call SalShowWindow(pbMoveToLeft)
.head 6 -  Call SalShowWindow(pbMoveToRight)
.head 6 -  Call SalShowWindow(pbMoveUp)
.head 6 -  Call SalShowWindow(pbMoveDown)
.head 6 -  Call SalShowWindow(pbDelete)
.head 6 -  Call SalShowWindow(pbMark)
.head 6 -  Call SalEnableWindow(tbSetAjustion)
.head 6 -  Call SalEnableWindow(tbSetExecution)
.head 6 -  Call SalEnableWindow(tbSetNew)
.head 6 -  Call SalEnableWindow(tbSetDelete)
.head 6 -  Call SalEnableWindow(tbFuncSearch)
.head 6 -  Call SalEnableWindow(tbExit)
.head 6 -  Set nIndex = TBL_MinRow
.head 6 +  Loop
.head 7 +  If SalTblFindNextRow(tblEditable, nIndex, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tblEditable, nIndex)
.head 8 -  Call SalTblSetContext(tblEditable , nIndex)
.head 8 -  Call SalTblSetCellTextColor(tblEditable.FuncStatus, COLOR_SysWindowText, FALSE)
.head 8 -  Set tblEditable.FuncStatus = 'Idle'
.head 7 +  Else
.head 8 -  Break
.head 6 -  Call SalHideWindow(tblEditable.FuncStatus)
.head 6 -  Call SalShowWindow(tblEditable.FuncComments)
.head 6 -  Call SalSetFocus(tblAvailable)
.head 6 -  Call SalTblSetRowFlags (tblSets, 0, ROW_Selected, TRUE)
.head 6 -  Call SalTblSetRowFlags (tblAvailable, 0, ROW_Selected, TRUE)
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nIndex
.head 3 -  Number: nPos
.head 3 -  Number: nFetchRes
.head 3 -  String: strText
.head 3 -  String: strTextName
.head 3 -  String: strTextComments
.head 3 -  Number: nNumber
.head 3 -  Number: nActionCode
.head 3 -  Number: nError
.head 3 -  Number: nErrorPos
.head 3 -  String: strReturn
.head 3 -  Number: nReturn
.head 3 -  Date/Time: dtReturn
.head 3 -  Window Handle: hWndReturn
.head 3 -  Number: nMax
.head 3 -  Boolean: bFlag
.head 3 -  : cMenu
.head 4 -  Class: cChildMenuEngine
.head 3 -  Number: nx
.head 3 -  Number: ny
.head 3 -  Number: nh
.head 3 -  Number: nw
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SalCenterWindow(fwListFuncSetAPI)
.head 4 -  Call tblSets.Constructor()
.head 4 -  Call SalTblSetContext(tblSets, 0)
.head 4 -  Call SalTblSetRowFlags(tblSets,0, ROW_Selected, TRUE)
.head 4 -  Call tblEditable.Constructor(tblSets.SetId)
.head 4 -  Call tblEditable.Fill()
.head 4 -  ! Get All function from QuaziListSet (id=-1) "AllFunctions"
.head 4 -  Call tblAvailable.Constructor(-1)
.head 4 -  Call tblAvailable.FillMinusSet(tblSets.SetId)
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call cMenu.Init(hWndForm,'menuListFuncSetAPI','Списки функций')
.head 4 -  ! Resizing initiation
.head 4 -  Set pbMoveToLeft.Parrent = fwListFuncSetAPI
.head 4 -  Set pbMoveToRight.Parrent = fwListFuncSetAPI
.head 4 -  Set pbMoveUp.Parrent = fwListFuncSetAPI
.head 4 -  Set pbMoveDown.Parrent = fwListFuncSetAPI
.head 4 -  Set pbDelete.Parrent = fwListFuncSetAPI
.head 4 -  Set pbMark.Parrent = fwListFuncSetAPI
.head 4 -  Set tblSets.Parrent = fwListFuncSetAPI
.head 4 -  Set tblEditable.Parrent = fwListFuncSetAPI
.head 4 -  Set tblAvailable.Parrent = fwListFuncSetAPI
.head 4 -  Set pbMoveToLeft.Current =pbMoveToLeft
.head 4 -  Set pbMoveToRight.Current = pbMoveToRight
.head 4 -  Set pbMoveUp.Current = pbMoveUp
.head 4 -  Set pbMoveDown.Current = pbMoveDown
.head 4 -  Set pbDelete.Current = pbDelete
.head 4 -  Set pbMark.Current = pbMark
.head 4 -  Set tblSets.Current = tblSets
.head 4 -  Set tblEditable.Current = tblEditable
.head 4 -  Set tblAvailable.Current = tblAvailable
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalTblSetRowFlags (tblAvailable, 0, ROW_Selected, TRUE)
.head 4 -  Call SalSetFocus(tblAvailable)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On WM_Size
.head 4 -  Call SalSendMsg(pbMoveToLeft,  UM_Align, 2222, 0)
.head 4 -  Call SalSendMsg(pbMoveToRight,  UM_Align, 2222, 0)
.head 4 -  Call SalSendMsg(pbMoveUp,  UM_Align, 2222, 0)
.head 4 -  Call SalSendMsg(pbMoveDown,  UM_Align, 2222, 0)
.head 4 -  Call SalSendMsg(pbDelete,  UM_Align, 2222, 0)
.head 4 -  Call SalSendMsg(pbMark,  UM_Align, 2222, 0)
.head 4 -  Call SalSendMsg(tblSets,  UM_Align, 2222, 0)
.head 4 -  Call SalSendMsg(tblAvailable,  UM_Align,2222, 0)
.head 4 -  Call SalSendMsg(tblEditable,  UM_Align,2222, 0)
.head 3 +  On SAM_Activate
.head 4 -  Call cMenu.Enable(wParam)
.head 3 +  On UM_MenuComponentShow
.head 4 -  Call cMenu.ShowMenu(wParam,lParam)
.head 3 +  On SAM_Destroy
.head 4 -  Call tblSets.Destructor()
.head 4 -  Call tblEditable.Destructor()
.head 4 -  Call tblAvailable.Destructor()
.head 4 -  Call cMenu.Kill()
.head 4 -  Set stListFuncSetAPI = FALSE
.head 4 -  Call SalSetFocus(SalParentWindow(hWndForm))
.head 1 +  Dialog Box: dbSetCreating
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Создание нового множества
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  6.571"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.26"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? No
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Purpose to get name and comments as parameter for creating set of function
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
.head 3 -  Frame
.head 4 -  Resource Id: 6521
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    0.071"
.head 5 -  Width:  6.314"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 -  Background Text: Наименование множества:
.head 4 -  Resource Id: 6522
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.283"
.head 5 -  Top:    0.179"
.head 5 -  Width:  5.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfNaming
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.283"
.head 6 -  Top:    0.405"
.head 6 -  Width:  5.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Комментарий:
.head 4 -  Resource Id: 6523
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.283"
.head 5 -  Top:    0.679"
.head 5 -  Width:  5.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfCommenting
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.283"
.head 6 -  Top:    0.905"
.head 6 -  Width:  5.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Создать
.head 4 -  Window Location and Size
.head 5 -  Left:   1.783"
.head 5 -  Top:    1.405"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Yes
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
.head 6 +  If dfNaming != ''
.head 7 -  Set strName = dfNaming
.head 7 -  Set strComments = dfCommenting
.head 7 -  Set nCode = 1
.head 7 -  Call SalEndDialog(dbSetCreating , 0)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.483"
.head 5 -  Top:    1.405"
.head 5 -  Width:  1.3"
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
.head 6 -  Set nCode = 0
.head 6 -  Call SalEndDialog(dbSetCreating , 0)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Receive String: strName
.head 3 -  Receive String: strComments
.head 3 -  Receive Number: nCode
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetFocus(dfNaming)
.head 4 -  Set nCode = 1
.head 1 +  Dialog Box: fwListFuncExecutor
.head 2 -  Class: cfwListFuncSetExec
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Class Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.625"
.head 4 -  Top:    0.625"
.head 4 -  Width:  6.52"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: 6.35"
.head 4 -  Height Editable? Class Default
.head 3 -  Absolute Screen Location? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 2 -  Description:
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
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Child Table: tblExecuted
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cfwListFuncSetExec
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    0.321"
.head 6 -  Width:  6.229"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 4.333"
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
.head 5 +  Column: FuncId
.head 6 -  Class Child Ref Key: 2
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cfwListFuncSetExec
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
.head 5 +  Column: FuncName
.head 6 -  Class Child Ref Key: 3
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cfwListFuncSetExec
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  4.043"
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
.head 5 +  Column: FuncActivity
.head 6 -  Class Child Ref Key: 4
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cfwListFuncSetExec
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  0.371"
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
.head 5 +  Column: FuncPosition
.head 6 -  Class Child Ref Key: 5
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cfwListFuncSetExec
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
.head 5 +  Column: FuncComments
.head 6 -  Class Child Ref Key: 6
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cfwListFuncSetExec
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
.head 5 +  Column: FuncCallString
.head 6 -  Class Child Ref Key: 7
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cfwListFuncSetExec
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
.head 5 +  Column: FuncStatus
.head 6 -  Class Child Ref Key: 8
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cfwListFuncSetExec
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  1.143"
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
.head 5 +  Column: FuncRoleName
.head 6 -  Class Child Ref Key: 13
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cfwListFuncSetExec
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
.head 3 +  Data Field: dfSetName
.head 4 -  Class Child Ref Key: 14
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cfwListFuncSetExec
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  6.229"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfSetComments
.head 4 -  Class Child Ref Key: 15
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cfwListFuncSetExec
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  6.229"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Custom Control: mProgressMeter
.head 4 -  Class Child Ref Key: 9
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cfwListFuncSetExec
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    4.726"
.head 6 -  Width:  6.229"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Yes
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
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbExecute
.head 4 -  Class Child Ref Key: 10
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cfwListFuncSetExec
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.55"
.head 5 -  Top:    5.393"
.head 5 -  Width:  Class Default
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
.head 6 -  Call SalSendClassMessage(SAM_Click, 0, 0)
.head 6 -  Call SalDisableWindow(cbChooseForAll)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 11
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cfwListFuncSetExec
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выйти
.head 4 -  Window Location and Size
.head 5 -  Left:   2.55"
.head 5 -  Top:    5.393"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 12
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cfwListFuncSetExec
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.55"
.head 5 -  Top:    5.393"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Check Box: cbChooseForAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Для всех
.head 4 -  Window Location and Size
.head 5 -  Left:   4.55"
.head 5 -  Top:    0.071"
.head 5 -  Width:  1.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nRow = TBL_MinRow
.head 6 +  While SalTblFindNextRow(tblExecuted, nRow, 0, 0)
.head 7 -  Call SalTblSetContext(tblExecuted, nRow)
.head 7 -  Set tblExecuted.FuncActivity = cbChooseForAll
.head 3 -  Frame
.head 4 -  Resource Id: 58454
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.017"
.head 5 -  Top:    5.25"
.head 5 -  Width:  6.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.78"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 58455
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.017"
.head 5 -  Top:    0.01"
.head 5 -  Width:  6.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 5.23"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nListID
.head 3 -  Boolean: fAutoRun
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Call SalCenterWindow(fwListFuncExecutor)
.head 4 -  Call fwListFuncExecutor.Constructor(nListID, fAutoRun)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call fwListFuncExecutor.ExecuteAccordingToMode()
.head 4 -  Call SalSetWindowText ( fwListFuncExecutor, dfSetComments )
.head 1 +  Dialog Box: REZAK
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
.head 4 -  Left:   0.5"
.head 4 -  Top:    0.5"
.head 4 -  Width:  7.7"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.208"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
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
.head 3 -  Group Box: Режимы и параметры архивации
.head 4 -  Resource Id: 57938
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.052"
.head 5 -  Width:  7.414"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 2.094"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Times New Roman
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 +  Data Field: Adat
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
.head 6 -  Left:   0.286"
.head 6 -  Top:    0.313"
.head 6 -  Width:  1.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.281"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If Adat>=GetBankDate()-7
.head 7 -  Call SalMessageBox('Опасная дата!','Внимание!',MB_Ok | MB_IconStop)
.head 7 -  Call SalMessageBeep(MB_IconStop)
.head 7 -  Call SalDisableWindow(pbOK)
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else If SalIsNull(Adat)
.head 7 -  Call SalMessageBox('Дата не задана!','Внимание!',MB_Ok | MB_IconStop)
.head 7 -  Call SalMessageBeep(MB_IconStop)
.head 7 -  Call SalDisableWindow(pbOK)
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else
.head 7 -  Call SalEnableWindow(pbOK)
.head 6 -  Set sDat=SalFmtFormatDateTime (Adat, 'dd/MM/yyyy')
.head 6 -  Return VALIDATE_Ok
.head 3 +  Data Field: dDBNAME
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
.head 6 -  Left:   2.886"
.head 6 -  Top:    0.323"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dHOST
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
.head 6 -  Left:   4.686"
.head 6 -  Top:    0.323"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Radio Button: rbARC_RRP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ARC_RRP
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    0.74"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Radio Button: rbOPER
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: OPER+OPLDOK
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    1.073"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Radio Button: rbSALDOA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: SALDOA
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    1.406"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Radio Button: rbAll
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Все
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    1.74"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Data Field: tBegin1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.886"
.head 6 -  Top:    0.74"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: DateTime
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: tEnd1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.686"
.head 6 -  Top:    0.74"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: DateTime
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: nRet1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.571"
.head 6 -  Top:    0.74"
.head 6 -  Width:  0.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: tBegin2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.886"
.head 6 -  Top:    1.073"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: DateTime
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: tEnd2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.686"
.head 6 -  Top:    1.073"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: DateTime
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: nRet2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.571"
.head 6 -  Top:    1.073"
.head 6 -  Width:  0.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: tBegin3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.886"
.head 6 -  Top:    1.406"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: DateTime
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: tEnd3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.686"
.head 6 -  Top:    1.406"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: DateTime
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: nRet3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.571"
.head 6 -  Top:    1.406"
.head 6 -  Width:  0.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: tBegin
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.886"
.head 6 -  Top:    1.74"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: DateTime
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: tEnd
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.686"
.head 6 -  Top:    1.74"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: DateTime
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: nRet
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.571"
.head 6 -  Top:    1.74"
.head 6 -  Width:  0.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   1.986"
.head 5 -  Top:    2.281"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Execute.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep (MB_IconAsterisk)
.head 6 +  If SalMessageBox ('Вы уверены, что хотите произвести архивацию данных с выбранными параметрами?',
'Внимание!', MB_IconAsterisk | MB_YesNo | MB_DefButton2) = IDYES
.head 7 +  If rbARC_RRP
.head 8 -  Call Arc(Adat)
.head 7 +  Else If rbOPER
.head 8 -  Call ArcOper(Adat)
.head 7 +  Else If rbSALDOA
.head 8 -  Call Arc_Sal(Adat)
.head 7 +  Else If rbAll
.head 8 -  Call ArcAll(Adat)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.0"
.head 5 -  Top:    2.281"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
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
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 +  Functions
.head 3 +  Function: Arc
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  Date/Time: Adat
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Date/Time: tBegin11
.head 5 -  Date/Time: tBegin12
.head 5 -  Date/Time: tBegin13
.head 5 -  Date/Time: tBegin14
.head 5 -  Date/Time: tEnd11
.head 5 -  Date/Time: tEnd12
.head 5 -  Date/Time: tEnd13
.head 5 -  Date/Time: tEnd14
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Set tBegin1=SalDateCurrent()
.head 5 -  Set tEnd1=DATETIME_Null
.head 5 -  Set nRet1=NUMBER_Null
.head 5 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 6 -  !
.head 6 -  Set tBegin11=SalDateCurrent()
.head 6 -  Call SqlPrepareAndExecute(hSql(), "set transaction use rollback segment R04")
.head 6 +  If not SqlPLSQLCommand(hSql(), "Arc1 (Adat,nRet1)")
.head 7 -  Set nRet1=-1
.head 6 +  Else
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Set tEnd11=SalDateCurrent()
.head 7 -  Call SaveFInfoToLog("Архивация-1 Arc_rrp по " || sDat ||
"(" ||
SalFmtFormatDateTime (tBegin11, 'dd/MM/yy-hh.mm.ss') ||
" - "||
SalFmtFormatDateTime (tEnd11, 'dd/MM/yy-hh.mm.ss') ||
")")
.head 6 -  !
.head 6 +  If nRet1=0
.head 7 -  Set tBegin12=SalDateCurrent()
.head 7 -  Call SqlPrepareAndExecute(hSql(), "set transaction use rollback segment R04")
.head 7 +  If not SqlPLSQLCommand(hSql(), "Arc2 (Adat,nRet1)")
.head 8 -  Set nRet1=-2
.head 7 +  Else
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Set tEnd12=SalDateCurrent()
.head 8 -  Call SaveFInfoToLog("Архивация-2 Arc_rrp по " || sDat ||
"(" ||
SalFmtFormatDateTime (tBegin12, 'dd/MM/yy-hh.mm.ss') ||
" - "||
SalFmtFormatDateTime (tEnd12, 'dd/MM/yy-hh.mm.ss') ||
")")
.head 7 -  ! Call Debug('Arc2 '||Str(nRet1))
.head 6 -  !
.head 6 +  If nRet1=0
.head 7 -  Set tBegin13=SalDateCurrent()
.head 7 -  Call SqlPrepareAndExecute(hSql(), "set transaction use rollback segment R04")
.head 7 +  If not SqlPLSQLCommand(hSql(), "Arc3 (Adat,nRet1)")
.head 8 -  Set nRet1=-3
.head 7 +  Else
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Set tEnd13=SalDateCurrent()
.head 8 -  Call SaveFInfoToLog("Архивация-3 Arc_rrp по "|| sDat ||
"(" ||
SalFmtFormatDateTime (tBegin13, 'dd/MM/yy-hh.mm.ss') ||
" - "||
SalFmtFormatDateTime (tEnd13, 'dd/MM/yy-hh.mm.ss') ||
")")
.head 7 -  ! Call Debug('Arc3 '||Str(nRet1))
.head 6 -  !
.head 6 +  If nRet1=0
.head 7 -  Set tBegin14=SalDateCurrent()
.head 7 -  Call SqlPrepareAndExecute(hSql(), "set transaction use rollback segment R04")
.head 7 +  If not SqlPLSQLCommand(hSql(), "Arc4 (Adat,nRet1)")
.head 8 -  Set nRet1=-4
.head 7 +  Else
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Set tEnd14=SalDateCurrent()
.head 8 -  Call SaveFInfoToLog("Архивация-4 Arc_rrp по "|| sDat  ||
"(" ||
SalFmtFormatDateTime (tBegin14, 'dd/MM/yy-hh.mm.ss') ||
" - "||
SalFmtFormatDateTime (tEnd14, 'dd/MM/yy-hh.mm.ss') ||
")")
.head 7 -  ! Call Debug('Arc4 '||Str(nRet1))
.head 6 -  !
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Set tEnd1=SalDateCurrent()
.head 5 -  ! Call DebugN(nRet)
.head 5 -  Return nRet1
.head 3 +  Function: ArcOper
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  Date/Time: Adat
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Set tBegin2=SalDateCurrent()
.head 5 -  Set tEnd2=DATETIME_Null
.head 5 -  Set nRet2=NUMBER_Null
.head 5 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 6 -  Call SqlPrepareAndExecute(hSql(),
"set transaction use rollback segment R04")
.head 6 +  If not SqlPLSQLCommand(hSql(), "ArcOper (Adat,nRet2)")
.head 7 -  Set nRet2=-1
.head 6 +  Else
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Set tEnd2=SalDateCurrent()
.head 7 -  Call SaveFInfoToLog(
"Архивация Oper+Opldok по " ||
sDat ||
"(" ||
SalFmtFormatDateTime (tBegin2, 'dd/MM/yy-hh.mm.ss') ||
" - "||
SalFmtFormatDateTime (tEnd2, 'dd/MM/yy-hh.mm.ss') ||
")"
)
.head 7 -  ! Set sDat=SalFmtFormatDateTime (tBegin2, 'dd/MM/yyyy')
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return nRet2
.head 3 +  Function: Arc_Sal
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  Date/Time: Adat
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Set tBegin3=SalDateCurrent()
.head 5 -  Set tEnd3=DATETIME_Null
.head 5 -  Set nRet3=NUMBER_Null
.head 5 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 6 +  If not SqlPLSQLCommand(hSql(), "Arc_Sal (Adat,nRet3)")
.head 7 -  Set nRet3=-1
.head 6 +  Else
.head 7 -  Call SaveFInfoToLog('Архивация Saldoa по '|| sDat)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Set tEnd3=SalDateCurrent()
.head 5 -  ! Call DebugN(nRet)
.head 5 -  Return nRet3
.head 3 -  !
.head 3 +  Function: ArcAll
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  Date/Time: Adat
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRet
.head 4 +  Actions
.head 5 -  Set tBegin=SalDateCurrent()
.head 5 -  Set tEnd=DATETIME_Null
.head 5 -  Set nRet=NUMBER_Null
.head 5 -  !
.head 5 -  Set tBegin1=DATETIME_Null
.head 5 -  Set tEnd1=DATETIME_Null
.head 5 -  Set nRet1=NUMBER_Null
.head 5 -  !
.head 5 -  Set tBegin2=DATETIME_Null
.head 5 -  Set tEnd2=DATETIME_Null
.head 5 -  Set nRet2=NUMBER_Null
.head 5 -  !
.head 5 -  Set tBegin3=DATETIME_Null
.head 5 -  Set tEnd3=DATETIME_Null
.head 5 -  Set nRet3=NUMBER_Null
.head 5 -  !
.head 5 -  Call Arc(Adat)
.head 5 +  If nRet1=0
.head 6 -  !
.head 6 -  Call ArcOper(Adat)
.head 6 +  ! If nRet2=0
.head 7 -  !
.head 7 -      Call Arc_Sal(Adat)
.head 5 -  Set tEnd=SalDateCurrent()
.head 5 -  Return nRet
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: sDat
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set Adat=GetBankDate()-8
.head 4 -  Set dDBNAME=GetDbs()
.head 4 -  Set dHOST=GetHost()
.head 1 +  Dialog Box: FormNlsZ
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Формирование перечня закрытых счетом эл.клиентам (авто)
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   2.638"
.head 4 -  Top:    1.104"
.head 4 -  Width:  6.917"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.202"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
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
.head 3 +  Multiline Field: mlText
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1024
.head 5 -  String Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? No
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   1.383"
.head 6 -  Top:    3.988"
.head 6 -  Width:  5.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.417"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbRun
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    3.988"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.81"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\INDEXGO.BMP
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Periwinkle
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set sFile = VisDosGetEnvString('TEMP') || '\\' || sFile3
.head 6 -  Call SalHideWindow(cc1)
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Set mlText = 'Формирование перечня закрытых счетов ...'
.head 6 +  If SqlPrepareAndExecute(hSql(), T("
   DELETE
   FROM tmp_sab"))
.head 7 -  Call SqlCommit(hSql())
.head 6 -  Set nRow = TBL_MinRow
.head 6 +  While SalTblFindNextRow(tbl1, nRow, 0, 0)
.head 7 -  Call SalTblSetContext(tbl1, nRow)
.head 7 +  If tbl1.colOTM = '1'
.head 8 -  Call SqlPrepareAndExecute(hSql(), T("
     INSERT
     INTO tmp_sab (sab)
     VALUES (:tbl1.colSAB)"))
.head 6 -  Call SqlCommit(hSql())
.head 6 -  ! вариант по всем SABам
.head 6 -  Set nKwo = 0
.head 6 -  Set bFL = TRUE
.head 6 +  If SqlPrepareAndExecute(hSql(), "
   SELECT DISTINCT count(*)
   INTO :nKwo
   FROM accounts_update au, banks b, bank_acc ba, tmp_sab t, accounts a
   WHERE au.acc=ba.acc and b.mfo=ba.mfo and au.kv=980 and au.dazs is not null and
         (au.nbs2 is null or au.nbs2<>'done') and a.acc=au.acc and
         a.dazs is not null and b.fmi='$A' and b.fmo='$B' and b.kodn=4 and
         b.blk<>2 and b.blk<>3 and b.blk<>9 and b.sab=t.sab")
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 6 +  Else
.head 7 -  Set bFL = FALSE
.head 6 +  If bFL and nKwo > 0
.head 7 -  Set nPos = 0
.head 7 -  Set nDelta = 100 / nKwo
.head 7 +  If File(sFile)
.head 8 -  Set nI = 0
.head 8 +  While not SalFileOpen(hF, sFile, OF_Delete)
.head 9 -  Set nI = nI + 1
.head 9 +  If nI > 5
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call MessageNoWait('Невозможно сформировать файл ' || sFile ||
     ', возможно он занят другим приложением.', 'ВНИМАНИЕ !!!', 0, 1)
.head 10 -  Set mlText = ''
.head 10 -  Return 0
.head 7 +  If SalFileOpen(hF, sFile, OF_Create | OF_Write)
.head 8 -  Set bFL = TRUE
.head 8 -  Call SaveInfoToLog('Open File: ' || sFile)
.head 8 +  If bFL
.head 9 -  Call SqlPrepareAndExecute(hSqlAux(), "
     DELETE
     FROM acc_nlsz")
.head 9 -  Set bFL = SqlPrepareAndExecute(hSql(), "
    SELECT DISTINCT a.acc, b.sab, a.nls
    INTO :nAcc,:sSab,:sNls
    FROM accounts_update au, banks b, bank_acc ba, tmp_sab t, accounts a
    WHERE au.acc=ba.acc and b.mfo=ba.mfo and au.kv=980 and
          au.dazs is not null and (au.nbs2 is null or au.nbs2<>'done') and
          a.acc=au.acc and a.dazs is not null and b.fmi='$A' and b.fmo='$B' and
          b.kodn=4 and b.blk<>2 and b.blk<>3 and b.blk<>9 and b.sab=t.sab
    ORDER by 2,3")
.head 8 +  If bFL
.head 9 -  Call SalShowWindow(cc1)
.head 9 -  Set sBuffer = ''
.head 9 -  ! Set sAcc = ''
.head 9 +  While SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Call cc1.SetProgress(nPos)
.head 10 -  Call SalUpdateWindow(hWndForm)
.head 10 -  Set sBuffer = sBuffer || PadR(sSab, 4) || SalStrTrimX(sNls) || PutLf()
.head 10 -  ! Set sAcc = sAcc || Str(nAcc) || ','
.head 10 -  Call SqlPrepareAndExecute(hSqlAux(), "
     INSERT
     INTO acc_nlsz (acc)
     VALUES (:nAcc)")
.head 10 +  If Len(sBuffer) > 64000
.head 11 -  Set bFL = SalFileWrite(hF, sBuffer, Len(sBuffer)) = Len(sBuffer)
.head 11 -  Call SaveInfoToLog('Write File: ' || Str(Len(sBuffer)))
.head 11 -  Set sBuffer = ''
.head 10 +  Else
.head 11 -  Set bFL = TRUE
.head 10 +  If not bFL
.head 11 -  Break
.head 10 -  Set nPos = nPos + nDelta
.head 9 -  ! Set sAcc = Left(sAcc, Len(sAcc)-1)
.head 9 +  If bFL
.head 10 -  ! Call SqlCommit(hSqlA)
.head 10 +  If Len(sBuffer) > 0
.head 11 -  Set bFL = SalFileWrite(hF, sBuffer, Len(sBuffer)) = Len(sBuffer)
.head 11 -  Call SaveInfoToLog('Write File: ' || Str(Len(sBuffer)) || ' - end')
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SaveInfoToLog('Close File: ' || sFile)
.head 10 -  Call cc1.SetProgress(100)
.head 9 +  Else
.head 10 -  Call SalFileClose(hF)
.head 10 -  Call SaveInfoToLog('Close File (error 2): ' || sFile)
.head 10 -  Call VisFileDelete(sFile)
.head 10 -  Set mlText = 'Ошибка 2 (запись строки) формирования перечня закрытых счетов.'
.head 8 +  If bFL
.head 9 +  If File(sFile)
.head 10 -  Call SalFileCopy(sFile, sBackDocPath || sFile4, TRUE)
.head 10 +  If SqlPrepareAndExecute(hSql(), "
   UPDATE accounts_update
   SET nbs2='done'
   WHERE dazs is not null and acc in (SELECT acc
                                      FROM acc_nlsz)")
.head 11 -  Call SqlCommit(hSql())
.head 10 -  Call SaveInfoToLog('Copy File: ' || sFile || ' to ' || sBackDocPath || sFile4)
.head 10 -  Set mlText = 'Отбор перечня закрытых счетов закончен.'
.head 8 +  Else
.head 9 +  If File(sFile)
.head 10 -  Call VisFileDelete(sFile)
.head 10 -  Call SaveInfoToLog('Delete File: ' || sFile)
.head 10 -  Set mlText = 'Ошибка 3 (запись файла) формирования перечня закрытых счетов.'
.head 6 +  Else
.head 7 -  Set mlText = 'Ошибка 1 (нет информации) формирования перечня закрытых счетов.'
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SalTimerKill(hWndItem, 1)
.head 6 -  Call SalTimerSet(pbExit, 2, 7000)
.head 5 +  On SAM_Create
.head 6 -  Call SalTimerSet(hWndItem, 1, nTimeVW*1000)
.head 5 +  On SAM_Timer
.head 6 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Exit
.head 4 -  Window Location and Size
.head 5 -  Left:   3.183"
.head 5 -  Top:    0.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalTimerKill(hWndItem, 2)
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  On SAM_Timer
.head 6 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.05"
.head 6 -  Top:    0.012"
.head 6 -  Width:  6.733"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.917"
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
.head 5 +  Column: colOTM
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Отм.
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.533"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_Click
.head 8 -  Call SalTimerKill(pbRun, 1)
.head 8 -  Call SalTimerSet(pbRun, 1, nTimeVW*1000)
.head 5 +  Column: colSAB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 4
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.6"
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
.head 5 +  Column: colNMK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 38
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.867"
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
.head 5 +  Column: colMFOSAB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: МФО
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Right
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
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call WaitCursorOn()
.head 6 -  Call SalTblPopulate(tbl1, hSql(), T("
     SELECT '1',sab,nb,mfo
     FROM banks
     INTO :tbl1.colOTM,:tbl1.colSAB,:tbl1.colNMK,:tbl1.colMFOSAB
     WHERE kodn=4 and blk<>2 and blk<>3 and blk<>9 and fmi='$A' and fmo='$B'
     ORDER BY sab"), TBL_FillAll)
.head 6 -  Call WaitCursorOff()
.head 3 +  Custom Control: cc1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cMeter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.383"
.head 6 -  Top:    4.488"
.head 6 -  Width:  5.4"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.333"
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
.head 5 -  Text Color: Dark Gray
.head 5 -  Background Color: Light Gray
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: LenArray
.head 4 -  Description: возвращает длину одномерного массива строк
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  String: smArr[*]
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nBound
.head 4 +  Actions
.head 5 -  Call SalArrayGetUpperBound(smArr, 1, nBound)
.head 5 -  Return nBound
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nUid
.head 3 -  Date/Time: dYes
.head 3 -  String: sFile3
.head 3 -  String: sFile4
.head 3 -  String: sBackDocPath
.head 3 -  Boolean: bOk
.head 3 -  Number: nKwo
.head 3 -  String: sFile
.head 3 -  Number: nI
.head 3 -  File Handle: hF
.head 3 -  String: sOdir
.head 3 -  File Handle: hSqlA
.head 3 -  Boolean: bFL
.head 3 -  String: sNLSK
.head 3 -  String: sSAB
.head 3 -  String: sNLS
.head 3 -  String: sNAMS
.head 3 -  String: sNMK
.head 3 -  String: sMFO
.head 3 -  Number: nMFO
.head 3 -  String: sND
.head 3 -  Number: nISP
.head 3 -  Number: nEL
.head 3 -  Number: nNM
.head 3 -  Number: nNP
.head 3 -  Number: nVOB
.head 3 -  Number: nDK
.head 3 -  Number: nS
.head 3 -  Date/Time: dDAOPL
.head 3 -  Number: nISM
.head 3 -  Date/Time: dDAPP
.head 3 -  String: sNAZ
.head 3 -  String: sPOND
.head 3 -  String: sFN_A
.head 3 -  String: sD_REC
.head 3 -  Number: nRNK
.head 3 -  String: sKOKK
.head 3 -  String: sTD
.head 3 -  Number: nISPZ
.head 3 -  Number: nREF
.head 3 -  String: sPOLU
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Number: nTimeVW
.head 3 -  String: sTimeVW
.head 3 -  !
.head 3 -  Number: nPos
.head 3 -  Number: nDelta
.head 3 -  !
.head 3 -  String: sRBSName
.head 3 -  !
.head 3 -  Number: nMinusA3
.head 3 -  ! !
.head 3 -  String: sSAB_tmp
.head 3 -  String: sMFOSAB
.head 3 -  Boolean: bNBU
.head 3 -  Boolean: bBeg1
.head 3 -  Boolean: bBeg2
.head 3 -  Boolean: bBeg3
.head 3 -  !
.head 3 -  String: sWText
.head 3 -  !
.head 3 -  String: sBuffer
.head 3 -  !
.head 3 -  Number: nAcc
.head 3 -  ! String: sAcc
.head 3 -  String: sSab
.head 3 -  String: sNls
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalHideWindow(cc1)
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set nUid = GetUserId()
.head 4 -  Set dYes = GetBankDate()
.head 4 -  Set sFile3 = 'IdksZ_.Txt'
.head 4 -  Set sFile4 = 'IdksZ.Txt'
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('ElektroKlients', 'BackDocPath', GetPrnDir(), sBackDocPath,
     GetIniFileName())
.head 4 -  Set sBackDocPath = IifS(Right(sBackDocPath, 1)='\\', sBackDocPath, sBackDocPath || '\\')
.head 4 -  Call SalGetProfileString('ElektroKlients', 'TimeVW', '30', sTimeVW, GetIniFileName())
.head 4 -  Set nTimeVW = Min(Max(Val(sTimeVW), 0), 65)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSetFocus(tbl1)
.head 4 -  Call SalTblSetFocusCell(tbl1, 0, tbl1.colOTM, 0, 1)
.head 1 +  Dialog Box: FormVWa
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Формирование выписок эл.клиентам (автомат)
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   2.638"
.head 4 -  Top:    1.104"
.head 4 -  Width:  9.8"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.202"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
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
.head 3 +  Multiline Field: mlText
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1024
.head 5 -  String Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? No
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   6.483"
.head 6 -  Top:    2.571"
.head 6 -  Width:  3.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.0"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbRun
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   7.483"
.head 5 -  Top:    1.655"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.81"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\INDEXGO.BMP
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Green
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTimerKill(hWndItem, 1)
.head 6 -  Call SalDisableWindow(tbl1)
.head 6 -  ! Set sFile = sBackDocPath || sFile1
.head 6 -  Set sFile = IifS(bNBU, sBackDocPath || sFile1, VisDosGetEnvString('TEMP') || '\\' ||
    sFile3)
.head 6 -  Call SalHideWindow(cc1)
.head 6 -  Set mlText = 'Отбор выписок за ' || Str(SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) || ' г. ...'
.head 6 +  If SqlPrepareAndExecute(hSql(), T("
   DELETE
   FROM tmp_sab"))
.head 7 -  Call SqlCommit(hSql())
.head 6 -  Set nRow = TBL_MinRow
.head 6 -  Set nInd = 0
.head 6 +  While SalTblFindNextRow(tbl1, nRow, 0, 0)
.head 7 -  Call SalTblSetContext(tbl1, nRow)
.head 7 +  If tbl1.colOTM = '1'
.head 8 -  Call SqlPrepareAndExecute(hSql(), T("
     INSERT
     INTO tmp_sab (sab)
     VALUES (:tbl1.colSAB)"))
.head 8 -  Set sSelectSAB[nInd] = tbl1.colSAB
.head 8 -  Set sSelectMFOSAB[nInd] = tbl1.colMFOSAB
.head 8 -  Set nInd = nInd + 1
.head 6 -  Call SqlCommit(hSql())
.head 6 +  If bNBU
.head 7 +  If SqlPrepareAndExecute(hSql(), T("
   DELETE
   FROM tmp_lick
   WHERE id=:nUid"))
.head 8 -  Call SqlCommit(hSql())
.head 7 -  Set bOk = TRUE
.head 7 -  Set nKwo = 0
.head 7 -  Set sRBSName = GetGlobalOption('BIG_SEG')
.head 7 -  Call SaveInfoToLog('Имя роллбэк-сегмента sRBSName = ' || sRBSName)
.head 7 +  If sRBSName
.head 8 -  ! Make end of transaction and start new
.head 8 -  Call SqlCommit(hSql())
.head 8 -  ! to avoid error with set transaction...
.head 8 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 8 -  ! Call SaveInfoToLog('Установка роллбэк-сегмента 1')
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 -  ! Call SalMessageBox('Begin exe p_lick','AT',0)
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 +  If SqlPLSQLCommand(hSql(), "p_lick(nUid,dYes)")
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT count(*)
     FROM tmp_lick
     INTO :nKwo
     WHERE id=:nUid"))
.head 8 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set bOk = nKwo>0
.head 8 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 8 -  ! Call SalMessageBox('END execute p_lick','AT',0)
.head 8 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 +  Else
.head 8 -  Set bOk = FALSE
.head 7 +  If bOk
.head 8 -  Set nPos = 0
.head 8 -  Set nDelta = 100 / nKwo
.head 8 +  If File(sFile)
.head 9 -  Set nI = 0
.head 9 +  While not SalFileOpen(hF, sFile, OF_Delete)
.head 10 -  Set nI = nI + 1
.head 10 +  If nI > 5
.head 11 -  Set mlText = ''
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call SalMessageBeep(-1)
.head 11 -  Call SalMessageBeep(-1)
.head 11 -  Call SalMessageBeep(-1)
.head 11 -  Call SalMessageBeep(-1)
.head 11 -  Call SalMessageBeep(-1)
.head 11 -  Call SalMessageBeep(-1)
.head 11 -  Call SalMessageBeep(-1)
.head 11 -  Call MessageNoWait('Невозможно сформировать файл ' || sFile ||
     ', возможно он занят другим приложением.', 'ВНИМАНИЕ !!!', 0, 1)
.head 11 -  Call SalTimerSet(pbExit, 2, 1)
.head 11 -  Return 0
.head 8 -  Call SalFileGetCurrentDirectory(sOdir)
.head 8 -  Call SalFileSetCurrentDirectory(Left(sBackDocPath, Len(sBackDocPath)-1))
.head 8 -  Set SqlDatabase = 'dBase_Files'
.head 8 -  ! родить VWABS.Dbf
.head 8 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 8 -  ! Call SalMessageBox('INCOME TO retrieve from tmp_lick','AT',0)
.head 8 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 8 +  If SqlConnect(hSqlA)
.head 9 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    CREATE
    TABLE " || sFile1 || " (SAB     CHAR(4),
                            NLS     CHAR(14),
                            NLSK    CHAR(14),
                            NAMS    CHAR(38),
                            NMK     CHAR(38),
                            MFO     NUMBER(9),
                            ND      CHAR(10),
                            ISP     NUMBER(3),
                            EL      NUMBER(1),
                            NM      NUMBER(1),
                            NP      NUMBER(3),
                            VOB     NUMBER(3),
                            DK      NUMBER(1),
                            S       NUMBER(16),
                            DAOPL   DATE,
                            ISM     NUMBER(16),
                            DAPP    DATE,
                            NAZ     CHAR(160),
                            POND    CHAR(10),
                            FN_A    CHAR(12),
                            D_REC   CHAR(60),
                            RNK     NUMBER(10),
                            KOKK    CHAR(14),
                            TD      CHAR(2),
                            ISPZ    NUMBER(3),
                            REF     NUMBER(10),
                            POLU    CHAR(38),
                            MINUSA3 NUMBER(16))")
.head 9 +  If sRBSName
.head 10 -  ! Make end of transaction and start new
.head 10 -  Call SqlCommit(hSql())
.head 10 -  ! to avoid error with set transaction...
.head 10 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 10 -  ! Call SaveInfoToLog('Установка роллбэк-сегмента 2')
.head 9 +  If bFL
.head 10 -  Set bFL = SqlPrepareAndExecute(hSql(), "
    SELECT sab,nls,nlsk,nams,nmk,mfo,nd,isp,el,nm,np,vob,dk,s,daopl,ism,dapp,
           naz,pond,fn_a,d_rec,rnk,kokk,td,ispz,ref,polu,minusa3
    INTO :sSAB,:sNLS,:sNLSK,:sNAMS,:sNMK,:sMFO,:sND,:nISP,:nEL,:nNM,:nNP,
         :nVOB,:nDK,:nS,:dDAOPL,:nISM,:dDAPP,:sNAZ,:sPOND,:sFN_A,:sD_REC,
         :nRNK,:sKOKK,:sTD,:nISPZ,:nREF,:sPOLU,:nMinusA3
    FROM tmp_lick
    WHERE id=:nUid")
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 -  ! Call SalMessageBox('EXIT FROM retrieve from tmp_lick','AT',0)
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 +  If bFL
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  ! Call SalMessageBox('BEGIN INSERT daopl','AT',0)
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || " (DAOPL)
    VALUES (:dYes)")
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  ! Call SalMessageBox('END INSERT daopl','AT',0)
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 +  If not bFL
.head 11 -  Call SqlRollback(hSqlA)
.head 11 -  Set mlText = 'Ошибка 0 (внесение служебной записи) отбора выписок за ' ||
    Str(SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 10 +  Else
.head 11 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 11 -  ! Call SalMessageBox('BEGIN INSERT *.dbf','AT',0)
.head 11 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 11 -  Call SalShowWindow(cc1)
.head 11 +  While SqlFetchNext(hSql(), nFetchRes)
.head 12 -  Call cc1.SetProgress(nPos)
.head 12 -  Set sNLSK = IifS(Len(SalStrTrimX(sNLSK))=0, '0', sNLSK)
.head 12 -  Set sNAMS = StrWinToDosX2(sNAMS)
.head 12 -  Set sNMK = StrWinToDosX2(sNMK)
.head 12 -  Set nMFO = Val(sMFO)
.head 12 -  Set sND = StrWinToDosX2(sND)
.head 12 -  Set nISP = Mod(nISP, 100)
.head 12 -  Set sNAZ = StrWinToDosX2(sNAZ)
.head 12 -  Set sD_REC = StrWinToDosX2(sD_REC)
.head 12 -  Set nISPZ = Mod(nISPZ, 100)
.head 12 -  Set sPOLU = StrWinToDosX2(sPOLU)
.head 12 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || "
    VALUES (:sSAB,:sNLS,:sNLSK,:sNAMS,:sNMK,:nMFO,:sND,:nISP,:nEL,:nNM,
            :nNP,:nVOB,:nDK,:nS,:dDAOPL,:nISM,:dDAPP,:sNAZ,:sPOND,:sFN_A,
            :sD_REC,:nRNK,:sKOKK,:sTD,:nISPZ,:nREF,:sPOLU,:nMinusA3)")
.head 12 +  If not bFL
.head 13 -  Break
.head 12 +  Else
.head 13 -  Call SaveInfoToLog('INSERT into DBF: ' || PadR(sNLS, 14) || ' ' ||
     Str(nMFO) || ' ' || PadR(sNLSK, 14) || ' ' || PadL(
     Str(nS/100), 20))
.head 12 -  Set nPos = nPos + nDelta
.head 11 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 11 -  ! Call SalMessageBox('END INSERT *.dbf','AT',0)
.head 11 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 11 +  If bFL
.head 12 -  Call SqlCommit(hSqlA)
.head 12 -  Call cc1.SetProgress(100)
.head 12 -  Set mlText = 'Выписки за ' || Str(SalDateDay(dYes)) || ' ' ||
    GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' || Str(
    SalDateYear(dYes)) || ' г. отобраны.'
.head 11 +  Else
.head 12 -  Call SqlRollback(hSqlA)
.head 12 -  Set mlText = 'Ошибка 2 (запись строки) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE)
    || ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 9 -  Call SqlDisconnect(hSqlA)
.head 9 +  If bFL
.head 10 +  If File(sFile)
.head 11 -  Call SalFileCopy(sFile, sBackDocPath || sFile2, TRUE)
.head 9 +  Else
.head 10 +  If File(sFile)
.head 11 -  Call SalFileOpen(hF, sFile, OF_Delete)
.head 8 -  Call SalFileSetCurrentDirectory(sOdir)
.head 7 +  Else
.head 8 -  Set mlText = 'Ошибка 1 (нет информации) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' '
    || Str(SalDateYear(dYes)) || ' г.'
.head 6 +  Else ! Treasury
.head 7 -  Set nVWABS = IifN(rb0, 0, IifN(rb1, 1, IifN(rb2, 2, IifN(rb3, 3, IifN(rb4, 4, 5)))))
.head 7 -  Call SalSetWindowText(hWndForm, sWText || ' ' ||
     IifS(nVWABS=2 or nVWABS=3 or nVWABS=5, 'One', 'All') ||
     IifS(nVWABS=0 or nVWABS=2, '', '+' || IifS(nVWABS>3, 'Deb.', '') || 'Info'))
.head 7 +  If nVWABS = 2 or nVWABS = 3 or nVWABS = 5
.head 8 -  ! вариант по одному SAB
.head 8 -  Set nInd = 0
.head 8 -  Set bBeg1 = TRUE
.head 8 -  Set bBeg2 = TRUE
.head 8 -  Set bBeg3 = TRUE
.head 8 +  While nInd <= LenArray(sSelectSAB)
.head 9 -  Set sSAB_tmp = sSelectSAB[nInd]
.head 9 -  Set sMFOSAB = sSelectMFOSAB[nInd]
.head 9 -  ! Set dfSAB = sSAB_tmp
.head 9 -  Set mlText = 'Отбор выписок за ' || Str(SalDateDay(dYes)) || ' ' ||
    GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes))
    || ' г. ... (' || sSAB_tmp || ')'
.head 9 -  Call SaveInfoToLog(mlText)
.head 9 +  If sRBSName
.head 10 -  ! Make end of transaction and start new
.head 10 -  Call SqlCommit(hSql())
.head 10 -  ! to avoid error with set transaction...
.head 10 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 10 -  ! Call SaveInfoToLog('Установка роллбэк-сегмента 1')
.head 9 +  If SqlPrepareAndExecute(hSql(), T("
   DELETE
   FROM tmp_lick
   WHERE id=:nUid"))
.head 10 -  Call SqlCommit(hSql())
.head 9 -  Set bOk = TRUE
.head 9 -  Set nKwo = 0
.head 9 +  If sRBSName
.head 10 -  ! Make end of transaction and start new
.head 10 -  Call SqlCommit(hSql())
.head 10 -  ! to avoid error with set transaction...
.head 10 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 10 -  ! Call SaveInfoToLog('Установка роллбэк-сегмента 1')
.head 9 +  If SqlPLSQLCommand(hSql(), "p_lick1" || IifS(nVWABS=2, '',
   IifS(nVWABS=3, 'i', 'd')) || "(nUid,dYes,sSAB_tmp,sMFOSAB)")
.head 10 -  Call SqlCommit(hSql())
.head 10 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT count(*)
     FROM tmp_lick
     INTO :nKwo
     WHERE id=:nUid"))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Set bOk = nKwo>0
.head 10 -  Call SalShowWindow(cc1)
.head 9 +  Else
.head 10 -  Set bOk = FALSE
.head 9 +  If bOk
.head 10 -  Set nPos = 0
.head 10 -  Set nDelta = 100 / nKwo
.head 10 +  If bBeg1
.head 11 +  If File(sFile)
.head 12 -  Set nI = 0
.head 12 +  While not SalFileOpen(hF, sFile, OF_Delete)
.head 13 -  Set nI = nI + 1
.head 13 +  If nI > 5
.head 14 -  Call SalWaitCursor(FALSE)
.head 14 -  Call MessageNoWait('Невозможно сформировать файл ' || sFile ||
     ', возможно он занят другим приложением.', 'ВНИМАНИЕ !!!', 0, 1)
.head 14 -  Set mlText = ''
.head 14 -  Return 0
.head 11 -  Set bBeg1 = FALSE
.head 10 -  ! Call SalFileGetCurrentDirectory(sOdir)
.head 10 -  ! Call SalFileSetCurrentDirectory(Left(sBackDocPath, Len(sBackDocPath)-1))
.head 10 -  ! Set SqlDatabase = 'dBase_Files'
.head 10 -  ! родить VWABS.Txt (было VWABS.Dbf)
.head 10 +  If TRUE ! SqlConnect(hSqlA)
.head 11 +  If bBeg2
.head 12 -  ! Set bFL = SqlPrepareAndExecute(hSqlA, "
    CREATE
    TABLE " || sFile1 || " (SAB     CHAR(4),
                            NLS     CHAR(14),
                            NLSK    CHAR(14),
                            NAMS    CHAR(38),
                            NMK     CHAR(38),
                            MFO     NUMBER(9),
                            ND      CHAR(10),
                            ISP     NUMBER(3),
                            EL      NUMBER(1),
                            NM      NUMBER(1),
                            NP      NUMBER(3),
                            VOB     NUMBER(3),
                            DK      NUMBER(1),
                            S       NUMBER(16),
                            DAOPL   DATE,
                            ISM     NUMBER(16),
                            DAPP    DATE,
                            NAZ     CHAR(160),
                            POND    CHAR(10),
                            FN_A    CHAR(12),
                            D_REC   CHAR(60),
                            RNK     NUMBER(10),
                            KOKK    CHAR(14),
                            TD      CHAR(2),
                            ISPZ    NUMBER(3),
                            REF     NUMBER(10),
                            POLU    CHAR(38),
                            MINUSA3 NUMBER(16))")
.head 12 -  Set bFL = SalFileOpen(hF, sFile, OF_Create | OF_Write)
.head 12 -  Set bBeg2 = not bFL
.head 12 -  Call SaveInfoToLog('Open File: ' || sFile)
.head 11 +  Else
.head 12 -  Set bFL = TRUE
.head 11 +  If sRBSName
.head 12 -  ! Make end of transaction and start new
.head 12 -  Call SqlCommit(hSql())
.head 12 -  ! to avoid error with set transaction...
.head 12 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT '
     || SalStrUpperX(sRBSName))
.head 12 -  ! Call SaveInfoToLog('Установка роллбэк-сегмента 2')
.head 11 +  If bFL
.head 12 -  Set bFL = SqlPrepareAndExecute(hSql(), "
    SELECT sab,nls,nlsk,nams,nmk,mfo,nd,isp,el,nm,np,vob,dk,s,daopl,ism,
           dapp,naz,pond,fn_a,d_rec,rnk,kokk,td,ispz,ref,polu,minusa3
    INTO :sSAB,:sNLS,:sNLSK,:sNAMS,:sNMK,:sMFO,:sND,:nISP,:nEL,:nNM,:nNP,
         :nVOB,:nDK,:nS,:dDAOPL,:nISM,:dDAPP,:sNAZ,:sPOND,:sFN_A,:sD_REC,
         :nRNK,:sKOKK,:sTD,:nISPZ,:nREF,:sPOLU,:nMinusA3
    FROM tmp_lick
    WHERE id=:nUid")
.head 11 +  If bFL
.head 12 +  If bBeg3
.head 13 -  ! Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || " (DAOPL)
    VALUES (:dYes)")
.head 13 -  Set bFL = SalFileWrite(hF,
    PadL(DtoS(dYes), 163) || PutCrLf(), 165) = 165
.head 13 -  Set bBeg3 = not bFL
.head 13 -  Call SaveInfoToLog('Write File: 165 - begin')
.head 12 +  Else
.head 13 -  Set bFL = TRUE
.head 12 +  If not bFL
.head 13 -  ! Call SqlRollback(hSqlA)
.head 13 -  Call SalFileClose(hF)
.head 13 -  Call SaveInfoToLog('Close File: (error 0) ' || sFile)
.head 13 -  Call VisFileDelete(sFile)
.head 13 -  Call SaveInfoToLog('Delete File: ' || sFile)
.head 13 -  Set mlText = 'Ошибка 0 (внесение служебной записи) отбора выписок за '
    || Str(SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 12 +  Else
.head 13 -  Set sBuffer = ''
.head 13 +  While SqlFetchNext(hSql(), nFetchRes)
.head 14 -  Call cc1.SetProgress(nPos)
.head 14 -  Call SalUpdateWindow(hWndForm)
.head 14 -  Set sNLSK = IifS(Len(SalStrTrimX(sNLSK))=0, '0', sNLSK)
.head 14 -  Set sNAMS = StrWinToDosX2(sNAMS)
.head 14 -  Set sNMK = StrWinToDosX2(sNMK)
.head 14 -  Set nMFO = Val(sMFO)
.head 14 -  Set sND = StrWinToDosX2(sND)
.head 14 -  Set nISP = Mod(nISP, 100)
.head 14 -  Set sNAZ = StrWinToDosX2(sNAZ)
.head 14 -  Set sD_REC = StrWinToDosX2(sD_REC)
.head 14 -  Set nISPZ = Mod(nISPZ, 100)
.head 14 -  Set sPOLU = StrWinToDosX2(sPOLU)
.head 14 -  ! Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || "
    VALUES (:sSAB,:sNLS,:sNLSK,:sNAMS,:sNMK,:nMFO,:sND,:nISP,:nEL,
            :nNM,:nNP,:nVOB,:nDK,:nS,:dDAOPL,:nISM,:dDAPP,:sNAZ,
            :sPOND,:sFN_A,:sD_REC,:nRNK,:sKOKK,:sTD,:nISPZ,:nREF,
            :sPOLU,:nMinusA3)")
.head 14 -  Set sBuffer = sBuffer || PadR(sSAB, 4) || PadR(sNLS, 14) ||
    PadR(sNLSK, 14) || PadR(sNAMS, 38) || PadR(sNMK, 38) || PadL(
    Str(nMFO), 9) || PadR(sND, 10) || PadL(Str(nISP), 3) || PadL(
    Str(nEL), 1) || PadL(Str(nNM), 1) || PadL(Str(nNP), 3) || PadL(
    Str(nVOB), 3) || PadL(Str(nDK), 1) || PadL(Str(nS), 16) ||
    PadR(DtoS(dDAOPL), 8) || PadL(Str(nISM), 16) || PadR(
    DtoS(dDAPP), 8) || PadR(sNAZ, 160) || PadR(sPOND, 10) ||
    PadR(sFN_A, 12) || PadR(sD_REC, 60) || PadL(Str(nRNK), 10) ||
    PadR(sKOKK, 14) || PadR(sTD, 2) || PadL(Str(nISPZ), 3) ||
    VisStrRightTrim(PadL(Str(nREF), 10) || PadR(sPOLU, 38) ||
    IifS(nMinusA3>0, PadL(Str(nMinusA3), 16), '')) || PutCrLf()
.head 14 +  If Len(sBuffer) > 64000
.head 15 -  Set bFL = SalFileWrite(hF, sBuffer, Len(sBuffer)) = Len(sBuffer)
.head 15 -  Call SaveInfoToLog('Write File: ' || Str(Len(sBuffer)))
.head 15 -  Set sBuffer = ''
.head 14 +  Else
.head 15 -  Set bFL = TRUE
.head 14 +  If not bFL
.head 15 -  Break
.head 14 +  ! Else
.head 15 -  ! Call SaveInfoToLog('INSERT into DBF: ' || PadR(sNLS, 14) || ' ' ||
     Str(nMFO) || ' ' || PadR(sNLSK, 14) || ' ' || PadL(
     Str(nS/100), 20))
.head 15 -  ! Call SaveInfoToLog('INSERT into TXT: ' || PadR(sNLS, 14) || ' ' ||
     Str(nMFO) || ' ' || PadR(sNLSK, 14) || ' ' || PadL(
     Str(nS/100), 20))
.head 14 -  Set nPos = nPos + nDelta
.head 13 +  If bFL
.head 14 -  ! Call SqlCommit(hSqlA)
.head 14 +  If Len(sBuffer) > 0
.head 15 -  Set bFL = SalFileWrite(hF, sBuffer, Len(sBuffer)) = Len(sBuffer)
.head 15 -  Call SaveInfoToLog('Write File: ' || Str(Len(sBuffer)) || ' - end')
.head 14 -  ! Call SalFileClose(hF)
.head 14 -  ! Call SaveInfoToLog('Close File: ' || sFile)
.head 14 -  Call cc1.SetProgress(100)
.head 14 +  If bFL
.head 15 -  Set mlText = 'Выписка за ' || Str(SalDateDay(dYes)) || ' ' ||
    GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' || Str(
    SalDateYear(dYes)) || ' г. отобрана (' || sSAB_tmp || ').'
.head 14 +  Else
.head 15 -  Set mlText = 'Ошибка 3 (запись файла) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) ||
    ' г. (' || sSAB_tmp || ')'
.head 13 +  Else
.head 14 -  ! Call SqlRollback(hSqlA)
.head 14 -  Call SalFileClose(hF)
.head 14 -  Call SaveInfoToLog('Close File (error 2): ' || sFile)
.head 14 -  Call VisFileDelete(sFile)
.head 14 -  Set mlText = 'Ошибка 2 (запись строки) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) ||
    ' г. (' || sSAB_tmp || ')'
.head 11 -  ! Call SqlDisconnect(hSqlA)
.head 11 -  Call SalHideWindow(cc1)
.head 10 -  Call SalFileSetCurrentDirectory(sOdir)
.head 9 -  Set nInd = nInd + 1
.head 8 +  If bFL and not bBeg2
.head 9 -  Call SalFileClose(hF)
.head 9 -  Call SaveInfoToLog('Close File: ' || sFile)
.head 8 +  If File(sFile)
.head 9 -  ! Call VisFileCopy(sFile, sBackDocPath || sFile2)
.head 9 -  Call SalFileCopy(sFile, sBackDocPath || sFile4, TRUE)
.head 9 -  Call SaveInfoToLog('Copy File: ' || sFile || ' to ' || sBackDocPath || sFile4)
.head 8 +  If not bBeg3
.head 9 -  Set mlText = 'Выписки за ' || Str(SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) ||
    ' г. отобраны.'
.head 9 -  Call SalShowWindow(cc1)
.head 9 -  Call cc1.SetProgress(100)
.head 8 +  Else
.head 9 -  Set mlText = 'Ошибка 1 (нет информации) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' '
    || Str(SalDateYear(dYes)) || ' г.'
.head 9 -  Call SalHideWindow(cc1)
.head 7 +  Else ! nVWABS = 0 or nVWABS = 1 or nVWABS = 4
.head 8 -  ! вариант по всем SABам
.head 8 +  If sRBSName
.head 9 -  ! Make end of transaction and start new
.head 9 -  Call SqlCommit(hSql())
.head 9 -  ! to avoid error with set transaction...
.head 9 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 9 -  ! Call SaveInfoToLog('Установка роллбэк-сегмента 1')
.head 8 +  If SqlPrepareAndExecute(hSql(), T("
   DELETE
   FROM tmp_lick
   WHERE id=:nUid"))
.head 9 -  Call SqlCommit(hSql())
.head 8 -  Set bOk = TRUE
.head 8 -  Set nKwo = 0
.head 8 +  If sRBSName
.head 9 -  ! Make end of transaction and start new
.head 9 -  Call SqlCommit(hSql())
.head 9 -  ! to avoid error with set transaction...
.head 9 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 9 -  ! Call SaveInfoToLog('Установка роллбэк-сегмента 1')
.head 8 +  If SqlPLSQLCommand(hSql(), "p_lickA" || IifS(nVWABS=0, '',
   IifS(nVWABS=1, 'i', 'd')) || "(nUid,dYes)")
.head 9 -  Call SqlCommit(hSql())
.head 9 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT count(*)
     FROM tmp_lick
     INTO :nKwo
     WHERE id=:nUid"))
.head 9 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set bOk = nKwo>0
.head 8 +  Else
.head 9 -  Set bOk = FALSE
.head 8 +  If bOk
.head 9 -  Set nPos = 0
.head 9 -  Set nDelta = 100 / nKwo
.head 9 +  If File(sFile)
.head 10 -  Set nI = 0
.head 10 +  While not SalFileOpen(hF, sFile, OF_Delete)
.head 11 -  Set nI = nI + 1
.head 11 +  If nI > 5
.head 12 -  Call SalWaitCursor(FALSE)
.head 12 -  Call MessageNoWait('Невозможно сформировать файл ' || sFile ||
     ', возможно он занят другим приложением.', 'ВНИМАНИЕ !!!', 0, 1)
.head 12 -  Set mlText = ''
.head 12 -  Return 0
.head 9 -  ! Call SalFileGetCurrentDirectory(sOdir)
.head 9 -  ! Call SalFileSetCurrentDirectory(Left(sBackDocPath, Len(sBackDocPath)-1))
.head 9 -  ! Set SqlDatabase = 'dBase_Files'
.head 9 -  ! родить VWABS.Txt (было VWABS.Dbf)
.head 9 +  If SalFileOpen(hF, sFile, OF_Create | OF_Write) ! SqlConnect(hSqlA)
.head 10 -  ! Set bFL = SqlPrepareAndExecute(hSqlA, "
    CREATE
    TABLE " || sFile1 || " (SAB     CHAR(4),
                            NLS     CHAR(14),
                            NLSK    CHAR(14),
                            NAMS    CHAR(38),
                            NMK     CHAR(38),
                            MFO     NUMBER(9),
                            ND      CHAR(10),
                            ISP     NUMBER(3),
                            EL      NUMBER(1),
                            NM      NUMBER(1),
                            NP      NUMBER(3),
                            VOB     NUMBER(3),
                            DK      NUMBER(1),
                            S       NUMBER(16),
                            DAOPL   DATE,
                            ISM     NUMBER(16),
                            DAPP    DATE,
                            NAZ     CHAR(160),
                            POND    CHAR(10),
                            FN_A    CHAR(12),
                            D_REC   CHAR(60),
                            RNK     NUMBER(10),
                            KOKK    CHAR(14),
                            TD      CHAR(2),
                            ISPZ    NUMBER(3),
                            REF     NUMBER(10),
                            POLU    CHAR(38),
                            MINUSA3 NUMBER(16))")
.head 10 -  Set bFL = TRUE
.head 10 -  Call SaveInfoToLog('Open File: ' || sFile)
.head 10 +  If sRBSName
.head 11 -  ! Make end of transaction and start new
.head 11 -  Call SqlCommit(hSql())
.head 11 -  ! to avoid error with set transaction...
.head 11 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 11 -  ! Call SaveInfoToLog('Установка роллбэк-сегмента 2')
.head 10 +  If bFL
.head 11 -  Set bFL = SqlPrepareAndExecute(hSql(), "
    SELECT sab,nls,nlsk,nams,nmk,mfo,nd,isp,el,nm,np,vob,dk,s,daopl,ism,
           dapp,naz,pond,fn_a,d_rec,rnk,kokk,td,ispz,ref,polu,minusa3
    INTO :sSAB,:sNLS,:sNLSK,:sNAMS,:sNMK,:sMFO,:sND,:nISP,:nEL,:nNM,:nNP,
         :nVOB,:nDK,:nS,:dDAOPL,:nISM,:dDAPP,:sNAZ,:sPOND,:sFN_A,:sD_REC,
         :nRNK,:sKOKK,:sTD,:nISPZ,:nREF,:sPOLU,:nMinusA3
    FROM tmp_lick
    WHERE id=:nUid")
.head 10 +  If bFL
.head 11 -  ! Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || " (DAOPL)
    VALUES (:dYes)")
.head 11 -  Set bFL = SalFileWrite(hF, PadL(DtoS(dYes), 163) || PutCrLf(), 165) = 165
.head 11 -  Call SaveInfoToLog('Write File: 165 - begin')
.head 11 +  If not bFL
.head 12 -  ! Call SqlRollback(hSqlA)
.head 12 -  Call SalFileClose(hF)
.head 12 -  Call SaveInfoToLog('Close File: (error 0) ' || sFile)
.head 12 -  Call VisFileDelete(sFile)
.head 12 -  Call SaveInfoToLog('Delete File: ' || sFile)
.head 12 -  Set mlText = 'Ошибка 0 (внесение служебной записи) отбора выписок за ' ||
    Str(SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 11 +  Else
.head 12 -  Call SalShowWindow(cc1)
.head 12 -  Set sBuffer = ''
.head 12 +  While SqlFetchNext(hSql(), nFetchRes)
.head 13 -  Call cc1.SetProgress(nPos)
.head 13 -  Set sNLSK = IifS(Len(SalStrTrimX(sNLSK))=0, '0', sNLSK)
.head 13 -  Set sNAMS = StrWinToDosX2(sNAMS)
.head 13 -  Set sNMK = StrWinToDosX2(sNMK)
.head 13 -  Set nMFO = Val(sMFO)
.head 13 -  Set sND = StrWinToDosX2(sND)
.head 13 -  Set nISP = Mod(nISP, 100)
.head 13 -  Set sNAZ = StrWinToDosX2(sNAZ)
.head 13 -  Set sD_REC = StrWinToDosX2(sD_REC)
.head 13 -  Set nISPZ = Mod(nISPZ, 100)
.head 13 -  Set sPOLU = StrWinToDosX2(sPOLU)
.head 13 -  ! Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || "
    VALUES (:sSAB,:sNLS,:sNLSK,:sNAMS,:sNMK,:nMFO,:sND,:nISP,:nEL,:nNM,
            :nNP,:nVOB,:nDK,:nS,:dDAOPL,:nISM,:dDAPP,:sNAZ,:sPOND,
            :sFN_A,:sD_REC,:nRNK,:sKOKK,:sTD,:nISPZ,:nREF,:sPOLU,
            :nMinusA3)")
.head 13 -  Set sBuffer = sBuffer || PadR(sSAB, 4) || PadR(sNLS, 14) ||
    PadR(sNLSK, 14) || PadR(sNAMS, 38) || PadR(sNMK, 38) || PadL(
    Str(nMFO), 9) || PadR(sND, 10) || PadL(Str(nISP), 3) || PadL(
    Str(nEL), 1) || PadL(Str(nNM), 1) || PadL(Str(nNP), 3) || PadL(
    Str(nVOB), 3) || PadL(Str(nDK), 1) || PadL(Str(nS), 16) ||
    PadR(DtoS(dDAOPL), 8) || PadL(Str(nISM), 16) || PadR(DtoS(dDAPP), 8)
    || PadR(sNAZ, 160) || PadR(sPOND, 10) || PadR(sFN_A, 12) ||
    PadR(sD_REC, 60) || PadL(Str(nRNK), 10) || PadR(sKOKK, 14) ||
    PadR(sTD, 2) || PadL(Str(nISPZ), 3) || VisStrRightTrim(PadL(
    Str(nREF), 10) || PadR(sPOLU, 38) || IifS(nMinusA3>0, PadL(
    Str(nMinusA3), 16), '')) || PutCrLf()
.head 13 +  If Len(sBuffer) > 64000
.head 14 -  Set bFL = SalFileWrite(hF, sBuffer, Len(sBuffer)) = Len(sBuffer)
.head 14 -  Call SaveInfoToLog('Write File: ' || Str(Len(sBuffer)))
.head 14 -  Set sBuffer = ''
.head 13 +  Else
.head 14 -  Set bFL = TRUE
.head 13 +  If not bFL
.head 14 -  Break
.head 13 +  ! Else
.head 14 -  ! Call SaveInfoToLog('INSERT into DBF: ' || PadR(sNLS, 14) || ' ' ||
     Str(nMFO) || ' ' || PadR(sNLSK, 14) || ' ' || PadL(
     Str(nS/100), 20))
.head 14 -  ! Call SaveInfoToLog('INSERT into TXT: ' || PadR(sNLS, 14) || ' ' ||
     Str(nMFO) || ' ' || PadR(sNLSK, 14) || ' ' || PadL(
     Str(nS/100), 20))
.head 13 -  Set nPos = nPos + nDelta
.head 12 +  If bFL
.head 13 -  ! Call SqlCommit(hSqlA)
.head 13 +  If Len(sBuffer) > 0
.head 14 -  Set bFL = SalFileWrite(hF, sBuffer, Len(sBuffer)) = Len(sBuffer)
.head 14 -  Call SaveInfoToLog('Write File: ' || Str(Len(sBuffer)) || ' - end')
.head 13 -  Call SalFileClose(hF)
.head 13 -  Call SaveInfoToLog('Close File: ' || sFile)
.head 13 -  Call cc1.SetProgress(100)
.head 13 +  ! If bFL
.head 14 -      Set mlText = 'Выписки за ' || Str(SalDateDay(dYes)) || ' ' ||
    GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' || Str(
    SalDateYear(dYes)) || ' г. отобраны.'
.head 13 +  ! Else
.head 14 -      Set mlText = 'Ошибка 3 (запись файла) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) ||
    ' г.'
.head 12 +  Else
.head 13 -  ! Call SqlRollback(hSqlA)
.head 13 -  Call SalFileClose(hF)
.head 13 -  Call SaveInfoToLog('Close File (error 2): ' || sFile)
.head 13 -  Call VisFileDelete(sFile)
.head 13 -  Set mlText = 'Ошибка 2 (запись строки) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 10 -  ! Call SqlDisconnect(hSqlA)
.head 10 +  If bFL
.head 11 +  If File(sFile)
.head 12 -  ! Call VisFileCopy(sFile, sBackDocPath || sFile2)
.head 12 -  Call SalFileCopy(sFile, sBackDocPath || sFile4, TRUE)
.head 12 -  Call SaveInfoToLog('Copy File: ' || sFile || ' to ' || sBackDocPath ||
     sFile4)
.head 12 -  Set mlText = 'Выписки за ' || Str(SalDateDay(dYes)) || ' ' ||
    GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' || Str(
    SalDateYear(dYes)) || ' г. отобраны.'
.head 10 +  Else
.head 11 +  If File(sFile)
.head 12 -  Call VisFileDelete(sFile)
.head 12 -  Call SaveInfoToLog('Delete File: ' || sFile)
.head 12 -  Set mlText = 'Ошибка 3 (запись файла) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) ||
    ' г.'
.head 9 -  ! Call SalFileSetCurrentDirectory(sOdir)
.head 8 +  Else
.head 9 -  Set mlText = 'Ошибка 1 (нет информации) отбора выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' '
    || Str(SalDateYear(dYes)) || ' г.'
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SalTimerSet(pbExit, 2, 7000)
.head 5 +  On SAM_Create
.head 6 -  Call SalTimerSet(hWndItem, 1, nTimeVW*1000)
.head 5 +  On SAM_Timer
.head 6 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Exit
.head 4 -  Window Location and Size
.head 5 -  Left:   3.183"
.head 5 -  Top:    0.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalTimerKill(hWndItem, 2)
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  On SAM_Timer
.head 6 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.05"
.head 6 -  Top:    0.012"
.head 6 -  Width:  6.433"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.917"
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
.head 5 +  Column: colOTM
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Отм.
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.533"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_Click
.head 8 -  Call SalTimerKill(pbRun, 1)
.head 8 -  Call SalTimerSet(pbRun, 1, nTimeVW*1000)
.head 5 +  Column: colSAB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 4
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.6"
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
.head 5 +  Column: colNMK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 38
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.567"
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
.head 5 +  Column: colMFOSAB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: МФО
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Right
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
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call WaitCursorOn()
.head 6 -  Call SalTblPopulate(tbl1, hSql(), T("
     SELECT '1',sab,nb,mfo
     FROM banks
     INTO :tbl1.colOTM,:tbl1.colSAB,:tbl1.colNMK,:tbl1.colMFOSAB
     WHERE kodn=4 and blk<>2 and blk<>3 and blk<>9 and fmi='$A' and fmo='$B'
     ORDER BY sab"), TBL_FillAll)
.head 6 -  Call WaitCursorOff()
.head 3 +  Custom Control: cc1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cMeter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   6.483"
.head 6 -  Top:    3.655"
.head 6 -  Width:  3.2"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
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
.head 5 -  Text Color: Dark Gray
.head 5 -  Background Color: Light Gray
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 3 +  Radio Button: rb0
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: (0) по ВСЕМ, без инфор.
.head 4 -  Window Location and Size
.head 5 -  Left:   6.483"
.head 5 -  Top:    0.071"
.head 5 -  Width:  3.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSetWindowText(hWndForm, sWText || ' All')
.head 3 +  Radio Button: rb1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: (1) по ВСЕМ + инфор.
.head 4 -  Window Location and Size
.head 5 -  Left:   6.483"
.head 5 -  Top:    0.321"
.head 5 -  Width:  3.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSetWindowText(hWndForm, sWText || ' All+Info')
.head 3 +  Radio Button: rb2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: (2) по ОДНОМУ, без инфор.
.head 4 -  Window Location and Size
.head 5 -  Left:   6.483"
.head 5 -  Top:    0.571"
.head 5 -  Width:  3.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSetWindowText(hWndForm, sWText || ' One')
.head 3 +  Radio Button: rb3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: (3) по ОДНОМУ + инфор.
.head 4 -  Window Location and Size
.head 5 -  Left:   6.483"
.head 5 -  Top:    0.821"
.head 5 -  Width:  3.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSetWindowText(hWndForm, sWText || ' One+Info')
.head 3 +  Radio Button: rb4
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: (4) по ВСЕМ + деб.инфор.
.head 4 -  Window Location and Size
.head 5 -  Left:   6.483"
.head 5 -  Top:    1.071"
.head 5 -  Width:  3.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSetWindowText(hWndForm, sWText || ' All+Deb.Info')
.head 3 +  Radio Button: rb5
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: (5) по ОДНОМУ + деб.инф.
.head 4 -  Window Location and Size
.head 5 -  Left:   6.483"
.head 5 -  Top:    1.321"
.head 5 -  Width:  3.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSetWindowText(hWndForm, sWText || ' One+Deb.Info')
.head 2 +  Functions
.head 3 +  Function: LenArray
.head 4 -  Description: возвращает длину одномерного массива строк
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  String: smArr[*]
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nBound
.head 4 +  Actions
.head 5 -  Call SalArrayGetUpperBound(smArr, 1, nBound)
.head 5 -  Return nBound
.head 3 +  Function: StrWinToDosX2
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: sIn
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sOut
.head 4 +  Actions
.head 5 -  Set sOut = Spac(Len(sIn))
.head 5 -  Call CharToOemUkr(sIn, sOut)
.head 5 -  Return sOut
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nUid
.head 3 -  Date/Time: dYes
.head 3 -  String: sFile1
.head 3 -  String: sFile2
.head 3 -  String: sFile3
.head 3 -  String: sFile4
.head 3 -  String: sBackDocPath
.head 3 -  Boolean: bOk
.head 3 -  Number: nKwo
.head 3 -  String: sFile
.head 3 -  Number: nI
.head 3 -  File Handle: hF
.head 3 -  String: sOdir
.head 3 -  File Handle: hSqlA
.head 3 -  Boolean: bFL
.head 3 -  String: sNLSK
.head 3 -  String: sSAB
.head 3 -  String: sNLS
.head 3 -  String: sNAMS
.head 3 -  String: sNMK
.head 3 -  String: sMFO
.head 3 -  Number: nMFO
.head 3 -  String: sND
.head 3 -  Number: nISP
.head 3 -  Number: nEL
.head 3 -  Number: nNM
.head 3 -  Number: nNP
.head 3 -  Number: nVOB
.head 3 -  Number: nDK
.head 3 -  Number: nS
.head 3 -  Date/Time: dDAOPL
.head 3 -  Number: nISM
.head 3 -  Date/Time: dDAPP
.head 3 -  String: sNAZ
.head 3 -  String: sPOND
.head 3 -  String: sFN_A
.head 3 -  String: sD_REC
.head 3 -  Number: nRNK
.head 3 -  String: sKOKK
.head 3 -  String: sTD
.head 3 -  Number: nISPZ
.head 3 -  Number: nREF
.head 3 -  String: sPOLU
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Number: nTimeVW
.head 3 -  String: sTimeVW
.head 3 -  !
.head 3 -  Number: nPos
.head 3 -  Number: nDelta
.head 3 -  !
.head 3 -  String: sRBSName
.head 3 -  !
.head 3 -  Number: nMinusA3
.head 3 -  ! !
.head 3 -  String: sSelectSAB[*]
.head 3 -  String: sSAB_tmp
.head 3 -  String: sSelectMFOSAB[*]
.head 3 -  String: sMFOSAB
.head 3 -  Boolean: bNBU
.head 3 -  Boolean: bBeg1
.head 3 -  Boolean: bBeg2
.head 3 -  Boolean: bBeg3
.head 3 -  Number: nInd
.head 3 -  !
.head 3 -  Number: nVWABS
.head 3 -  String: sWText
.head 3 -  !
.head 3 -  String: sBuffer
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalHideWindow(cc1)
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set bNBU = GetGlobalOption('NBUBANK')='1'
.head 4 -  Set nVWABS = Val(GetGlobalOption('VWABS'))
.head 4 -  Set nVWABS = IifN(nVWABS<0 or nVWABS>5, 0, nVWABS)
.head 4 +  If bNBU
.head 5 -  Call SalHideWindow(rb0)
.head 5 -  Call SalHideWindow(rb1)
.head 5 -  Call SalHideWindow(rb2)
.head 5 -  Call SalHideWindow(rb3)
.head 5 -  Call SalHideWindow(rb4)
.head 5 -  Call SalHideWindow(rb5)
.head 4 +  Else
.head 5 -  Set rb0 = nVWABS=0
.head 5 -  Set rb1 = nVWABS=1
.head 5 -  Set rb2 = nVWABS=2
.head 5 -  Set rb3 = nVWABS=3
.head 5 -  Set rb4 = nVWABS=4
.head 5 -  Set rb5 = nVWABS=5
.head 4 -  Call SalGetWindowText(hWndForm, sWText, 99)
.head 4 -  ! Call SalSetWindowText(hWndForm, sWText || ' ' || IifS(nVWABS>1, 'One', 'All') || IifS(
     Mod(nVWABS, 2)=0, '', '+Info'))
.head 4 -  Call SalSetWindowText(hWndForm, sWText || ' ' ||
     IifS(nVWABS=2 or nVWABS=3 or nVWABS=5, 'One', 'All') ||
     IifS(nVWABS=0 or nVWABS=2, '', '+' || IifS(nVWABS>3, 'Deb.', '') || 'Info'))
.head 4 -  ! Call DebugN(nVWABS)
.head 4 -  Set nUid = GetUserId()
.head 4 -  Set dYes = GetBankDate()
.head 4 -  Set sFile1 = 'VWAB_.Dbf'
.head 4 -  Set sFile2 = 'VWABS.Dbf'
.head 4 -  Set sFile3 = 'VWAB_.Txt'
.head 4 -  Set sFile4 = 'VWABS.Txt'
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('ElektroKlients', 'BackDocPath', GetPrnDir(), sBackDocPath,
     GetIniFileName())
.head 4 -  Set sBackDocPath = IifS(Right(sBackDocPath, 1)='\\', sBackDocPath, sBackDocPath || '\\')
.head 4 -  Call SalGetProfileString('ElektroKlients', 'TimeVW', '30', sTimeVW, GetIniFileName())
.head 4 -  Set nTimeVW = Min(Max(Val(sTimeVW), 0), 65)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSetFocus(tbl1)
.head 4 -  Call SalTblSetFocusCell(tbl1, 0, tbl1.colOTM, 0, 1)
.head 1 +  Dialog Box: FormVWaV
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Формирование валютных выписок эл.клиентам (автомат)
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.625"
.head 4 -  Top:    0.625"
.head 4 -  Width:  6.9"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.0"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
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
.head 3 +  Multiline Field: mlText
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1024
.head 5 -  String Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? No
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   1.583"
.head 6 -  Top:    3.988"
.head 6 -  Width:  5.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.417"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbRun
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.283"
.head 5 -  Top:    3.988"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.643"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Gray
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTimerKill(hWndItem, 1)
.head 6 -  Call SalDisableWindow(tbl1)
.head 6 -  Set sFile = sBackDocPath || sFile1
.head 6 -  Set mlText = 'Отбор валютных выписок за ' || Str(SalDateDay(dYes)) || ' ' ||
    GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) ||
    ' г. ...'
.head 6 -  Call SqlPrepareAndExecute(hSql(), T("
     DELETE
     FROM tmp_sabv"))
.head 6 -  Set nRow = TBL_MinRow
.head 6 +  While SalTblFindNextRow(tbl1, nRow, 0, 0)
.head 7 -  Call SalTblSetContext(tbl1, nRow)
.head 7 +  If tbl1.colOTM = '1'
.head 8 -  Call SqlPrepareAndExecute(hSql(), T("
     INSERT
     INTO tmp_sabv (sab)
     VALUES (:tbl1.colSAB)"))
.head 6 -  Set bOk = TRUE
.head 6 -  Set nKwo = 0
.head 6 -  Set sRBSName = GetGlobalOption('BIG_SEG')
.head 6 +  If sRBSName
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 6 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 6 -  ! Call SalMessageBox('Begin exe p_liv','AT',0)
.head 6 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 6 +  If SqlPLSQLCommand(hSql(), "p_liv(nUid,dYes)")
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT count(*)
     FROM tmp_licv
     INTO :nKwo
     WHERE id=:nUid"))
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set bOk = nKwo>0
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 -  ! Call SalMessageBox('END execute p_liv','AT',0)
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 6 +  Else
.head 7 -  Set bOk = FALSE
.head 6 +  If bOk
.head 7 -  Set nPos = 0
.head 7 -  Set nDelta = 100 / nKwo
.head 7 +  If File(sFile)
.head 8 -  Set nI = 0
.head 8 +  While not SalFileOpen(hF, sFile, OF_Delete)
.head 9 -  Set nI = nI + 1
.head 9 +  If nI > 5
.head 10 -  Set mlText = ''
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call MessageNoWait('Невозможно сформировать файл ' || sFile ||
     ', возможно он занят другим приложением.', 'ВНИМАНИЕ !!!', 0, 1)
.head 10 -  Call SalTimerSet(pbExit, 2, 1)
.head 10 -  Return 0
.head 7 -  Call SalFileGetCurrentDirectory(sOdir)
.head 7 -  Call SalFileSetCurrentDirectory(Left(sBackDocPath, Len(sBackDocPath)-1))
.head 7 -  Set SqlDatabase = 'dBase_Files'
.head 7 -  ! родить VWABSV.Dbf
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 -  ! Call SalMessageBox('INCOME TO retrieve from tmp_licv','AT',0)
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 +  If SqlConnect(hSqlA)
.head 8 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    CREATE
    TABLE " || sFile1 || " (SAB    CHAR(4),
                            DATP   DATE,
                            TIMP   CHAR(8),
                            AAMF   NUMBER(9),
                            NAQH   CHAR(38),
                            RNK    NUMBER(6),
                            NMK    CHAR(38),
                            NMS    CHAR(38),
                            KVAL   CHAR(3),
                            NVAL   CHAR(15),
                            NLS    CHAR(14),
                            KVD    NUMBER(3),
                            ODATE  DATE,
                            VDATE  DATE,
                            ISP    NUMBER(3),
                            DPOTK  DATE,
                            DPOPK  DATE,
                            ETALS  NUMBER(5),
                            KPOTK  NUMBER(12,4),
                            KPOPK  NUMBER(12,4),
                            DIGIT  NUMBER(1),
                            SISV   NUMBER(16),
                            SIS    NUMBER(16),
                            NLSK   CHAR(14),
                            ISPK   CHAR(2),
                            KVK    NUMBER(3),
                            ND     NUMBER(3),
                            ISV    NUMBER(16),
                            ISR    NUMBER(16),
                            NAZN   CHAR(220),
                            DK     NUMBER(1))") and SqlPrepareAndExecute(hSql(), "
    SELECT sab,rnk,nmk,nms,kval,nval,nls,kvd,odate,vdate,isp,dpotk,dpopk,etals,
           kpotk,kpopk,digit,sisv,sis,nlsk,ispk,kvk,nd,isv,isr,nazn,dk
    INTO :sSAB,:nRNK,:sNMK,:sNMS,:sKVAL,:sNVAL,:sNLS,:nKVD,:dODATE,:dVDATE,:nISP,
         :dDPOTK,:dDPOPK,:nETALS,:nKPOTK,:nKPOPK,:nDIGIT,:nSISV,:nSIS,:sNLSK,
         :nISPK,:nKVK,:sND,:nISV,:nISR,:sNAZN,:nDK
    FROM tmp_licv
    WHERE id=:nUid")
.head 8 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 8 -  ! Call SalMessageBox('EXIT FROM retrieve from tmp_licv','AT',0)
.head 8 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 8 +  If bFL
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 -  ! Call SalMessageBox('BEGIN INSERT odate','AT',0)
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || " (ODATE)
    VALUES (:dYes)")
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 -  ! Call SalMessageBox('END INSERT odate','AT',0)
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 +  If not bFL
.head 10 -  Call SqlRollback(hSqlA)
.head 10 -  Set mlText =
    'Ошибка 0 (внесение служебной записи) отбора валютных выписок за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE) ||
    ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 9 +  Else
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  ! Call SalMessageBox('BEGIN INSERT *.dbf','AT',0)
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  Call SalShowWindow(cc1)
.head 10 +  While SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Call cc1.SetProgress(nPos)
.head 11 -  Set dDATP = SalDateCurrent()
.head 11 -  Set sTIMP = Right('0' || SalFmtFormatDateTime(
    SalDateCurrent(), 'hhhh:mm:ss'), 8)
.head 11 -  Set nAAMF = Val(GetBankMfo())
.head 11 -  Set sNAQH = StrWinToDosX(GetBankName())
.head 11 -  Set sNMK = StrWinToDosX(sNMK)
.head 11 -  Set sNMS = StrWinToDosX(sNMS)
.head 11 -  Set sKVAL = StrWinToDosX(sKVAL)
.head 11 -  Set sNVAL = StrWinToDosX(sNVAL)
.head 11 -  Set nMFO = Val(sMFO)
.head 11 -  Set nND = Val('000' || Right(sND, 3))
.head 11 -  Set nISP = Mod(nISP, 1000)
.head 11 -  Set sISPK = Right('00' || Str(Mod(nISPK, 100)), 2)
.head 11 -  Set sNAZN = StrWinToDosX(sNAZN)
.head 11 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || "
    VALUES (:sSAB,:dDATP,:sTIMP,:nAAMF,:sNAQH,:nRNK,:sNMK,:sNMS,:sKVAL,
            :sNVAL,:sNLS,:nKVD,:dODATE,:dVDATE,:nISP,:dDPOTK,:dDPOPK,
            :nETALS,:nKPOTK,:nKPOPK,:nDIGIT,:nSISV,:nSIS,:sNLSK,:sISPK,
            :nKVK,:nND,:nISV,:nISR,:sNAZN,:nDK)")
.head 11 +  If not bFL
.head 12 -  Break
.head 11 -  Set nPos = nPos + nDelta
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  ! Call SalMessageBox('END INSERT *.dbf','AT',0)
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 +  If bFL
.head 11 -  Call SqlCommit(hSqlA)
.head 11 -  Call cc1.SetProgress(100)
.head 11 -  Set mlText = 'Выписки(В) за ' || Str(SalDateDay(dYes)) || ' ' ||
    GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' || Str(
    SalDateYear(dYes)) || ' г. отобраны.'
.head 10 +  Else
.head 11 -  Call SqlRollback(hSqlA)
.head 11 -  Set mlText = 'Ошибка 2 (запись строки) отбора выписок(В) за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE) ||
    ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 8 -  Call SqlDisconnect(hSqlA)
.head 8 +  If bFL
.head 9 +  If File(sFile)
.head 10 -  Call SalFileCopy(sFile, sBackDocPath || sFile2, TRUE)
.head 8 +  Else
.head 9 +  If File(sFile)
.head 10 -  Call SalFileOpen(hF, sFile, OF_Delete)
.head 7 -  Call SalFileSetCurrentDirectory(sOdir)
.head 6 +  Else
.head 7 -  Set mlText = 'Ошибка 1 (нет информации) отбора выписок(В) за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' ||
    Str(SalDateYear(dYes)) || ' г.'
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SalTimerSet(pbExit, 2, 7000)
.head 5 +  On SAM_Create
.head 6 -  Call SalTimerSet(hWndItem, 1, nTimeVWV*1000)
.head 5 +  On SAM_Timer
.head 6 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Exit
.head 4 -  Window Location and Size
.head 5 -  Left:   3.183"
.head 5 -  Top:    0.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalTimerKill(hWndItem, 2)
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  On SAM_Timer
.head 6 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.25"
.head 6 -  Top:    0.012"
.head 6 -  Width:  6.333"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.917"
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
.head 5 +  Column: colOTM
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Отм.
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.467"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_Click
.head 8 -  Call SalTimerKill(pbRun, 1)
.head 8 -  Call SalTimerSet(pbRun, 1, nTimeVWV*1000)
.head 5 +  Column: colSAB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 4
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.6"
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
.head 5 +  Column: colNMK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 38
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.55"
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
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call WaitCursorOn()
.head 6 -  Call SalTblPopulate(tbl1, hSql(), T("
     SELECT '1',sab,nb
     FROM banks
     INTO :tbl1.colOTM,:tbl1.colSAB,:tbl1.colNMK
     WHERE kodn=4 and blk<>2 and blk<>3 and blk<>9 and fmi='$A' and fmo='$B'
     ORDER BY sab"), TBL_FillAll)
.head 6 -  Call WaitCursorOff()
.head 3 +  Custom Control: cc1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cMeter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.583"
.head 6 -  Top:    4.405"
.head 6 -  Width:  5.1"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
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
.head 5 -  Text Color: Dark Gray
.head 5 -  Background Color: Light Gray
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nUid
.head 3 -  Date/Time: dYes
.head 3 -  String: sFile1
.head 3 -  String: sFile2
.head 3 -  String: sBackDocPath
.head 3 -  Boolean: bOk
.head 3 -  Number: nKwo
.head 3 -  String: sFile
.head 3 -  Number: nI
.head 3 -  File Handle: hF
.head 3 -  String: sOdir
.head 3 -  File Handle: hSqlA
.head 3 -  Boolean: bFL
.head 3 -  String: sNLSK
.head 3 -  String: sSAB
.head 3 -  String: sNLS
.head 3 -  String: sNAMS
.head 3 -  String: sNMK
.head 3 -  String: sMFO
.head 3 -  Number: nMFO
.head 3 -  String: sND
.head 3 -  Number: nISP
.head 3 -  Number: nEL
.head 3 -  Number: nNM
.head 3 -  Number: nNP
.head 3 -  Number: nVOB
.head 3 -  Number: nDK
.head 3 -  Number: nS
.head 3 -  Number: nISM
.head 3 -  Date/Time: dDAPP
.head 3 -  String: sNAZ
.head 3 -  String: sPOND
.head 3 -  String: sFN_A
.head 3 -  String: sD_REC
.head 3 -  Number: nRNK
.head 3 -  String: sKOKK
.head 3 -  String: sTD
.head 3 -  Number: nISPZ
.head 3 -  Number: nREF
.head 3 -  String: sPOLU
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Number: nTimeVWV
.head 3 -  String: sTimeVWV
.head 3 -  !
.head 3 -  Number: nPos
.head 3 -  Number: nDelta
.head 3 -  !
.head 3 -  String: sRBSName
.head 3 -  !
.head 3 -  Date/Time: dDATP
.head 3 -  String: sTIMP
.head 3 -  Number: nAAMF
.head 3 -  String: sNAQH
.head 3 -  String: sNMS
.head 3 -  String: sKVAL
.head 3 -  String: sNVAL
.head 3 -  Number: nKVD
.head 3 -  Date/Time: dODATE
.head 3 -  Date/Time: dVDATE
.head 3 -  Date/Time: dDPOTK
.head 3 -  Date/Time: dDPOPK
.head 3 -  Number: nETALS
.head 3 -  Number: nKPOTK
.head 3 -  Number: nKPOPK
.head 3 -  Number: nDIGIT
.head 3 -  Number: nSISV
.head 3 -  Number: nSIS
.head 3 -  String: sISPK
.head 3 -  Number: nKVK
.head 3 -  Number: nND
.head 3 -  Number: nISV
.head 3 -  Number: nISR
.head 3 -  String: sNAZN
.head 3 -  Number: nISPK
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalHideWindow(cc1)
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set nUid = GetUserId()
.head 4 -  Set dYes = GetBankDate()
.head 4 -  Set sFile1 = 'VWAB_V.Dbf'
.head 4 -  Set sFile2 = 'VWABSV.Dbf'
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('ElektroKlients', 'BackDocPath', GetPrnDir(), sBackDocPath,
     GetIniFileName())
.head 4 -  Set sBackDocPath = IifS(Right(sBackDocPath, 1)='\\', sBackDocPath, sBackDocPath || '\\')
.head 4 -  Call SalGetProfileString('ElektroKlients', 'TimeVWV', '30', sTimeVWV, GetIniFileName())
.head 4 -  Set nTimeVWV = Min(Max(Val(sTimeVWV), 0), 65)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSetFocus(tbl1)
.head 4 -  Call SalTblSetFocusCell(tbl1, 0, tbl1.colOTM, 0, 1)
.head 1 +  Dialog Box: FormVWaN
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Формирование внебалансовых выписок эл.клиентам (автомат)
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.625"
.head 4 -  Top:    0.625"
.head 4 -  Width:  6.85"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.0"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
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
.head 3 +  Multiline Field: mlText
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1024
.head 5 -  String Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? No
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   1.383"
.head 6 -  Top:    3.988"
.head 6 -  Width:  5.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.417"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbRun
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выполнить
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    3.988"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.643"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Gray
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTimerKill(hWndItem, 1)
.head 6 -  Call SalDisableWindow(tbl1)
.head 6 -  Set sFile = sBackDocPath || sFile1
.head 6 -  Set mlText = 'Отбор выписок за ' || Str(SalDateDay(dYes)) || ' ' || GetMonthNameRus(
    SalDateMonth(dYes), TRUE) || ' ' || Str(SalDateYear(dYes)) || ' г. ...'
.head 6 -  Call SqlPrepareAndExecute(hSql(), T("
     DELETE
     FROM tmp_sabn"))
.head 6 -  Set nRow = TBL_MinRow
.head 6 +  While SalTblFindNextRow(tbl1, nRow, 0, 0)
.head 7 -  Call SalTblSetContext(tbl1, nRow)
.head 7 +  If tbl1.colOTM = '1'
.head 8 -  Call SqlPrepareAndExecute(hSql(), T("
     INSERT
     INTO tmp_sabn (sab)
     VALUES (:tbl1.colSAB)"))
.head 6 -  Set bOk = TRUE
.head 6 -  Set nKwo = 0
.head 6 -  Set sRBSName = GetGlobalOption('BIG_SEG')
.head 6 +  If sRBSName
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Call SqlPrepareAndExecute(hSql(), 'SET TRANSACTION USE ROLLBACK SEGMENT ' ||
     SalStrUpperX(sRBSName))
.head 6 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 6 -  ! Call SalMessageBox('Begin exe p_lin','AT',0)
.head 6 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 6 +  If SqlPLSQLCommand(hSql(), "p_lin(nUid,dYes)")
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT count(*)
     FROM tmp_licn
     INTO :nKwo
     WHERE id=:nUid"))
.head 7 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set bOk = nKwo>0
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 -  ! Call SalMessageBox('END execute p_lin','AT',0)
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 6 +  Else
.head 7 -  Set bOk = FALSE
.head 6 +  If bOk
.head 7 -  Set nPos = 0
.head 7 -  Set nDelta = 100 / nKwo
.head 7 +  If File(sFile)
.head 8 -  Set nI = 0
.head 8 +  While not SalFileOpen(hF, sFile, OF_Delete)
.head 9 -  Set nI = nI + 1
.head 9 +  If nI > 5
.head 10 -  Set mlText = ''
.head 10 -  Call SalWaitCursor(FALSE)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call SalMessageBeep(-1)
.head 10 -  Call MessageNoWait('Невозможно сформировать файл ' || sFile ||
     ', возможно он занят другим приложением.', 'ВНИМАНИЕ !!!', 0, 1)
.head 10 -  Call SalTimerSet(pbExit, 2, 1)
.head 10 -  Return 0
.head 7 -  Call SalFileGetCurrentDirectory(sOdir)
.head 7 -  Call SalFileSetCurrentDirectory(Left(sBackDocPath, Len(sBackDocPath)-1))
.head 7 -  Set SqlDatabase = 'dBase_Files'
.head 7 -  ! родить VWABSN.Dbf
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 -  ! Call SalMessageBox('INCOME TO retrieve from tmp_licn','AT',0)
.head 7 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 7 +  If SqlConnect(hSqlA)
.head 8 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    CREATE
    TABLE " || sFile1 || " (SAB    CHAR(4),
                            DATP   DATE,
                            TIMP   CHAR(8),
                            AAMF   NUMBER(9),
                            NAQH   CHAR(38),
                            RNK    NUMBER(6),
                            NMK    CHAR(38),
                            NMS    CHAR(38),
                            KVAL   CHAR(3),
                            NVAL   CHAR(15),
                            NBS    CHAR(14),
                            KV     NUMBER(3),
                            ODATE  DATE,
                            VDATE  DATE,
                            ISP    NUMBER(3),
                            DPOTK  DATE,
                            DPOPK  DATE,
                            ETALS  NUMBER(5),
                            KPOTK  NUMBER(12,4),
                            KPOPK  NUMBER(12,4),
                            DIGIT  NUMBER(1),
                            FIOI   CHAR(25),
                            SISV   NUMBER(16),
                            SIS    NUMBER(16),
                            NBSK   CHAR(14),
                            TP     CHAR(2),
                            NP     NUMBER(3),
                            ND     CHAR(10),
                            SV     NUMBER(15),
                            SR     NUMBER(16),
                            NAZN   CHAR(100),
                            DK     NUMBER(1),
                            PP     NUMBER(1),
                            VOB    NUMBER(2))") and SqlPrepareAndExecute(hSql(), "
    SELECT sab,rnk,nmk,nms,kval,nval,nbs,kv,odate,vdate,isp,dpotk,dpopk,etals,
           kpotk,kpopk,digit,fioi,sisv,sis,nbsk,tp,np,nd,sv,sr,nazn,dk,pp,vob
    INTO :sSAB,:nRNK,:sNMK,:sNMS,:sKVAL,:sNVAL,:sNBS,:nKV,:dODATE,:dVDATE,:nISP,
         :dDPOTK,:dDPOPK,:nETALS,:nKPOTK,:nKPOPK,:nDIGIT,:sFIOI,:nSISV,:nSIS,
         :sNBSK,:sTP,:nNP,:sND,:nSV,:nSR,:sNAZN,:nDK,:nPP,:nVOB
    FROM tmp_licn
    WHERE id=:nUid")
.head 8 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 8 -  ! Call SalMessageBox('EXIT FROM retrieve from tmp_licv','AT',0)
.head 8 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 8 +  If bFL
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 -  ! Call SalMessageBox('BEGIN INSERT odate','AT',0)
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || " (ODATE)
    VALUES (:dYes)")
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 -  ! Call SalMessageBox('END INSERT odate','AT',0)
.head 9 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 9 +  If not bFL
.head 10 -  Call SqlRollback(hSqlA)
.head 10 -  Set mlText =
    'Ошибка 0 (внесение служебной записи) отбора внебалансовых выписок за ' ||
    Str(SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE)
    || ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 9 +  Else
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  ! Call SalMessageBox('BEGIN INSERT *.dbf','AT',0)
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  Call SalShowWindow(cc1)
.head 10 +  While SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Call cc1.SetProgress(nPos)
.head 11 -  Set dDATP = SalDateCurrent()
.head 11 -  Set sTIMP = Right('0' || SalFmtFormatDateTime(
    SalDateCurrent(), 'hhhh:mm:ss'), 8)
.head 11 -  Set nAAMF = Val(GetBankMfo())
.head 11 -  Set sNAQH = StrWinToDosX(GetBankName())
.head 11 -  Set sNMK = StrWinToDosX(sNMK)
.head 11 -  Set sNMS = StrWinToDosX(sNMS)
.head 11 -  Set sKVAL = StrWinToDosX(sKVAL)
.head 11 -  Set sNVAL = StrWinToDosX(sNVAL)
.head 11 -  Set sFIOI = StrWinToDosX(sFIOI)
.head 11 -  Set nMFO = Val(sMFO)
.head 11 -  Set nND = Val('000' || Right(sND, 3))
.head 11 -  Set nISP = Mod(nISP, 1000)
.head 11 -  Set sISPK = Right('00' || Str(Mod(nISPK, 100)), 2)
.head 11 -  Set sNAZN = Left(StrWinToDosX(sNAZN), 100)
.head 11 -  Set bFL = SqlPrepareAndExecute(hSqlA, "
    INSERT
    INTO " || sFile1 || "
    VALUES (:sSAB,:dDATP,:sTIMP,:nAAMF,:sNAQH,:nRNK,:sNMK,:sNMS,:sKVAL,
            :sNVAL,:sNBS,:nKV,:dODATE,:dVDATE,:nISP,:dDPOTK,:dDPOPK,
            :nETALS,:nKPOTK,:nKPOPK,:nDIGIT,:sFIOI,:nSISV,:nSIS,:sNBSK,
            :sTP,:nNP,:sND,:nSV,:nSR,:sNAZN,:nDK,:nPP,:nVOB)")
.head 11 +  If not bFL
.head 12 -  Break
.head 11 -  Set nPos = nPos + nDelta
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 -  ! Call SalMessageBox('END INSERT *.dbf','AT',0)
.head 10 -  ! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
.head 10 +  If bFL
.head 11 -  Call SqlCommit(hSqlA)
.head 11 -  Call cc1.SetProgress(100)
.head 11 -  Set mlText = 'Выписки(Н) за ' || Str(SalDateDay(dYes)) || ' ' ||
    GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' || Str(
    SalDateYear(dYes)) || ' г. отобраны.'
.head 10 +  Else
.head 11 -  Call SqlRollback(hSqlA)
.head 11 -  Set mlText = 'Ошибка 2 (запись строки) отбора выписок(Н) за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE) ||
    ' ' || Str(SalDateYear(dYes)) || ' г.'
.head 8 -  Call SqlDisconnect(hSqlA)
.head 8 +  If bFL
.head 9 +  If File(sFile)
.head 10 -  Call SalFileCopy(sFile, sBackDocPath || sFile2, TRUE)
.head 8 +  Else
.head 9 +  If File(sFile)
.head 10 -  Call SalFileOpen(hF, sFile, OF_Delete)
.head 7 -  Call SalFileSetCurrentDirectory(sOdir)
.head 6 +  Else
.head 7 -  Set mlText = 'Ошибка 1 (нет информации) отбора выписок(Н) за ' || Str(
    SalDateDay(dYes)) || ' ' || GetMonthNameRus(SalDateMonth(dYes), TRUE) || ' ' ||
    Str(SalDateYear(dYes)) || ' г.'
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SalTimerSet(pbExit, 2, 7000)
.head 5 +  On SAM_Create
.head 6 -  Call SalTimerSet(hWndItem, 1, nTimeVWN*1000)
.head 5 +  On SAM_Timer
.head 6 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Exit
.head 4 -  Window Location and Size
.head 5 -  Left:   3.183"
.head 5 -  Top:    0.155"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalTimerKill(hWndItem, 2)
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  On SAM_Timer
.head 6 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.05"
.head 6 -  Top:    0.012"
.head 6 -  Width:  6.633"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.917"
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
.head 5 +  Column: colOTM
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Отм.
.head 6 -  Visible? Yes
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.467"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Check Box
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value: 1
.head 8 -  Uncheck Value: 0
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 +  Message Actions
.head 7 +  On SAM_Click
.head 8 -  Call SalTimerKill(pbRun, 1)
.head 8 -  Call SalTimerSet(pbRun, 1, nTimeVWN*1000)
.head 5 +  Column: colSAB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 4
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.6"
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
.head 5 +  Column: colNMK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 38
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.85"
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
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call WaitCursorOn()
.head 6 -  Call SalTblPopulate(tbl1, hSql(), T("
     SELECT '1',sab,nb
     FROM banks
     INTO :tbl1.colOTM,:tbl1.colSAB,:tbl1.colNMK
     WHERE kodn=4 and blk<>2 and blk<>3 and blk<>9 and fmi='$A' and fmo='$B'
     ORDER BY sab"), TBL_FillAll)
.head 6 -  Call WaitCursorOff()
.head 3 +  Custom Control: cc1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cMeter
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.383"
.head 6 -  Top:    4.405"
.head 6 -  Width:  5.3"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 0.25"
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
.head 5 -  Text Color: Dark Gray
.head 5 -  Background Color: Light Gray
.head 5 -  DLL Settings
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nUid
.head 3 -  Date/Time: dYes
.head 3 -  String: sFile1
.head 3 -  String: sFile2
.head 3 -  String: sBackDocPath
.head 3 -  Boolean: bOk
.head 3 -  Number: nKwo
.head 3 -  String: sFile
.head 3 -  Number: nI
.head 3 -  File Handle: hF
.head 3 -  String: sOdir
.head 3 -  File Handle: hSqlA
.head 3 -  Boolean: bFL
.head 3 -  String: sNLSK
.head 3 -  String: sSAB
.head 3 -  String: sNLS
.head 3 -  String: sNAMS
.head 3 -  String: sNMK
.head 3 -  String: sMFO
.head 3 -  Number: nMFO
.head 3 -  String: sND
.head 3 -  Number: nISP
.head 3 -  Number: nEL
.head 3 -  Number: nNM
.head 3 -  Number: nNP
.head 3 -  Number: nVOB
.head 3 -  Number: nDK
.head 3 -  Number: nS
.head 3 -  Number: nISM
.head 3 -  Date/Time: dDAPP
.head 3 -  String: sNAZ
.head 3 -  String: sPOND
.head 3 -  String: sFN_A
.head 3 -  String: sD_REC
.head 3 -  Number: nRNK
.head 3 -  String: sKOKK
.head 3 -  String: sTD
.head 3 -  Number: nISPZ
.head 3 -  Number: nREF
.head 3 -  String: sPOLU
.head 3 -  !
.head 3 -  Number: nRow
.head 3 -  Number: nTimeVWN
.head 3 -  String: sTimeVWN
.head 3 -  !
.head 3 -  Number: nPos
.head 3 -  Number: nDelta
.head 3 -  !
.head 3 -  String: sRBSName
.head 3 -  !
.head 3 -  Date/Time: dDATP
.head 3 -  String: sTIMP
.head 3 -  Number: nAAMF
.head 3 -  String: sNAQH
.head 3 -  String: sNMS
.head 3 -  String: sKVAL
.head 3 -  String: sNVAL
.head 3 -  Number: nKVD
.head 3 -  Date/Time: dODATE
.head 3 -  Date/Time: dVDATE
.head 3 -  Date/Time: dDPOTK
.head 3 -  Date/Time: dDPOPK
.head 3 -  Number: nETALS
.head 3 -  Number: nKPOTK
.head 3 -  Number: nKPOPK
.head 3 -  Number: nDIGIT
.head 3 -  Number: nSISV
.head 3 -  Number: nSIS
.head 3 -  String: sISPK
.head 3 -  Number: nKVK
.head 3 -  Number: nND
.head 3 -  Number: nISV
.head 3 -  Number: nISR
.head 3 -  String: sNAZN
.head 3 -  Number: nISPK
.head 3 -  !
.head 3 -  Number: nPP
.head 3 -  Number: nSR
.head 3 -  Number: nSV
.head 3 -  String: sTP
.head 3 -  String: sNBSK
.head 3 -  String: sNBS
.head 3 -  String: sFIOI
.head 3 -  Number: nKV
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalHideWindow(cc1)
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set nUid = GetUserId()
.head 4 -  Set dYes = GetBankDate()
.head 4 -  Set sFile1 = 'VWAB_N.Dbf'
.head 4 -  Set sFile2 = 'VWABSN.Dbf'
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('ElektroKlients', 'BackDocPath', GetPrnDir(), sBackDocPath,
     GetIniFileName())
.head 4 -  Set sBackDocPath = IifS(Right(sBackDocPath, 1)='\\', sBackDocPath, sBackDocPath || '\\')
.head 4 -  Call SalGetProfileString('ElektroKlients', 'TimeVWN', '30', sTimeVWN, GetIniFileName())
.head 4 -  Set nTimeVWN = Min(Max(Val(sTimeVWN), 0), 65)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalSetFocus(tbl1)
.head 4 -  Call SalTblSetFocusCell(tbl1, 0, tbl1.colOTM, 0, 1)
.head 1 +  Form Window: frm_Tasks
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Выполнение задач
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? No
.head 3 -  Minimizable? No
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   2.45"
.head 4 -  Top:    1.042"
.head 4 -  Width:  6.25"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.179"
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
.head 2 -  Description: Журнализатор
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
.head 3 -  Background Text: Текущая задача
.head 4 -  Resource Id: 40260
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    0.095"
.head 5 -  Width:  2.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfCurrent
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
.head 6 -  Left:   0.183"
.head 6 -  Top:    0.321"
.head 6 -  Width:  4.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Multiline Field: mlErrors
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 10000
.head 5 -  String Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.183"
.head 6 -  Top:    0.655"
.head 6 -  Width:  5.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 1.083"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  ! cTimer: pbTimer
.winattr class Pushbutton:
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTimer
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: 0
.head 4 -  Window Location and Size
.head 5 -  Left:   6.083"
.head 5 -  Top:    0.071"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.75"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +  Message Actions 
.head 5 +  On SAM_Timer
.head 6 +  Loop 
.head 7 +  If FindNextTask()
.head 8 -  Call ExecuteCurrentTask()
.head 7 +  Else 
.head 8 -  Break 
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.483"
.head 5 -  Top:    0.155"
.head 5 -  Width:  1.3"
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
.head 6 -  Call SalDestroyWindow(frm_Tasks)
.head 3 +  Pushbutton: pbTimer
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.133"
.head 5 -  Top:    0.095"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? No
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
.head 5 +  On SAM_Timer
.head 6 -  ! Call SaveInfoToLog('TTTTTTTT SAM_Timer')
.head 6 -  ! Call Debug('TTTTTTTT SAM_Timer')
.head 6 +  ! Loop 
.head 7 +  If FindNextTask()
.head 8 -  Call SalTimerKill(pbTimer, 1)
.head 8 -  Call ExecuteCurrentTask()
.head 8 -  Call SaveInfoToLog('TTTTTTTT after Execute --- ' || Str(CurrentTask) || ' ' || sNames[CurrentTask])
.head 8 -  Break 
.head 7 +  Else 
.head 8 -  ! Call SalTimerSet(pbTimer, 1, 1000)
.head 8 -  Break 
.head 6 -  Call SalTimerKill(pbTimer, 1)
.head 6 +  If FindNextTask()
.head 7 -  ! Call SaveInfoToLog('TTTTTTTT before Execute --- ' || Str(CurrentTask) || ' ' || sNames[CurrentTask])
.head 7 -  Call ExecuteCurrentTask()
.head 7 -  ! Call SaveInfoToLog('TTTTTTTT after Execute --- ' || Str(CurrentTask) || ' ' || sNames[CurrentTask])
.head 7 -  ! Call SaveInfoToLog('TTTTTTTT after Execute --- ' || Str(CurrentTask) || ' ' || sNames[CurrentTask])
.head 7 -  ! Call SaveInfoToLog('TTTTTTTT SalTimerSet ...')
.head 7 -  ! Call SalWindowGetProperty(hWndForm, 'WindowName', strWindowName)
.head 7 -  ! Call SaveInfoToLog('TTTTTTTT ' || strWindowName)
.head 6 +  ! Else 
.head 7 -  Call SaveInfoToLog('TTTTTTTT no FindNextTask')
.head 6 -  Set CurrentTask = -1
.head 6 -  Call SalTimerSet(pbTimer, 1, 1000)
.head 2 +  Functions
.head 3 +  Function: FindNextTask
.head 4 -  Description: Установить след. задачу
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: FirstTask
.head 5 -  Date/Time: dServer
.head 5 -  Number: nYear1
.head 5 -  Number: nMonth1
.head 5 -  Number: nDay1
.head 5 -  Number: nHour1
.head 5 -  Number: nMinute1
.head 5 -  Number: nSecond1
.head 4 +  Actions
.head 5 +  If not fExecuting
.head 6 -  Set FirstTask = CurrentTask
.head 6 -  ! Call SaveInfoToLog('FindNextTask: begin FirstTask = ' || Str(FirstTask))
.head 6 -  ! Call SaveInfoToLog('FindNextTask: begin iCount = ' || Str(iCount))
.head 6 +  Loop
.head 7 -  Set CurrentTask = CurrentTask + 1
.head 7 -  ! Call SaveInfoToLog('FindNextTask 0: CurrentTask = ' || Str(CurrentTask))
.head 7 +  If CurrentTask >= iCount
.head 8 -  Set CurrentTask = -1
.head 8 -  Return FALSE
.head 7 -  ! Определяю условие запуска
.head 7 +  If nMethods[CurrentTask]
.head 8 -  ! Запуск по еже(дневно,недельно,месячно,годно)
.head 8 -  ! Call SaveInfoToLog('FindNextTask 1: CurrentTask = ' || Str(CurrentTask))
.head 8 -  Call SalDateDeconstruct(GetServerDate(), nYear1, nMonth1, nDay1, nHour1, nMinute1, nSecond1)
.head 8 -  Set dServer = SalDateConstruct(nYear1, nMonth1, nDay1, nHour1, nMinute1, 0)
.head 8 +  If dReal[CurrentTask] = dServer ! было - < GetServerDate()
.head 9 -  Set dfCurrent = sNames[CurrentTask]
.head 9 -  Return TRUE
.head 7 +  Else
.head 8 -  ! Запуск через период в секундах
.head 8 -  ! Call SaveInfoToLog('FindNextTask Z: CurrentTask = ' || Str(CurrentTask))
.head 8 +  If (dtTasks[CurrentTask] = DATETIME_Null) or
   (((SalDateCurrent()-dtTasks[CurrentTask])*24*3600) > nIntervals[CurrentTask])
.head 9 -  Set dfCurrent = sNames[CurrentTask]
.head 9 -  Return TRUE
.head 7 +  If CurrentTask = FirstTask
.head 8 -  Return FALSE
.head 7 -  ! Call SaveInfoToLog('FindNextTask cykle: CurrentTask = ' || Str(CurrentTask))
.head 5 +  Else
.head 6 -  Return FALSE
.head 3 +  Function: ExecuteCurrentTask
.head 4 -  Description: Выполнить текущую
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  ! Времянки
.head 5 -  Number: nError
.head 5 -  Number: nErrorPos
.head 5 -  Number: nReturn	
.head 5 -  String: strReturn
.head 5 -  Date/Time: dtReturn
.head 5 -  Window Handle: hWndReturn
.head 4 +  Actions
.head 5 +  If not fExecuting
.head 6 -  ! Здесь мы выполняем функцию
.head 6 +  If bFirst[CurrentTask]
.head 7 -  Set fExecuting = TRUE
.head 7 -  Call SalCompileAndEvaluate(
     sTasks[CurrentTask],
     nError,
     nErrorPos,
     nReturn,
     strReturn,
     dtReturn,
     hWndReturn,
     TRUE,
     SalContextCurrent())
.head 7 +  If nError = 0
.head 8 -  Call SaveInfoToLog('Функция выполнена: ' || sNames[CurrentTask])
.head 8 -  ! Call SalDestroyWindow(hWndReturn)
.head 7 +  Else
.head 8 -  Call SaveErrorToLog('Ошибка (' || Str(nError) || ') при выполнении функции: ' || sNames[CurrentTask])
.head 8 -  Set mlErrors = mlErrors || ' --> Ошибка (' || Str(nError) || ') при выполнении функции: ' || sNames[CurrentTask]
.head 7 -  !
.head 7 -  ! Call Debug('CurrentTask = ' || Str(CurrentTask))
.head 7 -  Set dtTasks[CurrentTask] = SalDateCurrent()
.head 7 -  ! Call Debug('2')
.head 7 +  If nMethods[CurrentTask]
.head 8 -  Set dReal[CurrentTask] = EvaluateRealDate(nMethods[CurrentTask], GetServerDate()+1, dT_Dates[CurrentTask])
.head 7 -  ! Call Debug('3')
.head 6 +  Else
.head 7 -  Set bFirst[CurrentTask] = TRUE
.head 6 -  Set fExecuting = FALSE
.head 6 -  Set dfCurrent = 'Ожидание ...'
.head 6 -  ! Call SaveInfoToLog('TTTTTTTT Ожидание ...')
.head 6 -  ! Set CurrentTask = -1
.head 6 -  ! Call Wait(5*600000)
.head 6 -  Return TRUE
.head 5 +  Else
.head 6 -  ! Set CurrentTask = -1
.head 6 -  Set fExecuting = FALSE
.head 6 -  Return FALSE
.head 3 +  Function: EvaluateRealDate
.head 4 -  Description: Вычисление следующей даты запуска задачи
.head 4 +  Returns
.head 5 -  Date/Time:
.head 4 +  Parameters
.head 5 -  Number: nMethod
.head 5 -  Date/Time: dCurrent
.head 5 -  Date/Time: dSheduled
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nYear1
.head 5 -  Number: nMonth1
.head 5 -  Number: nDay1
.head 5 -  Number: nHour1
.head 5 -  Number: nMinute1
.head 5 -  Number: nSecond1
.head 5 -  Number: nDow1
.head 5 -  Number: nYear2
.head 5 -  Number: nMonth2
.head 5 -  Number: nDay2
.head 5 -  Number: nHour2
.head 5 -  Number: nMinute2
.head 5 -  Number: nSecond2
.head 5 -  Number: nDow2
.head 5 -  Date/Time: Result
.head 4 +  Actions
.head 5 -  ! Call Debug('a')
.head 5 -  Set Result = DATETIME_Null
.head 5 +  If nMethod = NUMBER_Null or dSheduled = Result
.head 6 -  Return Result
.head 5 -  ! Call Debug('b')
.head 5 -  Call SalDateDeconstruct(dCurrent,  nYear1, nMonth1, nDay1, nHour1, nMinute1, nSecond1)
.head 5 -  Call SalDateDeconstruct(dSheduled, nYear2, nMonth2, nDay2, nHour2, nMinute2, nSecond2)
.head 5 +  Select Case nMethod
.head 6 -  ! Ежедневно
.head 6 +  Case 1
.head 7 -  Set Result = SalDateConstruct(nYear1, nMonth1, nDay1, nHour2, nMinute2, nSecond2)
.head 7 -  Break
.head 6 -  ! Еженедельно
.head 6 +  Case 2
.head 7 -  ! Определяю дни недели
.head 7 -  Set nDow1 = SalDateWeekday(dCurrent)
.head 7 -  Set nDow2 = SalDateWeekday(dSheduled)
.head 7 -  ! Нахожу искомый день на текущей неделе
.head 7 -  Set Result = SalDateWeekBegin(dCurrent) + nDow2
.head 7 -  Call SalDateDeconstruct(Result, nYear1, nMonth1, nDay1, nHour1, nMinute1, nSecond1)
.head 7 -  Set Result = SalDateConstruct(nYear1, nMonth1, nDay1, nHour2, nMinute2, nSecond2)
.head 7 -  Break
.head 6 -  ! Ежемесячно
.head 6 +  Case 3
.head 7 -  Set Result = SalDateConstruct(nYear1, nMonth1, nDay2, nHour2, nMinute2, nSecond2)
.head 7 -  Break
.head 6 -  ! Ежегодно
.head 6 +  Case 4
.head 7 -  Set Result = SalDateConstruct(nYear1, nMonth2, nDay2, nHour2, nMinute2, nSecond2)
.head 7 -  Break
.head 5 +  ! If Result < dCurrent
.head 6 +  Select Case nMethod
.head 7 -  ! Ежедневно
.head 7 +  Case 1
.head 8 -  Call SalDateDeconstruct(dCurrent, nYear1, nMonth1, nDay1, nHour1, nMinute1, nSecond1)
.head 8 -  Set dCurrent = SalDateConstruct(nYear1, nMonth1, nDay1+1, 0, 0, 0)
.head 8 -  Break 
.head 7 -  ! Еженедельно
.head 7 +  Case 2
.head 8 -  Call SalDateDeconstruct(dCurrent, nYear1, nMonth1, nDay1, nHour1, nMinute1, nSecond1)
.head 8 -  Set dCurrent = SalDateConstruct(nYear1, nMonth1, nDay1+7, 0, 0, 0)
.head 8 -  Break 
.head 7 -  ! Ежемесячно
.head 7 +  Case 3
.head 8 -  Call SalDateDeconstruct(dCurrent, nYear1, nMonth1, nDay1, nHour1, nMinute1, nSecond1)
.head 8 -  Set dCurrent = SalDateConstruct(nYear1, nMonth1+1, 1, 0, 0, 0)
.head 8 -  Break 
.head 7 -  ! Ежегодно
.head 7 +  Case 4
.head 8 -  Call SalDateDeconstruct(dCurrent, nYear1, nMonth1, nDay1, nHour1, nMinute1, nSecond1)
.head 8 -  Set dCurrent = SalDateConstruct(nYear1+1, 1, 1, 0, 0, 0)
.head 8 -  Break 
.head 5 +  ! Else
.head 6 -  Break 
.head 5 -  Return Result
.head 3 +  Function: SalDateDeconstruct
.head 4 -  Description: Разбор даты на запчасти
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Date/Time: dDate
.head 5 -  Receive Number: nYear
.head 5 -  Receive Number: nMonth
.head 5 -  Receive Number: nDay
.head 5 -  Receive Number: nHour
.head 5 -  Receive Number: nMinute
.head 5 -  Receive Number: nSecond
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set nYear   = SalDateYear(dDate)
.head 5 -  Set nMonth  = SalDateMonth(dDate)
.head 5 -  Set nDay    = SalDateDay(dDate)
.head 5 -  Set nHour   = SalDateHour(dDate)
.head 5 -  Set nMinute = SalDateMinute(dDate)
.head 5 -  Set nSecond = SalDateSecond(dDate)
.head 5 -  Return TRUE
.head 3 +  Function: GetServerDate
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Date/Time:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Date/Time: Result
.head 4 +  Actions
.head 5 +  If SqlPrepareAndExecute(hSqlAux(), "
   SELECT SYSDATE
   INTO :Result
   FROM dual")
.head 6 +  If SqlFetchNext(hSqlAux(), nFetchRes)
.head 7 -  Return Result
.head 5 -  Return DATETIME_Null
.head 3 +  ! Function: Wait
.head 4 -  Description: 
.head 4 -  Returns 
.head 4 +  Parameters 
.head 5 -  Number: nPeriod
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  Number: nTemp
.head 5 -  Number: nBeg
.head 4 +  Actions 
.head 5 -  Set nTemp = nPeriod
.head 5 +  While nTemp > 0
.head 6 -  Call SalNumberRandInit(0)
.head 6 -  Set nTemp = nTemp - 1
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  ! Дата последнего запуска задачи
.head 3 -  Date/Time: dtTasks[*]
.head 3 -  ! Интервалы
.head 3 -  Number: nIntervals[*]
.head 3 -  ! Наименования
.head 3 -  String: sNames[*]
.head 3 -  ! Вызовы
.head 3 -  String: sTasks[*]
.head 3 -  ! Методы срабатывания
.head 3 -  Number: nMethods[*]
.head 3 -  ! Даты срабатывания из БД
.head 3 -  Date/Time: dT_Dates[*]
.head 3 -  ! Даты срабатывания реальные
.head 3 -  Date/Time: dReal[*]
.head 3 -  Boolean: bFirst[*]
.head 3 -  ! Index
.head 3 -  Number: i
.head 3 -  Number: iCount
.head 3 -  ! Тек. задача
.head 3 -  Number: CurrentTask
.head 3 -  ! Флаг выполнения
.head 3 -  Boolean: fExecuting
.head 3 -  ! Дата старта
.head 3 -  Date/Time: dStart
.head 3 -  !
.head 3 -  Date/Time: dT_Dates1
.head 3 -  Number: nIntervals1
.head 3 -  String: sNames1
.head 3 -  String: sTasks1
.head 3 -  Number: nMethods1
.head 3 -  ! String: strWindowName
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set fTaskShed = TRUE
.head 4 -  Call SalCenterWindow(frm_Tasks)
.head 4 -  ! Call Debug('0 - Вычитка задач')
.head 4 -  ! Вычитка задач
.head 4 -  Set dStart = GetServerDate()
.head 4 +  If SqlPrepareAndExecute(hSqlAux2(), '
   SELECT name,function,intereval,method,trigger_date
   INTO   :sNames1,:sTasks1,:nIntervals1,:nMethods1,:dT_Dates1
   FROM   user_tasks
   ORDER BY ord,task_id')
.head 5 -  ! Выделяю место под задачи
.head 5 -  Call SalArraySetUpperBound(dtTasks, 1, 100)
.head 5 -  Call SalArraySetUpperBound(nIntervals, 1, 100)
.head 5 -  Call SalArraySetUpperBound(sNames, 1, 100)
.head 5 -  Call SalArraySetUpperBound(sTasks, 1, 100)
.head 5 -  Call SalArraySetUpperBound(nMethods, 1, 100)
.head 5 -  Call SalArraySetUpperBound(dT_Dates, 1, 100)
.head 5 -  Call SalArraySetUpperBound(dReal, 1, 100)
.head 5 -  Call SalArraySetUpperBound(bFirst, 1, 100)
.head 5 -  ! Читаю задачи
.head 5 -  ! Call Debug('1 - Читаю задачи')
.head 5 -  Set i = 0
.head 5 +  While SqlFetchNext(hSqlAux2(), nFetchRes)
.head 6 -  Set sNames[i]     = sNames1
.head 6 -  Set sTasks[i]     = sTasks1
.head 6 -  Set nIntervals[i] = nIntervals1
.head 6 -  Set nMethods[i]   = nMethods1
.head 6 -  Set dT_Dates[i]   = dT_Dates1
.head 6 -  ! Чищу даты
.head 6 -  Set dtTasks[i] = DATETIME_Null
.head 6 -  ! Определяю следующую дату вызова
.head 6 -  ! Call Debug('do dReal ' || Str(i))
.head 6 -  ! Call Debug('nMethods[i] = ' || Str(nMethods[i]))
.head 6 -  Set dReal[i] = EvaluateRealDate(nMethods[i], dStart, dT_Dates[i])
.head 6 -  ! Call Debug('dReal[i] = ' || SalFmtFormatDateTime(dReal[i], 'dd-MM-yyyy hhhh:mm:ss,mmmmmm'))
.head 6 -  ! Call Debug('posle dReal ' || Str(i))
.head 6 -  Set bFirst[i] = not (nMethods[i]=NUMBER_Null)
.head 6 -  Set i = i + 1
.head 5 -  ! Call Debug('ВСЕГО i = ' || Str(i))
.head 5 -  ! Call Debug('sNames[0] = ' || sNames[0])
.head 5 -  ! Call Debug('sTasks[0] = ' || sTasks[0])
.head 5 +  If i = 0
.head 6 -  Call SalMessageBox('Нет задач для обработки!', 'Ошибка', MB_Ok | MB_IconStop)
.head 6 -  Call SalDestroyWindow(frm_Tasks)
.head 5 +  Else
.head 6 -  ! Call pbTimer.Init(10, 0, TRUE)
.head 6 -  Call SalTimerSet(pbTimer, 1, 1000)
.head 6 -  Set iCount = i
.head 6 -  Set CurrentTask = -1
.head 6 -  Set dfCurrent = 'Ожидание ....'
.head 3 +  On SAM_Destroy
.head 4 -  Set fTaskShed = FALSE
.head 4 -  Call SalTimerKill(pbTimer, 1)
.head 1 +  Table Window: frm_TaskEdit
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Редактирование задач автомат. выполнения
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
.head 4 -  Width:  13.233"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
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
.head 2 -  Description: Редактор журнала функций
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
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
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
.head 5 -  Resource Id: 42494
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
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
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
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
.head 5 -  Resource Id: 42495
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
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
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
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
.head 5 -  Resource Id: 42496
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: colID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
польз.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.667"
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
.head 3 +  Column: colUsername
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ФИО
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 100
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.017"
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
.head 4 +  Message Actions
.head 5 +  On SAM_DoubleClick
.head 6 +  If FunNSIGet( 'STAFF', 'FIO', sCode, sSemantic )
.head 7 -  Set colID=SalStrToNumber( sCode )
.head 7 -  Set colUsername=sSemantic
.head 7 -  Call SalTblSetRowFlags( frm_TaskEdit, SalTblQueryContext(frm_TaskEdit), ROW_Edited, TRUE )
.head 3 +  Column: colORD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: №
пп
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  0.783"
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
.head 3 +  Column: colTASK_ID
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
задачи
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  1.067"
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
.head 3 +  Column: colTASK_NAME
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
задачи
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 100
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  2.7"
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
.head 4 +  Message Actions
.head 5 +  On SAM_DoubleClick
.head 6 +  If FunNSIGet( 'TASK_LIST', 'NAME', sCode, sSemantic )
.head 7 -  Set colTASK_ID=SalStrToNumber( sCode )
.head 7 -  Set colTASK_NAME=sSemantic
.head 7 -  Call SalTblSetRowFlags( frm_TaskEdit, SalTblQueryContext(frm_TaskEdit), ROW_Edited, TRUE )
.head 3 +  Column: colINTERVAL
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Инрервал
(с)
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  Default
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
.head 3 +  Column: colMETHOD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  Default
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
.head 3 +  Column: colMETHOD_NAME
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Метод
вызова
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 45
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.617"
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
.head 4 +  Message Actions
.head 5 +  On SAM_DoubleClick
.head 6 +  If FunNSIGet( 'TASK_METHOD', 'NAME', sCode, sSemantic )
.head 7 -  Set colMETHOD=SalStrToNumber( sCode )
.head 7 -  Set colMETHOD_NAME=sSemantic
.head 3 +  Column: colTRIGGER_DATE
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата 
вызова
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  2.333"
.head 4 -  Width Editable? Yes
.head 4 -  Format: dd/MM/yyyy hhhh:mm
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
.head 3 +  Column: colIdKey
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  Default
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
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  String: sCode
.head 3 -  String: sSemantic
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set fTaskEdit = TRUE
.head 4 -  Set nFlags=0
.head 4 -  !
.head 4 -  !
.head 4 -  !
.head 4 -  Set strSqlPopulate=
"SELECT l.id, s.fio, l.ord, l.task_id, t.name, 
        l.interval, l.method, m.name, l.trigger_date, idkey  
 INTO 
        :frm_TaskEdit.colID, :frm_TaskEdit.colUsername, :frm_TaskEdit.colORD, :frm_TaskEdit.colTASK_ID,
        :frm_TaskEdit.colTASK_NAME, 
        :frm_TaskEdit.colINTERVAL, :frm_TaskEdit.colMETHOD, :frm_TaskEdit.colMETHOD_NAME, :frm_TaskEdit.colTRIGGER_DATE, :colIdKey 
 FROM task_staff l, task_list t, staff s, task_method m 
 WHERE  l.id=s.id and l.task_id=t.task_id and l.method=m.method(+) 
 ORDER by l.id, l.ord, l.task_id "
.head 4 -  !
.head 4 -  !
.head 4 -  !
.head 4 -  Set strSqlInsert= 
"insert into task_staff(id,ord,task_id,interval,method,trigger_date, idkey)
(
 select :frm_TaskEdit.colID, :frm_TaskEdit.colORD, :frm_TaskEdit.colTASK_ID, :frm_TaskEdit.colINTERVAL,
        :frm_TaskEdit.colMETHOD, :frm_TaskEdit.colTRIGGER_DATE, nvl(max(idkey),0)+1 
 from task_staff
)"
.head 4 -  !
.head 4 -  !
.head 4 -  !
.head 4 -  Set strSqlDelete=
"delete from task_staff where idKey=:frm_TaskEdit.colIdKey"
.head 4 -  !
.head 4 -  !
.head 4 -  !
.head 4 -  Set strSqlUpdate=
"update task_staff set 
   task_id=:frm_TaskEdit.colTASK_ID, interval=:frm_TaskEdit.colINTERVAL, METHOD=:frm_TaskEdit.colMETHOD, 
   trigger_date=:frm_TaskEdit.colTRIGGER_DATE,  id =:frm_TaskEdit.colID, ord = :frm_TaskEdit.colORD 
 where idkey=:frm_TaskEdit.colIdKey"
.head 4 -  Set strFilterTblName='TASK_STAFF'
.head 4 -  Set fFilterAtStart=FALSE
.head 4 -  Call SalSendClassMessage( UM_Create, 0, 0 )
.head 3 +  On SAM_Destroy
.head 4 -  Set fTaskEdit = FALSE
.head 1 +  Table Window: tOvr
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Протокол проверки контрольных точек ОВЕРДРАФТА
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   1.925"
.head 4 -  Top:    1.604"
.head 4 -  Width:  10.967"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
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
.head 5 -  Resource Id: 29955
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
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
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.7"
.head 6 -  Top:    0.071"
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
.head 6 -  Left:   3.35"
.head 6 -  Top:    Class Default
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
.head 5 -  Resource Id: 29956
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
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
.head 6 -  Left:   4.0"
.head 6 -  Top:    Class Default
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
.head 5 -  Resource Id: 29957
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: ID 
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.717"
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
.head 3 +  Column: DK 
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: DK
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.833"
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
.head 3 +  Column: NLSA 
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-А
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.383"
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
.head 3 +  Column: NLSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-Б
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.383"
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
.head 3 +  Column: S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  1.933"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
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
.head 3 +  Column: TXT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Подробнее о транзакции
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  3.917"
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
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: DAT
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set tOvr.DAT=GetBankDate()
.head 4 -  ! If SqlPLSQLCommand(hSql(),  "BARS.FINIS_P(DAT)")
.head 4 -  Set tOvr.strPrintFileName = 'tOvr'
.head 4 -  Set tOvr.strFilterTblName = 'TMP_OVR'
.head 4 -  Set tOvr.strSqlPopulate =
"SELECT ID, DK, NLSA, NLSB, S/100, txt 
 INTO  :tOvr.ID, :tOvr.DK, :tOvr.NLSA, :tOvr.NLSB, :tOvr.S, :tOvr.TXT
 FROM tmp_ovr where dat=:tOvr.DAT 
 ORDER BY  1,2,3 "
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 1 +  Table Window: tFinis
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Протокол проверки контрольных точек
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
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
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
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
.head 3 -  Maximum Rows in Memory: 100000
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
.head 5 -  Resource Id: 4876
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
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
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
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
.head 5 -  Resource Id: 4877
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
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
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
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
.head 5 -  Resource Id: 4878
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Column: ID 
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Код
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.717"
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
.head 3 +  Column: KV 
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.833"
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
.head 3 +  Column: NLS 
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.383"
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
.head 3 +  Column: TXT
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Подробно
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  5.733"
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
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: DAT
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set DAT = GetBankDate()
.head 4 -  ! If SqlPLSQLCommand(hSql(),  "BARS.FINIS_P(DAT)")
.head 4 +  If SqlPLSQLCommand(hSql(),  "BARS.FINIS_P_" || GetBankMfo() || "(DAT)")
.head 5 -  Set tFinis.strPrintFileName = 'tFinis'
.head 5 -  Set tFinis.strFilterTblName = 'TMP_FINIS'
.head 5 -  Set tFinis.strSqlPopulate =
"SELECT ID, KV, NLS, TXT 
 INTO  :tFinis.ID, :tFinis.KV, :tFinis.NLS, :tFinis.TXT 
 FROM tmp_finis
 ORDER BY  1,2,3 "
.head 5 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 1 +  ! cGenericTable: tVBNK
.winattr class Table Window:
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Экспорт сведенных документов
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? Yes
.head 3 -  Minimizable? Yes
.head 3 -  System Menu? Yes
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  16.367"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.781"
.head 4 -  Height Editable? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 3 -  View: Table
.head 3 -  Allow Row Sizing? No
.head 3 -  Lines Per Row: Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: Default
.head 3 -  Discardable? No
.end
.head 2 -  Description: 
.head 2 -  Named Menus 
.head 2 -  Menu 
.head 2 +  Tool Bar 
.winattr
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.427"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 3 +  Contents 
.head 4 +  Pushbutton: pbIns
.winattr
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Insert.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbDel
.winattr
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.514"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Delrec.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbRefresh
.winattr
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.943"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Refresh.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbUpdate
.winattr
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.383"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Save.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  4.557"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  4.557"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 4 +  Pushbutton: pbSearch
.winattr
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.043"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\search.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbFilter
.winattr
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.483"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Filter.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbDetails
.winattr
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.917"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\open.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 +  Pushbutton: pbPrint
.winattr
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   3.35"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: F5
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  3.886"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  3.886"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 4 +  Pushbutton: pbExit
.winattr
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.014"
.head 6 -  Top:    0.073"
.head 6 -  Width:  0.43"
.head 6 -  Width Editable? No
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? No
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Esc
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 -  Message Actions 
.head 4 -  Line 
.winattr
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  1.9"
.head 6 -  Begin Y:  -0.01"
.head 6 -  End X:  1.9"
.head 6 -  End Y:  0.448"
.head 5 -  Visible? Yes
.head 5 -  Line Style: Etched
.head 5 -  Line Thickness: 1
.head 5 -  Line Color: 3D Shadow Color
.end
.head 4 +  Pushbutton: pbExport
.winattr class
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbEdit
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   4.883"
.head 6 -  Top:    0.071"
.head 6 -  Width:  0.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.317"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: (none)
.head 5 -  Font Name: MS Sans Serif
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Edit.bmp
.head 5 -  Picture Transparent Color: Gray
.head 5 -  Image Style: Single
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.end
.head 5 +  Message Actions 
.head 6 +  On SAM_Click
.head 7 -  Set nRow=TBL_MinRow
.head 7 -  Set sFile=sUNICORNDir||'UN'||SalFmtFormatDateTime( GetBankDate(  ),'yyMMdd')||'.txt'
.head 7 -  Call SalFileOpen( fH, sFile, OF_Delete )
.head 7 +  If SalFileOpen( fH, sFile, OF_Create|OF_ReadWrite )
.head 8 +  While SalTblFindNextRow( tVBNK, nRow, 0, 0 )
.head 9 -  Call SalTblSetFocusRow( tVBNK, nRow )
.head 9 -  Call SalTblSetContext( tVBNK, nRow )
.head 9 -  Set sBuffer=ND||'|'||SalFmtFormatDateTime( GetBankDate(  ),'dd.MM.yyyy')||'|'||
            NLSA||'|'||NLSB||'|0|'||NMSB||'|'||Str(S)||'|'||Str(KV)||'|'||
            NAZN||'|'||Str(VOB)||'|1|'||Str(SK)||'|'||sOKPO||'|'||sOKPO||'||'||
            NMSA||'|'||PutCrLf(  )
.head 9 -  ! Если нужно перекодировать в DOS
.head 9 -  ! Set sBuffer=StrWinToDosX(ND||'|'||SalFmtFormatDateTime( GetBankDate(  ),'dd.MM.yyyy')||'|'||
            NLSA||'|'||NLSB||'|0|'||NMSB||'|'||Str(S)||'|'||Str(KV)||'|'||
            NAZN||'|'||Str(VOB)||'|1|'||Str(SK)||'|'||sOKPO||'|'||sOKPO||'||'||
            NMSA)||'|'||PutCrLf(  )
.head 9 -  ! Call Debug(sBuffer)
.head 9 -  ! Call DebugN(Len(sBuffer))
.head 9 -  ! Set nZZZ=SalFileWrite( fH, sBuffer, Len(sBuffer) )
.head 9 -  ! Call DebugN(nZZZ)
.head 9 +  If SalFileWrite( fH, sBuffer, Len(sBuffer) )!=Len(sBuffer)
.head 10 -  Call SalFileClose(fH)
.head 10 -  Call SalMessageBox( 'Ошибка записи файла '||sFile, 'Внимание!', MB_IconStop )
.head 10 -  Return FALSE
.head 8 -  Call SalFileClose(fH)
.head 8 -  Call MessageNoWait( 'Сформирован файл '||sFile,'Сообщение',nTimer ,0 )
.head 7 +  Else 
.head 8 -  Call SalMessageBox( 'Невозможно открыть файл '||sFile, 'Внимание!', MB_IconStop )
.head 2 +  Contents 
.head 3 +  Column: ND
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Номер
док
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Right
.head 4 -  Width:  0.633"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: FDAT
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Дата
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Date/Time
.head 4 -  Justify: Left
.head 4 -  Width:  1.117"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Date
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: VOB
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вид
обр.
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.5"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NLSA
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
отправителя
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 15
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.883"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NMSA
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
отправителя
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.467"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NLSB
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет
получателя
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 15
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.9"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NMSB
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Наименование
получателя
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.467"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: S
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
документа
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  Default
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: KV 
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вал
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 3
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.467"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: SK
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: СК
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  0.567"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 3 +  Column: NAZN
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назначение платежа
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 160
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  5.733"
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
.end
.head 4 -  List Values 
.head 4 -  Message Actions 
.head 2 -  Functions 
.head 2 -  Window Parameters 
.head 2 +  Window Variables 
.head 3 -  Date/Time: DAT
.head 3 -  File Handle: fH
.head 3 -  Number: nRow
.head 3 -  String: sBuffer
.head 3 -  String: sFile
.head 3 -  String: sUNICORNDir
.head 3 -  Number: nTimer
.head 3 -  String: sOKPO
.head 3 -  Number: nZZZ
.head 2 +  Message Actions 
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set sOKPO = GetBankOkpoS(  )
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('Export', 'UNICORN', GetPrnDir(  ), sUNICORNDir, GetIniFileName())
.head 4 -  Set sUNICORNDir=sUNICORNDir||IifS(Right( sUNICORNDir,1 )='\\','','\\')
.head 4 -  Set nTimer=Max(Min(SalGetProfileInt( 'Export', 'UNICORN_Timer', 5, GetIniFileName()),65),1) 
.head 4 -  Set tVBNK.strPrintFileName = 'VBNK'
.head 4 -  ! Set tVBNK.strFilterTblName = 'TMP_FINIS'
.head 4 -  Set DAT=GetBankDate()
.head 4 +  If SqlPLSQLCommand(hSql(),"DPT.ODB_VABANK(DAT)")
.head 5 -  Set tVBNK.strSqlPopulate =
   "SELECT to_char(rownum),fdat,vob,sk,nlsd,'BARS',
           nlsk,'VABANK',s,kv,nazn
    INTO :tVBNK.ND,:tVBNK.FDAT,:tVBNK.VOB,:tVBNK.SK,
         :tVBNK.NLSA,:tVBNK.NMSA,:tVBNK.NLSB,:tVBNK.NMSB,
         :tVBNK.S,:tVBNK.KV,:tVBNK.NAZN
    FROM dpt_vabank_oper WHERE fdat=:tVBNK.DAT
    ORDER BY nlsd, nlsk"
.head 5 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  ! On SAM_CreateComplete
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('Export', 'UNICORN', GetPrnDir(  ), sUNICORNDir, GetIniFileName())
.head 4 -  Set sUNICORNDir=sUNICORNDir||IifS(Right( sUNICORNDir,1 )='\\','','\\')
.head 4 -  Set nTimer=Max(Min(SalGetProfileInt( 'Export', 'UNICORN_Timer', 5, GetIniFileName()),65),1) 
.head 1 +  Form Window: frm_MsgFileViewer
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Просмотр файлов регламента
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
.head 4 -  Left:   1.813"
.head 4 -  Top:    1.781"
.head 4 -  Width:  9.733"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.679"
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
.head 3 +  Multiline Field: ml_Text
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
.head 5 -  Border? No
.head 5 -  Word Wrap? No
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.0"
.head 6 -  Top:    0.0"
.head 6 -  Width:  9.5"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 2.679"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbClose
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Close
.head 4 -  Window Location and Size
.head 5 -  Left:   3.85"
.head 5 -  Top:    2.762"
.head 5 -  Width:  1.35"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.31"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow( hWndForm )
.head 5 +  On SAM_Timer
.head 6 +  If bInitialized
.head 7 +  If nPlayWAV=1
.head 8 -  Call PlaySound( szAudioFilePath, NUMBER_Null,
	SND_NOWAIT | SND_ASYNC | SND_FILENAME | SND_NOSTOP )
.head 7 +  Else
.head 8 -  Set nCounter = 0
.head 8 +  Loop
.head 9 +  If nCounter > 3
.head 10 -  Break
.head 9 -  Call SalMessageBeep( 0xFFFFFFFF )
.head 9 -  Call Sleep(1000)
.head 9 -  Set nCounter = nCounter + 1
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: szFileName
.head 3 -  String: szFilePath
.head 3 -  Number: nPlayWAV
.head 3 -  String: szAudioFilePath
.head 2 +  Window Variables
.head 3 -  File Handle: hFile
.head 3 -  Boolean: bOk
.head 3 -  Boolean: bInitialized
.head 3 -  String: strDosBuffer
.head 3 -  String: strWinBuffer
.head 3 -  String: strSAB
.head 3 -  String: strBankName
.head 3 -  Number: nFetchRes
.head 3 -  Number: nCounter
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set bInitialized = FALSE
.head 4 -  ! Попытка открыть файл
.head 4 -  Set bOk = SalFileOpen (hFile, szFilePath, OF_Read|OF_Text|OF_Share_Exclusive )
.head 4 +  If bOk=FALSE
.head 5 -  Call SalDestroyWindow( hWndForm )
.head 5 -  Return -1
.head 4 -  ! Установка таймера
.head 4 -  Call SalTimerSet( pbClose, 33, 8000 ) ! играть музыку каждые 8 сек
.head 4 -  ! Установка заголовка окна
.head 4 -  Set strSAB = SalStrUpperX(SalStrMidX(szFileName,2,4))
.head 4 +  If NOT SqlPrepareAndExecute( hSql(), T("SELECT nb
 FROM Banks WHERE sab = :strSAB INTO :strBankName" ) )
.head 5 -  Call SalMessageBox ( 'SqlPrepareAndExecute was not successful','Error', MB_Ok )
.head 5 -  Return -1
.head 4 -  Call SqlFetchNext( hSql(), nFetchRes )
.head 4 +  If FETCH_Ok != nFetchRes
.head 5 -  Call SalMessageBox ( 'SqlFetchNext was not successful.'||
  PutCrLf()||'FETCH_Res='||SalNumberToStrX(nFetchRes,0), 'Error', MB_Ok )
.head 5 -  Return -1
.head 4 -  Call SalSetWindowText ( hWndForm, 'Сообщение '|| szFileName ||
' - '|| strSAB ||' - '||strBankName)
.head 4 -  ! Чтение файла
.head 4 -  Set ml_Text = ''
.head 4 -  Call SalFileSeek( hFile, 0, FILE_SeekBegin )
.head 4 -  Set strDosBuffer = SalStrRepeatX( ' ', 2048 )
.head 4 +  While SalFileGetStr( hFile, strDosBuffer, 2048 )
.head 5 -  Set strWinBuffer = StrDosToWinX( strDosBuffer )
.head 5 -  Set ml_Text = ml_Text || strWinBuffer || PutCrLf()
.head 4 -  Set bInitialized = TRUE
.head 3 +  On SAM_Destroy
.head 4 -  Call SalTimerKill ( pbClose, 33 )
.head 4 -  ! Удаление таймера и файла, деинициализация окна
.head 4 -  Call SalFileClose( hFile )
.head 4 -  Call SalFileOpen (hFile, szFilePath, OF_Delete )
.head 4 -  Set bInitialized = FALSE
.head 3 +  On SAM_CreateComplete
.head 4 +  If bInitialized
.head 5 -  Call SalSendMsg( pbClose, SAM_Timer, 0, 0 )
.head 1 +  Dialog Box: dlgVBNK
.head 2 -  Class: cGenericTableDlg
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Экспорт консолидированных проводок по "Вкладам населения" в ОДБ ВАБАНКА
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Display Style? Class Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  13.583"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
.head 4 -  Height Editable? Class Default
.head 3 -  Absolute Screen Location? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 2 -  Description:
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
.head 5 -  Class Child Ref Key: 11
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
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
.head 5 -  Class Child Ref Key: 12
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
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
.head 5 -  Class Child Ref Key: 20
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.095"
.head 6 -  Top:    Class Default
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
.head 5 -  Class Child Ref Key: 15
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
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
.head 5 -  Resource Id: 60847
.head 5 -  Class Child Ref Key: 19
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Coordinates
.head 6 -  Begin X:  0.8"
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  0.8"
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 13
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.55"
.head 6 -  Top:    Class Default
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
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 23
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.983"
.head 6 -  Top:    Class Default
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
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 14
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.417"
.head 6 -  Top:    Class Default
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
.head 5 -  Resource Id: 60848
.head 5 -  Class Child Ref Key: 21
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Coordinates
.head 6 -  Begin X:  1.983"
.head 6 -  Begin Y:  0.405"
.head 6 -  End X:  1.983"
.head 6 -  End Y:  -0.012"
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbOk
.head 5 -  Class Child Ref Key: 16
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.094"
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\CHKMAIL.BMP
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Create
.head 7 -  Set strTip = "Сформировать файл"
.head 7 -  Call SalTimerSet(hWndItem, 1, nTimer1*1000)
.head 6 +  On SAM_Timer
.head 7 -  Call SalSendMsg(hWndItem, SAM_Click, 0, 0)
.head 6 +  On SAM_Click
.head 7 -  Set nRow=TBL_MinRow
.head 7 -  Set sFile=sUNICORNDir||'UN'||SalFmtFormatDateTime( GetBankDate(  ),'yyMMdd')||'.txt'
.head 7 -  Call SalFileOpen( fH, sFile, OF_Delete )
.head 7 +  If SalFileOpen( fH, sFile, OF_Create|OF_ReadWrite )
.head 8 +  While SalTblFindNextRow( dlgVBNK.tbl, nRow, 0, 0 )
.head 9 -  Call SalTblSetFocusRow( dlgVBNK.tbl, nRow )
.head 9 -  Call SalTblSetContext( dlgVBNK.tbl, nRow )
.head 9 -  ! Set sBuffer=dlgVBNK.tbl.ND||'|'||SalFmtFormatDateTime( GetBankDate(  ),'dd.MM.yyyy')||'|'||
            dlgVBNK.tbl.NLSA||'|'||dlgVBNK.tbl.NLSB||'|0|'||dlgVBNK.tbl.NMSB||'|'||Str(dlgVBNK.tbl.S)||'|'||Str(dlgVBNK.tbl.KV)||'|'||
            dlgVBNK.tbl.NAZN||'|'||Str(dlgVBNK.tbl.VOB)||'|1|'||Str(dlgVBNK.tbl.SK)||'|'||sOKPO||'|'||sOKPO||'||'||
            dlgVBNK.tbl.NMSA||'|'||PutCrLf(  )
.head 9 -  ! Если нужно перекодировать в DOS
.head 9 -  Set sBuffer=StrWinToDosX(dlgVBNK.tbl.ND||'|'||SalFmtFormatDateTime( GetBankDate(  ),'dd.MM.yyyy')||'|'||
            dlgVBNK.tbl.NLSA||'|'||dlgVBNK.tbl.NLSB||'|0|'||dlgVBNK.tbl.NMSB||'|'||SalNumberToStrX(dlgVBNK.tbl.S,2)||'|'||Str(dlgVBNK.tbl.KV)||'|'||
            dlgVBNK.tbl.NAZN||'|'||Str(dlgVBNK.tbl.VOB)||'|1|'||Str(dlgVBNK.tbl.SK)||'|'||sOKPO||'|'||sOKPO||'||'||
            dlgVBNK.tbl.NMSA||'|')||PutCrLf(  )
.head 9 -  ! Set sBuffer=StrWinToDosX(ND||'|'||SalFmtFormatDateTime( GetBankDate(  ),'dd.MM.yyyy')||'|'||
            NLSA||'|'||NLSB||'|0|'||NMSB||'|'||Str(S)||'|'||Str(KV)||'|'||
            NAZN||'|'||Str(VOB)||'|1|'||Str(SK)||'|'||sOKPO||'|'||sOKPO||'||'||
            NMSA)||'|'||PutCrLf(  )
.head 9 -  ! Set nZZZ=SalFileWrite( fH, sBuffer, Len(sBuffer) )
.head 9 +  If SalFileWrite( fH, sBuffer, Len(sBuffer) )!=Len(sBuffer)
.head 10 -  Call SalFileClose(fH)
.head 10 -  Call SalMessageBox( 'Ошибка записи файла '||sFile, 'Внимание!', MB_IconStop )
.head 10 -  Return FALSE
.head 8 -  Call SalFileClose(fH)
.head 8 -  Call MessageNoWait( 'Сформирован файл '||sFile,'Сообщение',nTimer ,0 )
.head 8 -  Call SalTimerKill ( hWndForm, 1 )
.head 8 -  Call SalEndDialog( hWndForm, 0 )
.head 7 +  Else
.head 8 -  Call SalMessageBox( 'Невозможно открыть файл '||sFile, 'Внимание!', MB_IconStop )
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 17
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   2.817"
.head 6 -  Top:    Class Default
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
.head 5 -  Resource Id: 60849
.head 5 -  Class Child Ref Key: 22
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTableDlg
.head 5 -  Coordinates
.head 6 -  Begin X:  2.667"
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  2.667"
.head 6 -  End Y:  Class Default
.head 5 -  Visible? Class Default
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 2 +  Contents
.head 3 +  Child Table: tbl
.head 4 -  Class Child Ref Key: 8
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenericTableDlg
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  13.3"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
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
.head 5 +  Column: ND
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: №
док
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Right
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
.head 5 +  Column: FDAT
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Left
.head 6 -  Width:  1.05"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Date
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
.head 5 +  Column: VOB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид
обр.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.467"
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
.head 5 +  Column: NLSA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Счет
отправителя
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 15
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.65"
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
.head 5 +  Column: NMSA
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
отправителя
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.45"
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
.head 5 +  Column: NLSB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Счет
получателя
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 15
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.65"
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
.head 5 +  Column: NMSB
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
получателя
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.45"
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
.head 5 +  Column: S
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сумма
документа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Format: ###000
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
.head 5 +  Column: KV 
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вал
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.417"
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
.head 5 +  Column: SK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: СК
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
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
.head 5 +  Column: NAZN
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назначение платежа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 160
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.733"
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
.head 4 -  Window Variables
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Date/Time: DAT
.head 3 -  File Handle: fH
.head 3 -  Number: nRow
.head 3 -  String: sBuffer
.head 3 -  String: sFile
.head 3 -  String: sUNICORNDir
.head 3 -  Number: nTimer
.head 3 -  String: sOKPO
.head 3 -  Number: nTimer1
.head 3 -  Number: nZZZ
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  Set sOKPO = GetBankOkpoS(  )
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('Export', 'UNICORN', GetPrnDir(  ), sUNICORNDir, GetIniFileName())
.head 4 -  Set sUNICORNDir=sUNICORNDir||IifS(Right( sUNICORNDir,1 )='\\','','\\')
.head 4 -  Set nTimer=Max(Min(SalGetProfileInt( 'Export', 'UNICORN_Timer', 5, GetIniFileName()),65),1) 
.head 4 -  Set nTimer1=Max(Min(SalGetProfileInt( 'Export', 'UNICORN_AutoRun', 5, GetIniFileName()),65),1) 
.head 4 -  Set dlgVBNK.strPrintFileName = 'VBNK'
.head 4 -  ! Set dlgVBNK.strFilterTblName = 'TMP_FINIS'
.head 4 -  Set DAT=GetBankDate()
.head 4 +  If SqlPLSQLCommand(hSql(),"DPT.ODB_VABANK(DAT)")
.head 5 -  Set dlgVBNK.strSqlPopulate =
   "SELECT to_char(rownum),fdat,vob,sk,nlsd,'BARS',
           nlsk,'VABANK',s/100,kv,nazn
    INTO :dlgVBNK.tbl.ND,:dlgVBNK.tbl.FDAT,:dlgVBNK.tbl.VOB,:dlgVBNK.tbl.SK,
         :dlgVBNK.tbl.NLSA,:dlgVBNK.tbl.NMSA,:dlgVBNK.tbl.NLSB,:dlgVBNK.tbl.NMSB,
         :dlgVBNK.tbl.S,:dlgVBNK.tbl.KV,:dlgVBNK.tbl.NAZN
    FROM dpt_vabank_oper WHERE fdat=:dlgVBNK.DAT
    ORDER BY nlsd, nlsk"
.head 5 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  ! On SAM_CreateComplete
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('Export', 'UNICORN', GetPrnDir(  ), sUNICORNDir, GetIniFileName())
.head 4 -  Set sUNICORNDir=sUNICORNDir||IifS(Right( sUNICORNDir,1 )='\\','','\\')
.head 4 -  Set nTimer=Max(Min(SalGetProfileInt( 'Export', 'UNICORN_Timer', 5, GetIniFileName()),65),1) 
.head 1 +  Form Window: TechVip
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Создание файлов технической выписки
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Yes
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? No
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? No
.head 3 -  Minimizable? No
.head 3 -  System Menu? Yes
.head 3 -  Resizable? No
.head 3 -  Window Location and Size
.head 4 -  Left:   2.575"
.head 4 -  Top:    0.979"
.head 4 -  Width:  11.933"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.393"
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
.head 4 -  Visible? No
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Pushbutton: pbExec
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbExecute
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.483"
.head 5 -  Top:    0.06"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: F10
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
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 6 -  Call SalTblReset(tbl1)
.head 6 -  Call NewRow()
.head 6 -  Set tbl1.Col1 = 'Формирование файлов остатков ...'
.head 6 -  ! Set dfFD = ''
.head 6 -  ! Set dfResD = ''
.head 6 -  ! Set dfFO = 'Формирование файлов остатков ...'
.head 6 -  Call NewRow()
.head 6 -  Set tbl1.Col1 = 'Наполнение временной таблицы ...'
.head 6 -  ! Set dfResO = 'Наполнение временной таблицы ...'
.head 6 +  If SqlPLSQLCommand(hSql(), "p_l(nUid,dYes)")
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Call NewRow()
.head 7 -  Set tbl1.Col1 = 'Наполнение временной таблицы OK'
.head 7 -  ! лазить по OKPO_AFD
.head 7 -  Set nI = 0
.head 7 +  While nI < nTV
.head 8 -  Set sId_Kli = smId_Kli[nI]
.head 8 -  Call SalGetProfileString('TVO', Right(Str(SalDateYear(dYes)), 1) || Sep98md(dYes) || '.' || sId_Kli, '0', sNum1,
     'Bars98')
.head 8 +  If Val(sNum1) > 9
.head 9 -  Set sP = Chr(Val(sNum1)+55)
.head 8 +  Else
.head 9 -  Set sP = sNum1
.head 8 -  Set sNum1 = Str(Val(sNum1)+1)
.head 8 -  Set sNameO = 'R' || sSab || Right(Str(SalDateYear(dYes)), 1) || Sep98md(dYes) || '.' || sId_Kli || sP
.head 8 -  Call SalFileOpen(hF, sKuda || '\\' || sNameO, OF_Create | OF_ReadWrite)
.head 8 -  Call NewRow()
.head 8 -  Set tbl1.Col1 = 'Создание файла ' || sNameO || ' ...'
.head 8 -  ! Set dfResO = 'Создание файла ' || sNameO || ' ...'
.head 8 -  Set nKwo = 0
.head 8 -  If SqlPrepareAndExecute(hSql(), T("
   SELECT count(*)
   FROM tmp_tvost
   INTO :nKwo
   WHERE id=:nUid and id_kli=:sId_Kli")) and SqlFetchNext(hSql(), nFetchRes)
.head 8 +  Else
.head 9 -  ! Set dfResO = 'Ошибка чтения временной таблицы ...'
.head 9 -  Call NewRow()
.head 9 -  Set tbl1.Col1 = 'Ошибка чтения временной таблицы ...'
.head 8 +  If nKwo > 0
.head 9 -  ! читаем записи по sId_Kli и пишем в файл
.head 9 +  If SqlPrepareAndExecute(hSql(), T("
   SELECT datod,mfo,nls,kv,dos,dosq,kos,kosq,ostf,ostq,okpo,nmk
   INTO :dDatod,:nMfo,:nNls,:nKv,:nDos,:nDosq,:nKos,:nKosq,:nOstf,:nOstq,:sOkpo,:sNmk
   FROM tmp_tvost
   WHERE id=:nUid and id_kli=:sId_Kli"))
.head 10 +  While SqlFetchNext(hSql(), nFetchRes)
.head 11 +  ! If nDos = NUMBER_Null
.head 12 -  Set nDos = 0
.head 11 +  ! If nDosq = NUMBER_Null
.head 12 -  Set nDosq = 0
.head 11 +  ! If nKos = NUMBER_Null
.head 12 -  Set nKos = 0
.head 11 +  ! If nKosq = NUMBER_Null
.head 12 -  Set nKosq = 0
.head 11 +  If nOstf = NUMBER_Null
.head 12 -  Set nOstf = 0
.head 11 +  If nOstq = NUMBER_Null
.head 12 -  Set nOstq = 0
.head 11 -  Set sBuffer = SalFmtFormatDateTime(dDatod, 'yyMMdd') || PadL(Str(nMfo), 9) || PadL(Str(nNls), 14) || PadL(
    Str(nKv), 3) || PadL(Str(nDos), 14) || PadL(Str(nDosq), 14) || PadL(Str(nKos), 14) || PadL(
    Str(nKosq), 14) || PadL(Str(nOstf), 14) || PadL(Str(nOstq), 14) || PadR(sOkpo, 14) || PadR(sNmk, 255) ||
    PutCrLf()
.head 11 -  Call SalFileWrite(hF, sBuffer, Len(sBuffer))
.head 9 +  Else
.head 10 -  ! Set dfResO = 'Ошибка чтения временной таблицы ...'
.head 10 -  Call NewRow()
.head 10 -  Set tbl1.Col1 = 'Ошибка чтения временной таблицы ...'
.head 8 +  Else
.head 9 -  Set sBuffer = Spac(385) || PutCrLf()
.head 9 -  Call SalFileWrite(hF, sBuffer, Len(sBuffer))
.head 8 -  Call SalFileClose(hF)
.head 8 -  Call SalSetProfileString('TVO', Right(Str(SalDateYear(dYes)), 1) || Sep98md(dYes) || '.' || sId_Kli, sNum1,
     'Bars98')
.head 8 -  ! Set dfResO = 'Сформирован файл ' || sNameO
.head 8 -  Set tbl1.Col1 = 'Сформирован файл ' || sNameO
.head 8 -  Set nI = nI + 1
.head 6 +  Else
.head 7 -  ! Set dfResO = 'Ошибка наполнения временной таблицы ...'
.head 7 -  Call NewRow()
.head 7 -  Set tbl1.Col1 = 'Ошибка наполнения временной таблицы ...'
.head 6 -  !
.head 6 -  ! Set dfFD = 'Формирование файлов документов ...'
.head 6 -  Call NewRow()
.head 6 -  Set tbl1.Col1 = 'Формирование файлов документов ...'
.head 6 -  ! Set dfResD = 'Наполнение временной таблицы ...'
.head 6 -  Call NewRow()
.head 6 -  Set tbl1.Col1 = 'Наполнение временной таблицы ...'
.head 6 +  If SqlPLSQLCommand(hSql(), "p_d(nUid,dYes)")
.head 7 -  Call SqlCommit(hSql())
.head 7 -  Call NewRow()
.head 7 -  Set tbl1.Col1 = 'Наполнение временной таблицы OK'
.head 7 -  ! лазить по OKPO_AFD
.head 7 -  Set nI = 0
.head 7 +  While nI < nTV
.head 8 -  Set sId_Kli = smId_Kli[nI]
.head 8 -  Call SalGetProfileString('TVD', Right(Str(SalDateYear(dYes)), 1) || Sep98md(dYes) || '.' || sId_Kli, '0', sNum1,
     'Bars98')
.head 8 +  If Val(sNum1) > 9
.head 9 -  Set sP = Chr(Val(sNum1)+55)
.head 8 +  Else
.head 9 -  Set sP = sNum1
.head 8 -  Set sNum1 = Str(Val(sNum1)+1)
.head 8 -  Set sNameD = 'D' || sSab || Right(Str(SalDateYear(dYes)), 1) || Sep98md(dYes) || '.' || sId_Kli || sP
.head 8 -  Call SalFileOpen(hF, sKuda || '\\' || sNameD, OF_Create | OF_ReadWrite)
.head 8 -  ! Set dfResD = 'Создание файла ' || sNameD || ' ...'
.head 8 -  Call NewRow()
.head 8 -  Set tbl1.Col1 = 'Создание файла ' || sNameD || ' ...'
.head 8 -  Set nKwo = 0
.head 8 -  If SqlPrepareAndExecute(hSql(), T("
   SELECT count(*)
   FROM tmp_tvdoc
   INTO :nKwo
   WHERE id=:nUid and id_kli=:sId_Kli")) and SqlFetchNext(hSql(), nFetchRes)
.head 8 +  Else
.head 9 -  ! Set dfResD = 'Ошибка чтения временной таблицы ...'
.head 9 -  Call NewRow()
.head 9 -  Set tbl1.Col1 = 'Ошибка чтения временной таблицы ...'
.head 8 +  If nKwo > 0
.head 9 -  ! читаем записи по sId_Kli и пишем в файл
.head 9 +  If SqlPrepareAndExecute(hSql(), T("
   SELECT DISTINCT fdat,datd,nd,vob,dk,nlsa_r,kva_r,nlsb_r,kvb_r,mfoa,nlsa,kva,nama,okpoa,mfob,nlsb,kvb,namb,s,
                   kv,sq,nazn,datp,FA_T_ARM3,FA_T_ARM2,FB_T_ARM2,FB_T_ARM3,FB_D_ARM3,okpob,ref,rezerv
   INTO :dFdat,:dDatd,:sNd,:nVob,:sDk,:nNlsa_r,:nKva_r,:nNlsb_r,:nKvb_r,:nMfoa,:nNlsa,:nKva,:sNama,:sOkpoa,
        :nMfob,:nNlsb,:nKvb,:sNamb,:nS,:nKv,:nSq,:sNazn,:dDatp,:sFA_T_ARM3,:sFA_T_ARM2,:sFB_T_ARM2,:sFB_T_ARM3,
        :dFB_D_ARM3,:sOkpob,:nRef,:sRezerv
   FROM tmp_tvdoc
   WHERE id=:nUid and id_kli=:sId_Kli"))
.head 10 +  While SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Set sBuffer = PadR(SalFmtFormatDateTime(dFdat, 'yyMMdd'), 6) || PadR(
    SalFmtFormatDateTime(dDatd, 'yyMMdd'), 6) || PadR(sNd, 10) || PadL(Str(nVob), 2) || PadR(sDk, 1) ||
    PadL(Str(nNlsa_r), 14) || PadL(Str(nKva_r), 3) || PadL(Str(nNlsb_r), 14) || PadL(Str(nKvb_r), 3) ||
    PadL(Str(nMfoa), 9) || PadL(Str(nNlsa), 14) || PadL(Str(nKva), 3) || PadR(sNama, 38) ||
    PadR(sOkpoa, 14) || PadL(Str(nMfob), 9) || PadL(Str(nNlsb), 14) || PadL(Str(nKvb), 3) || PadR(sNamb, 38)
    || PadL(Str(nS), 16) || PadL(Str(nKv), 3) || PadL(Str(nSq), 16) || PadR(sNazn, 160) || PadR(
    SalFmtFormatDateTime(dDatp, 'yyMMdd'), 6) || PadR(sFA_T_ARM3, 4) || PadR(sFA_T_ARM2, 4) ||
    PadR(sFB_T_ARM2, 4) || PadR(sFB_T_ARM3, 4) || PadR(SalFmtFormatDateTime(dFB_D_ARM3, 'yyMMdd'), 6) ||
    PadR(sOkpob, 14) || PadL(Str(nRef), 9) || PadR(sRezerv, 77) || PutCrLf()
.head 11 -  Call SalFileWrite(hF, sBuffer, Len(sBuffer))
.head 9 +  Else
.head 10 -  ! Set dfResD = 'Ошибка чтения временной таблицы ...'
.head 10 -  Call NewRow()
.head 10 -  Set tbl1.Col1 = 'Ошибка чтения временной таблицы ...'
.head 8 +  Else
.head 9 -  Set sBuffer = Spac(524) || PutCrLf()
.head 9 -  Call SalFileWrite(hF, sBuffer, Len(sBuffer))
.head 8 -  Call SalFileClose(hF)
.head 8 -  Call SalSetProfileString('TVD', Right(Str(SalDateYear(dYes)), 1) || Sep98md(dYes) || '.' || sId_Kli, sNum1,
     'Bars98')
.head 8 -  ! Set dfResD = 'Сформирован файл ' || sNameD
.head 8 -  Set tbl1.Col1 = 'Сформирован файл ' || sNameD
.head 8 -  Set nI = nI + 1
.head 6 +  Else
.head 7 -  ! Set dfResD = 'Ошибка наполнения временной таблицы ...'
.head 7 -  Call NewRow()
.head 7 -  Set tbl1.Col1 = 'Ошибка наполнения временной таблицы ...'
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Call SalTblSetFocusRow(tbl1, 0)
.head 5 +  On SAM_TooltipSetText
.head 6 +  If Val(sTime) <= 0
.head 7 -  Return XSalTooltipSetText(lParam, 'Сформировать файлы (F10)')
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.033"
.head 5 -  Top:    0.06"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
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
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Выход (Esc)')
.head 5 +  On SAM_Timer
.head 6 -  Call SalTimerKill(pbExit, 1)
.head 6 -  Call SalSendMsg(pbExit, SAM_Click, 0, 0)
.head 3 +  Custom Control: cc1
.data CLASSPROPSSIZE
0000: 3600
.enddata
.data CLASSPROPS
0000: 56543A43616C656E 6461720025000100 0000000100010000 0200000001000001
0020: 0101010000000A31 352E30362E313935 360000000000
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cCalendar
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  DLL Name:
.head 5 -  MS Windows Class Name:
.head 5 -  Style:  Class Default
.head 5 -  ExStyle:  Class Default
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    0.06"
.head 6 -  Width:  3.3"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: 2.667"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  DLL Settings
.head 4 +  Message Actions
.head 5 +  On SAM_CustControlCmd
.head 6 -  Call cc1.GetFocusDate(dDada)
.head 6 +  If cc1.IsSpecialDate(SPECIAL_OneTime, dDada, DAY_Unset, SEQ_Unset)
.head 7 -  Call cc1.SpecialDate(SPECIAL_OneTime, dYes, DAY_Unset, SEQ_Unset, COLOR_Blue, COLOR_Cyan, TRUE)
.head 7 -  Set dYes = dDada
.head 7 -  Call cc1.SpecialDate(SPECIAL_OneTime, dYes, DAY_Unset, SEQ_Unset, COLOR_Blue, COLOR_Yellow, TRUE)
.head 5 +  On SAM_Create
.head 6 -  Call cc1.WeekStartSet(2)
.head 5 +  On SAM_TooltipSetText
.head 6 +  If Val(sTime) <= 0
.head 7 -  Return XSalTooltipSetText(lParam, 'Выбор даты')
.head 3 -  ! Frame
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   3.483"
.head 5 -  Top:    5.024"
.head 5 -  Width:  8.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 2.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.end
.head 3 +  ! Data Field: dfFO
.winattr
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
.head 6 -  Left:   3.583"
.head 6 -  Top:    5.119"
.head 6 -  Width:  8.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.end
.head 4 -  Message Actions 
.head 3 +  Data Field: dfKat
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
.head 6 -  Left:   7.033"
.head 6 -  Top:    0.06"
.head 6 -  Width:  4.75"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.321"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Каталог выгрузки:
.head 4 -  Resource Id: 24268
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.583"
.head 5 -  Top:    0.095"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.226"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  ! Data Field: dfResO
.winattr
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
.head 6 -  Left:   3.583"
.head 6 -  Top:    5.667"
.head 6 -  Width:  8.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 -  Message Actions 
.head 3 +  ! Data Field: dfFD
.winattr
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
.head 6 -  Left:   3.583"
.head 6 -  Top:    6.262"
.head 6 -  Width:  8.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.end
.head 4 -  Message Actions 
.head 3 +  ! Data Field: dfResD
.winattr
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
.head 6 -  Left:   3.583"
.head 6 -  Top:    6.81"
.head 6 -  Width:  8.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.333"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.end
.head 4 -  Message Actions 
.head 3 -  ! Line
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  3.533"
.head 5 -  Begin Y:  6.107"
.head 5 -  End X:  11.683"
.head 5 -  End Y:  6.107"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Etched
.head 4 -  Line Thickness: 8
.head 4 -  Line Color: Default
.end
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.483"
.head 6 -  Top:    0.452"
.head 6 -  Width:  8.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.5"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 20000
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: Col1
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Действия
.head 6 -  Visible? Class Default
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  5.7"
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
.head 3 +  Function: NewRow
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nNewRow
.head 4 +  Actions
.head 5 -  Set nNewRow = SalTblInsertRow(tbl1, TBL_MaxRow)
.head 5 -  Call SalTblSetContext(tbl1, nNewRow)
.head 5 -  Call SalTblSetRowFlags(tbl1, nNewRow, ROW_New, FALSE)
.head 5 -  Call SalTblSetFocusRow(tbl1, nNewRow)
.head 2 +  Window Parameters
.head 3 -  String: sTime
.head 2 +  Window Variables
.head 3 -  Number: nUid
.head 3 -  String: sSab
.head 3 -  String: sKuda
.head 3 -  Date/Time: dYes
.head 3 -  String: smMonth[*]
.head 3 -  String: smWeek[*]
.head 3 -  Number: nI
.head 3 -  Date/Time: dSelect
.head 3 -  Number: nTV
.head 3 -  String: smId_Kli[*]
.head 3 -  String: sId_Kli
.head 3 -  String: sNum1
.head 3 -  String: sP
.head 3 -  String: sNameO
.head 3 -  String: sNameD
.head 3 -  Number: nKwo
.head 3 -  File Handle: hF
.head 3 -  String: sBuffer
.head 3 -  Date/Time: dDatod
.head 3 -  Date/Time: dFdat
.head 3 -  Date/Time: dDada
.head 3 -  Number: nMfo
.head 3 -  Date/Time: dDatd
.head 3 -  String: sNd
.head 3 -  Number: nNls
.head 3 -  Number: nVob
.head 3 -  Number: nKv
.head 3 -  String: sDk
.head 3 -  Number: nDos
.head 3 -  Number: nNlsa_r
.head 3 -  Number: nDosq
.head 3 -  Number: nKva_r
.head 3 -  Number: nKos
.head 3 -  Number: nNlsb_r
.head 3 -  Number: nKosq
.head 3 -  Number: nKvb_r
.head 3 -  Number: nOstf
.head 3 -  Number: nMfoa
.head 3 -  Number: nOstq
.head 3 -  Number: nNlsa
.head 3 -  String: sOkpo
.head 3 -  Number: nKva
.head 3 -  String: sNmk
.head 3 -  String: sNama
.head 3 -  String: sOkpoa
.head 3 -  Number: nMfob
.head 3 -  Number: nNlsb
.head 3 -  Number: nKvb
.head 3 -  String: sNamb
.head 3 -  Number: nS
.head 3 -  Number: nSq
.head 3 -  String: sNazn
.head 3 -  Date/Time: dDatp
.head 3 -  String: sFA_T_ARM3
.head 3 -  String: sFA_T_ARM2
.head 3 -  String: sFB_T_ARM2
.head 3 -  String: sFB_T_ARM3
.head 3 -  Date/Time: dFB_D_ARM3
.head 3 -  String: sOkpob
.head 3 -  Number: nRef
.head 3 -  String: sRezerv
.head 3 -  !
.head 3 -  String: sText
.head 3 -  Number: nNewRow
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set nUid = GetUserId()
.head 4 -  Set sSab = GetBankSab()
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalUseRegistry(FALSE, '')
.head 4 -  Call SalGetProfileString('Export', 'TechVip', GetPrnDir(), sKuda, GetIniFileName())
.head 4 -  Set sKuda = IifS(Right(sKuda, 1)='\\', Left(sKuda, Len(sKuda)-1), sKuda)
.head 4 -  Set dfKat = sKuda
.head 4 -  !
.head 4 -  Set dYes = GetBankDate()
.head 4 -  Call cc1.ClearSpecials()
.head 4 -  Call SalSetFocus(cc1)
.head 4 -  Call GetMonthArrayRus(smMonth)
.head 4 -  Call GetWeekDayArray(smWeek)
.head 4 -  Call cc1.SetMonthText(smMonth)
.head 4 -  Call cc1.SetWeekDayText(smWeek)
.head 4 -  Call cc1.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Sunday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
.head 4 -  Call cc1.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Monday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
.head 4 -  Call cc1.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Tuesday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
.head 4 -  Call cc1.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Wednesday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
.head 4 -  Call cc1.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Thursday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
.head 4 -  Call cc1.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Friday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
.head 4 -  Call cc1.SpecialDate(SPECIAL_Weekly, DATETIME_Null, DAY_Saturday, SEQ_Unset, COLOR_Black, COLOR_Gray, TRUE)
.head 4 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT fdat
     INTO :dSelect
     FROM fdat"))
.head 4 -  Set nI = 0
.head 4 +  While SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Call cc1.SpecialDate(SPECIAL_OneTime, dSelect, DAY_Unset, SEQ_Unset, COLOR_Blue, COLOR_Cyan, TRUE)
.head 5 -  Set nI = nI + 1
.head 4 +  If nI = 0
.head 5 -  Call SalHideWindow(cc1)
.head 5 -  Call SalHideWindow(pbExec)
.head 5 -  Call SalSetFocus(pbExit)
.head 4 +  Else
.head 5 -  Call cc1.SetFocusDate(dYes)
.head 4 -  !
.head 4 -  Set nTV = 0
.head 4 +  If SqlPrepareAndExecute(hSql(), "
   SELECT DISTINCT id_kli
   INTO :sId_Kli
   FROM okpo_afd")
.head 5 +  While SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set smId_Kli[nTV] = sId_Kli
.head 6 -  Set nTV = nTV + 1
.head 4 +  Else
.head 5 -  Call MessageNoWait('Ошибка чтения СПРАВОЧНИКа клиентов для технической выписки.', 'Завершение работы!!!', 17, 1)
.head 5 -  Call SalDestroyWindow(hWndForm)
.head 4 +  If nTV = 0
.head 5 -  Call MessageNoWait('СПРАВОЧНИК клиентов для технической выписки ПУСТ.', 'Завершение работы!!!', 17, 1)
.head 5 -  Call SalDestroyWindow(hWndForm)
.head 4 -  !
.head 3 +  On SAM_CreateComplete
.head 4 +  If Val(sTime) > 0
.head 5 -  Call SalGetWindowText(hWndForm, sText, 100)
.head 5 -  Call SalSetWindowText(hWndForm, sText || ' (за текущую банковскую дату - автомат)')
.head 5 -  Call SalSendMsg(pbExec, SAM_Click, 0, 0)
.head 5 -  Call SalDisableWindow(cc1)
.head 5 -  Call SalDisableWindow(pbExec)
.head 5 -  Call SalTimerSet(pbExit, 1, Min(Val(sTime)*1000, 65000))
.head 1 +  Dialog Box: dlg_In3
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Механізм зміни параметрів процедури виклику WEB-сервісу
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? No
.head 3 -  Type of Dialog: System Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   5.313"
.head 4 -  Top:    4.083"
.head 4 -  Width:  13.7"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.774"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Введення реквізитів для WEB-сервісу та передача в процедуру (механізм)
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Etched
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.548"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 -  Contents
.head 2 +  Contents
.head 3 -  Background Text: Aдреса WEB-сервісу:
.head 4 -  Resource Id: 30522
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.15"
.head 5 -  Top:    0.274"
.head 5 -  Width:  2.283"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Lucida Console
.head 4 -  Font Size: 9
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfAdr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.467"
.head 6 -  Top:    0.226"
.head 6 -  Width:  10.933"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.262"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Lucida Console
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Dark Blue
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbRun)
.head 5 +  ! On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, 'Введіть адресу (URL) WEB-сервісу...')
.head 5 +  On SAM_TooltipSetText
.head 6 -  Call XSalTooltipShow(hWndItem, 'Введіть адресу (URL) WEB-сервісу...')
.head 5 +  ! On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 -  Background Text: Логін:
.head 4 -  Resource Id: 30523
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.15"
.head 5 -  Top:    0.905"
.head 5 -  Width:  2.283"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Lucida Console
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfLogin
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.467"
.head 6 -  Top:    0.823"
.head 6 -  Width:  10.933"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.315"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Lucida Console
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbRun)
.head 5 +  ! On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, 'Введіть логін...')
.head 5 +  On SAM_TooltipSetText
.head 6 -  Call XSalTooltipShow(hWndItem, 'Введіть логін...')
.head 5 +  ! On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 -  Background Text: Пароль:
.head 4 -  Resource Id: 30524
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.183"
.head 5 -  Top:    1.31"
.head 5 -  Width:  2.283"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Lucida Console
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfPassword
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.483"
.head 6 -  Top:    1.226"
.head 6 -  Width:  10.933"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.315"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Invisible
.head 5 -  Country: Default
.head 5 -  Font Name: Lucida Console
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbRun)
.head 5 +  ! On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, 'Введіть пароль...')
.head 5 +  On SAM_TooltipSetText
.head 6 -  Call XSalTooltipShow(hWndItem, 'Введіть пароль...')
.head 5 +  ! On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 -  Background Text: Wallet-dir:
.head 4 -  Resource Id: 65029
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.15"
.head 5 -  Top:    1.857"
.head 5 -  Width:  2.283"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Lucida Console
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfWdir
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.467"
.head 6 -  Top:    1.774"
.head 6 -  Width:  10.933"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.315"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Lucida Console
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbRun)
.head 5 +  ! On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, 'Введіть Wallet-dir...')
.head 5 +  On SAM_TooltipSetText
.head 6 -  Call XSalTooltipShow(hWndItem, 'Введіть Wallet-dir...')
.head 5 +  ! On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 -  Background Text: Wallet-pass:
.head 4 -  Resource Id: 65031
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.15"
.head 5 -  Top:    2.262"
.head 5 -  Width:  2.283"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Lucida Console
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfWpass
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.467"
.head 6 -  Top:    2.19"
.head 6 -  Width:  10.933"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.315"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Invisible
.head 5 -  Country: Default
.head 5 -  Font Name: Lucida Console
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Call SalEnableWindow(pbRun)
.head 5 +  ! On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, 'Введіть Wallet-pass...')
.head 5 +  On SAM_TooltipSetText
.head 6 -  Call XSalTooltipShow(hWndItem, 'Введіть Wallet-pass...')
.head 5 +  ! On UM_NoFontChange
.head 6 -  Return TRUE
.head 3 +  Pushbutton: pbRun
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Виконати
.head 4 -  Window Location and Size
.head 5 -  Left:   4.867"
.head 5 -  Top:    2.762"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call WaitCursorOn()
.head 6 +  ! When SqlError
.head 7 -  Call WaitCursorOff()
.head 7 -  Return FALSE
.head 6 +  If (dfLogin    = STRING_Null or SqlPLSQLCommand(hSql(), "ea_utils.set_param('EA.LoginUrl',   dfLogin)"))    and
   (dfPassword = STRING_Null or SqlPLSQLCommand(hSql(), "ea_utils.set_param('EA.Password',   dfPassword)")) and
   (dfAdr      = STRING_Null or SqlPLSQLCommand(hSql(), "ea_utils.set_param('EA.Url',        dfAdr)"))      and
   (dfWdir     = STRING_Null or SqlPLSQLCommand(hSql(), "ea_utils.set_param('EA.Wallet_dir', dfWdir)"))     and
   (dfWpass    = STRING_Null or SqlPLSQLCommand(hSql(), "ea_utils.set_param('EA.Wallet_pass',dfWpass)"))
.head 7 -  Call WaitCursorOff()
.head 7 -  Call MessageNoWait('Виконано!', 'Зміна параметрів.', 3, 0)
.head 7 -  Call SqlCommit(hSql())
.head 6 +  Else
.head 7 -  Call WaitCursorOff()
.head 7 -  Call MessageNoWait('Помилка!', 'Зміна параметрів.', 7, 1)
.head 7 -  Call SqlRollback(hSql())
.head 5 +  ! On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, 'Виконати...')
.head 5 +  On SAM_TooltipSetText
.head 6 -  Call XSalTooltipShow(hWndItem, 'Виконати...')
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Вийти
.head 4 -  Window Location and Size
.head 5 -  Left:   6.8"
.head 5 -  Top:    2.762"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  ! On SAM_SetFocus
.head 6 -  Call SalStatusSetText(hWndForm, 'Вихід...')
.head 5 +  On SAM_TooltipSetText
.head 6 -  Call XSalTooltipShow(hWndItem, 'Вийти...')
.head 3 -  Frame
.head 4 -  Resource Id: 30525
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.073"
.head 5 -  Width:  13.417"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.607"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 -  Frame
.head 4 -  Resource Id: 30526
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.74"
.head 5 -  Width:  13.417"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.917"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 65030
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.083"
.head 5 -  Top:    1.714"
.head 5 -  Width:  13.417"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.917"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 2 +  Functions
.head 3 +  ! Function: UnpackPass
.head 4 -  Description: 
.head 4 +  Returns 
.head 5 -  String: 
.head 4 +  Parameters 
.head 5 -  String: strPwd
.head 5 -  String: strUser
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  String: strRes
.head 5 -  Number: ni
.head 5 -  Number: nP1
.head 5 -  Number: nU1
.head 4 +  Actions 
.head 5 -  Set ni = 0
.head 5 +  While ni < 18
.head 6 -  Set nP1 = SalStrToNumber(SalStrMidX(strPwd, ni*3+2, 3))
.head 6 -  Call SalStrFirstC(strUser, nU1)
.head 6 -  Set nP1 = SalNumberXOR(nU1, nP1)
.head 6 -  Set strRes = strRes || SalNumberToChar(nP1)
.head 6 -  Set ni = ni+1
.head 5 -  Return strRes
.head 3 +  ! Function: PackPass
.head 4 -  Description: 
.head 4 +  Returns 
.head 5 -  String: 
.head 4 +  Parameters 
.head 5 -  String: strPwd
.head 5 -  String: strUser
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  String: strRes
.head 5 -  Number: ni
.head 5 -  Number: nP1
.head 5 -  Number: nU1
.head 4 +  Actions 
.head 5 -  Set ni = 0
.head 5 -  Set strRes = "EP"
.head 5 +  While ni < 18
.head 6 -  Call SalStrFirstC(strUser, nU1)
.head 6 -  Call SalStrFirstC(strPwd, nP1)
.head 6 -  Set nP1 = SalNumberXOR(nU1, nP1)
.head 6 -  Set strRes = strRes || SalStrRightX("  " || SalNumberToStrX(nP1, 0), 3)
.head 6 -  Set ni = ni+1
.head 5 -  Return strRes
.head 3 +  ! Function: SalNumberXOR
.head 4 -  Description: 
.head 4 +  Returns 
.head 5 -  Number: 
.head 4 +  Parameters 
.head 5 -  Number: n1
.head 5 -  Number: n2
.head 4 -  Static Variables 
.head 4 +  Local variables 
.head 5 -  Number: nRes
.head 4 +  Actions 
.head 5 -  Set nRes = (n1 & (-1-n2)) | (n2 & (-1-n1))
.head 5 -  Return nRes
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  ! cABSConnect: Connect
.winattr class :
.head 4 -  Class: cABSConnect
.end
.head 3 -  !
.head 3 -  ! String: strTemp
.head 3 -  ! String: strUserName
.head 3 -  ! String: strAdr
.head 3 -  ! String: strNlsLang
.head 3 -  ! Number: nSize
.head 3 -  ! Number: nFetchRes
.head 3 -  ! Number: nConnectError
.head 3 -  !
.head 3 -  ! Boolean: fDenied
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call WaitCursorOn()
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  ! Call SetWindowFont(hWndForm)
.head 4 -  Call SalDisableWindow(pbRun)
.head 4 -  ! Call SalHideWindow(pbComm)
.head 4 -  ! Call SalHideWindow(pbRoll)
.head 4 -  !
.head 4 -  ! Call SalUseRegistry(TRUE, GetDBMS())
.head 4 -  ! Call SalGetProfileString(GetHost(), "USER", "", strUserName, "")
.head 4 -  ! Call SalGetProfileString(GetHost(), "ADR", "", strAdr, "")
.head 4 -  Set dfLogin = GetValueStr("
    SELECT substr(ea_utils.get_param('EA.LoginUrl'),1,254)
    FROM   dual")
.head 4 -  Set dfAdr = GetValueStr("
    SELECT substr(ea_utils.get_param('EA.Url'),1,254)
    FROM   dual")
.head 4 -  Set dfWdir = GetValueStr("
    SELECT substr(ea_utils.get_param('EA.Wallet_dir'),1,254)
    FROM   dual")
.head 4 +  If dfAdr
.head 5 -  Call SalSetFocus(dfAdr)
.head 4 -  Call WaitCursorOff()
.head 3 +  On SAM_Destroy
.head 4 -  ! Call SalUseRegistry(TRUE, GetDBMS())
.head 4 -  ! Call SalSetProfileString(GetHost(), "USER", dfLogin, "")
.head 4 -  ! Call SalSetProfileString(GetHost(), "ADR", dfAdr, "")
