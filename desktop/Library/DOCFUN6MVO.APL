.head 0 +  Application Description: Функциональные классы для работы с
платежными документами

01.03.2005 SERG
Реализована поддержка SmartCard или eToken
Для компиляции требуется только VegaCCP.dll
которая в процессе работы подгружает VegaCC.dll

24-FEB-2004 SERG
Добавлена библиотека CreateCred.dll для 
(де)инициализации ЭЦП UNI(внутр. НБУ)
Переработана ф. cDoc.sIni(): для ЭЦП UNI диалог пароля
зовет сама библиотека. Изменены ф-ции (де)инициализации ЭЦП.
Добавлен параметр INI-файла в разделе [Common Parameters]
IconPath
путь к иконке для показа в диалоге ввода пароля ЭЦП UNI
----------------------------------
08-JUL2003 Пропускаем без изменений VOB=81
----------------------------------
09-AUG-2001 Изменен класс cDoc      - SERG
- добавлена обработка кодов сообщений VEGA и TM
  (используется vegamsg.dll)
- реализована запись СК на ТМ, в случае его обновления
----------------------------------
28-AUG2001 Переход на СЕП 2001 (ОКПО-Б) - MIK
12-NOV2001 Пропускаем без изменений VOB=33
26-JUN2002 Дату ввода документа ставим SYSDATE
13-NOV2002 Добавил функцию для вставки допреквизитов
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B40000 002C000000020000 0003000000000000 0043020000FCFFFF
0040: FFE9FFFFFFFFFFFF FF000000007C0200 004D010000010000 0001000000010000
0060: 000F4170706C6963 6174696F6E497465 6D00000000
.enddata
.data DT_MAKERUNDLG
0000: 000000000020713A 5C6261727339385C 64656275675C6D69 6B5C746573745F64
0020: 656C2E6578651E71 3A5C626172733938 5C64656275675C6D 696B5C6E65776170
0040: 702E646C6C1E713A 5C6261727339385C 64656275675C6D69 6B5C6E6577617070
0060: 2E61706300000101 0115433A5C43454E 545552415C6E6577 6170702E72756E15
0080: 433A5C43454E5455 52415C6E65776170 702E646C6C15433A 5C43454E54555241
00A0: 5C6E65776170702E 6170630000010101 15433A5C43454E54 5552415C6E657761
00C0: 70702E6170641543 3A5C43454E545552 415C6E6577617070 2E646C6C15433A5C
00E0: 43454E545552415C 6E65776170702E61 7063000001010115 433A5C43454E5455
0100: 52415C6E65776170 702E61706C15433A 5C43454E54555241 5C6E65776170702E
0120: 646C6C15433A5C43 454E545552415C6E 65776170702E6170 630000010101
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
.head 2 -  Reject Multiple Window Instances? Yes
.head 2 -  Enable Runtime Checks Of External References? Yes
.head 2 -  Use Release 4.0 Scope Rules? No
.head 1 +  Libraries
.head 2 -  Dynalib: Absapi.apd
.head 2 -  Dynalib: global.apd
.head 2 -  Dynalib: PRINTAPI.apd
.head 2 -  ! Dynalib: Global.apd
.head 2 -  File Include: Winbars2.apl
.head 2 -  File Include: Constant.apl
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
.head 3 -  Date/Time: dd-MM-yyyy
.head 3 -  Number: #00000
.head 2 +  External Functions
.head 3 -  ! Signature library
.head 3 +  Library name: DSGBVC4.DLL
.head 4 -  ! DSGBVC4.DLL - экспортируемые функции
.head 4 +  Function: nsignInitGBSign
.head 5 -  Description: int GLOBAL nsignInitGBSign(char *dbDir,
           char *secKeyDisk, char *pin,
           char *mfo, int mode)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: INT
.head 4 +  Function: nsignExitGBSign
.head 5 -  Description: int GLOBAL nsignExitGBSign(void)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 -  !
.head 4 +  Function: nsignInitOPSign
.head 5 -  Description: int GLOBAL nsignInitOPSign(char *dbDir,
           char *secKeyDisk, char *pin,
           char *mfo)
int DSGBEXT nsignInitOPSign(char* dbDir,
            char* secKeyDisk, char* pin,
            char* mfo, const char* cszUID)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 +  ! Function: nsignInitOPSign
.head 5 -  Description: int GLOBAL nsignInitOPSign(char *dbDir,
                 char *secKeyDisk, char *pin, char *mfo)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: nsignExitOPSign
.head 5 -  Description: int GLOBAL nsignExitOPSign(void)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 +  Function: nsignMapError2Text
.head 5 -  Description: void GLOBAL nsignMapError2Text(
            char *buffer, int errorCode)
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 +  Parameters
.head 6 -  Receive String: LPSTR
.head 6 -  Number: INT
.head 4 -  !
.head 4 +  Function: nsignPutOPSignOnMemory
.head 5 -  Description: int GLOBAL nsignPutOPSignOnMemory(
           void* data, unsigned short size,
           void* signPtr)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPVOID
.head 6 -  Number: SHORT
.head 6 -  Receive String: LPVOID
.head 3 +  ! Library name: DSGBVC4.DLL
.head 4 -  ! DSGBVC4.DLL - экспортируемые функции
.head 4 +  Function: nsignInitGBSign
.head 5 -  Description: int GLOBAL nsignInitGBSign(char *dbDir,
                        char *secKeyDisk, char *pin,
                        char *mfo, int mode)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: INT
.head 4 +  Function: nsignExitGBSign
.head 5 -  Description: int GLOBAL nsignExitGBSign(void)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 +  Function: nsignInitOPSign
.head 5 -  Description: int GLOBAL nsignInitOPSign(char *dbDir,
                        char *secKeyDisk, char *pin,
                        char *mfo)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: nsignExitOPSign
.head 5 -  Description: int GLOBAL nsignExitOPSign(void)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 +  Function: nsignMapError2Text
.head 5 -  Description: void GLOBAL nsignMapError2Text(
                         char *buffer, int errorCode)
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 +  Parameters
.head 6 -  Receive String: LPSTR
.head 6 -  Number: INT
.head 4 +  Function: nsignPutOPSignOnMemory
.head 5 -  Description: int GLOBAL nsignPutOPSignOnMemory(
                        void* data, unsigned short size,
                        void* signPtr)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPVOID
.head 6 -  Number: SHORT
.head 6 -  Receive String: LPVOID
.head 3 +  Library name: RSAC.DLL
.head 4 -  ! RSAC.DLL - экспортируемые функции
.head 4 +  Function: INIT_ZAH
.head 5 -  Description: int InitSign(char *szPathOpenKey,
             char *szPathSecKey,
             char *szIdOper,
             char *szUxDateTme,
             char *szPasword)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: CLOSE_ZAH
.head 5 -  Description: int CloseRsa(void)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 +  Function: RSA_ZAH
.head 5 -  Description: int RSA_ZAH(char cMode, int iHandler,
            dword dwCountPart,
            dword dwOffset, dword dwLength,
            dword dwOffsetSecond,
            char *szSign, char *szIdOpen)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: CHAR
.head 6 -  Number: INT
.head 6 -  Number: DWORD
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  String: LPSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: RSA_ZAH0
.head 5 -  Description: int RSA_ZAH(char cMode, int iHandler,
            dword dwCountPart,
            dword dwOffset, dword dwLength,
            dword dwOffsetSecond,
            char *szSign, char *szIdOpen)
.head 5 -  Export Ordinal: 3
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: CHAR
.head 6 -  Number: INT
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  ! String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  String: LPSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: RENEW_ZAH
.head 5 -  Description: int RENEW_ZAH(char, char*, char*, long)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: CHAR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 -  !
.head 3 +  Library name: VEGA32.DLL
.head 4 +  Function: VegaGetVer
.head 5 -  Description: int GLOBAL VegaGetVer
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 +  Function: VegaSetBuf
.head 5 -  Description: int GLOBAL VegaSetBuf (void *Buf,int len)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  Number: INT
.head 4 +  Function: VegaCheckDB
.head 5 -  Description: int GLOBAL VegaCheckDB
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 +  Function: VegaSetDate
.head 5 -  Description: int GLOBAL VegaSetDate
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 4 +  Function: VegaOpen
.head 5 -  Description: int GLOBAL VegaOpen (File Config,char *VegaPath, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  ! String: LPCSTR
.head 4 +  Function: VegaClose
.head 5 -  Description: int GLOBAL VegaClose ( pVegaSES xVS )
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: DWORD
.head 6 -  ! String: LPCSTR
.head 4 +  Function: VegaLoadSecKey
.head 5 -  Description: int GLOBAL VegaLoadSecKey (File SKPath,char *Psw,char *Id, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  ! String: LPCSTR
.head 4 +  Function: VegaDelSecKey
.head 5 -  Description: int GLOBAL VegaDelSecKey (char *Id, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: VegaEnsignGet
.head 5 -  Description: int GLOBAL VegaEnsignGet (void *Sign,void *IdR,void *Id, pVegaWA V,  pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: VegaEnsign
.head 5 -  Description: int GLOBAL VegaEnsign (void *Sign,void *Mess,word Len,void *IdR, void *Id, pVegaWA V, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Receive String: LPVOID
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  ! String: LPCSTR
.head 6 -  ! String: LPCSTR
.head 4 +  Function: VegaCheck
.head 5 -  Description: int GLOBAL VegaCheck (void *Sign,void *Mess,word Len,void *IdR, void *Id, pVegaWA V, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Receive String: LPVOID
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  String: LPSTR
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  ! String: LPCSTR
.head 6 -  ! String: LPCSTR
.head 4 +  Function: VegaStart
.head 5 -  Description: int GLOBAL VegaStart (pVegaWA V,pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: VegaStep
.head 5 -  Description: int GLOBAL VegaStep (void *Mess,word Len, pVegaWA V, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 4 +  Function: VegaRcpName
.head 5 -  Description: int GLOBAL VegaRcpName (char *Name,char *Path,File RcpNum, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 4 +  Function: VegaMail
.head 5 -  Description: int GLOBAL VegaMail (File FileIn,File FileOut, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 4 +  Function: VegaSetFmode
.head 5 -  Description: int GLOBAL VegaSetFmode (int Fmode, pVegaSES xVS)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: INT
.head 6 -  Number: DWORD
.head 4 +  Function: VegaSecKeyUpdate
.head 5 -  Description: int VegaSecKeyUpdate(pVegaSes VS)
Возвращает ненулевое значение, если было произведено обновление
секретного ключа при последнем запуске VegaLoadSecKey
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: DWORD
.head 4 +  Function: VegaDaysLeft
.head 5 -  Description: int VegaDaysLeft(pVegaSES VS);
Получение числа дней, оставшихся до конца действия секретного ключа,
загруженного при последнем запуске VegaLoadSecKey
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: DWORD
.head 4 +  Function: VegaDaysLeftA
.head 5 -  Description: int VegaDaysLeftA(pVegaSES VS);
Получение числа дней, оставшихся до конца действия ключа администратора,
загруженного при последнем запуске VegaLoadSecKey
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: DWORD
.head 3 +  Library name: VegaCCP.dll
.head 4 +  Function: VegaLoadSecKeyCC
.head 5 -  Description: VegaLoadSecKeyCC (char *SKPath,char *Psw,char *Id,pVegaSES xVS,char *Rname)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  String: LPCSTR
.head 3 +  Library name: tmm.dll
.head 4 +  Function: TMinitOwn
.head 5 -  Description: TMinit  (int AdapterType,int PortNum,int TmType)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: INT
.head 6 -  Number: INT
.head 6 -  Number: INT
.head 4 +  Function: TMcheckOwn
.head 5 -  Description: TMcheck (byte *Id,word *RAMsize);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Receive String: LPVOID
.head 6 -  Receive Number: LPWORD
.head 4 +  Function: TMreadOwn
.head 5 -  Description: TMread  (void *Buf,int Ofs,int Len);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Receive String: LPVOID
.head 6 -  Number: INT
.head 6 -  Number: INT
.head 4 +  Function: TMdoneOwn
.head 5 -  Description: TMdone  (void);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 -  Parameters
.head 4 +  Function: TMwriteOwn
.head 5 -  Description: int TMwrite (void *Buf,int Ofs,int Len);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  Number: INT
.head 6 -  Number: INT
.head 3 +  Library name: TMEX32.DLL
.head 4 +  Function: TMinit
.head 5 -  Description: int TMinit (int AdapterType,int PortNum)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: INT
.head 6 -  Number: INT
.head 4 +  Function: TMdone
.head 5 -  Description: void TMdone (void)
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 -  Parameters
.head 4 +  Function: TMcheck
.head 5 -  Description: int TMcheck (byte *Id)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPVOID
.head 4 +  Function: TMdelete
.head 5 -  Description: int TMdelete (char *Fn)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 4 +  Function: TMFF
.head 5 -  Description: int TMFF(char *Fn)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 4 +  Function: TMFN
.head 5 -  Description: int TMFN(char *Fn)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 4 +  Function: TMread
.head 5 -  Description: int TMread(char *Fn,void *Buf,int Len)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  Receive String: LPVOID
.head 6 -  Number: INT
.head 4 +  Function: TMwrite
.head 5 -  Description: int TMwrite(char *Fn,void *Buf,int Len)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPVOID
.head 6 -  Number: INT
.head 3 +  Library name: VEGAMSG
.head 4 +  Function: VegaGetMsgAux
.head 5 -  Description: void VegaGetMsgAux(int nCode, char* szMsgBuf, int nBufLen)
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 +  Parameters
.head 6 -  Number: INT
.head 6 -  Receive String: LPSTR
.head 6 -  Number: INT
.head 4 +  Function: VegaCheckGetMsg
.head 5 -  Description: char*	VegaCheckGetMsg(int nCode);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  String: LPSTR
.head 5 +  Parameters
.head 6 -  Number: INT
.head 3 +  Library name: msvcrt.dll
.head 4 +  Function: memmove
.head 5 -  Description: void *memmove( void *dest, const void *src, size_t count );
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 +  Parameters
.head 6 -  Receive String: LPVOID
.head 6 -  String: LPVOID
.head 6 -  Number: LONG
.head 4 +  Function: _sopen
.head 5 -  Description: int _sopen( const char *filename,
int oflag,
int shflag
[, int pmode ] );
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 4 +  Function: _get_osfhandle
.head 5 -  Description: long _get_osfhandle( int filehandle );
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: LONG
.head 5 +  Parameters
.head 6 -  Number: INT
.head 4 +  Function: _read
.head 5 -  Description: int _read( int handle,
void *buffer, unsigned int count );
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: INT
.head 6 -  String: LPSTR
.head 6 -  Number: UINT
.head 4 +  Function: _write
.head 5 -  Description: int _write( int handle,
const void *buffer, unsigned int count );
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: INT
.head 6 -  String: LPCSTR
.head 6 -  Number: UINT
.head 4 +  Function: _lseek
.head 5 -  Description: long _lseek( int handle, long offset, int origin );
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: LONG
.head 5 +  Parameters
.head 6 -  Number: INT
.head 6 -  Number: LONG
.head 6 -  Number: INT
.head 4 +  Function: _close
.head 5 -  Description: int _close( int handle );
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: INT
.head 4 +  Function: _commit
.head 5 -  Description: int _commit( int handle );
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  Number: INT
.head 4 +  Function: strncmp
.head 5 -  Description: int strncmp( const char *string1, const char *string2, size_t count );


.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: LONG
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: LONG
.head 3 +  Library name: hex2bin.dll
.head 4 +  Function: ConvertHexToBin
.head 5 -  Description: long ConvertHexToBin(
	char*	szSource,		// Исходная строка hex-цифр
	char*	szDest,			// приемный буфер.
	long	nDestLen );		// размер приемного буфера.
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: LONG
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPSTR
.head 6 -  Number: LONG
.head 4 +  Function: ConvertBinToHex
.head 5 -  Description: void ConvertBinToHex(
	char*	szSource,		// Исходный сырой BLOB.
	char*	szDest,			// буфер для результирующей строки hex-цифр
	long	nSourceLen );	// размер исходного массива.
.head 5 -  Export Ordinal: 0
.head 5 -  Returns
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPSTR
.head 6 -  Number: LONG
.head 4 +  Function: GetOffset
.head 5 -  Description: char* GetOffset(
char*	szSource,	// Исходный сырой BLOB.
long	nOffset	)	// смещение

.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  String: LPSTR
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  Number: LONG
.head 4 +  Function: ConcatBufs
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
.head 4 +  Function: NumPtr2HexStr
.head 5 -  Description: char* NumPtr2HexStr(unsigned int nNumPtr, unsigned int nBufSize)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  String: LPSTR
.head 5 +  Parameters
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 4 +  Function: NumPtr2Str
.head 5 -  Description: char* NumPtr2Str(unsigned int nNumPtr)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  String: LPSTR
.head 5 +  Parameters
.head 6 -  Number: DWORD
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
.head 3 +  Library name: NGSec.dll
.head 4 +  ! Function: NG_SET_ZAH
.head 5 -  Description: OM_uint32 NG_SET_ZAH(
	const char* strUserID,
	const char* strPathSecKey,
	const char* strPathCert,
	const char* strPubArb,
	const char* strPassword,
	const int nBdt);
.head 5 -  Export Ordinal: 0
.head 5 +  Returns 
.head 6 -  Number: UINT
.head 5 +  Parameters 
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: INT
.head 4 +  ! Function: NG_CLOSE_ZAH
.head 5 -  Description: void NG_CLOSE_ZAH()
.head 5 -  Export Ordinal: 0
.head 5 -  Returns 
.head 5 -  Parameters 
.head 4 +  Function: NG_CREATE_SIGN_CRED
.head 5 -  Description: OM_uint32 NG_CREATE_SIGN_CRED(
	OM_uint32 FAR * p_minor_status,
	gss_cred_id_t cred_handle,
	gss_buffer_t message_buffer,
	gss_buffer_t message_token,
	gss_buffer_t KeyToVerify)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: UINT
.head 5 +  Parameters
.head 6 -  Receive Number: LPUINT
.head 6 -  Number: DWORD
.head 6 +  structPointer
.head 7 -  Number: UINT
.head 7 -  String: LPSTR
.head 6 +  structPointer
.head 7 -  Receive Number: UINT
.head 7 -  Receive Number: DWORD
.head 6 +  structPointer
.head 7 -  Receive Number: UINT
.head 7 -  Receive Number: DWORD
.head 4 +  Function: NG_VERIFY_SIGN_CRED
.head 5 -  Description: OM_uint32 NG_VERIFY_SIGN_CRED(
	OM_uint32 FAR * p_minor_status,
	gss_cred_id_t cred_handle,
	gss_buffer_t message_buffer,
	gss_buffer_t message_token,
	gss_buffer_t KeyToVerify)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: UINT
.head 5 +  Parameters
.head 6 -  Receive Number: LPUINT
.head 6 -  Number: LPVOID
.head 6 +  structPointer
.head 7 -  Number: DWORD
.head 7 -  String: LPSTR
.head 6 +  structPointer
.head 7 -  Number: DWORD
.head 7 -  String: LPSTR
.head 6 +  structPointer
.head 7 -  Number: DWORD
.head 7 -  String: LPSTR
.head 4 +  Function: gss_display_status
.head 5 -  Description: OM_uint32 gss_display_status
             (OM_uint32 *,      /* minor_status */
              OM_uint32,        /* status_value */
              int,              /* status_type */
              const gss_OID,    /* mech_type */
              OM_uint32 *,      /* message_context */
              gss_buffer_t      /* status_string */
             )
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: UINT
.head 5 +  Parameters
.head 6 -  Receive Number: LPUINT
.head 6 -  Number: UINT
.head 6 -  Number: INT
.head 6 -  Number: UINT
.head 6 -  Receive Number: LPUINT
.head 6 +  structPointer
.head 7 -  Receive Number: UINT
.head 7 -  Receive Number: DWORD
.head 4 +  Function: gss_release_buffer
.head 5 -  Description: OM_uint32 gss_release_buffer
        (OM_uint32 *,           /* minor_status */
         gss_buffer_t           /* buffer */
        )
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: UINT
.head 5 +  Parameters
.head 6 -  Receive Number: LPUINT
.head 6 +  structPointer
.head 7 -  Receive Number: UINT
.head 7 -  Receive Number: DWORD
.head 4 +  Function: gss_acquire_cred
.head 5 -  Description: OM_uint32 gss_acquire_cred
             (OM_uint32 *,            /*  minor_status */
              const gss_name_t,       /* desired_name */
              OM_uint32,              /* time_req */
              const gss_OID_set,      /* desired_mechs */
              gss_cred_usage_t,       /* cred_usage */
              gss_cred_id_t *,        /* output_cred_handle */
              gss_OID_set *,          /* actual_mechs */
              OM_uint32 *             /* time_rec */
             )
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: UINT
.head 5 +  Parameters
.head 6 -  Receive Number: LPUINT
.head 6 -  String: LPCSTR
.head 6 -  Number: UINT
.head 6 -  Number: DWORD
.head 6 -  Number: INT
.head 6 -  Receive Number: LPDWORD
.head 6 -  Number: DWORD
.head 6 -  Receive Number: LPDWORD
.head 4 +  Function: gss_release_cred
.head 5 -  Description: OM_uint32 gss_release_cred
             (OM_uint32 *,        /* minor_status */
              gss_cred_id_t *     /* cred_handle */
             )
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: UINT
.head 5 +  Parameters
.head 6 -  Receive Number: LPUINT
.head 6 -  Receive Number: LPDWORD
.head 4 +  Function: NG_CREATE_SIGN_CRED_FILE1
.head 5 -  Description: OM_uint32 NG_CREATE_SIGN_CRED_FILE1(
	OM_uint32 * p_minor_status,
	gss_cred_id_t cred_handle,
	const int hFile,
	const OM_uint32 dwNumberOfSection,
	const size_t szFirstOffset,
	const size_t szLengthOfSection,
	const size_t szLengthOfOffset,
	gss_buffer_t message_token,
	gss_buffer_t KeyToVerify)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: UINT
.head 5 +  Parameters
.head 6 -  Receive Number: LPUINT
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 +  structPointer
.head 7 -  Receive Number: UINT
.head 7 -  Receive Number: DWORD
.head 6 +  structPointer
.head 7 -  Receive Number: UINT
.head 7 -  Receive Number: DWORD
.head 4 +  Function: NG_VERIFY_SIGN_CRED_FILE1
.head 5 -  Description: OM_uint32 NG_VERIFY_SIGN_CRED_FILE1(
	OM_uint32 * p_minor_status,
	gss_cred_id_t cred_handle,
	const int hFile,
	const OM_uint32 dwNumberOfSection,
	const size_t szFirstOffset,
	const size_t szLengthOfSection,
	const size_t szLengthOfOffset,
	const gss_buffer_t message_token,
	const gss_buffer_t KeyToVerify)
.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: UINT
.head 5 +  Parameters
.head 6 -  Receive Number: LPUINT
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 -  Number: DWORD
.head 6 +  structPointer
.head 7 -  Receive Number: UINT
.head 7 -  Receive Number: DWORD
.head 6 +  structPointer
.head 7 -  Receive Number: UINT
.head 7 -  Receive Number: DWORD
.head 3 +  Library name: fcred.dll
.head 4 +  Function: F_InitCred
.head 5 -  Description: Инициализация ЭЦП UNI
int InitCred
(
	LPSTR	ioIdBuf, 
	LPDWORD	ioIdLenPtr,
	LPCSTR	inPrompt, 
	LPCSTR	inPathToIcon,
	DWORD	inWaitTimeout,
	WORD	inNum
) ;

.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPSTR
.head 6 -  Receive Number: LPDWORD
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 6 -  Number: WORD
.head 4 +  Function: F_ReinitCred
.head 5 -  Description: Переинициализация ЭЦП UNI
int ReinitCred
(	LPCSTR	inId, 
	LPCSTR	inPrompt, 
	LPCSTR	inPathToIcon,
	DWORD	inWaitTimeout
) ;

.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  String: LPCSTR
.head 6 -  Number: DWORD
.head 4 +  Function: F_DeinitCred
.head 5 -  Description: Деинициализация ЭЦП UNI
int DeinitCredA(LPCSTR inId) ;

.head 5 -  Export Ordinal: 0
.head 5 +  Returns
.head 6 -  Number: INT
.head 5 +  Parameters
.head 6 -  String: LPCSTR
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 3 +  User
.head 4 -  Number: VEGA_SKFILE_SIZE = 360
.head 4 -  Number: UNI_SIGN_SIZE = 88 ! Размер буфера подписи внутр. ЭЦП НБУ
.head 4 -  Number: UNI_CERT_SIZE = 168 ! Размер буфера откр. ключа внутр. ЭЦП НБУ
.head 2 -  Resources
.head 2 +  Variables
.head 3 -  Boolean: bSignInited
.head 2 +  Internal Functions
.head 2 -  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 406913099
0000: 030100007F000000 0000000000000000 0200000100FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F4D003C00 00046300446F63D4
0040: 0000000878000000 02F004000000FF9F 0400DC000200FF7F 0873000200FFFF01
0060: 0C000000010D00FC 0000FF0719000000 01F700FF1F260000 DC000100FF7F3370
0080: 0000000100FFFFC1 4000000001FD00FF 07
.enddata
.head 3 +  Functional Class: cDoc  ! __exported
.head 4 -  Description: Содержит атрибуты платежного документа и функции работы с ними
.head 4 -  Derived From
.head 4 +  Class Variables
.head 5 -  String: sBuf
.head 5 -  String: sUid
.head 5 -  String: sUidCheck
.head 5 -  Number: m_nNullContext
.head 5 -  Number: m_nCredHandle
.head 4 +  Instance Variables
.head 5 -  Number: m_nRef
.head 5 -  String: m_sTT        ! тип транзакции
.head 5 -  Number: m_nDk        ! признак дебета / кредита
.head 5 -  Boolean: b_WasDkNull ! Признак, что первоначально Д/К
                       не был установлен => надо брать из TTS
.head 5 -  Number: m_nVob       ! вид документа
.head 5 -  String: m_sNd        ! номер документа
.head 5 -  Date/Time: m_dDatD   ! дата на документе
.head 5 -  Date/Time: m_dDatV1  ! дата валютирования документа 1
.head 5 -  Date/Time: m_dDatV2  ! дата валютирования документа 2
.head 5 -  Date/Time: m_dDatP   ! дата ввода документа
.head 5 -  : A          ! сторона А
.head 6 -  Class: cStorona
.head 5 -  : B          ! сторона Б
.head 6 -  Class: cStorona
.head 5 -  String: m_sNazn      ! назначение платежа
.head 5 -  String: m_sDrec      ! дополнительные реквизиты
.head 5 -  Number: m_nSk        ! символ кассплана
.head 5 -  String: m_sNazns     ! способ заполнения "назначения платежа"
.head 5 -  String: m_sNaznk     ! код "назначения платежа"
.head 5 -  Number: m_nBis       ! номер БИС
.head 5 -  String: m_sOperId    ! идентификатор операциониста
.head 5 -  Long String: m_lsSign        ! подпись на документе
.head 5 -  Long String: m_lsSignI       ! внутренняя подпись на документе
.head 5 -  Number: m_nSignLen ! длина подписи в байтах
.head 5 -  Number: m_nSos
.head 5 -  Number: m_nOtm       ! отметка на документе (в норме-0 в процессинге (1,2,3)
.head 5 -  Number: m_nRec       ! номер записи в ARC_RRP
.head 5 -  Number: m_nErr       ! код ошибки при записи в ARC_RRP
.head 5 -  Number: m_nNom       ! сумма номинала ЦБ
.head 5 -  Number: m_nRefH      ! референция parent - документа
.head 5 -  Number: m_nRefL      ! референция child -  документа
.head 5 -  Number: m_nRefF      ! референция филиала
.head 5 -  String: m_sRef_A     ! Референция отправителя (в норме = m_nRef)
.head 5 -  Number: m_nPrty      ! приоритет документа (0/1)
.head 5 -  Number: m_nSq        ! эквивалент суммы
.head 5 -  Number: m_nFlg       ! флаг оплаты основной операции
.head 5 -  Number: m_nFli       ! флаг межбанк
.head 5 -  Number: m_nPyD       ! флаг разрешения факт оплаты (всегда 1)
.head 5 -  Long String: m_lsSecretKey   ! Секрентный ключ
.head 5 -  Long String: m_lsSecretKeyCopy   ! Копия секретного ключа 
(необх. для отката при записи измененного ключа на TouchMemory)
.head 5 -  File Handle: hFileKeyBackup  ! handle для backup-а секретного ключа 
.head 5 -  !
.head 5 -  Number: m_nTim       ! время переинициализации подписи (в минутах)
.head 5 -  Long String: m_lsCertificate  !  сертификат откр. ключа
.head 5 -  Number: nSignErrType ! Тип ошибки при проверке подписи (1 - док., 2 - виза)	
.head 4 +  Functions
.head 5 +  Function: SetDoc  ! Устанавливает экземпляр док-та
.head 6 -  Description: Устанавливает экземпляр "Документа" из переменных
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nRef     !! референс (NUMBER_Null для новых)
.head 7 -  String: sTT      !! Код операции
.head 7 -  Number: nDk      !! ДК (0-дебет, 1-кредит)
.head 7 -  Number: nVob     !! Вид обработки
.head 7 -  String: sNd      !! № док 
.head 7 -  Date/Time: dDoc  !! Дата док
.head 7 -  Date/Time: dPos  !! Дата ввода(поступления в банк)
.head 7 -  Date/Time: dVal1  !! Дата валютирования основной операции
.head 7 -  Date/Time: dVal2  !! Дата валютирования связаной операции
.head 7 -  String: sNls1     !! Счет-А
.head 7 -  String: sNam1     !! Наим-А
.head 7 -  String: sBank1    !! МФО-А
.head 7 -  String: sNb1      !! Наим банка-А(м.б. '')
.head 7 -  Number: nKv1      !! Код вал-А 
.head 7 -  Number: nS1       !! Сумма-А
.head 7 -  String: sOkpo1    !! ОКПО-А 
.head 7 -  String: sNls2     !! Счет-Б     
.head 7 -  String: sNam2     !! Наим-Б
.head 7 -  String: sBank2    !! МФО-Б
.head 7 -  String: sNb2      !! Наим банка-Б(м.б. '')
.head 7 -  Number: nKv2      !! Код вал-Б 
.head 7 -  Number: nS2       !! Сумма-Б
.head 7 -  String: sOkpo2    !! ОКПО-Б
.head 7 -  String: sNazn     !! Назначение пл
.head 7 -  String: sDrec     !! Доп реквизиты
.head 7 -  String: sOperId   !! Идентификатор ключа опрециониста
.head 7 -  Long String: lsSign !! ЭЦП опрециониста
.head 7 -  Number: nSk       !! СКП
.head 7 -  Number: nPrty     !! Приоритет документа
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  ! Set m_bEscPin = TRUE
.head 7 -  Call SetDocQ( nRef, sTT, nDk, nVob, sNd, dDoc, dPos, dVal1, dVal2,
     sNls1, sNam1, sBank1, sNb1, nKv1, nS1, sOkpo1,
     sNls2, sNam2, sBank2, sNb2, nKv2, nS2, sOkpo2, sNazn, sDrec, sOperId, lsSign, nSk, nPrty,0 )
.head 5 +  Function: SetDocQ ! Устанавливает экземпляр док-та (С эквивалентом)
.head 6 -  Description: Устанавливает экземпляр "Документа" из переменных
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nRef     !! референс (NUMBER_Null для новых)
.head 7 -  String: sTT      !! Код операции
.head 7 -  Number: nDk      !! ДК (0-дебет, 1-кредит)
.head 7 -  Number: nVob     !! Вид обработки
.head 7 -  String: sNd      !! № док
.head 7 -  Date/Time: dDoc  !! Дата док
.head 7 -  Date/Time: dPos  !! Дата ввода(поступления в банк)
.head 7 -  Date/Time: dVal1  !! Дата валютирования основной операции
.head 7 -  Date/Time: dVal2  !! Дата валютирования связаной операции
.head 7 -  String: sNls1     !! Счет-А
.head 7 -  String: sNam1     !! Наим-А
.head 7 -  String: sBank1    !! МФО-А
.head 7 -  String: sNb1      !! Наим банка-А(м.б. '')
.head 7 -  Number: nKv1      !! Код вал-А
.head 7 -  Number: nS1       !! Сумма-А
.head 7 -  String: sOkpo1    !! ОКПО-А
.head 7 -  String: sNls2     !! Счет-Б
.head 7 -  String: sNam2     !! Наим-Б
.head 7 -  String: sBank2    !! МФО-Б
.head 7 -  String: sNb2      !! Наим банка-Б(м.б. '')
.head 7 -  Number: nKv2      !! Код вал-Б
.head 7 -  Number: nS2       !! Сумма-Б
.head 7 -  String: sOkpo2    !! ОКПО-Б
.head 7 -  String: sNazn     !! Назначение пл
.head 7 -  String: sDrec     !! Доп реквизиты
.head 7 -  String: sOperId   !! Идентификатор ключа опрециониста
.head 7 -  Long String: lsSign !! ЭЦП опрециониста
.head 7 -  Number: nSk       !! СКП
.head 7 -  Number: nPrty     !! Приоритет документа
.head 7 -  Number: nSQ       !! Эквивалент для одновалютной оп
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nWaitSign
.head 6 +  Actions
.head 7 -  Set m_nRef = nRef
.head 7 -  Set m_sTT = sTT
.head 7 -  Set m_nDk = nDk
.head 7 -  Set m_nVob = nVob
.head 7 -  Set m_sNd = DeInva(sNd)
.head 7 -  Set m_dDatD = dDoc
.head 7 -  Set m_dDatV1 = dVal1
.head 7 -  Set m_dDatV2 = dVal2
.head 7 -  Set m_dDatP = dPos
.head 7 -  Call A.SetStorona(sNls1, SalStrLeftX( DeInva(sNam1), 38), sBank1, sNb1, nKv1, nS1, sOkpo1)
.head 7 -  Call B.SetStorona(sNls2, SalStrLeftX( DeInva(sNam2), 38), sBank2, sNb2, nKv2, nS2, sOkpo2)
.head 7 +  If not sTranN(m_sNazn, sNazn, sTT, A.Nls, A.Bank, A.Kv, A.S, B.Nls, B.Bank, B.Kv, B.S)
.head 8 -  Call MessageErrorEx('Ошибка формирования назначения платежа '|| m_sNazn)
.head 7 -  Set m_sNazn = SalStrLeftX( DeInva(m_sNazn), 160 )
.head 7 -  Set m_nSk = nSk
.head 7 -  Set m_nPrty = nPrty
.head 7 -  Set m_sDrec = DeInva(sDrec)
.head 7 +  If m_sDrec
.head 8 -  Set m_sNazns = '11'
.head 7 +  Else
.head 8 -  Set m_sNazns = '10'
.head 7 -  Set m_sNaznk = ''
.head 7 -  Set m_sRef_A = ''
.head 7 -  Set m_nBis = 0
.head 7 -  Set m_sOperId = sOperId
.head 7 -  Set m_lsSign = STRING_Null
.head 7 -  Set m_lsSignI= STRING_Null
.head 7 -  Set m_nRec = NUMBER_Null
.head 7 -  Set m_nRefH = NUMBER_Null
.head 7 -  Set m_nRefL = NUMBER_Null
.head 7 -  Set m_nRefF = NUMBER_Null
.head 7 -  Set m_nOtm = 0
.head 7 -  Set m_nSq = nSQ
.head 7 -  !
.head 7 -  Set nWaitSign = GetWaitSign()
.head 7 -  Set m_nTim = IifN(nWaitSign<=0, 5, nWaitSign) ! 5
.head 7 -  Set m_nPyD = 1
.head 5 +  Function: SetDocR
.head 6 -  Description: Устанавливает экземпляр "Документа" из записи в OPER
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nRef
.head 7 -  Boolean: bLock
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nFetchRes
.head 7 -  String: sTmp
.head 7 -  Number: nWaitSign
.head 6 +  Actions
.head 7 -  Set nWaitSign = GetWaitSign()
.head 7 -  Set m_nTim = IifN(nWaitSign<=0, 5, nWaitSign) ! 5
.head 7 -  Set m_nPyD = 1
.head 7 +  While TRUE
.head 8 +  If not SqlPrepare(hSql(), T("
   SELECT ref,tt,dk,vob,nd,data,vdat,datp,ref_a,
          nlsa,nam_a,mfoa,kv, s, id_a,
          nlsb,nam_b,mfob,kv2,s2,id_b,
          nazn,d_rec,sk,id_o,sign,sos,refl,prty,sq
   INTO :m_nRef,:m_sTT,:m_nDk,:m_nVob,:m_sNd,:m_dDatD,:m_dDatV1,:m_dDatP,:m_sRef_A,
        :A.Nls,:A.Nam,:A.Bank,:A.Kv,:A.S,:A.Okpo,
        :B.Nls,:B.Nam,:B.Bank,:B.Kv,:B.S,:B.Okpo,
        :m_sNazn,:m_sDrec,:m_nSk,:m_sOperId,:m_lsSign,:m_nSos,:m_nRefL,:m_nPrty,:m_nSq
   FROM oper WHERE ref=:nRef " ||
IifS(bLock,"FOR UPDATE OF sos NOWAIT","")))
.head 9 -  Break
.head 8 +  If not SqlSetLongBindDatatype(25, BLOB_BYTE)
.head 9 -  Break
.head 8 +  If not SqlExecute(hSql())
.head 9 -  Break
.head 8 +  If SqlFetchNext(hSql(), nFetchRes)
.head 9 +  If SalStrTrimX(m_sDrec)
.head 10 -  Set m_sNazns = '11'
.head 9 +  Else
.head 10 -  Set m_sNazns = '10'
.head 9 -  Set m_nBis = 0
.head 9 -  Set m_sNaznk = STRING_Null
.head 9 -  Set m_lsSignI= STRING_Null
.head 9 +  If SqlPrepareAndExecute(hSql(),"SELECT value  INTO :sTmp FROM operw WHERE ref=:nRef AND tag='REF_F' ")
.head 10 +  If SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Set m_nRefF=SalStrToNumber( SalStrTrimX( sTmp) )
.head 9 +  If not m_sRef_A
.head 10 -  Set m_sRef_A=SalNumberToStrX( m_nRef, 0 )
.head 9 -  Return TRUE
.head 7 -  Return FALSE
.head 5 +  Function: GetDoc
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Receive Number: nRef
.head 7 -  Receive String: sTT
.head 7 -  Receive Number: nDk
.head 7 -  Receive Number: nVob
.head 7 -  Receive String: sNd
.head 7 -  Receive Date/Time: dDoc
.head 7 -  Receive Date/Time: dVal
.head 7 -  Receive String: sNls1
.head 7 -  Receive String: sNam1
.head 7 -  Receive String: sBank1
.head 7 -  Receive String: sNb1
.head 7 -  Receive Number: nKv1
.head 7 -  Receive Number: nS1
.head 7 -  Receive String: sOkpo1
.head 7 -  Receive String: sNls2
.head 7 -  Receive String: sNam2
.head 7 -  Receive String: sBank2
.head 7 -  Receive String: sNb2
.head 7 -  Receive Number: nKv2
.head 7 -  Receive Number: nS2
.head 7 -  Receive String: sOkpo2
.head 7 -  Receive String: sNazn
.head 7 -  Receive Number: nSk
.head 7 -  Receive Number: nPrty
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set nRef = m_nRef
.head 7 -  Set sTT = m_sTT
.head 7 -  Set nDk = m_nDk
.head 7 -  Set nVob = m_nVob
.head 7 -  Set sNd = m_sNd
.head 7 -  Set dDoc = m_dDatD
.head 7 -  Set dVal = m_dDatV1
.head 7 -  Call A.GetStorona(sNls1, sNam1, sBank1, sNb1, nKv1, nS1, sOkpo1)
.head 7 -  Call B.GetStorona(sNls2, sNam2, sBank2, sNb2, nKv2, nS2, sOkpo2)
.head 7 -  Set sNazn = m_sNazn
.head 7 -  Set nSk = m_nSk
.head 7 -  Set nPrty = m_nPrty
.head 5 +  Function: iDoc
.head 6 -  Description: Вставка документа в OPER
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nFetchRes
.head 7 -  Date/Time: dPdat
.head 7 -  Long String: lsNull
.head 7 -  Date/Time: dDatV
.head 7 -  String: sData
.head 7 -  String: sDatp
.head 7 -  String: sDatv
.head 7 -  Number: nUid
.head 6 +  Actions
.head 7 +  If m_dDatV2 = DATETIME_Null or m_dDatV2 > m_dDatV1
.head 8 -  Set dDatV = m_dDatV1
.head 7 +  Else
.head 8 -  Set dDatV = m_dDatV2
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 -  Set lsNull = ''
.head 9 -  Set nUid = NUMBER_Null
.head 9 -  Set dPdat = SalDateConstruct(
    SalDateYear(m_dDatP), SalDateMonth(m_dDatP), SalDateDay(m_dDatP),
    SalDateHour(SalDateCurrent()), SalDateMinute(SalDateCurrent()), 0)
.head 9 +  If m_nSq
.head 10 -  Set sData='gl.in_Doc2(m_nRef, m_sTT, m_nVob, m_sNd, dPdat, dDatV,
    m_nDk, A.Kv, A.S, B.Kv, B.S, m_nSq, m_nSk, m_dDatD, m_dDatP,
    A.Nam,A.Nls,A.Bank,B.Nam,B.Nls,B.Bank,m_sNazn,
    m_sDrec,A.Okpo,B.Okpo,m_sOperId,lsNull,m_nSos,m_nPrty,nUid)'
.head 9 +  Else
.head 10 -  Set sData='gl.in_Doc3(m_nRef, m_sTT, m_nVob, m_sNd, dPdat, dDatV,
    m_nDk, A.Kv, A.S, B.Kv, B.S, m_nSk, m_dDatD, m_dDatP,
    A.Nam,A.Nls,A.Bank,B.Nam,B.Nls,B.Bank,m_sNazn,
    m_sDrec,A.Okpo,B.Okpo,m_sOperId,lsNull,m_nSos,m_nPrty,nUid)'
.head 9 +  If not SqlPLSQLCommand(hSql(),sData)
.head 10 -  Break
.head 9 +  If m_lsSign
.head 10 +  If not SqlPrepare(hSql(), "UPDATE oper SET sign=:m_lsSign,ref_a=:m_sRef_A WHERE ref=:m_nRef")
.head 11 -  Break
.head 10 +  If not SqlSetLongBindDatatype(1, BLOB_BYTE)
.head 11 -  Break
.head 10 +  If not SqlExecute(hSql())
.head 11 -  Break
.head 8 +  Else
.head 9 -  Set sData = SalFmtFormatDateTime(m_dDatD,'MM-dd-yyyy')
.head 9 -  Set sDatp = SalFmtFormatDateTime(m_dDatP,'MM-dd-yyyy')
.head 9 -  Set sDatv = SalFmtFormatDateTime(dDatV,  'MM-dd-yyyy')
.head 9 +  If not SqlRetrieve(hSql(), "informix.in_doc2",
   ":m_nRef,:m_sTT,:m_nVob,:m_sNd,:sDatp,:sDatv,
    :m_nDk,:A.Kv,:A.S,:B.Kv,:B.S,:m_nSk,:sData,:sDatp,
    :A.Nam,:A.Nls,:A.Bank,
    :B.Nam,:B.Nls,:B.Bank,:m_sNazn,:m_sDrec,
    :A.Okpo,:B.Okpo,:m_sOperId,:m_lsSign,:m_nSos", "")
.head 10 -  Break
.head 9 +  If not SqlSetLongBindDatatype(26, BLOB_BYTE)
.head 10 -  Break
.head 9 +  If not SqlExecute(hSql())
.head 10 -  Break
.head 8 +  If m_nRefH
.head 9 +  If not SqlPrepareAndExecute(hSql(), "UPDATE oper SET refl=:m_nRef WHERE ref=:m_nRefH")
.head 10 -  Break
.head 8 +  If m_nRefL
.head 9 +  If not SqlPrepareAndExecute(hSql(), "UPDATE oper SET refl=:m_nRefL WHERE ref=:m_nRef")
.head 10 -  Break
.head 8 -  Return TRUE
.head 7 -  Call SqlRollbackEx(hSql(),'Неуспех при вставке документа в OPER')
.head 7 -  Return FALSE
.head 5 +  Function: iDop    ! Вставка допреквизитов (переопределяется пользователем)
.head 6 -  Description: Вставка допреквизитов в OPERW
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return TRUE
.head 5 +  Function: iSep    ! Вставка документа в ARC_RRP с БИСами
.head 6 -  Description: Вставка документа в ARC_RRP
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nNull
.head 7 -  String: sNull
.head 7 -  Long String: lsNull
.head 7 -  Number: nFetchRes
.head 7 -  String: sRef
.head 7 -  String: sNd
.head 7 -  String: sNama
.head 7 -  String: sNamb
.head 7 -  String: sNazn
.head 7 -  String: sDrec
.head 7 -  String: sDatA
.head 7 -  Date/Time: dDatA
.head 7 -  String: sData
.head 7 -  String: sDatp
.head 7 -  Number: nVob
.head 7 -  Number: nDk
.head 7 -  Number: i
.head 7 -  String: aNazn[*]
.head 7 -  ! String: aDrec[*]
.head 7 -  String: sTag
.head 7 -  String: sVal
.head 6 +  Actions
.head 7 -  Set dDatA = SalDateConstruct(
    SalDateYear(m_dDatP),SalDateMonth(m_dDatP), SalDateDay(m_dDatP),
    SalDateHour(SalDateCurrent()),SalDateMinute(SalDateCurrent()),0)
.head 7 -  Set nNull = NUMBER_Null
.head 7 -  Set sNull = ''
.head 7 -  Set lsNull = ''
.head 7 +  If m_nVob=1 or m_nVob=2 or m_nVob=6 or m_nVob=33 or m_nVob=81
.head 8 -  Set nVob = m_nVob
.head 7 +  Else
.head 8 -  Set nVob = GetVobForBadVob()
.head 7 +  While TRUE
.head 8 -  Set m_nErr = -1
.head 8 -  Set m_nRec = 0
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 +  If m_nRefF
.head 10 -  Set sRef = SalNumberToStrX(m_nRefF, 0)
.head 9 +  Else
.head 10 -  Set sRef = m_sRef_A             !--SalNumberToStrX(m_nRef, 0)
.head 9 +  If SalStrScan ( m_sDrec, '#fMT' )>=0					
.head 10 +  If not SqlPrepareAndExecute(hSql(),
   "SELECT tag,value FROM operw WHERE ref=:m_nRef AND
           tag IN (SELECT tag FROM op_field WHERE vspo_char='F')
     INTO :sTag,:sVal")
.head 11 -  Call Debug('Ош выборки из OPERW')
.head 11 -  Break
.head 10 -  ! ***********************************
.head 10 +  While SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Set aNazn[i]='#F'||SalStrTrimX(sTag)||':'||SalStrTrimX(sVal)||'#'
.head 11 -  ! Call Debug(aNazn[i])
.head 11 -  Set i=i+1
.head 11 -  Set m_nBis=1
.head 9 +  While m_nBis=0 or m_nBis>0 and m_nBis<=i+1 
.head 10 +  If m_nBis 
.head 11 +  If m_nBis=1
.head 12 -  Set m_sDrec='#B'||SalStrRightX('00'||SalNumberToStrX(i, 0), 2 )||SalStrTrimX(m_sDrec)
.head 11 +  Else
.head 12 -  Set m_sDrec=''
.head 11 -  Set m_sOperId=GetIdOper()
.head 11 +  If not ..sDoc()
.head 12 -  ! Set sErrTxt = 'Не удалось переподписать документ.'
.head 12 -  Break
.head 10 -  ! Call Debug('===insep===')
.head 10 -  Set sNd   = m_sNd
.head 10 -  Set sNama = A.Nam
.head 10 -  Set sNamb = B.Nam
.head 10 -  Set sNazn = m_sNazn
.head 10 -  Set sDrec = m_sDrec
.head 10 +  If not SqlPLSQLCommand(hSql(),
  "sep.in_sep(m_nErr,m_nRec,A.Bank,A.Nls,B.Bank,B.Nls,m_nDk,A.S,
              nVob,sNd,A.Kv,m_dDatD,m_dDatP,sNama,sNamb,sNazn,
           m_sNaznk,m_sNazns,A.Okpo,B.Okpo,m_sOperId,sRef,m_nBis,
       lsNull,sNull,nNull,dDatA,sDrec,m_nOtm,m_nRef,nNull,sNull)")
.head 11 -  Break
.head 10 +  If m_nRec > 0 and m_lsSign
.head 11 +  If not SqlPrepare(hSql(), "UPDATE arc_rrp SET sign=:m_lsSign, prty=:m_nPrty WHERE rec=:m_nRec")
.head 12 -  Break
.head 11 +  If not SqlSetLongBindDatatype(1, BLOB_BYTE)
.head 12 -  Break
.head 11 +  If not SqlExecute(hSql())
.head 12 -  Break
.head 10 +  If m_nBis = 0
.head 11 -  Break
.head 10 +  Else
.head 11 -  Set m_nBis=m_nBis+1
.head 11 -  Set m_sNazn=aNazn[m_nBis-2]
.head 11 -  Set m_sNazns='33'
.head 11 -  Set m_nDk=3
.head 11 -  Set A.S=0
.head 10 -  ! Call Debug('bottom')
.head 8 +  Else
.head 9 -  Set sData = SalFmtFormatDateTime(m_dDatD, 'MM-dd-yyyy')
.head 9 -  Set sDatp = SalFmtFormatDateTime(m_dDatP, 'MM-dd-yyyy')
.head 9 -  Set sDatA = SalFmtFormatDateTime(m_dDatP, 'yyyy-MM-dd ') ||
    NumberToStr(SalDateHour(SalDateCurrent())) || ':' ||
    NumberToStr(SalDateMinute(SalDateCurrent()))
.head 9 +  If not SqlRetrieve(hSql(), "informix.in_sep",
   ':A.Bank,:A.Nls,:B.Bank,:B.Nls,:m_nDk,:A.S,
    :nVob,:sNd,:A.Kv,:sData,:sDatp,:sNama,:sNamb,:sNazn,:m_sNaznk,:m_sNazns,
    :A.Okpo,:B.Okpo,:m_sOperId,:m_nRef, :m_nBis,
    :m_lsSign,:nNull,:nNull,:sDatA,:sDrec,
    :m_nOtm,:m_nRef,:nNull',':m_nErr,:m_nRec')
.head 10 -  Break
.head 9 +  If not SqlSetLongBindDatatype(22, BLOB_BYTE)
.head 10 -  Break
.head 9 +  If not SqlExecute(hSql())
.head 10 -  Break
.head 9 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Break
.head 8 +  If m_nErr
.head 9 -  Break
.head 8 -  Return TRUE
.head 7 -  Call SqlRollbackEx(hSql(), 'Неуспех при IN_SEP ' || SalNumberToStrX(m_nErr, 0))
.head 7 +  If m_nBis
.head 8 -  Call SetDocR(m_nRef,FALSE)   ! Восстановить переменные класса cDoc
.head 7 -  Return FALSE
.head 5 +  Function: sIni
.head 6 -  Description: Инициализировать ЭЦП
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 +  Static Variables
.head 7 -  ! Boolean: bSignInited
.head 7 -  Number: nTim
.head 7 -  Number: nCredLifeSec
.head 7 -  Number: nCredLifeDays
.head 6 +  Local variables
.head 7 -  ! String: strUxDateTime
.head 7 -  String: strDay
.head 7 -  Number: nDay
.head 7 -  Number: nErrorSign
.head 7 -  String: strErrorSign
.head 7 -  String: strPinCode
.head 7 -  Number: lTim
.head 7 -  Number: nDaysLeft
.head 7 -  String: strDaysLeftMsg
.head 7 -  String: strFullMsg
.head 7 -  String: strFileName
.head 7 -  Number: nTmpNum
.head 7 -  Number: nBufAddress
.head 7 -  Number: message_context
.head 7 -  Number: maj_status
.head 7 -  Number: min_status
.head 7 -  Number: nMsgSize
.head 7 -  String: strBuf
.head 7 -  String: strIDOperBuf
.head 7 -  Number: nIDOperLength
.head 7 -  Number: nPinResult
.head 7 -  String: strIconPath
.head 7 -  String: strCRPin
.head 6 +  Actions
.head 7 -  Set lTim = nTim
.head 7 -  Set nTim = SalDateHour(SalDateCurrent())*60 + SalDateMinute(SalDateCurrent())
.head 7 +  If bSignInited and nTim-lTim < m_nTim
.head 8 -  Return TRUE
.head 7 +  If GetSignType() = 'UKR' 
or GetSignType() = 'NBU' 
or GetSignType() = 'VEG'
or GetSignType() = 'UNI'
.head 8 -  Set nErrorSign = NUMBER_Null
.head 8 -  Set strPinCode = ''
.head 8 -  Call WaitCursorOff(  )
.head 8 +  While TRUE
.head 9 +  If GetSignType() = 'UNI' ! Внутренняя ЭЦП НБУ - 
			   диалог пароля показывать не надо
.head 10 -  Set nPinResult = 1
.head 9 +  Else ! для остальных - показать диалог
.head 10 -  Set nPinResult = SalModalDialog(dlgAskPinCode, hWndForm, strPinCode)
.head 9 +  If nPinResult
.head 10 +  If GetSignType() = 'NBU'
.head 11 -  Set m_nSignLen = 64
.head 11 +  If bSignInited
.head 12 -  Set nErrorSign = CLOSE_ZAH()
.head 12 -  Set bSignInited = FALSE
.head 11 -  Set nErrorSign = INIT_ZAH(GetOpenKeyDir(),GetSecretKeyDrv(),GetIdOper(),GetKeyDate(), strPinCode)
.head 11 +  If nErrorSign = -70
.head 12 -  Call MessageErrorEx('Последний день действия секретного ключа '||GetIdOper())
.head 11 +  Else If nErrorSign > -77 And nErrorSign < -70
.head 12 -  Set nDay = - nErrorSign - 70
.head 12 -  Call MessageErrorEx('Действие ключа '||GetIdOper()||' прекращается через ' ||NumberToStr(nDay) || ' ' || GetDayStrByNum(nDay))
.head 11 +  Else If nErrorSign
.head 12 -  Break
.head 10 +  Else If GetSignType() = 'VEG'
.head 11 -  Set m_nSignLen = 90
.head 11 +  If bSignInited
.head 12 -  Set nErrorSign = VegaClose (0)
.head 12 -  Set bSignInited = FALSE
.head 11 -  Call SalStrSetBufferLength( sBuf, 11024+4104+1)
.head 11 -  Set nErrorSign = VegaSetBuf(sBuf,11024+4104)
.head 11 +  If nErrorSign
.head 12 -  ! Call Debug('VegaSetBuf Err '||SalNumberToStrX(nErrorSign,0))
.head 12 -  Break
.head 11 -  ! VegaSetDate() делать не будем
.head 11 -  ! Set nErrorSign = VegaSetDate(SalFmtFormatDateTime(GetBankDate(),'dd/MM/yyyy'))
.head 11 +  ! If nErrorSign
.head 12 -  ! Call Debug('VegaSetDate Err '||SalNumberToStrX(nErrorSign,0))
.head 12 -  Break 
.head 11 -  Set nErrorSign = VegaOpen(GetOpenKeyDir()||'\\Vega.cfg',GetOpenKeyDir()||'\\',0)
.head 11 +  If nErrorSign
.head 12 -  ! Call Debug('VegaOpen Err '||SalNumberToStrX(nErrorSign,0))
.head 12 -  Break
.head 11 -  Call SalStrSetBufferLength(sUid,9)
.head 11 -  Call SalStrSetBufferLength(sUidCheck,9)
.head 11 +  If GetSecretKeyDrv()='@'  ! устройство типа CardReader фирмы "АВТОР"
.head 12 -  ! Call Debug( 'CardReaderName='||GetCardReaderName() )
.head 12 -  ! Call Debug( 'CardReaderPin='||GetCardReaderPin() )
.head 12 +  ! If GetCardReaderPin()=STRING_Null or 
   Len(GetCardReaderPin())=0
.head 13 -  Set strCRPin = Subs( PadR(strPinCode,32),1,8 )
.head 12 +  ! Else
.head 13 -  Set strCRPin = GetCardReaderPin()
.head 12 -  ! Call Debug( 'strCRPin=&'||strCRPin||'&' )
.head 12 -  Set nErrorSign = VegaLoadSecKeyCC(
SalStrRightX('00'||GetGlobalOption('REGNCODE'),2)||GetIdOper()||'.KEY',
PadR(strPinCode,32),sUid,0,
GetCardReaderName())
.head 11 +  Else If GetSecretKeyDrv()='TM'  ! Touch Memory
.head 12 -  Set nErrorSign=ReadTM()
.head 12 +  If nErrorSign
.head 13 -  ! Call Debug('ReadTM Err '||SalNumberToStrX(nErrorSign,0))
.head 13 -  Break
.head 12 -  Call VegaSetFmode(1,0)
.head 12 -  Set nErrorSign = VegaLoadSecKey(m_lsSecretKey,PadR(strPinCode,32),sUid,0)
.head 12 -  Call VegaSetFmode(0,0)
.head 11 +  Else ! Floppy Disk
.head 12 -  Set nErrorSign = VegaLoadSecKey(GetSecretKeyDrv()||'\\'||SalStrRightX('00'||GetGlobalOption('REGNCODE'),2)||GetIdOper()||'.KEY',PadR(strPinCode,32),sUid,0)
.head 11 -  ! Обрабатываем все предупреждения от VegaLoadSecKey - SERG
.head 11 +  If nErrorSign>=1 AND  nErrorSign<=8
.head 12 -  Set strErrorSign = SalStrRepeatX(' ', 129)
.head 12 -  Call VegaGetMsgAux(nErrorSign, strErrorSign, 128 )
.head 12 +  If nErrorSign=1 OR nErrorSign=2 
.head 13 -  Set nDaysLeft = VegaDaysLeft(0)
.head 13 -  Set strDaysLeftMsg = 'До истечения срока действия секретного ключа осталось ' 
||SalNumberToStrX(nDaysLeft,0) || ' ' || GetDayStrByNum(nDaysLeft)
.head 12 +  Else If nErrorSign=4
.head 13 -  Set nDaysLeft = VegaDaysLeftA(0)
.head 13 -  Set strDaysLeftMsg = 'До истечения срока действия ключа администратора осталось ' 
||SalNumberToStrX(nDaysLeft,0) || ' ' || GetDayStrByNum(nDaysLeft)
.head 12 -  Set strFullMsg = SalStrLeftX(strErrorSign, SalStrLength(strErrorSign)) || SalNumberToChar(13) ||
	strDaysLeftMsg || SalNumberToChar(13) || 'Продолжите работу'
.head 12 -  ! Операционисты должны видеть только предупреждения 
с кодом 1 или 2 - остальные пока игнорируем
4 - касается администратора
8 - возникать не должно
.head 12 +  If nErrorSign=1 OR nErrorSign=2
.head 13 -  Call SalMessageBox(strFullMsg , 'Предупреждение', MB_Ok | MB_IconExclamation )
.head 12 -  ! Обнуляем переменную с кодом ошибки
.head 12 -  Set nErrorSign=0
.head 11 +  If nErrorSign
.head 12 -  ! Call Debug('VegaLoadSecKey Err '||SalNumberToStrX(nErrorSign,0))
.head 12 -  Break
.head 11 +  If SalStrRightX('00'||GetGlobalOption('REGNCODE'),2)||GetIdOper() != sUid
.head 12 -  Set nErrorSign=202
.head 12 -  Break
.head 11 -  ! Проверим соответствие идентификатора ключа 
.head 11 -  ! Обрабатываем ситуацию обновления ключа для TouchMemory
.head 11 +  If GetSecretKeyDrv()='TM'
.head 12 +  If VegaSecKeyUpdate(0)  ! было изменение ключа
.head 13 -  ! дампим старый ключ на диск C и прописываем новый на ТМ
.head 13 -  ! Call Debug('Обновление ключа')
.head 13 -  ! Дампить СК на лок. диск запрещается !!!
.head 13 -  ! Set strFileName = 'C:\\' || SalStrRightX('00'||GetGlobalOption('REGNCODE'),2)||GetIdOper()||'.KEY'
.head 13 +  ! If SalFileOpen(hFileKeyBackup, strFileName, OF_Create | OF_Write | OF_Binary )
.head 14 -  Call SalFileWrite(hFileKeyBackup, m_lsSecretKeyCopy, VEGA_SKFILE_SIZE)
.head 14 -  Call SalFileClose(hFileKeyBackup)
.head 14 -  Call SalMessageBox( 'Старый ключ сохранен в файле ' || strFileName , 
'Сообщение',  MB_Ok | MB_IconAsterisk )
.head 13 +  ! Else 
.head 14 -  Call SalMessageBox( 'Ошибка открытия файла '|| strFileName || 
' для записи' || SalNumberToChar(13) || 'Старый ключ сохранен не будет',
'Предупреждение', MB_Ok | MB_IconExclamation )
.head 13 -  Set nErrorSign =  WriteTM()
.head 13 +  If nErrorSign = 0
.head 14 -  Call SalMessageBox( 'Секретный ключ успешно обновлен на TouchMemory',
 'Сообщение', MB_Ok | MB_IconAsterisk )
.head 14 -  Call SaveInfoToLog('СК ' || SalStrRightX('00'||GetGlobalOption('REGNCODE'),2)||GetIdOper() ||
' успешно обновлен на TouchMemory')
.head 12 +  ! Else
.head 13 -  Call Debug('Ключ не менялся ')
.head 13 -  Set strFileName = 'C:\\' || SalStrRightX('00'||GetGlobalOption('REGNCODE'),2)||GetIdOper()||'.KEY'
.head 13 -  Call Debug( strFileName )
.head 10 +  Else If GetSignType() = 'UNI' ! Внутренняя ЭЦП НБУ
.head 11 -  Set m_nSignLen = UNI_SIGN_SIZE
.head 11 +  If bSignInited
.head 12 -  ! Set nErrorSign = OL_CLOSE_ZAH(m_nNullContext)
.head 12 -  ! сначала удаляем удостоверение
.head 12 -  Call gss_release_cred( min_status,
  m_nCredHandle )
.head 12 -  ! деинициализация ЭЦП
.head 12 -  ! Call NG_CLOSE_ZAH()
.head 12 -  ! Set nErrorSign = F_DeinitCred( GetIdOper() )
.head 12 +  ! If nErrorSign!=0 AND nErrorSign!=2
.head 13 -  Set strErrorSign = CredFormatMessage(nErrorSign)
.head 13 -  Call SalMessageBox( strErrorSign, 'DeinitCred()', 
MB_Ok|MB_IconStop )
.head 12 -  Set bSignInited = FALSE
.head 11 +  ! If nErrorSign
.head 12 -  Set strErrorSign = UNIFormatMessage(nErrorSign)
.head 12 -  Break 
.head 11 -  Set strIDOperBuf = GetIdOper()
.head 11 -  Set nIDOperLength = SalStrLength( GetIdOper() )+1
.head 11 -  Set strIconPath = GetIconPath()
.head 11 +  If '' = strIconPath 
.head 12 -  Set strIconPath = STRING_Null
.head 11 -  Set nErrorSign = F_ReinitCred(
	strIDOperBuf,
	'АБС БАРС Міленіум', 
	strIconPath,
	0xFFFFFFFF
	)
.head 11 +  If nErrorSign
.head 12 -  Set strErrorSign = CredFormatMessage(nErrorSign)
.head 12 -  Break
.head 11 -  Set nErrorSign = gss_acquire_cred(
  min_status,
  GetIdOper(),
  0xffffffff,
  0,
  0,
  m_nCredHandle,
  NUMBER_Null,
  nCredLifeSec
)
.head 11 +  If nErrorSign
.head 12 -  Set strErrorSign = UNIFormatGSSMessage(min_status, nErrorSign)
.head 12 -  Break
.head 11 -  ! проверка: сколько удостоверению осталось жить ?
.head 11 -  Set nCredLifeDays = nCredLifeSec / (24*60*60)
.head 11 +  If nCredLifeDays<8
.head 12 -  Set nCredLifeDays = SalNumberTruncate ( nCredLifeDays, 1, 0 )
.head 12 +  If nCredLifeDays<=7 AND nCredLifeDays>=5
.head 13 -  Set strErrorSign = 'До истечения срока действия ключа осталось '
||SalNumberToStrX( nCredLifeDays, 0 ) || ' дней'
.head 12 +  Else If nCredLifeDays<=4 AND nCredLifeDays>=2
.head 13 -  Set strErrorSign = 'До истечения срока действия ключа осталось '
||SalNumberToStrX( nCredLifeDays, 0 ) || ' дня'
.head 12 +  Else If 1=nCredLifeDays
.head 13 -  Set strErrorSign = 'До истечения срока действия ключа осталось '
||SalNumberToStrX( nCredLifeDays, 0 ) || ' день'
.head 12 +  Else
.head 13 -  Set strErrorSign = 'Срок действия ключа заканчивается сегодня'
.head 12 -  Call SalMessageBox('UNI: KeyID='||GetIdOper()||PutCrLf()
||strErrorSign,	'Предупреждение', MB_Ok | MB_IconExclamation )
.head 11 -  Call InsertCert2DB()
.head 10 +  Else
.head 11 -  Set m_nSignLen = 128
.head 11 +  If bSignInited
.head 12 -  Set nErrorSign = nsignExitOPSign()
.head 12 -  Set bSignInited = FALSE
.head 11 -  Set nErrorSign = nsignInitOPSign(GetOpenKeyDir(),GetSecretKeyDrv(),strPinCode,GetBankMfo(),GetIdOper())
.head 11 +  If nErrorSign
.head 12 -  Break
.head 10 -  Call SaveInfoToLog('Инициализация ЭЦП - OK')
.head 10 -  Set bSignInited = TRUE
.head 10 -  ! Set m_bEscPin = TRUE
.head 10 -  Return TRUE
.head 9 +  Else
.head 10 -  Set bSignInited = FALSE
.head 10 -  ! Set m_bEscPin = FALSE
.head 10 -  Break
.head 8 +  If nErrorSign                 ! обработка ошибок ЭЦП
.head 9 +  If GetSignType() = 'NBU'
.head 10 -  Set strErrorSign = 
'Ошибка '||NumberToStr(nErrorSign)
|| ' инициализации ЭЦП НБУ. Ключ '||GetIdOper()
|| PutCrLf() || GetSepSignMsg(nErrorSign)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'VEG'
.head 10 -  ! Строку сообщения для ошибок VEGA и TM предоставляет библ. ф-ция VegaGetMsgAux - SERG
.head 10 -  ! Set strErrorSign = 'Ошибка '||SalNumberToStrX( (nErrorSign - SalNumberMod( nErrorSign, 4096 ))/4095, 0 )||'-'||
                SalNumberToStrX(SalNumberMod( nErrorSign, 4096 ),0) || ' инициализации ЭЦП VEGA. '||GetIdOper()
.head 10 -  Set strErrorSign = SalStrRepeatX(' ', 4096)
.head 10 -  Call VegaGetMsgAux(nErrorSign, strErrorSign, 4096)
.head 10 -  Call MessageErrorEx('Ошибка инициализации ЭЦП ВЕГА. Ключ '
||SalStrRightX('00'||GetGlobalOption('REGNCODE'),2)||GetIdOper()||'.'
||PutCrLf() 
||strErrorSign)
.head 9 +  Else If GetSignType() = 'UNI'
.head 10 -  ! Set strErrorSign = SalStrRepeatX(' ', 4096)
.head 10 -  ! Call NBUFormatMessage(nErrorSign,strErrorSign,4096)
.head 10 -  ! Call MessageErrorEx('UNI: KeyID='||GetIdOper()||PutCrLf()||strErrorSign)
.head 10 -  ! ------------------------------------------------
.head 10 -  Call MessageErrorEx( strErrorSign )
.head 9 +  Else
.head 10 -  Set strErrorSign = SalStrRepeatX(' ', 129)
.head 10 -  Call nsignMapError2Text(strErrorSign, nErrorSign)
.head 10 -  Call MessageErrorEx( StrDosToWinX(strErrorSign) )
.head 10 -  Call nsignExitOPSign()
.head 8 -  Return FALSE
.head 7 +  Else
.head 8 -  Return MessageErrorEx('Неизвестная система ЭЦП: '|| GetSignType())
.head 7 +  ! Комментарий
.head 8 -  ! 'NBU' -- используется ЭЦП НБУ
.head 8 -  ! 'UKR' -- используется ЭЦП Банка 'Украина'
.head 8 -  ! 'VEG' -- используется ЭЦП NOKK 'VEGA'
.head 8 -  ! 'UNI' -- используется внутр. ЭЦП НБУ
.head 5 +  Function: sDoc       ! Подписать документ
.head 6 -  Description: (Здесь ничего не трогать, тут и так все хорошо)
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sSignData
.head 7 -  Number: nErrorSign
.head 7 -  String: strErrorSign
.head 7 -  String: sNd
.head 7 -  String: sNama
.head 7 -  String: sNamb
.head 7 -  String: sNazn
.head 7 -  String: sDrec
.head 7 -  String: sDat1
.head 7 -  String: sDat2
.head 7 -  Number: nVob
.head 7 -  String: szTempBuf
.head 7 -  ! Date/Time: dtSomeDate
.head 7 -  Number: nInd
.head 7 -  Number: min_status
.head 7 -  Number: nSignLen
.head 7 -  Number: nCertLen
.head 7 -  Number: nSignHandle
.head 7 -  Number: nCertHandle
.head 6 +  Actions
.head 7 +  If GetSignOn() = 0 ! ЭЦП отключена - вернуть Пусто
.head 8 -  Set m_lsSign = STRING_Null
.head 8 -  Return TRUE
.head 7 +  If ..sIni()
.head 8 -  Set sNd = m_sNd
.head 8 -  Set sNama = A.Nam
.head 8 -  Set sNamb = B.Nam
.head 8 -  Set sNazn = m_sNazn
.head 8 -  Set sDat1 = SalFmtFormatDateTime(m_dDatD,'yyMMdd')
.head 8 -  Set sDat2 = SalFmtFormatDateTime(m_dDatP,'yyMMdd')
.head 8 -  Set sDrec = m_sDrec
.head 8 +  If m_nVob=1 or  m_nVob=2 or m_nVob=6 or m_nVob=33 or m_nVob=81
.head 9 -  Set nVob = m_nVob
.head 8 +  Else
.head 9 -  Set nVob = GetVobForBadVob()
.head 8 -  Set sSignData = PadL(A.Bank, 9) || PadL(A.Nls, 14) ||
                PadL(B.Bank, 9) || PadL(B.Nls, 14) ||
    PadL(SalNumberToStrX(m_nDk, 0), 1) || PadL(SalNumberToStrX(A.S, 0), 16) ||
    PadL(SalNumberToStrX(nVob,0), 2) || PadR(sNd, 10)  ||
    PadL(SalNumberToStrX(A.Kv, 0), 3) || sDat1 || sDat2 ||
    PadR(sNama, 38)  || PadR(sNamb,38) ||
    PadR(sNazn, 160) || PadR(sDrec,60) || PadR(m_sNaznk, 3) || PadR(m_sNazns, 2) ||
    PadL(A.Okpo, 14) || PadL(B.Okpo, 14)  ||
    PadL(m_sRef_A,9) || PadR(m_sOperId, 6) ||
    PadL(SalNumberToStrX(m_nBis,0),2)  || PadL(' ', 8)
.head 8 +  If GetSignType() = 'NBU'
.head 9 -  Call SalStrSetBufferLength( m_lsSign, 65 )
.head 9 -  Set nErrorSign = RSA_ZAH(87,-1,1,sSignData,444,0,m_lsSign,m_sOperId)
.head 8 +  Else If GetSignType() = 'VEG'
.head 9 -  Call SalStrSetBufferLength( m_lsSign, 91 )
.head 9 -  Set nErrorSign = VegaEnsign(m_lsSign,sSignData,444,0,sUid,0,0)
.head 8 +  Else If GetSignType() = 'UNI'
.head 9 -  ! Call SalStrSetBufferLength( m_lsSign, UNI_SIGN_SIZE+1 )
.head 9 -  ! Call SalStrSetBufferLength( m_lsCertificate, UNI_CERT_SIZE+1 )
.head 9 -  ! Set nErrorSign = OL_CREATE_SIGN_CRED( m_nNullContext,
			444, sSignData,
			UNI_SIGN_SIZE, m_lsSign,
			UNI_CERT_SIZE, m_lsCertificate)
.head 9 -  ! ------------------------------
.head 9 -  Call SalStrSetBufferLength( m_lsSign, UNI_SIGN_SIZE+1 )
.head 9 -  Call SalStrSetBufferLength( m_lsCertificate, UNI_CERT_SIZE+1 )
.head 9 -  Set nErrorSign = NG_CREATE_SIGN_CRED( min_status,
			m_nCredHandle,
			444, sSignData,
			nSignLen, nSignHandle,
			nCertLen, nCertHandle)
.head 9 +  If 0=nErrorSign
.head 10 -  Call ConvertHexToBin( NumPtr2HexStr(nSignHandle, nSignLen), 
	m_lsSign, nSignLen )
.head 10 -  Call ConvertHexToBin( NumPtr2HexStr(nCertHandle, nCertLen), 
	m_lsCertificate, nCertLen )
.head 10 -  ! чистим память
.head 10 -  Call gss_release_buffer( min_status, nSignLen, nSignHandle )
.head 10 -  Call gss_release_buffer( min_status, nCertLen, nCertHandle )
.head 8 +  Else
.head 9 -  Call SalStrSetBufferLength( m_lsSign, 129 )
.head 9 -  Set nErrorSign = nsignPutOPSignOnMemory(sSignData,444,m_lsSign)
.head 8 +  If nErrorSign = 0
.head 9 -  Call sTrace(sSignData, 444, m_lsSign)
.head 9 -  Return TRUE
.head 8 +  Else
.head 9 +  If GetSignType() = 'NBU'
.head 10 -  Set strErrorSign = 'Ошибка наложения ЭЦП НБУ: '||NumberToStr(nErrorSign)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'VEG'
.head 10 -  Set strErrorSign = 'Ошибка наложения ЭЦП VEGA: '
||SalNumberToStrX(SalNumberMod( nErrorSign, 4096 ),0)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'UNI'
.head 10 -  ! Set szTempBuf = SalStrRepeatX(' ', 256)
.head 10 -  ! Call NBUFormatMessage( nErrorSign, szTempBuf, 256)
.head 10 -  ! Set strErrorSign = 'Ошибка наложения ЭЦП UNI: '||SalNumberToStrX( nErrorSign, 0)
  || PutCrLf()||'KeyID='||GetIdOper()||PutCrLf()||szTempBuf
.head 10 -  ! Call MessageErrorEx(strErrorSign)
.head 10 -  ! -------------------------------------
.head 10 -  Call MessageErrorEx( UNIFormatGSSMessage(min_status, nErrorSign) )
.head 9 +  Else ! обработка ошибок ЭЦП
.head 10 -  Call nsignMapError2Text(strErrorSign,nErrorSign)
.head 10 -  Call nsignExitOPSign()
.head 10 -  Call MessageErrorEx(StrDosToWinX(strErrorSign))
.head 7 -  Return FALSE
.head 5 +  Function: sDocInt    ! Подписать внутренней подписью (при визировании и вводе)
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nLev
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sSignType
.head 7 -  Long String: sSignData
.head 7 -  Long String: sBuff
.head 7 -  Number: nErrorSign
.head 7 -  String: strErrorSign
.head 7 -  String: szTempBuf
.head 7 -  Long String: p_lsBuffer
.head 7 -  Long String: binBuff
.head 7 -  Number: nBuffLen
.head 7 -  String: p_KeyID
.head 7 -  Long String: p_lsSign
.head 7 -  Long String: binSign
.head 7 -  Number: p_nSignLen
.head 7 -  Number: nLen
.head 7 -  Number: nFetchRes
.head 7 -  Long String: binTempBuf
.head 7 -  Long String: lsTempBuf
.head 7 -  Number: nTmpVal
.head 7 -  Long String: ptrBuf
.head 7 -  Long String: ptrBuf2
.head 7 -  Number: hFile
.head 7 -  String: szCrtID
.head 7 -  String: szID_O_Buf
.head 7 -  Number: min_status
.head 7 -  Number: nSignLen
.head 7 -  Number: nCertLen
.head 7 -  Number: nSignHandle
.head 7 -  Number: nCertHandle
.head 6 +  Actions
.head 7 +  If GetSignOn() = 0 ! ЭЦП отключена - вернуть Пусто
.head 8 -  Set m_lsSignI = STRING_Null
.head 8 -  Return TRUE
.head 7 +  If ..sIni()
.head 8 -  Set sSignData = iSignData()
.head 8 -  Set nLen = SalStrLength( sSignData )
.head 8 -  ! Получить буфер для подписывания
.head 8 +  If NOT SqlPLSQLCommand( hSql(),"chk.get_buf( m_nRef, nLev, sBuff )" )
.head 9 -  Call Debug( 'Ошибка!' )
.head 9 -  Return FALSE
.head 8 -  Set nBuffLen=SalStrLength(sBuff)/2
.head 8 +  If nBuffLen
.head 9 -  Call SalStrSetBufferLength( binBuff, nBuffLen+1 )
.head 9 -  Call ConvertHexToBin(sBuff, binBuff, nBuffLen )  ! HEX --> BIN
.head 9 -  Call SalStrSetBufferLength( sSignData, nLen+nBuffLen+1 )
.head 9 -  Call ConcatBufs( sSignData, iSignData(), nLen, binBuff, nBuffLen )
.head 8 +  If GetSignType() = 'NBU'
.head 9 -  Call SalStrSetBufferLength( m_lsSignI, m_nSignLen+1 )
.head 9 -  Set nErrorSign = RSA_ZAH(87,-1,1,sSignData,nLen+nBuffLen,0,m_lsSignI,m_sOperId)
.head 8 +  Else If GetSignType() = 'VEG'
.head 9 -  Call SalStrSetBufferLength( m_lsSignI, m_nSignLen+1 )
.head 9 -  Set nErrorSign = VegaEnsign(m_lsSignI,sSignData,nLen+nBuffLen,0,sUid,0,0)
.head 8 +  Else If GetSignType() = 'UNI'
.head 9 -  Call SalStrSetBufferLength( m_lsSignI, m_nSignLen+1 )
.head 9 -  Call SalStrSetBufferLength( m_lsCertificate, UNI_CERT_SIZE+1 )
.head 9 -  Set nErrorSign = NG_CREATE_SIGN_CRED( min_status,
			m_nCredHandle,
			nLen+nBuffLen, sSignData,
			nSignLen, nSignHandle,
			nCertLen, nCertHandle)
.head 9 +  If 0=nErrorSign
.head 10 -  Call ConvertHexToBin( NumPtr2HexStr(nSignHandle, nSignLen), m_lsSignI, nSignLen )
.head 10 -  Call ConvertHexToBin( NumPtr2HexStr(nCertHandle, nCertLen), m_lsCertificate, nCertLen )
.head 10 -  ! чистим память
.head 10 -  Call gss_release_buffer( min_status, nSignLen, nSignHandle )
.head 10 -  Call gss_release_buffer( min_status, nCertLen, nCertHandle )
.head 9 -  ! Set hFile = _sopen( GetPrnDir() || '\\' || 'VisaSign.dat', 0x00008302, 0x00000010, 0x00000180)
.head 9 +  ! If hFile != -1
.head 10 -  Call _write( hFile, m_lsSign, 88 )
.head 10 -  Call _close( hFile )
.head 8 +  Else
.head 9 -  Call SalMessageBox( 'Наложение ЭЦП "UKR" не реализована', 'Ошибка',MB_Ok | MB_IconStop )
.head 8 +  If nErrorSign = 0
.head 9 -  Call sTrace( sSignData, nLen+nBuffLen, m_lsSignI )
.head 9 -  Return TRUE
.head 8 +  Else
.head 9 +  If GetSignType() = 'NBU'
.head 10 -  Set strErrorSign = 'Ошибка наложения ЭЦП НБУ: '
|| NumberToStr(nErrorSign)
|| PutCrLf()||'Ключ='||GetIdOper()||PutCrLf()||GetSepSignMsg(nErrorSign)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'VEG'
.head 10 -  Set strErrorSign = SalStrRepeatX(' ', 4096)
.head 10 -  Call VegaGetMsgAux(nErrorSign, strErrorSign, 4096)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'UNI'
.head 10 -  ! Set szTempBuf = SalStrRepeatX(' ', 256)
.head 10 -  ! Call NBUFormatMessage( nErrorSign, szTempBuf, 256)
.head 10 -  ! Set strErrorSign = 'Ошибка наложения ЭЦП UNI: '||SalNumberToStrX( nErrorSign, 0)
  || PutCrLf()||'KeyID='||GetIdOper()||PutCrLf()||szTempBuf
.head 10 -  ! Call MessageErrorEx(strErrorSign)
.head 10 -  ! ----------------------------
.head 10 -  Call MessageErrorEx( UNIFormatGSSMessage(min_status, nErrorSign) )
.head 9 +  Else ! обработка ошибок ЭЦП
.head 10 -  Call nsignMapError2Text(strErrorSign,nErrorSign)
.head 10 -  Call nsignExitOPSign()
.head 10 -  Call MessageErrorEx(StrDosToWinX(strErrorSign))
.head 7 -  Return FALSE
.head 5 +  Function: sDocVisa   ! Подписать документ при  визировании
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Long String: sSignData
.head 7 -  Number: nErrorSign
.head 7 -  String: strErrorSign
.head 7 -  String: sNd
.head 7 -  String: sNama
.head 7 -  String: sNamb
.head 7 -  String: sNazn
.head 7 -  String: sDrec
.head 7 -  String: sDat1
.head 7 -  String: sDat2
.head 7 -  Number: nVob
.head 7 -  String: szTempBuf
.head 7 -  Long String: p_lsBuffer
.head 7 -  Long String: binBuffer
.head 7 -  Number: p_nBufferLen
.head 7 -  String: p_KeyID
.head 7 -  Long String: p_lsSign
.head 7 -  Long String: binSign
.head 7 -  Number: p_nSignLen
.head 7 -  Number: p_nRetVal
.head 7 -  String: p_szSignType
.head 7 -  Number: nFetchRes
.head 7 -  Long String: binTempBuf
.head 7 -  Long String: lsTempBuf
.head 7 -  Number: nTmpVal
.head 7 -  Long String: ptrBuf
.head 7 -  Long String: ptrBuf2
.head 7 -  Number: hFile
.head 7 -  String: szCrtID
.head 7 -  String: szID_O_Buf
.head 7 -  Number: min_status
.head 7 -  Number: nSignLen
.head 7 -  Number: nCertLen
.head 7 -  Number: nSignHandle
.head 7 -  Number: nCertHandle
.head 6 +  Actions
.head 7 +  If GetSignOn() = 0 ! ЭЦП отключена - вернуть Пусто
.head 8 -  Set m_lsSign = STRING_Null
.head 8 -  Return TRUE
.head 7 +  If ..sIni()
.head 8 -  Set sNd = m_sNd
.head 8 -  Set sNama = A.Nam
.head 8 -  Set sNamb = B.Nam
.head 8 -  Set sNazn = m_sNazn
.head 8 -  Set sDat1 = SalFmtFormatDateTime(m_dDatD,'yyMMdd')
.head 8 -  Set sDat2 = SalFmtFormatDateTime(m_dDatP,'yyMMdd')
.head 8 -  Set sDrec = m_sDrec
.head 8 +  If m_nVob=1 or m_nVob=2 or m_nVob=6 or m_nVob=33 or m_nVob=81
.head 9 -  Set nVob = m_nVob
.head 8 +  Else
.head 9 -  Set nVob = GetVobForBadVob()
.head 8 -  ! Если m_szREF_A is not NULL ==> его вычитывали из arc_rrp
  ==> надо проставить его вместо m_nRef для ответных платежей
  и для докум. клиент-банка
.head 8 +  ! If m_szREF_A != STRING_Null
.head 9 -  Set szID_O_Buf = PadL( m_szREF_A, 9 )
.head 8 +  ! Else
.head 9 -  ! иначе - работаем по-старому
.head 9 -  Set szID_O_Buf = PadL(SalNumberToStrX(m_nRef,0), 9)
.head 8 -  Set sSignData = PadL(A.Bank, 9) || PadL(A.Nls, 14) ||
                PadL(B.Bank, 9) || PadL(B.Nls, 14) ||
    PadL(SalNumberToStrX(m_nDk, 0), 1) || PadL(SalNumberToStrX(A.S, 0), 16) ||
    PadL(SalNumberToStrX(nVob,0), 2) || PadR(sNd, 10)  ||
    PadL(SalNumberToStrX(A.Kv, 0),  3) || sDat1 || sDat2 ||
    PadR(sNama, 38)  || PadR(sNamb,38) ||
    PadR(sNazn, 160) || PadR(sDrec,60) || PadR(m_sNaznk, 3) || PadR(m_sNazns, 2) ||
    PadL(A.Okpo, 14) || PadL(B.Okpo, 14)  ||
    PadL(m_sRef_A,9) || PadR(m_sOperId, 6) ||
    PadL(SalNumberToStrX(m_nBis, 0),2) || PadL(' ', 8)
.head 8 -  Set nTmpVal = SalStrLength( sSignData )
.head 8 -  ! Здесь должен быть вызов Денисовой процедуры
+ конкатенация полученного буфера с sSignData
.head 8 -  Set p_szSignType = GetSignType()
.head 8 +  If NOT SqlPLSQLCommand( hSql(), 
"GetVisaSignAttribute(
  p_nRetVal, m_nRef, 'NEW', 0, 
  p_szSignType, p_lsBuffer, p_nBufferLen, p_KeyID, p_lsSign, p_nSignLen)" )
.head 9 -  Call Debug( 'Ошибка!' )
.head 9 -  Return FALSE
.head 8 -  ! Преобразование HEX --> BIN
.head 8 -  Set binBuffer = SalStrRepeatX( '\0', 8*1024 )
.head 8 -  Set binSign   = SalStrRepeatX( '\0', 1024 )
.head 8 -  Set ptrBuf  = p_lsBuffer
.head 8 -  Set ptrBuf2 = binBuffer
.head 8 -  Call ConvertHexToBin( ptrBuf, ptrBuf2, p_nBufferLen )
.head 8 -  Set ptrBuf = p_lsSign
.head 8 -  Set ptrBuf2 = binSign
.head 8 -  Call ConvertHexToBin( p_lsSign, binSign, p_nSignLen )
.head 8 -  ! Set hFile = _sopen( GetPrnDir() || '\\' || 'binBuf.DAT', 0x00008302, 0x00000010, 0x00000180)
.head 8 +  ! If hFile != -1
.head 9 -  Call _write( hFile, binBuffer, p_nBufferLen )
.head 9 -  Call _close( hFile )
.head 8 +  If p_nBufferLen > 0
.head 9 -  Set nSignErrType = 2
.head 9 -  ! Конкатенация бинарных буферов
.head 9 -  Set binTempBuf = SalStrRepeatX( ' ', 9*1024 )
.head 9 -  Set lsTempBuf =  SalStrRepeatX( ' ', 9*1024 )
.head 9 -  Set lsTempBuf = sSignData
.head 9 -  Set sSignData =  SalStrRepeatX( ' ', 64*1024 )
.head 9 -  Call ConcatBufs( sSignData, lsTempBuf, nTmpVal, binBuffer, p_nBufferLen )
.head 9 -  ! Set hFile = _sopen( GetPrnDir() || '\\' || 'SIGNTRAB.DAT', 0x00008302, 0x00000010, 0x00000180)
.head 9 +  ! If hFile != -1
.head 10 -  Call _write( hFile, sSignData, nTmpVal+p_nBufferLen )
.head 10 -  Call _close( hFile )
.head 8 +  If GetSignType() = 'NBU'
.head 9 -  Call SalStrSetBufferLength( m_lsSign, 65 )
.head 9 -  Set nErrorSign = RSA_ZAH(87,-1,1,
    sSignData,nTmpVal+p_nBufferLen,
    0,m_lsSign,m_sOperId)
.head 8 +  Else If GetSignType() = 'VEG'
.head 9 -  Call SalStrSetBufferLength( m_lsSign, 91 )
.head 9 -  Set nErrorSign = VegaEnsign(m_lsSign,sSignData,
    nTmpVal+p_nBufferLen,0,sUid,0,0)
.head 8 +  Else If GetSignType() = 'UNI'
.head 9 -  ! Call SalStrSetBufferLength( m_lsSign, UNI_SIGN_SIZE+1 )
.head 9 -  ! Call SalStrSetBufferLength( m_lsCertificate, UNI_CERT_SIZE+1 )
.head 9 -  ! Set nErrorSign = OL_CREATE_SIGN_CRED( m_nNullContext,
			nTmpVal+p_nBufferLen, sSignData,
			UNI_SIGN_SIZE, m_lsSign,
			UNI_CERT_SIZE, m_lsCertificate)
.head 9 -  ! --------------------------------
.head 9 -  Call SalStrSetBufferLength( m_lsSign, UNI_SIGN_SIZE+1 )
.head 9 -  Call SalStrSetBufferLength( m_lsCertificate, UNI_CERT_SIZE+1 )
.head 9 -  Set nErrorSign = NG_CREATE_SIGN_CRED( min_status,
			m_nCredHandle,
			nTmpVal+p_nBufferLen, sSignData,
			nSignLen, nSignHandle,
			nCertLen, nCertHandle)
.head 9 +  If 0=nErrorSign
.head 10 -  Call ConvertHexToBin( NumPtr2HexStr(nSignHandle, nSignLen), 
	m_lsSign, nSignLen )
.head 10 -  Call ConvertHexToBin( NumPtr2HexStr(nCertHandle, nCertLen), 
	m_lsCertificate, nCertLen )
.head 10 -  ! чистим память
.head 10 -  Call gss_release_buffer( min_status, nSignLen, nSignHandle )
.head 10 -  Call gss_release_buffer( min_status, nCertLen, nCertHandle )
.head 9 -  ! Set hFile = _sopen( GetPrnDir() || '\\' || 'VisaSign.dat', 0x00008302, 0x00000010, 0x00000180)
.head 9 +  ! If hFile != -1
.head 10 -  Call _write( hFile, m_lsSign, 88 )
.head 10 -  Call _close( hFile )
.head 8 +  Else
.head 9 -  Call SalMessageBox( 'Наложение ЭЦП "UKR" не реализована', 'Ошибка', 
MB_Ok | MB_IconStop )
.head 9 -  ! Call SalStrSetBufferLength( m_lsSign, 129 )
.head 9 -  ! Set nErrorSign = nsignPutOPSignOnMemory(sSignData,444,m_lsSign)
.head 8 +  If nErrorSign = 0
.head 9 -  Call sTrace(sSignData, nTmpVal+p_nBufferLen, m_lsSign)
.head 9 -  Return TRUE
.head 8 +  Else
.head 9 +  If GetSignType() = 'NBU'
.head 10 -  Set strErrorSign = 'Ошибка наложения ЭЦП НБУ: '
|| NumberToStr(nErrorSign)
|| PutCrLf()||'Ключ='||GetIdOper()||PutCrLf()||GetSepSignMsg(nErrorSign)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'VEG'
.head 10 -  Set strErrorSign = SalStrRepeatX(' ', 4096)
.head 10 -  Call VegaGetMsgAux(nErrorSign, strErrorSign, 4096)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'UNI'
.head 10 -  ! Set szTempBuf = SalStrRepeatX(' ', 256)
.head 10 -  ! Call NBUFormatMessage( nErrorSign, szTempBuf, 256)
.head 10 -  ! Set strErrorSign = 'Ошибка наложения ЭЦП UNI: '||SalNumberToStrX( nErrorSign, 0)
  || PutCrLf()||'KeyID='||GetIdOper()||PutCrLf()||szTempBuf
.head 10 -  ! Call MessageErrorEx(strErrorSign)
.head 10 -  ! ----------------------------
.head 10 -  Call MessageErrorEx( UNIFormatGSSMessage(min_status, nErrorSign) )
.head 9 +  Else ! обработка ошибок ЭЦП
.head 10 -  Call nsignMapError2Text(strErrorSign,nErrorSign)
.head 10 -  Call nsignExitOPSign()
.head 10 -  Call MessageErrorEx(StrDosToWinX(strErrorSign))
.head 7 -  Return FALSE
.head 5 +  Function: CheckDocSign   ! Проверить ЭЦП на документ
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: szMode ! Режим работы 'CUR' - проверить текущую ЭЦП (nVisaLevel=max)
                              'LVL' - проверить ЭЦП уровня nVisaLevel
.head 7 -  Number: nVisaLevel ! Уровень ЭЦП
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sSignData
.head 7 -  Number: nErrorSign
.head 7 -  String: strErrorSign
.head 7 -  String: sNd
.head 7 -  String: sNama
.head 7 -  String: sNamb
.head 7 -  String: sNazn
.head 7 -  String: sDrec
.head 7 -  String: sDat1
.head 7 -  String: sDat2
.head 7 -  Number: nVob
.head 7 -  String: szTempBuf
.head 7 -  Long String: p_lsBuffer
.head 7 -  Long String: binBuffer
.head 7 -  Number: p_nBufferLen
.head 7 -  String: p_KeyID
.head 7 -  Long String: p_lsSign
.head 7 -  Long String: binSign
.head 7 -  Number: p_nSignLen
.head 7 -  Number: p_nRetVal
.head 7 -  String: p_szSignType
.head 7 -  Number: nFetchRes
.head 7 -  Long String: binTempBuf
.head 7 -  Long String: lsTempBuf
.head 7 -  Number: nTmpVal
.head 7 -  Long String: ptrBuf
.head 7 -  Long String: ptrBuf2
.head 7 -  Number: hFile
.head 7 -  String: szCrtID
.head 7 -  Number: nMaxVisaLevel
.head 7 -  String: szID_O_Buf
.head 7 -  Number: min_status
.head 7 -  Number: nSignLen
.head 7 -  Number: nCertLen
.head 7 -  Number: nSignHandle
.head 7 -  Number: nCertHandle
.head 6 +  Actions
.head 7 +  If GetSignOn() = 0 ! ЭЦП отключена - вернуть Пусто
.head 8 -  Set m_lsSign = STRING_Null
.head 8 -  Return TRUE
.head 7 +  If ..sIni()
.head 8 -  ! Определяемся с уровнем визы
.head 8 +  If m_nRef=-1 ! референс не задан
.head 9 -  Set nMaxVisaLevel=0
.head 8 +  Else
.head 9 +  If NOT SqlPrepareAndExecute( hSql(),
"select nvl(length(rtrim(chk))/6,0) from oper where ref=:m_nRef into :nMaxVisaLevel" )
.head 10 -  Call SalMessageBox( 'Не могу получить MAX уровень визы', 'Ошибка', MB_Ok | MB_IconStop )
.head 10 -  Return FALSE
.head 9 -  Call SqlFetchNext( hSql(), nFetchRes )
.head 9 +  If FETCH_Ok != nFetchRes
.head 10 -  Call SalMessageBox( 'Не могу получить MAX уровень визы', 'Ошибка', MB_Ok | MB_IconStop )
.head 10 -  Return FALSE
.head 8 +  If nMaxVisaLevel>0
.head 9 -  Set nSignErrType = 2
.head 8 +  Else
.head 9 -  Set nSignErrType = 1
.head 8 -  ! -----------------------------
.head 8 -  Set sNd = m_sNd
.head 8 -  Set sNama = A.Nam
.head 8 -  Set sNamb = B.Nam
.head 8 -  Set sNazn = m_sNazn
.head 8 -  Set sDat1 = SalFmtFormatDateTime(m_dDatD,'yyMMdd')
.head 8 -  Set sDat2 = SalFmtFormatDateTime(m_dDatP,'yyMMdd')
.head 8 -  Set sDrec = m_sDrec
.head 8 +  If m_nVob=1 or m_nVob=2 or m_nVob=6 or m_nVob=33 or m_nVob=81
.head 9 -  Set nVob = m_nVob
.head 8 +  Else
.head 9 -  Set nVob = GetVobForBadVob()
.head 8 -  ! Если m_szREF_A is not NULL ==> его вычитывали из arc_rrp
  ==> надо проставить его вместо m_nRef для ответных платежей
  и для докум. клиент-банка
.head 8 +  ! If m_szREF_A != STRING_Null
.head 9 -  Set szID_O_Buf = PadL( m_szREF_A, 9 )
.head 8 +  ! Else
.head 9 -  ! иначе - работаем по-старому
.head 9 -  Set szID_O_Buf = PadL(SalNumberToStrX(m_nRef,0), 9)
.head 8 -  Set sSignData = PadL(A.Bank, 9) || PadL(A.Nls, 14) ||
                PadL(B.Bank, 9) || PadL(B.Nls, 14) ||
    PadL(SalNumberToStrX(m_nDk, 0), 1) || PadL(SalNumberToStrX(A.S, 0), 16) ||
    PadL(SalNumberToStrX(nVob,0), 2) || PadR(sNd, 10)  ||
    PadL(SalNumberToStrX(A.Kv, 0),  3) || sDat1 || sDat2 ||
    PadR(sNama, 38)  || PadR(sNamb,38) ||
    PadR(sNazn, 160) || PadR(sDrec,60) || PadR(m_sNaznk, 3) || PadR(m_sNazns, 2) ||
    PadL(A.Okpo, 14) || PadL(B.Okpo, 14)  ||
    PadL(m_sRef_A,9) || PadR(m_sOperId, 6) ||
    PadL(SalNumberToStrX(m_nBis, 0),2) || PadL(' ', 8)
.head 8 -  Set nTmpVal = SalStrLength( sSignData )
.head 8 -  ! Здесь должен быть вызов Денисовой процедуры
+ конкатенация полученного буфера с sSignData
.head 8 -  Set p_szSignType = GetSignType()
.head 8 -  Call SalStrSetBufferLength( binBuffer, 8*1024 )
.head 8 -  Call SalStrSetBufferLength( binSign, 1024 )
.head 8 +  If m_nRef=-1 ! референс не задан
.head 9 -  ! выставляем параметры по-умолчанию
.head 9 -  Set p_nBufferLen = 0
.head 9 -  Set p_KeyID = m_sOperId
.head 9 -  Set p_nSignLen = m_nSignLen
.head 9 -  Call memmove( binSign, m_lsSign, m_nSignLen )
.head 8 +  Else
.head 9 +  If NOT SqlPLSQLCommand( hSql(), 
"GetVisaSignAttribute(
  p_nRetVal, m_nRef, szMode, nVisaLevel, 
  p_szSignType, p_lsBuffer, p_nBufferLen, p_KeyID, p_lsSign, p_nSignLen)" )
.head 10 -  Call Debug( 'Ошибка выполнения GetVisaSignAttribute()' )
.head 10 -  Return FALSE
.head 9 +  If p_nSignLen=NUMBER_Null OR p_nSignLen=0 ! ==> нечего проверять
.head 10 -  Call SalMessageBox( 'ЭЦП отсутствует', 'Ошибка', MB_Ok | MB_IconStop )
.head 10 -  Set nErrorSign = 3301
.head 10 -  Return FALSE
.head 9 -  ! Преобразование HEX --> BIN
.head 9 -  Set ptrBuf  = p_lsBuffer
.head 9 -  Set ptrBuf2 = binBuffer
.head 9 -  Call ConvertHexToBin( ptrBuf, ptrBuf2, p_nBufferLen )
.head 9 -  Set ptrBuf = p_lsSign
.head 9 -  Set ptrBuf2 = binSign
.head 9 -  Call ConvertHexToBin( p_lsSign, binSign, p_nSignLen )
.head 8 -  ! Set hFile = _sopen( GetPrnDir() || '\\' || 'binBuf.DAT', 0x00008302, 0x00000010, 0x00000180)
.head 8 +  ! If hFile != -1
.head 9 -  Call _write( hFile, binBuffer, p_nBufferLen )
.head 9 -  Call _close( hFile )
.head 8 -  Set hFile = _sopen( GetPrnDir() || '\\' || 'binSign.DAT', 0x00008302, 0x00000010, 0x00000180)
.head 8 +  If hFile != -1
.head 9 -  Call _write( hFile, binSign, p_nSignLen )
.head 9 -  Call _close( hFile )
.head 8 -  ! ------------------------
.head 8 -  Set hFile = _sopen( GetPrnDir() || '\\' || 'signdata.dat', 0x00008302, 0x00000010, 0x00000180)
.head 8 +  If hFile != -1
.head 9 -  Call _write( hFile, sSignData, nTmpVal )
.head 9 -  Call _close( hFile )
.head 8 +  If 0 = strncmp( binSign, 'AUTOTRANSACTION', 15 )
.head 9 -  Return TRUE
.head 8 +  If p_nBufferLen > 0
.head 9 -  Set nSignErrType = 2
.head 9 -  ! Конкатенация бинарных буферов
.head 9 -  Set binTempBuf = SalStrRepeatX( ' ', 9*1024 )
.head 9 -  Set lsTempBuf =  SalStrRepeatX( ' ', 9*1024 )
.head 9 -  Set lsTempBuf = sSignData
.head 9 -  Set sSignData =  SalStrRepeatX( ' ', 64*1024 )
.head 9 -  Call ConcatBufs( sSignData, lsTempBuf, nTmpVal, binBuffer, p_nBufferLen )
.head 9 -  ! -------------------------------
.head 9 -  Set hFile = _sopen( GetPrnDir() || '\\' || 'SIGNTRAB.DAT', 0x00008302, 0x00000010, 0x00000180)
.head 9 +  If hFile != -1
.head 10 -  Call _write( hFile, sSignData, nTmpVal+p_nBufferLen )
.head 10 -  Call _close( hFile )
.head 8 -  ! ----------------------------
.head 8 +  If GetSignType() = 'NBU'
.head 9 -  ! Call SalStrSetBufferLength( m_lsSign, 65 )
.head 9 -  Set nErrorSign = RSA_ZAH(82,-1,1,sSignData,nTmpVal+p_nBufferLen,
0,binSign,p_KeyID)
.head 8 +  Else If GetSignType() = 'VEG'
.head 9 -  ! Call SalStrSetBufferLength( m_lsSign, 91 )
.head 9 -  Set nErrorSign = VegaCheck(binSign,sSignData,
nTmpVal+p_nBufferLen,0,sUidCheck,0,0,0)
.head 8 +  Else If GetSignType() = 'UNI'
.head 9 -  ! Тут много геморроя с новой ЭЦП НБУ :(
.head 9 -  ! Call SalStrSetBufferLength( m_lsSign, UNI_SIGN_SIZE+1 )
.head 9 -  Call SalStrSetBufferLength( m_lsCertificate, UNI_CERT_SIZE+1 )
.head 9 -  ! Извлекаем ID откр. ключа
.head 9 -  Set szCrtID = SalStrMidX( p_lsSign, 14, 18 )
.head 9 -  Call SqlSetLongBindDatatype( 1, BLOB_BYTE )
.head 9 +  If NOT SqlPrepareAndExecute( hSql(), "select key into :m_lsCertificate from keys where key_id=:szCrtID" )
.head 10 -  Call SalMessageBox( 'Ошибка при выполнении select key from keys', 'Error', 
MB_Ok|MB_IconStop )
.head 10 -  Return FALSE
.head 9 -  Call SqlFetchNext( hSql(), nFetchRes )
.head 9 +  If FETCH_Ok = nFetchRes
.head 10 -  ! Проверяем подпись
.head 10 -  ! Set nErrorSign = OL_VERIFY_SIGN_CRED( m_nNullContext,
			nTmpVal+p_nBufferLen, sSignData,
			UNI_SIGN_SIZE, binSign,
			UNI_CERT_SIZE, m_lsCertificate)
.head 10 -  Set nErrorSign = NG_VERIFY_SIGN_CRED( min_status,
			m_nCredHandle,
			nTmpVal+p_nBufferLen, sSignData,
			UNI_SIGN_SIZE, binSign,
			UNI_CERT_SIZE, m_lsCertificate) 
.head 9 +  Else
.head 10 -  Call SalMessageBox( 'Не найден открытый ключ [' || szCrtID || ']', 'Error', 
MB_Ok|MB_IconStop )
.head 10 -  Set nErrorSign = 3301
.head 10 -  Return FALSE
.head 8 +  Else
.head 9 -  Call SalMessageBox( 'Проверка ЭЦП "UKR" не реализована', 'Ошибка', 
MB_Ok | MB_IconStop )
.head 9 -  ! Call SalStrSetBufferLength( m_lsSign, 129 )
.head 9 -  ! Set nErrorSign = nsignPutOPSignOnMemory(sSignData,444,m_lsSign)
.head 8 -  Call sTrace(sSignData, nTmpVal+p_nBufferLen, binSign)
.head 8 +  If nErrorSign = 0
.head 9 -  Return TRUE
.head 8 +  Else
.head 9 +  If GetSignType() = 'NBU'
.head 10 -  Set strErrorSign = 'Ошибка снятия ЭЦП НБУ: '
|| NumberToStr(nErrorSign)
|| PutCrLf()||'Ключ='||GetIdOper()||PutCrLf()||GetSepSignMsg(nErrorSign)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'VEG'
.head 10 -  Set strErrorSign = SalStrRepeatX(' ', 4096)
.head 10 -  Call VegaGetMsgAux(nErrorSign, strErrorSign, 4096)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'UNI'
.head 10 -  ! Set szTempBuf = SalStrRepeatX(' ', 256)
.head 10 -  ! Call NBUFormatMessage( nErrorSign, szTempBuf, 256)
.head 10 -  ! Set strErrorSign = 'Ошибка снятия ЭЦП UNI: '||SalNumberToStrX( nErrorSign, 0)
  || PutCrLf()||'Ключ='||GetIdOper()||PutCrLf()||szTempBuf
.head 10 -  ! Call MessageErrorEx(strErrorSign)
.head 10 -  ! ---------------------------------
.head 10 -  Call MessageErrorEx( UNIFormatGSSMessage(min_status, nErrorSign) )
.head 9 +  Else ! обработка ошибок ЭЦП
.head 10 -  Call nsignMapError2Text(strErrorSign,nErrorSign)
.head 10 -  Call nsignExitOPSign()
.head 10 -  Call MessageErrorEx(StrDosToWinX(strErrorSign))
.head 7 -  Return FALSE
.head 5 +  Function: cDocInt    ! Проверить внутреннюю подпись на документе
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nLev         ! Уровень ЭЦП
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sSignData
.head 7 -  Long String: sBuff
.head 7 -  Number: nLen
.head 7 -  Number: nErrorSign
.head 7 -  String: strErrorSign
.head 7 -  String: sNd
.head 7 -  String: sNama
.head 7 -  String: sNamb
.head 7 -  String: sNazn
.head 7 -  String: sDrec
.head 7 -  String: sDat1
.head 7 -  String: sDat2
.head 7 -  Number: nVob
.head 7 -  String: szTempBuf
.head 7 -  Long String: p_lsBuffer
.head 7 -  Long String: binBuffer
.head 7 -  Long String: binBuff
.head 7 -  Number: nBuffLen
.head 7 -  String: p_KeyID
.head 7 -  Long String: p_lsSign
.head 7 -  Long String: binSign
.head 7 -  Number: p_nSignLen
.head 7 -  Number: p_nRetVal
.head 7 -  String: p_szSignType
.head 7 -  Number: nFetchRes
.head 7 -  Long String: binTempBuf
.head 7 -  Long String: lsTempBuf
.head 7 -  Number: nTmpVal
.head 7 -  Long String: ptrBuf
.head 7 -  Long String: ptrBuf2
.head 7 -  Number: hFile
.head 7 -  String: szCrtID
.head 7 -  Number: nMaxVisaLevel
.head 7 -  String: szID_O_Buf
.head 7 -  Number: min_status
.head 7 -  Number: nSignLen
.head 7 -  Number: nCertLen
.head 7 -  Number: nSignHandle
.head 7 -  Number: nCertHandle
.head 6 +  Actions
.head 7 +  If GetSignOn() = 0 ! ЭЦП отключена - вернуть Пусто
.head 8 -  Set m_lsSignI = STRING_Null
.head 8 -  Return TRUE
.head 7 +  If ..sIni()
.head 8 -  Set sSignData = iSignData()
.head 8 -  Set nLen = SalStrLength( sSignData )
.head 8 -  ! Получить буфер для проверки
.head 8 +  If NOT SqlPLSQLCommand( hSql(),"chk.get_buf( m_nRef, nLev, sBuff )" )
.head 9 -  Call Debug( 'Ошибка!' )
.head 9 -  Return FALSE
.head 8 -  Set nBuffLen=SalStrLength(sBuff)/2
.head 8 +  If nBuffLen
.head 9 -  Call SalStrSetBufferLength( m_lsSignI, m_nSignLen+1 )
.head 9 -  Call ConvertHexToBin(SalStrMidX(sBuff,(nBuffLen-m_nSignLen)*2,m_nSignLen*2), m_lsSignI, m_nSignLen )  ! HEX --> BIN
.head 9 -  !
.head 9 -  Call SalStrSetBufferLength( binBuff, nBuffLen+1 )
.head 9 -  Call ConvertHexToBin(sBuff, binBuff, nBuffLen )  ! HEX --> BIN
.head 9 -  Call SalStrSetBufferLength( sSignData, nLen+nBuffLen+1 )
.head 9 -  Call ConcatBufs( sSignData, iSignData(), nLen, binBuff, nBuffLen )
.head 8 +  Else
.head 9 -  Return TRUE
.head 8 +  If GetSignType() = 'NBU'
.head 9 -  Set nErrorSign = RSA_ZAH(82,-1,1,sSignData,nLen+nBuffLen-m_nSignLen-6,0,
                       m_lsSignI,
                       GetOffset(sSignData,nLen+nBuffLen-m_nSignLen-6))
.head 8 +  Else If GetSignType() = 'VEG'
.head 9 -  Set nErrorSign = VegaCheck(binSign,sSignData,nLen+nBuffLen-m_nSignLen-6,0,sUidCheck,0,0,0)
.head 8 +  Else If GetSignType() = 'UNI'
.head 9 -  ! Тут много геморроя с новой ЭЦП НБУ :(
.head 9 -  ! Call SalStrSetBufferLength( m_lsSign, UNI_SIGN_SIZE+1 )
.head 9 -  Call SalStrSetBufferLength( m_lsCertificate, UNI_CERT_SIZE+1 )
.head 9 -  ! Извлекаем ID откр. ключа
.head 9 -  Set szCrtID = SalStrMidX( p_lsSign, 14, 18 )
.head 9 -  Call SqlSetLongBindDatatype( 1, BLOB_BYTE )
.head 9 +  If NOT SqlPrepareAndExecute( hSql(), "select key into :m_lsCertificate from keys where key_id=:szCrtID" )
.head 10 -  Call SalMessageBox( 'Ошибка при выполнении select key from keys', 'Error', 
MB_Ok|MB_IconStop )
.head 10 -  Return FALSE
.head 9 -  Call SqlFetchNext( hSql(), nFetchRes )
.head 9 +  If FETCH_Ok = nFetchRes
.head 10 -  ! Проверяем подпись
.head 10 -  ! Set nErrorSign = OL_VERIFY_SIGN_CRED( m_nNullContext,
			nTmpVal+p_nBufferLen, sSignData,
			UNI_SIGN_SIZE, binSign,
			UNI_CERT_SIZE, m_lsCertificate)
.head 10 -  Set nErrorSign = NG_VERIFY_SIGN_CRED( min_status,
			m_nCredHandle,
			nLen+nBuffLen-m_nSignLen-6, sSignData,
			UNI_SIGN_SIZE, binSign,
			UNI_CERT_SIZE, m_lsCertificate) 
.head 9 +  Else
.head 10 -  Call SalMessageBox( 'Не найден открытый ключ [' || szCrtID || ']', 'Error', 
MB_Ok|MB_IconStop )
.head 10 -  Set nErrorSign = 3301
.head 10 -  Return FALSE
.head 8 +  Else
.head 9 -  Call SalMessageBox( 'Проверка ЭЦП "UKR" не реализована', 'Ошибка', MB_Ok | MB_IconStop )
.head 8 -  Call sTrace(sSignData, nLen+nBuffLen-m_nSignLen-6, m_lsSignI)
.head 8 +  If nErrorSign = 0
.head 9 -  Return TRUE
.head 8 +  Else
.head 9 +  If GetSignType() = 'NBU'
.head 10 -  Set strErrorSign = 'Ошибка снятия ЭЦП НБУ: '
|| NumberToStr(nErrorSign)
|| PutCrLf()||'Ключ='||GetIdOper()||PutCrLf()||GetSepSignMsg(nErrorSign)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'VEG'
.head 10 -  Set strErrorSign = SalStrRepeatX(' ', 4096)
.head 10 -  Call VegaGetMsgAux(nErrorSign, strErrorSign, 4096)
.head 10 -  Call MessageErrorEx(strErrorSign)
.head 9 +  Else If GetSignType() = 'UNI'
.head 10 -  ! Set szTempBuf = SalStrRepeatX(' ', 256)
.head 10 -  ! Call NBUFormatMessage( nErrorSign, szTempBuf, 256)
.head 10 -  ! Set strErrorSign = 'Ошибка снятия ЭЦП UNI: '||SalNumberToStrX( nErrorSign, 0)
  || PutCrLf()||'Ключ='||GetIdOper()||PutCrLf()||szTempBuf
.head 10 -  ! Call MessageErrorEx(strErrorSign)
.head 10 -  ! ---------------------------------
.head 10 -  Call MessageErrorEx( UNIFormatGSSMessage(min_status, nErrorSign) )
.head 9 +  Else ! обработка ошибок ЭЦП
.head 10 -  Call nsignMapError2Text(strErrorSign,nErrorSign)
.head 10 -  Call nsignExitOPSign()
.head 10 -  Call MessageErrorEx(StrDosToWinX(strErrorSign))
.head 7 -  Return FALSE
.head 5 +  Function: sTrace ! Трассировка подписей в файл
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sString
.head 7 -  Number: nLenS
.head 7 -  Long String: lsSign
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Date/Time: dDatTmp
.head 7 -  File Handle: hFile
.head 7 -  String: sFn
.head 7 -  String: sTmp
.head 7 -  ! Number: nChar
.head 7 -  ! Number: nN1
.head 7 -  ! Number: nN2
.head 7 -  ! Number: nIter
.head 6 +  Actions
.head 7 -  Set sFn = GetPrnDir() || '\\' || 'SIGNTRAC.TXT'
.head 7 +  If SalFileGetDateTime(sFn, dDatTmp)
.head 8 -  Call SalFileOpen(hFile, sFn, OF_Append | OF_Binary)
.head 7 +  Else
.head 8 -  Call SalFileOpen(hFile, sFn, OF_Create | OF_Write | OF_Binary)
.head 7 -  Call SalFileWrite(hFile, sString, nLenS)
.head 7 -  ! Set sTmp = '-'
.head 7 -  ! Set nIter = 0
.head 7 +  ! While SalStrFirstC(lsSign, nChar) AND nIter<m_nSignLen
.head 8 -  Set nN1 = (nChar - SalNumberMod(nChar, 16)) / 16
.head 8 +  If nN1 > 9
.head 9 -  Set nN1 = nN1 + 55
.head 8 +  Else 
.head 9 -  Set nN1 = nN1 + 48
.head 8 -  Set nN2 = SalNumberMod(nChar, 16)
.head 8 +  If nN2 > 9
.head 9 -  Set nN2 = nN2 + 55
.head 8 +  Else 
.head 9 -  Set nN2 = nN2 + 48
.head 8 -  Set sTmp = sTmp || SalNumberToChar(nN1) || SalNumberToChar(nN2)
.head 8 -  Set nIter = nIter + 1
.head 7 -  Call SalStrSetBufferLength( sTmp, m_nSignLen * 2 + 1 )
.head 7 -  Call ConvertBinToHex( lsSign, sTmp, m_nSignLen )  ! BIN->HEX
.head 7 -  Call SalFilePutStr(hFile, '-'||sTmp)
.head 7 -  Call SalFileClose(hFile)
.head 5 +  Function: sTranS ! Трансляция формулы суммы
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Receive Number: nS
.head 7 -  String: sS
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: S    !
.head 7 -  String: S2   ! для
.head 7 -  String: N    ! подстановки
.head 7 -  String: KvA  ! при вычислении суммы операции
.head 7 -  String: KvB  !
.head 7 -  String: REF
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 +  If sS
.head 8 -  Set S  = SalNumberToStrX(A.S, 0)     ! Сумма платежа
.head 8 -  Set S2 = SalNumberToStrX(B.S, 0)     ! Сумма платежа
.head 8 -  Set N = SalNumberToStrX(m_nNom, 0)   ! Номинал Б
.head 8 -  Set KvA = SalNumberToStrX(A.Kv, 0)   ! Код валюты А
.head 8 -  Set KvB = SalNumberToStrX(B.Kv, 0)   ! Код валюты B
.head 8 -  Set REF = SalNumberToStrX(m_nRef, 0) ! Референція
.head 8 -  Set sS = SalStrUpperX(' ' || sS)
.head 8 +  While SalStrScan(sS, '#(S)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(S)'),4,S)
.head 8 +  While SalStrScan(sS, '#(S2)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(S2)'),5,S2)
.head 8 +  While SalStrScan(sS,'#(NOM)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(NOM)'),6,N)
.head 8 +  While SalStrScan(sS,'#(NLSA)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(NLSA)'),7,A.Nls)
.head 8 +  While SalStrScan(sS,'#(NLSB)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(NLSB)'),7,B.Nls)
.head 8 +  While SalStrScan(sS,'#(MFOA)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(MFOA)'),7,A.Bank)
.head 8 +  While SalStrScan(sS,'#(MFOB)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(MFOB)'),7,B.Bank)
.head 8 +  While SalStrScan(sS,'#(KVA)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(KVA)'),6,KvA)
.head 8 +  While SalStrScan(sS,'#(KVB)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(KVB)'),6,KvB)
.head 8 +  While SalStrScan(sS,'#(REF)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(REF)'),6,REF)
.head 8 +  If not SqlPrepareAndExecute(hSql(), "SELECT ROUND(" || sS || ",0) INTO :nS FROM dual")
.head 9 -  Return FALSE
.head 8 +  If not SqlFetchNext(hSql(),nFetchRes)
.head 9 -  Return FALSE
.head 7 -  Return TRUE
.head 5 +  Function: sTranN ! Трансляция формул в назначении платежа
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Receive String: rsNazn
.head 7 -  String: sNazn     !! Исходная строка
.head 7 -  String: sTT       !! Тип операции
.head 7 -  String: sNls1     !! Счет-А
.head 7 -  String: sBank1    !! МФО-А
.head 7 -  Number: nKv1      !! Код вал-А 
.head 7 -  Number: nS1       !! Сумма-А
.head 7 -  String: sNls2     !! Счет-Б     
.head 7 -  String: sBank2    !! МФО-Б
.head 7 -  Number: nKv2      !! Код вал-Б 
.head 7 -  Number: nS2       !! Сумма-Б
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: S    !
.head 7 -  String: S2   ! для
.head 7 -  String: KvA  ! при вычислении суммы операции
.head 7 -  String: KvB  !
.head 7 -  !
.head 7 -  String: sS
.head 7 -  String: sFormula
.head 7 -  String: sNazD
.head 7 -  Number: i
.head 7 -  Number: j
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  !
.head 7 -  Set sS=sNazn
.head 7 -  Set i=SalStrScan(sS,'?')
.head 7 +  While i>=0 and (SalStrMidX(sS,i+3,1) =' ' or SalStrMidX(sS,i+3,1) = STRING_Null)
           and SalStrMidX(sS,i+1,1)>='0' and SalStrMidX(sS,i+1,1) <='9'
           and SalStrMidX(sS,i+2,1)>='0' and SalStrMidX(sS,i+2,1) <='9'
.head 8 -  Call SqlPrepareAndExecute(hSql(), "SELECT TRIM(txt) INTO :sNazD FROM tnaznf WHERE n="||SalStrMidX(sS,i+1,2))
.head 8 +  If SqlFetchNext(hSql(),nFetchRes)
.head 9 -  Set sS=SalStrLeftX(sS,i)||'#{'||SalStrTrimX(sNazD)||'}'||SalStrRightX(sS,SalStrLength(sS)-i-3)
.head 8 +  Else
.head 9 -  Break
.head 8 -  Set i=SalStrScan(sS,'?')
.head 7 -  Set rsNazn=sS
.head 7 +  If SalStrScan(sS,'#{')<0 and SalStrScan(sS,'#(')<0
.head 8 -  Return TRUE
.head 7 +  Else
.head 8 -  Set S  = SalNumberToStrX(nS1, 0)   ! Сумма платежа
.head 8 -  Set S2 = SalNumberToStrX(nS2, 0)   ! Сумма платежа
.head 8 -  Set KvA = SalNumberToStrX(nKv1, 0) ! Код валюты А
.head 8 -  Set KvB = SalNumberToStrX(nKv2, 0) ! Код валюты B
.head 8 -  Set sS = ' ' || sS                 ! SalStrUpperX(' ' || sS)
.head 8 +  While SalStrScan(sS, '#(S)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(S)'),4,S)
.head 8 +  While SalStrScan(sS, '#(S2)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(S2)'),5,S2)
.head 8 +  While SalStrScan(sS,'#(NLSA)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(NLSA)'),7,sNls1)
.head 8 +  While SalStrScan(sS,'#(NLSB)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(NLSB)'),7,sNls2)
.head 8 +  While SalStrScan(sS,'#(MFOA)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(MFOA)'),7,sBank1)
.head 8 +  While SalStrScan(sS,'#(MFOB)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(MFOB)'),7,sBank2)
.head 8 +  While SalStrScan(sS,'#(KVA)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(KVA)'),6,KvA)
.head 8 +  While SalStrScan(sS,'#(KVB)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(KVB)'),6,KvB)
.head 8 +  While SalStrScan(sS,'#(TT)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(TT)'),5,"'"||sTT||"'")
.head 8 -  Set i=SalStrScan(sS,'#{')
.head 8 +  While i>=0
.head 9 -  Set sFormula=SalStrMidX(sS,i+2,SalStrLength(sS)-i-2)
.head 9 -  Set j=SalStrScan(sFormula,'}')
.head 9 +  If j>=0
.head 10 -  Set sFormula=SalStrLeftX(sFormula,j)
.head 10 +  If not SqlPrepareAndExecute(hSql(), "SELECT SUBSTR(" || sFormula || ",1,100) INTO :sNazD FROM dual")
.head 11 -  Return FALSE
.head 10 +  If not SqlFetchNext(hSql(),nFetchRes)
.head 11 -  Return FALSE
.head 10 -  Set sS=SalStrLeftX(sS,i)||SalStrTrimX(sNazD)||SalStrRightX(sS,SalStrLength(sS)-j-i-3)
.head 9 -  Set i=SalStrScan(sS,'#{')
.head 8 -  Set rsNazn=sS
.head 7 -  Return TRUE
.head 5 +  Function: pLnk
.head 6 -  Description: Оплата связанных транзакций
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nFlgBlank ! Пустой параметр
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sTT
.head 7 -  Number: nNlsm
.head 7 -  Number: nNlsk
.head 7 -  String: sS
.head 7 -  String: sS2
.head 7 -  Number: nSA
.head 7 -  Number: nSB
.head 7 -  String: sL
.head 7 -  String: sR
.head 7 -  Number: i
.head 7 -  Number: j
.head 7 -  Number: nKv
.head 7 -  Number: nDk
.head 7 -  Number: n_ttDk       ! Для Д/К связанной транзакции
.head 7 -  Number: nDkAp
.head 7 -  String: sNam
.head 7 -  String: sErrTxt
.head 7 -  Number: nFetchRes
.head 7 -  Date/Time: dDatV
.head 6 +  Actions
.head 7 +  While TRUE
.head 8 +  ! If not SqlPrepareAndExecute(hSqlAux(),T(
  "SELECT t.tt,t.dk,a.dk,t.s,t.s2,t.flags[38,38]
     INTO :sTT,:n_ttDk,:nDk,:sS,:sS2,:nFlg
     FROM tts t, ttsap a
    WHERE a.ttap=t.tt and a.tt=:m_sTT"))
.head 9 -  Set sErrTxt = 'Ош в описании связанной к '|| sTT ||' операции'
.head 9 -  Break 
.head 8 +  If not SqlPrepareAndExecute(hSqlAux(),T(
  "SELECT t.tt,t.dk,a.dk,t.s,t.s2
     INTO :sTT,:n_ttDk,:nDk,:sS,:sS2
     FROM tts t, ttsap a
    WHERE a.ttap=t.tt and a.tt=:m_sTT"))
.head 9 -  Set sErrTxt = 'Ош в описании связанной к '|| sTT ||' операции'
.head 9 -  Break
.head 8 +  Loop
.head 9 +  If not SqlFetchNext(hSqlAux(), nFetchRes)
.head 10 +  If m_nPyD and (m_nFlg=1 or m_nFlg=2)   ! Визируем только f38 1 и 2
.head 11 +  If not Pay(2,m_nRef,m_dDatV1,'',NUMBER_Null,NUMBER_Null,'',NUMBER_Null,NUMBER_Null,'')
.head 12 -  Return FALSE
.head 10 -  Return TRUE
.head 9 -  ! Call Debug('F'||sTT||Str(m_nFlg)||Str(nFlg))
.head 9 +  ! If nFlg=1 and (m_nFlg=0 or m_nFlg=2)
.head 10 -  Set m_nFlg=1
.head 9 +  If nDk = 1 ! Надо инвертировать Дебет/Кредит
.head 10 +  If b_WasDkNull
.head 11 -  Set nDk = SalNumberAbs(n_ttDk-1) ! Берем Д/К из TTS дочерней
.head 10 +  Else
.head 11 -  Set nDk = SalNumberAbs(m_nDk-1)
.head 9 +  Else
.head 10 +  If b_WasDkNull
.head 11 -  Set nDk = n_ttDk ! Берем Д/К из TTS дочерней
.head 10 +  Else
.head 11 -  Set nDk = m_nDk
.head 9 -  ! Подстановка суммы
.head 9 -  Set nSA = A.S
.head 9 +  If A.Kv = B.Kv
.head 10 -  Set nSB = NUMBER_Null
.head 9 +  Else
.head 10 -  Set nSB = B.S
.head 9 +  If not sTranS(nSA,sS)
.head 10 -  Set sErrTxt = 'Ошибка вычисления формулы суммы '|| sS
.head 10 -  Break
.head 9 +  If not sTranS(nSB,sS2)
.head 10 -  Set sErrTxt = 'Ошибка вычисления формулы суммы '|| sS2
.head 10 -  Break
.head 9 +  If m_dDatV2
.head 10 -  Set dDatV = m_dDatV2
.head 9 +  Else
.head 10 -  Set dDatV = m_dDatV1
.head 9 +  If not PayTT(0,m_nRef,dDatV,sTT,nDk,A.Kv,A.Nls,nSA,B.Kv,B.Nls,nSB)
.head 10 -  Set sErrTxt = 'Неуспешная оплата связанной транзакции '|| sTT
.head 10 -  Break
.head 8 -  Break
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return MessageErrorEx('Ошибка : ' || sErrTxt || '.')
.head 5 +  Function: oDoc
.head 6 -  Description: Вставить и оплатить документ
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sNlsm                ! основной счет
.head 7 -  String: sNlsk                ! контра счет
.head 7 -  Number: nDk          ! признак д/к
.head 7 -  String: sNam         ! наименование транзакции
.head 7 -  String: sNazns       ! способ заполнения  "назначения платежа"
.head 7 -  String: sNaznk       ! код "назначения платежа"
.head 7 -  Number: nBis         ! номер БИС
.head 7 -  Number: nRet
.head 7 -  Number: nRec
.head 7 -  Number: nFetchRes
.head 7 -  String: sErrTxt
.head 7 -  Boolean: bNewDoc     ! флаг "вновь вставляемый документ"
.head 7 -  Number: nOtv         ! Флаг "ответственная виза"
.head 6 +  Actions
.head 7 -  Set bNewDoc = FALSE
.head 7 -  Set nRet = 0
.head 7 +  While TRUE
.head 8 -  ! Читать описание транзакции
.head 8 +  If not SqlPrepareAndExecute(hSql(), T("
   SELECT dk,nlsm,nlsk,fli,flags[38,38],name FROM tts WHERE tt=:m_sTT
     INTO :nDk,:sNlsm,:sNlsk,:m_nFli,:m_nFlg,:sNam"))
.head 9 -  Break
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set sErrTxt = 'Не описана транзакция ' || m_sTT
.head 9 -  Break
.head 8 +  If m_nDk = NUMBER_Null ! Если д/к не задали - берем из TTS
.head 9 -  Set m_nDk = nDk
.head 9 -  Set b_WasDkNull = TRUE
.head 8 +  Else
.head 9 -  Set b_WasDkNull = FALSE
.head 8 -  ! Получить референцию для документа
.head 8 +  If not m_nRef
.head 9 +  If not Ref(m_nRef)
.head 10 -  Set sErrTxt = 'Невозможно получить референцию для ДОК'
.head 10 -  Break
.head 9 -  Set bNewDoc = TRUE
.head 8 +  If not SalStrTrimX(m_sNd)
.head 9 -  Set m_sNd = SalNumberToStrX(m_nRef, 0)
.head 8 +  If not SalStrTrimX(m_sNazn)
.head 9 -  Set m_sNazn = SalStrTrimX(sNam)
.head 8 +  If not SalStrTrimX(m_sRef_A)
.head 9 -  Set m_sRef_A = SalNumberToStrX(m_nRef, 0)
.head 8 +  If SalStrLength(A.Nam) > 38
.head 9 -  Set A.Nam = SalStrLeftX(A.Nam,38)
.head 8 +  If SalStrLength(B.Nam) > 38
.head 9 -  Set B.Nam = SalStrLeftX(B.Nam,38)
.head 8 -  ! Подписать документ (если межбанк или включена внутренняя подпись)
.head 8 +  If GetGlobalOption('INTSIGN')='2'  !-- новая внутрення подпись    !!!!!!!!
.head 9 +  If GetGlobalOptionEx( 'VISASIGN' ) and not m_lsSignI  
.head 10 +  If not ..sDocInt(0)
.head 11 -  Set sErrTxt = 'Не удалось подписать документ INT.'
.head 11 -  Break
.head 9 +  If m_nFlg = 1 
.head 10 -  Set nOtv = 1
.head 9 +  Else
.head 10 -  Call SqlPrepareAndExecute(hSql(),"SELECT 0 INTO :nOtv FROM chklist_tts WHERE tt=:m_sTT AND f_in_charge=1")
.head 10 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Set nOtv=1
.head 9 +  If nOtv = 1    ! ответственный уровень
.head 10 +  If not m_lsSign 
.head 11 +  If not ..sDoc()
.head 12 -  Set sErrTxt = 'Не удалось подписать документ СЭП.'
.head 12 -  Break
.head 8 +  Else
.head 9 +  If m_nFli = 1 or GetGlobalOption('INTSIGN')='1'
.head 10 +  If not m_lsSign 
.head 11 +  If not ..sDoc()
.head 12 -  Set sErrTxt = 'Не удалось подписать документ.'
.head 12 -  Break
.head 8 -  ! Вставить в OPER
.head 8 +  If bNewDoc and not ..iDoc()
.head 9 -  Set sErrTxt = 'Неуспех при вставке документа '|| m_sNd
.head 9 -  Break
.head 8 -  ! Вставка внутренней подписи
.head 8 +  If bNewDoc and GetGlobalOption('INTSIGN')='2' and not ..PutVis(NUMBER_Null,0)  
.head 9 -  Set sErrTxt = 'Неуспех при вставке внутренней подписи документа '|| m_sNd
.head 9 -  Break
.head 8 -  ! Вставить в OPERW
.head 8 +  If not ..iDop()
.head 9 -  Set sErrTxt = 'Неуспех при вставке допреквизитов'
.head 9 -  Break
.head 8 -  ! Вставить в OPLDOK
.head 8 +  If not sNlsm
.head 9 -  Set sNlsm = A.Nls
.head 8 +  If not sNlsk
.head 9 -  Set sNlsk = B.Nls
.head 8 +  If (m_nFlg = 0 or m_nFlg = 1) and (m_nDk = 0 or m_nDk = 1)
.head 9 +  If m_nFlg = 0
.head 10 +  If not ChkBIG(m_nFlg,m_nRef,m_sTT,A.Kv,A.S,B.Kv,B.S)
.head 11 -  Set sErrTxt = 'Неуспешная проверка на БОЛЬШИЕ суммы транзакции '|| m_sTT
.head 11 -  Break
.head 9 -  ! Внимание, здесь может измениться флаг оплаты m_nFlg
.head 9 +  If not PayTT(0,m_nRef,m_dDatV1,m_sTT,m_nDk,A.Kv,A.Nls,A.S,B.Kv,B.Nls,B.S)
.head 10 -  Set sErrTxt = 'Неуспешная оплата транзакции '|| m_sTT
.head 10 -  Break
.head 8 +  If not ..pLnk(0)
.head 9 -  Set sErrTxt = 'Невозможно выполнить связанную операцию.'
.head 9 -  Break
.head 8 -  ! Вставить в ARC_RRP
.head 8 +  If m_nFli = 1
.head 9 +  If not SqlPrepareAndExecute(hSql(),"SELECT sos INTO :m_nSos FROM oper WHERE ref=:m_nRef")
.head 10 -  Set sErrTxt = 'Ошибка компиляции SQL выражения!'
.head 10 -  Break
.head 9 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Set sErrTxt = 'Нет документа Ref:'||SalNumberToStrX(m_nRef, 0)
.head 10 -  Break
.head 9 +  If m_nFlg=1 and m_nSos = 5
.head 10 +  If not iSep()
.head 11 -  Set sErrTxt = SalNumberToStrX(m_nErr, 0) ||'. Не удалось передать документ для отправки в СЭП.'
.head 11 -  Break
.head 8 -  Return TRUE
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return MessageErrorEx('Ошибка : ' || sErrTxt || '.')
.head 5 +  Function: pDoc
.head 6 -  Description: Печать бланка документа
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call DocsPrint(m_nRef,'OPER',0)
.head 5 +  Function: ChkBIG ! Проверить на большие суммы
.head 6 -  Description: Проверка на БОЛЬШИЕ СУММЫ и автовизирование МАЛЫХ сумм
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Receive Number: Pay       ! Флаг оплаты план/факт
.head 7 -  Number: Ref       ! Референция
.head 7 -  String: TT        ! Код транзакции
.head 7 -  Number: KvA       ! Код валюты А
.head 7 -  Number: SA        ! Сумма А
.head 7 -  Number: KvB       ! Код валюты Б
.head 7 -  Number: SB        ! Сумма Б
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 +  If not SqlPLSQLCommand(hSql(),"chk.PUT_BIG(Pay,Ref,TT,KvA,SA,KvB,SB)")
.head 10 -  Break
.head 8 +  Else
.head 9 -  Return TRUE
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Return TRUE
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return FALSE
.head 5 +  Function: DeInva ! Убрать недопустимые символы (<32)
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  String: sStr
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sTmp
.head 7 -  Number: i
.head 7 -  Number: nChar
.head 6 +  Actions
.head 7 -  Set i=0
.head 7 -  Set sTmp=sStr
.head 7 +  While SalStrFirstC(sTmp, nChar)
.head 8 +  If nChar<32
.head 9 -  Set sStr = SalStrReplaceX(sStr,i,1,' ')
.head 8 -  Set i=i+1
.head 7 -  Return SalStrTrimX(sStr)
.head 5 +  Function: ReadTM   ! Читать ТМ
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nTmp
.head 7 -  Number: i
.head 7 -  String: sTmp
.head 7 -  String: strTMSystem
.head 7 -  Number: nAdapter
.head 7 -  Number: nPort
.head 7 -  Number: nType
.head 7 -  String: strTMFile
.head 6 +  Actions
.head 7 -  ! Call Debug( 'Работаем с TM - Init, Read, Done' )
.head 7 -  Set strTMSystem = GetTMSystem()
.head 7 -  Set nAdapter = GetTMAdapter()
.head 7 -  Set nPort = GetTMPort()
.head 7 -  Set nType = GetTMType()
.head 7 -  ! Call Debug( 'TMInit('||SalNumberToStrX(nAdapter,0)||','
||SalNumberToStrX(nPort,0)||','||SalNumberToStrX(nType,0)||')')
.head 7 +  If strTMSystem='FILE'  ! TM - файловая система
.head 8 -  Set i = TMinit( GetTMAdapter(), GetTMPort() )
.head 8 +  If i
.head 9 -  Call SaveErrorToLog( 'TouchMemory: '
||'TMinit('||SalNumberToStrX(nAdapter,0)||','
||SalNumberToStrX(nPort,0)||') return '
||SalNumberToStrX(i,0) )
.head 7 +  Else If strTMSystem='RAW' ! TM - сырое устройство
.head 8 -  Set i = TMinitOwn(GetTMAdapter(),GetTMPort(),GetTMType())
.head 8 +  If i
.head 9 -  Call SaveErrorToLog( 'TouchMemory: '
||'TMinitOwn('||SalNumberToStrX(nAdapter,0)||','
||SalNumberToStrX(nPort,0)||','||SalNumberToStrX(nType,0)||') return '
||SalNumberToStrX(i,0) )
.head 7 +  Else
.head 8 -  Call SalMessageBox( 'Unknown TouchMemory System', 'Error', 
MB_IconStop|MB_Ok )
.head 8 -  Return FALSE
.head 7 +  If not i
.head 8 -  Call SalStrSetBufferLength( sTmp, 9 ) 
.head 8 +  If strTMSystem='RAW' ! TM - сырое устройство
.head 9 -  Set i=TMcheckOwn(sTmp,nTmp)
.head 9 +  If i
.head 10 -  ! Call Debug( 'TMcheck() return '||SalNumberToStrX(i,0) )
.head 10 -  Call SaveErrorToLog( 'TouchMemory: '
||'TMcheck() return '||SalNumberToStrX(i,0) )
.head 8 +  If not i
.head 9 -  Call SalStrSetBufferLength( m_lsSecretKey, 513 ) 
.head 9 -  Call SalStrSetBufferLength( m_lsSecretKeyCopy, 513 )
.head 9 +  If strTMSystem='FILE'  ! TM - файловая система
.head 10 -  Set strTMFile = SalStrMidX ( GetIdOper(), 0, 4 )
|| '.' || SalStrMidX ( GetIdOper(), 4, 2 )
.head 10 -  Set i=TMread( strTMFile, m_lsSecretKey, 360 )
.head 10 +  If i
.head 11 -  ! Call Debug( 'TMread() return '||SalNumberToStrX(i,0) )
.head 11 -  Call SaveErrorToLog( 'TouchMemory: '
||'TMread() return '||SalNumberToStrX(i,0) )
.head 10 -  ! делаем копию секр. ключа
.head 10 +  If not i
.head 11 -  Set i = TMread( strTMFile, m_lsSecretKeyCopy, 360 )
.head 9 +  Else If strTMSystem='RAW' ! TM - сырое устройство
.head 10 -  Set i=TMreadOwn(m_lsSecretKey,10,512-10)
.head 10 +  If i
.head 11 -  ! Call Debug( 'TMread() return '||SalNumberToStrX(i,0) )
.head 11 -  Call SaveErrorToLog( 'TouchMemory: '
||'TMread() return '||SalNumberToStrX(i,0) )
.head 10 -  ! делаем копию секр. ключа
.head 10 +  If not i
.head 11 -  Set i = TMreadOwn(m_lsSecretKeyCopy,10,512-10)
.head 7 +  If i=0
.head 8 -  Return 0
.head 7 +  If strTMSystem='FILE'  ! TM - файловая система
.head 8 -  Call TMdone()
.head 8 -  Return i+600
.head 7 +  Else If strTMSystem='RAW' ! TM - сырое устройство
.head 8 -  Call TMdoneOwn()
.head 8 -  Return i+500
.head 5 +  Function: WriteTM  ! Писать на ТМ
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nTmp
.head 7 -  Number: nRes
.head 7 -  String: sTmp
.head 7 -  String: strTMFile
.head 7 -  String: strTMSystem
.head 6 +  Actions
.head 7 -  Set strTMSystem=GetTMSystem()
.head 7 +  If strTMSystem='FILE'  ! TM - файловая система
.head 8 -  Set nRes = TMinit( GetTMAdapter(), GetTMPort() )
.head 7 +  Else If strTMSystem='RAW' ! TM - сырое устройство
.head 8 -  Set nRes = TMinitOwn(GetTMAdapter(),GetTMPort(),GetTMType())
.head 7 +  If not nRes
.head 8 +  If strTMSystem='FILE'  ! TM - файловая система
.head 9 -  Set strTMFile = SalStrMidX ( GetIdOper(), 0, 4 )
|| '.' || SalStrMidX ( GetIdOper(), 4, 2 )
.head 9 -  Set nRes = TMwrite( strTMFile, m_lsSecretKey, VEGA_SKFILE_SIZE )
.head 8 +  Else If strTMSystem='RAW' ! TM - сырое устройство
.head 9 -  Set nRes = TMwriteOwn( m_lsSecretKey,10, VEGA_SKFILE_SIZE )
.head 7 +  If nRes=0
.head 8 -  Return nRes
.head 7 +  If strTMSystem='FILE'  ! TM - файловая система
.head 8 -  Call TMdone()
.head 8 -  Return nRes+600
.head 7 +  Else If strTMSystem='RAW' ! TM - сырое устройство
.head 8 -  Call TMdoneOwn()
.head 8 -  Return nRes+500
.head 5 +  Function: GetDayStrByNum ! Возвращает строку 'день', 'дня', 'дней' 
.head 6 -  Description: Возвращает строку 'день', 'дня', 'дней' 
в зависимости от кол-ва дней - параметра nDays
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nDays
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nMod  ! последняя цифра числа
.head 6 +  Actions
.head 7 -  Set nMod = SalNumberMod(nDays,10)
.head 7 +  If nDays>=11 AND nDays<=14  ! Исключение
.head 8 -  Return 'дней'
.head 7 +  Else If nMod=1
.head 8 -  Return 'день'
.head 7 +  Else If nMod>=2 AND nMod<=4
.head 8 -  Return 'дня'
.head 7 +  Else
.head 8 -  Return 'дней'
.head 5 +  Function: P_Fac  ! Оплатить по факт остатку в контролере (Старая версия Compatible)
.head 6 -  Description: Оплата документа по факт остатку
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: nRef
.head 7 -  String: sVdat
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nFli
.head 7 -  Number: nFlg
.head 7 -  Number: nFetchRes
.head 7 -  String: sErrTxt
.head 7 -  Number: nRefL
.head 6 +  Actions
.head 7 +  While TRUE
.head 8 -  ! Читать описание транзакции
.head 8 +  If not SqlPrepareAndExecute(hSql(), T("
   SELECT t.fli,o.refl,flags[38,38]
     INTO :nFli,:nRefL,:nFlg
     FROM tts t, oper o
    WHERE t.tt=o.tt and o.ref=:nRef and o.sos<5 FOR UPDATE OF o.sos NOWAIT"))
.head 9 -  Set sErrTxt = 'Ошибка компиляции SQL выражения'
.head 9 -  Break
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set sErrTxt = 'Нет документа Ref:'||SalNumberToStrX(nRef, 0)
.head 9 -  Break
.head 8 +  If not Pay(2,nRef,MMddyyyyToDate(sVdat),'',NUMBER_Null,NUMBER_Null,'',NUMBER_Null,NUMBER_Null,'')
.head 9 -  Set sErrTxt = 'Неуспех при фактической оплате'
.head 9 -  Break
.head 8 +  If nFli = 1 and (nFlg=0 or nFlg=1 or nFlg=3) 
.head 9 +  If not SetDocR(nRef, TRUE)
.head 10 -  Set sErrTxt = 'Нет документа Ref: '||SalNumberToStrX(nRef, 0)
.head 10 -  Break
.head 9 +  If m_nSos = 5 ! Наступила дата валютирования
.head 10 +  If not iSep()
.head 11 -  Set sErrTxt = SalNumberToStrX(m_nErr, 0)||'. Не удалось передать документ для отправки в СЭП'
.head 11 -  Break
.head 8 +  If nRefL
.head 9 -  Set nRef = nRefL
.head 8 +  Else
.head 9 -  Return TRUE
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return MessageErrorEx(sErrTxt)
.head 5 +  Function: PayTT  ! Оплатить транзакцию с подстановкой требуемых счетов
.head 6 -  Description: Вставка мультивалютных проводок в OPLDOK
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: Pay       ! Флаг оплаты план/факт
.head 7 -  Number: Ref       ! Референция
.head 7 -  Date/Time: DatV   ! Дата валютирования
.head 7 -  String: TT        ! Код транзакции
.head 7 -  Number: Dk        ! Признак дебет/кредит
.head 7 -  Number: KvA       ! Код валюты А
.head 7 -  String: NlsA      ! Номер счета А
.head 7 -  Number: SA        ! Сумма А
.head 7 -  Number: KvB       ! Код валюты Б
.head 7 -  String: NlsB      ! Номер счета Б
.head 7 -  Number: SB        ! Сумма Б
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sDatV
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 +  If not SqlPLSQLCommand(hSql(), "PAYTT(Pay, Ref, DatV, TT, Dk, KvA, NlsA, SA, KvB, NlsB, SB )")
.head 10 -  Break
.head 8 +  Else
.head 9 -  Break
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Return TRUE
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return FALSE
.head 5 +  Function: PayV   ! Оплатить транзакцию без подстановки
.head 6 -  Description: Вставка мультивалютных проводок в OPLDOK
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: Pay       ! Флаг оплаты план/факт
.head 7 -  Number: Ref       ! Референция
.head 7 -  Date/Time: DatV   ! Дата валютирования
.head 7 -  String: TT        ! Код транзакции
.head 7 -  Number: Dk        ! Признак дебет/кредит
.head 7 -  Number: KvA       ! Код валюты А
.head 7 -  String: NlsA      ! Номер счета А
.head 7 -  Number: SA        ! Сумма А
.head 7 -  Number: KvB       ! Код валюты Б
.head 7 -  String: NlsB      ! Номер счета Б
.head 7 -  Number: SB        ! Сумма Б
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sDatV
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 +  If not SqlPLSQLCommand(hSql(), "gl.PAYV(Pay, Ref, DatV, TT, Dk, KvA, NlsA, SA, KvB, NlsB, SB )")
.head 10 -  Break
.head 8 +  Else
.head 9 -  Break
.head 8 -  Call SalWaitCursor(FALSE)
.head 8 -  Return TRUE
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return FALSE
.head 5 +  Function: Pay			
.head 6 -  Description: Вставка проводки в OPLDOK
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nFl
.head 7 -  Number: nRef
.head 7 -  Date/Time: dVdat
.head 7 -  String: sTT
.head 7 -  Number: nKv
.head 7 -  Number: nDk
.head 7 -  String: sNls
.head 7 -  Number: nS
.head 7 -  Number: nSq
.head 7 -  String: sTxt
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 9 +  If not SqlPLSQLCommand(hSql(),"gl.pay(nFl,nRef,dVdat,sTT,nKv,nDk,sNls,nS,nSq,sTxt)")
.head 10 -  Break
.head 8 +  Else
.head 9 -  Return FALSE
.head 8 -  Return TRUE
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return FALSE
.head 5 +  Function: Pay2			
.head 6 -  Description: Вставка проводки в OPLDOK
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nFl
.head 7 -  Number: nRef
.head 7 -  Date/Time: dVdat
.head 7 -  String: sTT
.head 7 -  Number: nKv
.head 7 -  Number: nDk
.head 7 -  String: sNls
.head 7 -  Number: nS
.head 7 -  Number: nSq
.head 7 -  Number: nStmt
.head 7 -  String: sTxt
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 9 +  If not SqlPLSQLCommand(hSql(),"gl.pay2(nFl,nRef,dVdat,sTT,nKv,nDk,sNls,nS,nSq,nStmt,sTxt)")
.head 10 -  Break
.head 8 +  Else
.head 9 -  Return FALSE
.head 8 -  Return TRUE
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return FALSE
.head 5 +  Function: InsertCert2DB
.head 6 -  Description: Вставка сертификата открытого ключа в БД
если его там нету
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: szTestMsg
.head 7 -  Number: nTestMsgLen
.head 7 -  Long String: lsCertID
.head 7 -  String: szHexCertID
.head 7 -  Number: i
.head 7 -  Number: nChar
.head 7 -  Number: nLowPart
.head 7 -  Number: nHighPart
.head 7 -  Number: nKeyCount
.head 7 -  Number: nFetchRes
.head 7 -  Number: nErrorSign
.head 7 -  String: strErrorSign
.head 7 -  String: szTempBuf
.head 7 -  String: szOperID
.head 7 -  Number: min_status
.head 7 -  Number: maj_status
.head 7 -  Number: nSignLen
.head 7 -  Number: nCertLen
.head 7 -  Number: nSignHandle
.head 7 -  Number: nCertHandle
.head 7 -  Long String: loc_lsSign
.head 7 -  Long String: loc_lsCertificate
.head 6 +  Actions
.head 7 +  If GetSignType() = 'UNI'  ! только для внутр. подписи НБУ
.head 8 -  ! Сначала подпишем тестовую строку, 
чтобы получить сертификат откр. ключа
.head 8 -  Call SalStrSetBufferLength( loc_lsSign, UNI_SIGN_SIZE+1 )
.head 8 -  Call SalStrSetBufferLength( loc_lsCertificate, UNI_CERT_SIZE+1 )
.head 8 -  Set szTestMsg = 'Тестовое сообщение для ЭЦП'
.head 8 -  Set nTestMsgLen = SalStrLength( szTestMsg )
.head 8 -  Set nErrorSign = NG_CREATE_SIGN_CRED( min_status,
			m_nCredHandle,
			nTestMsgLen, szTestMsg,
			nSignLen, nSignHandle,
			nCertLen, nCertHandle)
.head 8 +  If nErrorSign
.head 9 -  Call MessageErrorEx( UNIFormatGSSMessage(min_status, nErrorSign) )
.head 9 -  Return 0
.head 8 -  Call ConvertHexToBin( NumPtr2HexStr(nSignHandle, nSignLen), 
	loc_lsSign, nSignLen )
.head 8 -  Call ConvertHexToBin( NumPtr2HexStr(nCertHandle, nCertLen), 
	loc_lsCertificate, nCertLen )
.head 8 -  ! Вычленяем 9 байт ID сертификата
.head 8 -  Set szHexCertID = SalStrRepeatX( SalNumberToChar( 0 ), 9 )
.head 8 -  Set i = 0
.head 8 +  Loop
.head 9 +  If i=7
.head 10 -  Break
.head 9 -  Call SalStrLop( loc_lsSign )
.head 9 -  Set i = i+1
.head 8 -  Set i = 0
.head 8 +  Loop
.head 9 +  If i=9
.head 10 -  Break
.head 9 -  Set nChar = SalStrLop( loc_lsSign )
.head 9 -  Set nLowPart  = nChar & 0x0F
.head 9 -  Set nHighPart = ( nChar & 0xF0 ) / 16
.head 9 -  Set szHexCertID = szHexCertID || GetHexChar(nHighPart)||GetHexChar(nLowPart)
.head 9 -  Set i = i+1
.head 8 -  ! Call Debug('HexCrtID='||szHexCertID)
.head 8 -  ! Ищем такой HexCertID в базе
.head 8 +  If SqlPrepareAndExecute(hSql(),"SELECT count(key_id)  
INTO :nKeyCount FROM keys WHERE key_id=:szHexCertID ")
.head 9 +  If SqlFetchNext(hSql(), nFetchRes)
.head 10 +  If nKeyCount=0 ! не нашли такого ключа
.head 11 -  ! надо вставить
.head 11 -  Set szOperID = GetIdOper()
.head 11 +  If not SqlPrepare(hSql(),
"INSERT INTO keys(key_id,user_id,put_date,key)
VALUES(:szHexCertID,:szOperID,SYSDATE,:loc_lsCertificate)")
.head 12 -  Return 0
.head 11 +  If not SqlSetLongBindDatatype(3, BLOB_BYTE)
.head 12 -  Call SqlRollback( hSql() )
.head 12 -  Return 0 
.head 11 +  If not SqlExecute(hSql())
.head 12 -  Call SqlRollback( hSql() )
.head 12 -  Return 0 
.head 11 -  Call SalMessageBox( 'Сертификат '||szHexCertID||' открытого ключа '||szOperID
||' помещен в БД', 
'Сообщение', MB_Ok | MB_IconAsterisk)
.head 5 +  Function: GetHexChar
.head 6 -  Description: возвращает символ hex по заданному числу
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nVal
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: szHexVal
.head 6 +  Actions
.head 7 -  Set szHexVal = ''
.head 7 +  If nVal>=0 AND nVal<=9
.head 8 -  Set szHexVal = SalNumberToStrX( nVal, 0 )
.head 7 +  Else
.head 8 +  Select Case nVal
.head 9 +  Case 10
.head 10 -  Set szHexVal = 'A'
.head 10 -  Break
.head 9 +  Case 11
.head 10 -  Set szHexVal = 'B'
.head 10 -  Break
.head 9 +  Case 12
.head 10 -  Set szHexVal = 'C'
.head 10 -  Break
.head 9 +  Case 13
.head 10 -  Set szHexVal = 'D'
.head 10 -  Break
.head 9 +  Case 14
.head 10 -  Set szHexVal = 'E'
.head 10 -  Break
.head 9 +  Case 15
.head 10 -  Set szHexVal = 'F'
.head 10 -  Break
.head 7 -  Return szHexVal
.head 5 +  Function: GetSepSignMsg
.head 6 -  Description: возвращает описание ошибки 
инициализации/наложения/снятия ЭЦП СЭП НБУ
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nCode
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strMsg
.head 6 +  Actions
.head 7 +  Select Case (Abs(nCode))
.head 8 +  Case 0
.head 9 -  Set strMsg = 'Ok'
.head 9 -  Break
.head 8 +  Case 1
.head 9 -  Set strMsg = 'Подпись неверна'
.head 9 -  Break
.head 8 +  Case 2
.head 9 -  Set strMsg = 'Недостаточно памяти'
.head 9 -  Break
.head 8 +  Case 3
.head 9 -  Set strMsg = 'Неверно указан дисковод с дискетой с секретным ключом'
.head 9 -  Break
.head 8 +  Case 4
.head 9 -  Set strMsg = 'Ошибка работы с файлом секретного ключа'
.head 9 -  Break
.head 8 +  Case 5
.head 9 -  Set strMsg = 'Неверно указан путь к таблицам открытых ключей'
.head 9 -  Break
.head 8 +  Case 6
.head 9 -  Set strMsg = 'Ошибка работы с индексным файлом pub_odb.ind'
.head 9 -  Break
.head 8 +  Case 7
.head 9 -  Set strMsg = 'Индексный файл pub_odb.ind испорчен'
.head 9 -  Break
.head 8 +  Case 8
.head 9 -  Set strMsg = 'Ошибка работы с файлом открытых ключей pub_odb.key'
.head 9 -  Break
.head 8 +  Case 9
.head 9 -  Set strMsg = 'Файл открытых ключей pub_odb.key испорчен'
.head 9 -  Break
.head 8 +  Case 10
.head 9 -  Set strMsg = 'Не найден идентификатор открытого ключа'
.head 9 -  Break
.head 8 +  Case 11
.head 9 -  Set strMsg = 'Испорчена строка в таблице открытых ключей'
.head 9 -  Break
.head 8 +  Case 12
.head 9 -  Set strMsg = 'Срок действия ключа истек'
.head 9 -  Break
.head 8 +  Case 13
.head 9 -  Set strMsg = 'Секретный ключ испорчен'
.head 9 -  Break
.head 8 +  Case 14
.head 9 -  Set strMsg = 'Файл секретного ключа переименован'
.head 9 -  Break
.head 8 +  Case 15
.head 9 -  Set strMsg = 'Несовпадение номера сеанса генерации ключа'
.head 9 -  Break
.head 8 +  Case 16
.head 9 -  Set strMsg = 'Несоответствие открытого и секретного ключа'
.head 9 -  Break
.head 8 +  Case 17
.head 9 -  Set strMsg = 'Ошибка чтения входного файла'
.head 9 -  Break
.head 8 +  Case 18
.head 9 -  Set strMsg = 'Подпись сделана старым ключом'
.head 9 -  Break
.head 8 +  Case 20
.head 9 -  Set strMsg = 'Прерывание пользователя (при работе с Touch Memory)'
.head 9 -  Break
.head 8 +  Case 21
.head 9 -  Set strMsg = 'Ошибка чтения при работе с Touch Memory'
.head 9 -  Break
.head 8 +  Case 22
.head 9 -  Set strMsg = 'Неверный пароль для секретного ключа'
.head 9 -  Break
.head 8 +  Case 47
.head 9 -  Set strMsg = 'Несоответствие файла pub_odb.key и pub_odb.ind'
.head 9 -  Break
.head 8 +  Case 70
.head 9 -  Set strMsg = 'Последний день действия ключа'
.head 9 -  Break
.head 8 +  Case 71
.head 9 -  Set strMsg = 'До истечения срока действия ключа остался 1 день'
.head 9 -  Break
.head 8 +  Case 72
.head 9 -  Set strMsg = 'До истечения срока действия ключа осталось 2 дня'
.head 9 -  Break
.head 8 +  Case 73
.head 9 -  Set strMsg = 'До истечения срока действия ключа осталось 3 дня'
.head 9 -  Break
.head 8 +  Case 74
.head 9 -  Set strMsg = 'До истечения срока действия ключа осталось 4 дня'
.head 9 -  Break
.head 8 +  Case 75
.head 9 -  Set strMsg = 'До истечения срока действия ключа осталось 5 дней'
.head 9 -  Break
.head 8 +  Case 76
.head 9 -  Set strMsg = 'До истечения срока действия ключа осталось 6 дней'
.head 9 -  Break
.head 8 +  Case 91
.head 9 -  Set strMsg = 'Неверные параметры вызова функции'
.head 9 -  Break
.head 8 +  Case 92
.head 9 -  Set strMsg = 'Неверно указан тип параметров вызова функции'
.head 9 -  Break
.head 8 +  Default
.head 9 -  Set strMsg = ''
.head 9 -  Break
.head 7 -  Return strMsg
.head 5 +  Function: UNIFormatMessage
.head 6 -  Description: возвращает описание ошибки ЭЦП UNI
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nErrorCode
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strMessage
.head 7 -  Number: nMsgSize
.head 7 -  Number: nBufAddress
.head 7 -  Number: message_context
.head 7 -  Number: min_status
.head 7 -  Number: maj_status
.head 6 +  Actions
.head 7 -  Call SalStrSetBufferLength( strMessage, 4096 )
.head 7 -  Set message_context = 0
.head 7 -  Set maj_status = gss_display_status(
	min_status,
	nErrorCode,
	2, 0,
	message_context,
	nMsgSize, nBufAddress
)
.head 7 -  Call memmove( strMessage, NumPtr2Str( nBufAddress ), nMsgSize )
.head 7 -  Set strMessage = Left(strMessage,nMsgSize) || Chr(0)
.head 7 -  Call gss_release_buffer( min_status, nMsgSize, nBufAddress )
.head 7 -  Return 'UNI: KeyID='||GetIdOper()||PutCrLf()||
  ' Error='||SalNumberToStrX( nErrorCode, 0 )
  ||PutCrLf()||strMessage
.head 5 +  Function: UNIFormatGSSMessage
.head 6 -  Description: возвращает описание ошибки ЭЦП UNI функций GSS
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: minor_status
.head 7 -  Number: status_value
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strMessage
.head 7 -  String: strBuf
.head 7 -  String: strBuf2
.head 7 -  Number: nMsgSize
.head 7 -  Number: nBufAddress
.head 7 -  Number: nMsgSize2
.head 7 -  Number: nBufAddress2
.head 7 -  Number: message_context
.head 7 -  Number: maj_status
.head 7 -  Number: min_status
.head 6 +  Actions
.head 7 -  Set strMessage = ''
.head 7 -  ! --1
.head 7 -  Call SalStrSetBufferLength( strBuf, 4096 )
.head 7 -  Set message_context = 0
.head 7 -  Set nMsgSize = 0
.head 7 -  Set nBufAddress = 0
.head 7 -  Set maj_status = gss_display_status(
	min_status,
	status_value,
	1, 0,
	message_context,
	nMsgSize, nBufAddress
)
.head 7 -  Call memmove( strBuf, NumPtr2Str( nBufAddress ), nMsgSize )
.head 7 -  Set strBuf = Left(strBuf,nMsgSize) || Chr(0)
.head 7 -  Call gss_release_buffer( min_status, nMsgSize, nBufAddress )
.head 7 -  Set strMessage = strMessage || strBuf
.head 7 -  ! --2
.head 7 -  Call SalStrSetBufferLength( strBuf2, 4096 )
.head 7 -  Set message_context = 0
.head 7 -  Set nMsgSize2 = 0
.head 7 -  Set nBufAddress2 = 0
.head 7 -  Set maj_status = gss_display_status(
	min_status,
	minor_status,
	2, 0,
	message_context,
	nMsgSize2, nBufAddress2
)
.head 7 -  Call memmove( strBuf2, NumPtr2Str( nBufAddress2 ), nMsgSize2 )
.head 7 -  Set strBuf2 = Left(strBuf2,nMsgSize2) || Chr(0)
.head 7 -  Call gss_release_buffer( min_status, nMsgSize2, nBufAddress2 )
.head 7 -  Set strMessage = strMessage || strBuf2
.head 7 -  Return 'UNI: KeyID='||GetIdOper()
  ||PutCrLf()||'minor_status='
    ||SalNumberToStrX( minor_status, 0 )||' ('||NumberToHexSX(minor_status)||')'
  ||PutCrLf()||'status_value='
    ||SalNumberToStrX( status_value, 0 )||' ('||NumberToHexSX(status_value)||')'
  ||PutCrLf()||strMessage
.head 5 +  Function: CredFormatMessage
.head 6 -  Description: Возвращает описание ошибок для функций библиотеки CreateCred.dll
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nErrorCode
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: strMessage
.head 6 +  Actions
.head 7 -  Call SalStrSetBufferLength( strMessage, 4096 )
.head 7 +  ! Select Case ( nErrorCode )
.head 8 +  Case 0
.head 9 -  Set strMessage = 'Ok'
.head 9 -  Break 
.head 8 +  Case 1
.head 9 -  Set strMessage = 'Неопределенная ошибка'
.head 9 -  Break 
.head 8 +  Case 3
.head 9 -  Set strMessage = 'Время ожидания закончилось'
.head 9 -  Break 
.head 8 +  Case 4
.head 9 -  Set strMessage = 'Программа NbuSecurity не запущена'
.head 9 -  Break 
.head 8 +  Case 5
.head 9 -  Set strMessage = 'Недопустимые аргументы'
.head 9 -  Break 
.head 8 +  Default 
.head 9 -  Set strMessage = 'Неизвестный код ошибки ' || Str(nErrorCode)
.head 7 -  Set strMessage = SalNumberToStrX( nErrorCode, 0 ) 
|| ' - Помилка системи захисту НБУ'
.head 7 -  Return strMessage
.head 5 +  Function: iSignData
.head 6 -  Description: Возвращает подписываемую строку для внутренней ЭЦП
.head 6 +  Returns
.head 7 -  String:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return PadR(m_sNd,10)||SalFmtFormatDateTime(m_dDatD,'yyMMdd')||
    PadL(SalNumberToStrX(m_nDk, 0), 1) || 
    PadL(A.Bank, 9)||PadL(A.Nls, 14)||PadL(SalNumberToStrX(A.Kv, 0),3)||PadL(SalNumberToStrX(A.S, 0),16)||
    PadL(B.Bank, 9)||PadL(B.Nls, 14)||PadL(SalNumberToStrX(B.Kv, 0),3)||PadL(SalNumberToStrX(B.S, 0),16)
.head 5 +  Function: PutVis
.head 6 -  Description: Вставка внутренней подписи (новой)
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: nGrp
.head 7 -  Number: nStat
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: lsTemp1
.head 7 -  String: lsTemp2
.head 6 +  Actions
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS()))='ORACLE'
.head 9 +  If m_lsSignI
.head 10 -  Call SalStrSetBufferLength( lsTemp1, m_nSignLen * 2 + 1)
.head 10 -  Call ConvertBinToHex( m_lsSignI, lsTemp1, m_nSignLen )  ! BIN->HEX
.head 9 +  Else
.head 10 -  Set lsTemp1=STRING_Null
.head 9 +  If m_lsSign
.head 10 -  Call SalStrSetBufferLength( lsTemp2, m_nSignLen * 2 + 1)
.head 10 -  Call ConvertBinToHex( m_lsSign , lsTemp2, m_nSignLen )  ! BIN->HEX
.head 9 +  Else
.head 10 -  Set lsTemp2=STRING_Null
.head 9 +  If not SqlPLSQLCommand(hSql(), 'chk.put_visa(m_nRef,m_sTT,nGrp,nStat,m_sOperId,lsTemp1,lsTemp2)')
.head 10 -  Break
.head 8 +  Else
.head 9 -  Return FALSE
.head 8 -  Return TRUE
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return FALSE
.head 3 +  Functional Class: cStorona  ! __exported
.head 4 -  Description: Сторона платежного документа
.head 4 -  Derived From
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  String: Nls  ! номер счета
.head 5 -  String: Nam  ! намиенвание счета
.head 5 -  String: Bank ! код банка
.head 5 -  String: Nb   ! наименование банка
.head 5 -  Number: Kv   ! код валюты
.head 5 -  Number: S    ! сумма
.head 5 -  String: Okpo ! код клиента
.head 4 +  Functions
.head 5 +  Function: SetStorona
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  String: sNls ! номер счета
.head 7 -  String: sNam ! намиенвание счета
.head 7 -  String: sBank        ! код банка
.head 7 -  String: sNb  ! наименование банка
.head 7 -  Number: nKv  ! код валюты
.head 7 -  Number: nS   ! сумма
.head 7 -  String: sOkpo        ! код клиента
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set Nls = sNls
.head 7 -  Set Nam = sNam
.head 7 -  Set Bank = sBank
.head 7 -  Set Nb = sNb
.head 7 -  Set Kv = nKv
.head 7 -  Set S = nS
.head 7 -  Set Okpo = SalStrTrimX(sOkpo)
.head 5 +  Function: GetStorona
.head 6 -  Description:
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Receive String: sNls ! номер счета
.head 7 -  Receive String: sNam ! намиенвание счета
.head 7 -  Receive String: sBank        ! код банка
.head 7 -  Receive String: sNb  ! наименование банка
.head 7 -  Receive Number: nKv  ! код валюты
.head 7 -  Receive Number: nS   ! сумма
.head 7 -  Receive String: sOkpo        ! код клиента
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Set sNls = Nls
.head 7 -  Set sNam = Nam
.head 7 -  Set sBank = Bank
.head 7 -  Set sNb = Nb
.head 7 -  Set nKv = Kv
.head 7 -  Set nS = S
.head 7 -  Set sOkpo = Okpo
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: cpbRelation
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
.head 3 -  Column:
.head 3 -  Background Text:
.head 3 -  Group Box:
.head 3 -  Line:
.head 3 -  Frame:
.head 3 -  Custom Control:
.head 2 -  Application Actions
.head 1 +  Dialog Box: dlgAskPinCode
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Ввод PIN-кода пользователя
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? No
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   1.588"
.head 4 -  Top:    1.646"
.head 4 -  Width:  4.467"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.643"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: MS Sans Serif
.head 3 -  Font Size: 8
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Ввод PIN-кода пользователя
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
.head 3 -  Frame
.head 4 -  Resource Id: 63429
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.06"
.head 5 -  Width:  4.15"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.143"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: 3D Face Color
.head 3 -  Background Text: PIN-Код:
.head 4 -  Resource Id: 63430
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.617"
.head 5 -  Top:    0.524"
.head 5 -  Width:  1.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfPinCode
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 16
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.867"
.head 6 -  Top:    0.488"
.head 6 -  Width:  1.586"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Invisible
.head 5 -  Country: Default
.head 5 -  Font Name: Arial
.head 5 -  Font Size: 12
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_AnyEdit
.head 6 -  Set strPinCode = dfPinCode
.head 3 +  Data Field: dfFiller
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
.head 6 -  Left:   1.867"
.head 6 -  Top:    0.488"
.head 6 -  Width:  1.583"
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
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalEndDialog(hWndForm, TRUE)
.head 3 +  Pushbutton: bEsc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Default
.head 5 -  Top:    Default
.head 5 -  Width:  Default
.head 5 -  Width Editable? Yes
.head 5 -  Height: Default
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Esc
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
.head 6 -  Call SalEndDialog(hWndForm, FALSE)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Receive String: strPinCode
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Set strPinCode = ''
.head 4 -  Call SalSetFocus(dfPinCode)
.head 4 -  Call SalMapEnterToTab(TRUE)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalMapEnterToTab(FALSE)
.head 3 +  On SAM_Close
.head 4 -  Call SalEndDialog(hWndForm, FALSE)
