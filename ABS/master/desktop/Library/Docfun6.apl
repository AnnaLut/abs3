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
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650200010000
0020: 0000000000000000 002C000000020000 0003000000000000 0043020000F8FFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0001000000010000
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
.head 2 -  File Include: dsconst.apl
.head 2 -  File Include: dsdll.apl
.head 2 -  Dynalib: dsig.apd
.head 2 -  Dynalib: global.apd
.head 2 -  Dynalib: PRINTAPI.apd
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
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 3 +  User
.head 4 -  ! ! << Версія бібліотеки >>
.head 4 -  String: sLibraryVersion =  'від 05.04.2016'
.head 2 -  Resources
.head 2 +  Variables
.head 2 +  Internal Functions
.head 2 -  Named Menus
.head 2 +  Class Definitions
.head 3 +  Functional Class: cDoc
.head 4 -  Description: Содержит атрибуты платежного документа и функции работы с ними
.head 4 -  Derived From
.head 4 -  Class Variables
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
.head 5 -  String: m_sSub          ! номер субрахунку
.head 5 -  String: m_sNazns     ! способ заполнения "назначения платежа"
.head 5 -  String: m_sNaznk     ! код "назначения платежа"
.head 5 -  Number: m_nBis       ! номер БИС
.head 5 -  String: m_sOperId    ! идентификатор операциониста
.head 5 -  Long String: m_lsSign        ! подпись на документе
.head 5 -  Long String: m_lsSignI       ! внутренняя подпись на документе
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
.head 5 -  Number: m_nFbi       ! флаг формирования БИС
.head 5 -  Number: m_nPyD       ! флаг разрешения факт оплаты (всегда 1)
.head 5 -  Number: m_nSiG       ! Подписать при записи в arc_rrp (в норме 0)
.head 5 -  !
.head 5 -  Long String: m_lsSignIntHex  ! буфер внутр ЭЦП в hex
.head 5 -  Long String: m_lsSignExtHex  ! буфер внешн ЭЦП в hex
.head 5 -  Number: m_nSignErrType  ! Тип ошибки при проверке подписи (1 - док., 2 - виза)
.head 5 -  Boolean: m_isSignExist ! А была ли ЭЦП при проверке ? 
.head 4 +  Functions
.head 5 +  Function: Test ! Просто тест
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nFetchRes
.head 7 -  String: p_val
.head 7 -  String: strSql
.head 7 -  Sql Handle: sqlHndl
.head 6 +  Actions
.head 7 -  Call Debug( 'Вызван метод cDoc.Test() version 4' )
.head 7 +  While TRUE
.head 8 -  Call Debug( '0' )
.head 8 +  If not SqlPrepare( hSql(), "select val from params where par='BANKDATE' into :p_val " )
.head 9 -  Break
.head 8 -  Call Debug( '1' )
.head 8 +  If not SqlExecute( hSql() )
.head 9 -  Break
.head 8 -  Call Debug( '2' )
.head 8 +  If not SqlFetchNext( hSql(), nFetchRes )
.head 9 -  Break
.head 8 -  Call Debug( '3' )
.head 8 -  Call Debug( 'p_val='||p_val )
.head 8 -  Break
.head 5 +  Function: MakeSepBuf
.head 6 -  Description: формирует буфер СЭП для наложения ЭЦП по входящим полям
.head 6 +  Returns
.head 7 -  String:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_MakeSepBuf( A.Bank,A.Nls,B.Bank,B.Nls,m_nDk,A.S,
m_nVob,m_sNd,A.Kv,m_dDatD,m_dDatP,A.Nam,B.Nam,m_sNazn,m_sDrec,
m_sNaznk,m_sNazns,A.Okpo,B.Okpo,m_sRef_A,m_sOperId,m_nBis )
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
.head 5 +  Function: GetSignSize ! Возвращает размер буфера ЭЦП указанного типа                        
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Number:
.head 6 +  Parameters
.head 7 -  String: strSignType
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_GetSignSize( strSignType )
.head 5 +  Function: DefaultSignSize ! Возвращает размер буфера ЭЦП используемого в системе типа
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Number:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_DefaultSignSize(  )
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
.head 7 +  If not sTranN(m_sNazn, sNazn, sTT, A.Nls, A.Bank, A.Kv, A.S, B.Nls, B.Bank, B.Kv, B.S, nSk, nSQ, 0)
.head 8 -  Call MessageErrorEx('Ошибка формирования назначения платежа '|| m_sNazn)
.head 7 -  Set m_sNazn = SalStrLeftX( DeInva(m_sNazn), 160 )
.head 7 -  Set m_nSk = nSk
.head 7 -  Set m_nPrty = nPrty
.head 7 +  If A.Okpo = '0000000000' and SalStrScan(sDrec,'#Ф')=-1
.head 8 -  Set m_sDrec = DeInva(sGetPassP(sDrec, A.Nls, A.Kv))
.head 7 +  Else
.head 8 -  Set m_sDrec = DeInva(sDrec)
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
.head 7 -  Set m_lsSignIntHex = STRING_Null
.head 7 -  Set m_lsSignExtHex = STRING_Null
.head 7 -  Set m_nRec = NUMBER_Null
.head 7 -  Set m_nRefH = NUMBER_Null
.head 7 -  Set m_nRefL = NUMBER_Null
.head 7 -  Set m_nRefF = NUMBER_Null
.head 7 -  Set m_nOtm = 0
.head 7 -  Set m_nSq = nSQ
.head 7 -  !
.head 7 -  Set nWaitSign = GetWaitSign()
.head 7 -  Set g_nTim = IifN(nWaitSign<=0, 5, nWaitSign) ! 5
.head 7 -  Set m_nPyD = 1
.head 7 -  Set m_nSiG = 0
.head 7 -  Set m_nFbi = 0
.head 7 -  Set m_nSos = 0
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
.head 7 -  Set g_nTim = IifN(nWaitSign<=0, 5, nWaitSign) ! 5
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
.head 8 +  If not SqlSetLongBindDatatype(26, BLOB_BYTE)
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
.head 9 -  Set m_lsSignIntHex = STRING_Null
.head 9 -  Set m_lsSignExtHex = STRING_Null
.head 9 -  Set m_nRefF = NUMBER_Null
.head 9 +  If SqlPrepareAndExecute(hSql(),"SELECT value  INTO :sTmp FROM operw WHERE ref=:nRef AND tag='REF_F' ")
.head 10 +  If SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Set m_nRefF=SalStrToNumber( SalStrTrimX( sTmp) )
.head 9 +  If not SalStrTrimX(m_sRef_A)
.head 10 -  Set m_sRef_A=SalNumberToStrX( SalNumberMod(m_nRef,1000000000), 0 )
.head 9 -  Return TRUE
.head 8 -  Break
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
.head 7 -  Set dDatV = m_dDatV1
.head 7 -  ! При наличии 2-х дат вал : 
.head 7 +  If m_dDatV2 != DATETIME_Null
.head 8 -  ! 1) - Было раньше - в OPER пишем МЕНЬШУЮ из 2-х
.head 8 -  ! 2) - Hадо  - в OPER пишем БОЛЬШУЮ из 2-х
.head 8 +  If m_dDatV2 > m_dDatV1
.head 9 -  Set dDatV = m_dDatV2
.head 8 -  !
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 -  Set lsNull = ''
.head 9 -  Set nUid = NUMBER_Null
.head 9 -  Set dPdat = SalDateConstruct(
    SalDateYear(m_dDatP), SalDateMonth(m_dDatP), SalDateDay(m_dDatP),
    SalDateHour(SalDateCurrent()), SalDateMinute(SalDateCurrent()), 0)
.head 9 +  If GetGlobalOption('SUB')='1'
.head 10 -  Set sData='gl.in_Doc4(m_nRef, m_sTT, m_nVob, m_sNd, dPdat, dDatV,
    m_nDk, A.Kv, A.S, B.Kv, B.S, m_nSq, m_nSk, m_sSub, m_dDatD, m_dDatP,
    A.Nam,A.Nls,A.Bank,B.Nam,B.Nls,B.Bank,m_sNazn,
    m_sDrec,A.Okpo,B.Okpo,m_sOperId,lsNull,m_nSos,m_nPrty,nUid)'
.head 9 +  Else
.head 10 -  Set sData='gl.in_Doc2(m_nRef, m_sTT, m_nVob, m_sNd, dPdat, dDatV,
    m_nDk, A.Kv, A.S, B.Kv, B.S, m_nSq, m_nSk, m_dDatD, m_dDatP,
    A.Nam,A.Nls,A.Bank,B.Nam,B.Nls,B.Bank,m_sNazn,
    m_sDrec,A.Okpo,B.Okpo,m_sOperId,lsNull,m_nSos,m_nPrty,nUid)'
.head 9 +  ! Else
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
.head 7 -  Date/Time: dNull
.head 7 -  Long String: lsNull
.head 7 -  Number: nFetchRes
.head 7 -  String: sRef
.head 7 -  String: sNd
.head 7 -  String: sNama
.head 7 -  String: sNamb
.head 7 -  String: sNazn
.head 7 -  String: sDrec
.head 7 -  String: sDatA
.head 7 -  String: sData
.head 7 -  String: sDatp
.head 7 -  Number: nVob
.head 7 -  Number: nDk
.head 7 -  Number: i
.head 7 -  Number: j
.head 7 -  String: aNazn[*]
.head 7 -  String: aToken[*]
.head 7 -  Number: nToken
.head 7 -  String: sTag
.head 7 -  String: sVal
.head 7 -  String: sChr
.head 7 -  String: sSepVobList
.head 6 +  Actions
.head 7 -  Set nNull = NUMBER_Null
.head 7 -  Set dNull = DATETIME_Null
.head 7 -  Set sNull = ''
.head 7 -  Set lsNull = ''
.head 7 -  Set sSepVobList=SalStrTrimX(GetGlobalOption('VOB2SEP2'))
.head 7 +  If sSepVobList
.head 8 +  If SalStrScan ( ','||sSepVobList||',', ','||Str(m_nVob)||',' )>=0
.head 9 -  Set nVob = m_nVob
.head 8 +  Else
.head 9 -  Set nVob = GetVobForBadVob()
.head 7 +  Else
.head 8 +  If m_nVob=1 or m_nVob=2 or m_nVob=6 or m_nVob=33 or m_nVob=81
.head 9 -  Set nVob = m_nVob
.head 8 +  Else
.head 9 -  Set nVob = GetVobForBadVob()
.head 7 +  While TRUE
.head 8 -  Set m_nErr = -1
.head 8 -  Set m_nRec = 0
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 +  If m_nRefF
.head 10 -  Set sRef = SalNumberToStrX(m_nRefF, 0)
.head 9 +  Else
.head 10 -  Set sRef = m_sRef_A             !--SalNumberToStrX(m_nRef, 0)
.head 9 +  If SalStrScan ( m_sDrec, '#fMT' )>=0 or m_nFbi					
.head 10 +  If not SqlPrepareAndExecute(hSql(),
   "SELECT w.tag,w.value,v.vspo_char
      INTO :sTag,:sVal,:sChr
      FROM operw w, op_field v 
     WHERE w.ref=:m_nRef AND w.tag=v.tag AND v.vspo_char in ('F','П','C')
     ORDER BY v.vspo_char,w.tag")
.head 11 -  Call Debug('Ош выборки из OPERW')
.head 11 -  Break
.head 10 -  ! ***********************************
.head 10 +  While SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Set nToken = SalStrTokenize( sVal, PutCrLf(), PutCrLf(), aToken )
.head 11 -  Set j=0
.head 11 +  While j<nToken
.head 12 +  If sChr='F'
.head 13 -  Set aNazn[i]='#F'||SalStrLeftX(SalStrTrimX(sTag)||':'||SalStrTrimX(aToken[j]),157)||'#'
.head 12 +  Else
.head 13 -  Set aNazn[i]='#'||sChr||SalStrLeftX(SalStrTrimX(aToken[j]),217)||'#'
.head 12 -  Set i=i+1
.head 12 -  Set j=j+1
.head 11 -  Set m_nBis=1
.head 9 +  While m_nBis=0 or m_nBis>0 and m_nBis<=i+1 
.head 10 +  If m_nBis 
.head 11 +  If m_nBis=1
.head 12 -  Set m_sDrec='#B'||SalStrRightX('00'||SalNumberToStrX(i+1, 0), 2 )||IifS(m_sDrec='','#',SalStrTrimX(m_sDrec))
.head 12 -  Set m_sNazns = '11'
.head 11 +  ! Else
.head 12 -  Set m_sDrec=''
.head 11 -  Set m_nSiG=1
.head 10 +  If m_nSiG   ! Подписать здесь?
.head 11 -  Set m_sOperId=GetIdOper()
.head 11 +  If not ..sDoc()
.head 12 -  ! Set sErrTxt = 'Не удалось переподписать документ.'
.head 12 -  Break
.head 10 +  If GetGlobalOptionEx('SEPNUM')=2
.head 11 -  Set sNd   = m_sNd
.head 11 -  Set sNama = A.Nam
.head 11 -  Set sNamb = B.Nam
.head 11 -  Set sNazn = m_sNazn
.head 11 -  Set sDrec = m_sDrec
.head 10 +  Else
.head 11 -  Set sNd   = StrWinToDosX(m_sNd)
.head 11 -  Set sNama = StrWinToDosX(A.Nam)
.head 11 -  Set sNamb = StrWinToDosX(B.Nam)
.head 11 -  Set sNazn = StrWinToDosX(m_sNazn)
.head 11 -  Set sDrec = StrWinToDosX(m_sDrec)
.head 10 +  If not SqlPLSQLCommand(hSql(),
  "sep.in_sep(m_nErr,m_nRec,A.Bank,A.Nls,B.Bank,B.Nls,m_nDk,A.S,
              nVob,sNd,A.Kv,m_dDatD,m_dDatP,sNama,sNamb,sNazn,
           m_sNaznk,m_sNazns,A.Okpo,B.Okpo,m_sOperId,sRef,m_nBis,
       lsNull,sNull,nNull,dNull,sDrec,m_nOtm,m_nRef,nNull,sNull)")
.head 11 -  Break
.head 10 +  If m_nErr
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
.head 11 +  If SalStrLength ( aNazn[m_nBis-2] ) <= 160
.head 12 -  Set m_sNazn=aNazn[m_nBis-2]
.head 12 -  Set m_sDrec=''
.head 11 +  Else
.head 12 -  Set m_sNazn=SalStrLeftX(aNazn[m_nBis-2],160)
.head 12 -  Set m_sDrec=SalStrMidX(aNazn[m_nBis-2],160,60)
.head 11 -  Set m_sNazns='33'
.head 11 +  If m_nDk=0
.head 12 -  Set m_nDk=2
.head 11 +  Else If m_nDk=1
.head 12 -  Set m_nDk=3
.head 11 -  Set A.S=0
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
.head 7 +  If m_nBis or m_nSiG
.head 8 -  Call SetDocR(m_nRef,FALSE)   ! Восстановить переменные класса cDoc
.head 7 -  Return FALSE
.head 5 +  Function: sIni
.head 6 -  Description: Инициализировать ЭЦП
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_sIni( )
.head 5 +  Function: sDoc       ! Подписать документ
.head 6 -  Description: (Здесь ничего не трогать, тут и так все хорошо)
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: isOk
.head 6 +  Actions
.head 7 -  Set isOk = DSig_sDoc( MakeSepBuf(), m_sOperId, m_lsSignExtHex )
.head 7 +  If isOk
.head 8 -  Call SaveInfoToLog('sDoc: sign = ' || m_lsSignExtHex)
.head 8 -  Call SalStrSetBufferLength( m_lsSign, SalStrLength( m_lsSignExtHex )/2+1 )
.head 8 -  Call ConvertHexToBin( m_lsSignExtHex, m_lsSign, 
SalStrLength( m_lsSignExtHex )/2 )
.head 7 -  Return isOk
.head 5 +  Function: sDocInt    ! Подписать внутренней подписью (при визировании и вводе)
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nLev
.head 7 -  Number: nGrp         ! Код группы визирования 
                     (обязательно задавать только для nLev=99)
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: isOk
.head 6 +  Actions
.head 7 -  Set isOk = DSig_sDocInt( m_nRef,m_sTT,nLev,nGrp,iSignData(),m_sOperId,m_lsSignIntHex )
.head 7 +  If isOk
.head 8 -  Call SalStrSetBufferLength( m_lsSignI, SalStrLength( m_lsSignIntHex )/2+1 )
.head 8 -  Call ConvertHexToBin( m_lsSignIntHex, m_lsSignI, 
SalStrLength( m_lsSignIntHex )/2 )
.head 7 -  Return isOk
.head 5 +  Function: sDocVisa   ! Подписать документ при  визировании
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Boolean: isOk
.head 6 +  Actions
.head 7 -  Set isOk = DSig_sDocVisa( m_nRef,MakeSepBuf(),m_sOperId,m_lsSignExtHex )
.head 7 +  If isOk
.head 8 -  Call SalStrSetBufferLength( m_lsSign, SalStrLength( m_lsSignExtHex )/2+1 )
.head 8 -  Call ConvertHexToBin( m_lsSignExtHex, m_lsSign, 
SalStrLength( m_lsSignExtHex )/2 )
.head 7 -  Return isOk
.head 5 +  Function: CheckDocSign   ! Проверить ЭЦП на документ
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: szMode ! Режим работы 'CUR' - проверить текущую ЭЦП (nVisaLevel=max)
                              'LVL' - проверить ЭЦП уровня nVisaLevel
.head 7 -  Number: nVisaLevel ! Уровень ЭЦП
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_CheckDocSign( m_nRef,szMode,nVisaLevel,
  m_sOperId,MakeSepBuf(),m_nSignErrType )
.head 5 +  Function: cDocInt    ! Проверить внутреннюю подпись на документе
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: nLev         ! Уровень ЭЦП
.head 7 -  Number: nGrp         ! Код группы визирования 
                     (обязательно задавать только для nLev=99)
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_cDocInt( m_nRef,m_sTT,nLev,nGrp,iSignData(),m_isSignExist )
.head 5 +  Function: IsSignExist ! А была ли ЭЦП при проверке ?
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return m_isSignExist
.head 5 +  Function: sTrace ! Трассировка подписей в файл
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  String: sString
.head 7 -  Number: nLenS
.head 7 -  Long String: lsSign
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_sTrace( sString,nLenS,lsSign )
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
.head 7 -  Number: nSk       !! Символ кассплана
.head 7 -  Number: nSq       !! Эквівалент
.head 7 -  Number: nNom      !! Номинал ЦБ
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: S    !
.head 7 -  String: S2   ! для
.head 7 -  String: KvA  ! при вычислении суммы операции
.head 7 -  String: KvB  !
.head 7 -  String: N    !
.head 7 -  !
.head 7 -  String: sS
.head 7 -  String: sFormula
.head 7 -  String: sNazD
.head 7 -  Number: i
.head 7 -  Number: j
.head 7 -  Number: nFetchRes
.head 7 -  String: SK
.head 7 -  String: SQ
.head 7 -  String: sDecimal
.head 7 -  String: sDecimal2
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
.head 7 -  Set rsNazn=SalStrTrimX(sS)
.head 7 +  If SalStrScan(sS,'#{')<0 and SalStrScan(sS,'#(')<0
.head 8 -  Return TRUE
.head 7 +  Else
.head 8 -  Set S   = SalNumberToStrX(nS1, 0)  ! Сумма платежа
.head 8 -  Set S2  = SalNumberToStrX(nS2, 0)  ! Сумма платежа
.head 8 -  Set KvA = SalNumberToStrX(nKv1, 0) ! Код валюты А
.head 8 -  Set KvB = SalNumberToStrX(nKv2, 0) ! Код валюты B
.head 8 -  Set SK  = SalNumberToStrX(nSk, 0)  ! Символ кассплана
.head 8 -  !
.head 8 -  Set sDecimal=SalStrMidX(SalNumberToStrX(1.1,1),1,1)
.head 8 -  Set N   = Str(nNom)                ! Номинал Б
.head 8 +  If SalStrScan(N, sDecimal) >= 0
.head 9 -  Set N   = SalStrReplaceX(N,SalStrScan(N,sDecimal),1,'.')
.head 8 -  Set SQ  = Str(nSq/100)             ! Еквів
.head 8 +  If SalStrScan(SQ, sDecimal) >= 0
.head 9 -  Set SQ  = SalStrReplaceX(SQ,SalStrScan(SQ,sDecimal),1,'.')
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
.head 8 +  While SalStrScan(sS,'#(SK)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(SK)'),5,SK)
.head 8 +  While SalStrScan(sS,'#(SQ)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(SQ)'),5,SQ)
.head 8 +  While SalStrScan(sS,'#(NOM)') > 0
.head 9 -  Set sS = SalStrReplaceX(sS,SalStrScan(sS,'#(NOM)'),6,N)
.head 8 -  Set i=SalStrScan(sS,'#{')
.head 8 +  While i>=0
.head 9 -  Set sFormula=SalStrMidX(sS,i+2,SalStrLength(sS)-i-2)
.head 9 -  Set j=SalStrScan(sFormula,'}')
.head 9 +  If j>=0
.head 10 -  Set sFormula=SalStrLeftX(sFormula,j)
.head 10 +  If not SqlPrepareAndExecute(hSql(), "SELECT SUBSTR(" || sFormula || ",1,160) INTO :sNazD FROM dual")
.head 11 -  Return FALSE
.head 10 +  If not SqlFetchNext(hSql(),nFetchRes)
.head 11 -  Return FALSE
.head 10 -  Set sS=SalStrLeftX(sS,i)||SalStrTrimX(sNazD)||SalStrRightX(sS,SalStrLength(sS)-j-i-3)
.head 9 +  Else
.head 10 -  Return FALSE
.head 9 -  Set i=SalStrScan(sS,'#{')
.head 8 -  Set rsNazn=SalStrTrimX(sS)
.head 7 -  Return TRUE
.head 5 +  Function: sGetPassP
.head 6 -  Description: Вертає номер паспорта відправника
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  String: sDrec
.head 7 -  String: sNls
.head 7 -  Number: nKv
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sPassp
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  Call SqlPrepareAndExecute(hSql(), 
"SELECT 'Ф'||TRIM(p.ser)||' '||TRIM(p.numdoc)||'#' INTO :sPassp 
   FROM person p, accounts a 
  WHERE p.rnk=a.rnk AND p.passp = 1 AND p.numdoc IS NOT Null AND a.nls=:sNls AND a.kv=:nKv")
.head 7 +  If SqlFetchNext(hSql(),nFetchRes)
.head 8 -  Return IifS(sDrec=STRING_Null, '#',sDrec)||sPassp
.head 7 -  Return sDrec
.head 5 +  ! Function: pLnk 
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
.head 9 +  If not ..PayTT(0,m_nRef,dDatV,sTT,nDk,A.Kv,A.Nls,nSA,B.Kv,B.Nls,nSB)
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
.head 7 -  ! Number: nOtv         ! Флаг "ответственная виза"
.head 7 -  Number: fsig        ! Вид ЭЦП на визе: 0-Отсут, 1-Внутр, 2-СЭП, 3-Внутр+СЭП
.head 6 +  Actions
.head 7 -  Set bNewDoc = FALSE
.head 7 -  Set nRet = 0
.head 7 +  While TRUE
.head 8 -  ! Читать описание транзакции
.head 8 +  If not SqlPrepareAndExecute(hSql(), T("
   SELECT dk,nlsm,nlsk,fli,flags[35,35],flags[38,38],flags[2,2],name 
   FROM tts WHERE tt=:m_sTT
     INTO :nDk,:sNlsm,:sNlsk,:m_nFli,:m_nFbi,:m_nFlg,:fsig,:sNam"))
.head 9 -  Break
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set sErrTxt = 'Не описана транзакция ' || m_sTT
.head 9 -  Break
.head 8 -  ! Call Debug( '* fsig = '||SalNumberToStrX( fsig, 0 ) )
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
.head 9 -  Set m_sNd = SalStrRightX(SalNumberToStrX(m_nRef, 0),10)
.head 8 +  If not SalStrTrimX(m_sNazn)
.head 9 -  Set m_sNazn = SalStrTrimX(sNam)
.head 8 +  If not SalStrTrimX(m_sRef_A)
.head 9 -  Set m_sRef_A=SalNumberToStrX( SalNumberMod(m_nRef,1000000000), 0 )
.head 8 +  If SalStrLength(A.Nam) > 38
.head 9 -  Set A.Nam = SalStrLeftX(A.Nam,38)
.head 8 +  If SalStrLength(B.Nam) > 38
.head 9 -  Set B.Nam = SalStrLeftX(B.Nam,38)
.head 8 -  ! Подписать документ (если межбанк или включена внутренняя подпись)
.head 8 -  ! По старой методике наложения ЭЦП
.head 8 +  If GetGlobalOption('INTSIGN') != '2'
.head 9 +  If m_nFli = 1 or GetGlobalOption('INTSIGN')='1'
.head 10 +  If not m_lsSign 
.head 11 +  If not ..sDoc()
.head 12 -  Set sErrTxt = 'Не удалось подписать документ.'
.head 12 -  Break
.head 8 -  ! Вставить в OPER
.head 8 +  If bNewDoc and not ..iDoc()
.head 9 -  Set sErrTxt = 'Неуспех при вставке документа '|| m_sNd
.head 9 -  Break
.head 8 -  ! По новой методике наложения ЭЦП
.head 8 +  If GetGlobalOption('INTSIGN')='2'  !-- новая внутрення подпись    !!!!!!!!
.head 9 +  If fsig & DEF_INT_SIGN
.head 10 +  If not ..sDocInt(0,NUMBER_Null)
.head 11 -  Set sErrTxt = 'Не удалось подписать документ внутренней ЭЦП.'
.head 11 -  Break
.head 9 +  If fsig & DEF_EXT_SIGN
.head 10 +  If not m_lsSign 
.head 11 +  If not ..sDoc()
.head 12 -  Set sErrTxt = 'Не удалось подписать документ ЭЦП СЭП.'
.head 12 -  Break
.head 10 +  ! Else 
.head 11 -  Call Debug( 'буфер m_lsSign уже инициализирован' )
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
.head 8 -  ! If GetGlobalOption('DYNTT2')='Y'
.head 8 +  If not ..DynTT2()
.head 9 -  Set sErrTxt = 'Невозможно выполнить связанную операцию DYNTT2.'
.head 9 -  Break
.head 8 +  ! Else ! Убрать, когда все успокоится
.head 9 +  If (m_nFlg = 0 or m_nFlg = 1) and (m_nDk = 0 or m_nDk = 1)
.head 10 +  If m_nFlg = 0
.head 11 +  If not ChkBIG(m_nFlg,m_nRef,m_sTT,A.Kv,A.S,B.Kv,B.S)
.head 12 -  Set sErrTxt = 'Неуспешная проверка на БОЛЬШИЕ суммы транзакции '|| m_sTT
.head 12 -  Break 
.head 10 -  ! Внимание, здесь может измениться флаг оплаты m_nFlg
.head 10 +  If not ..PayTT(0,m_nRef,m_dDatV1,m_sTT,m_nDk,A.Kv,A.Nls,A.S,B.Kv,B.Nls,B.S)
.head 11 -  Set sErrTxt = 'Неуспешная оплата транзакции '|| m_sTT
.head 11 -  Break 
.head 9 +  If not ..pLnk(0)
.head 10 -  Set sErrTxt = 'Невозможно выполнить связанную операцию.'
.head 10 -  Break 
.head 8 -  ! Вставить в ARC_RRP
.head 8 +  If m_nFli = 1
.head 9 +  If not SqlPrepareAndExecute(hSql(),"SELECT sos INTO :m_nSos FROM oper WHERE ref=:m_nRef")
.head 10 -  Set sErrTxt = 'Ошибка компиляции SQL выражения!'
.head 10 -  Break
.head 9 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Set sErrTxt = 'Нет документа Ref:'||SalNumberToStrX(m_nRef, 0)
.head 10 -  Break
.head 9 +  If m_nFlg=1 and m_nSos = 5
.head 10 +  If not ..iSep()
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
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_ReadTM(  )
.head 5 +  Function: WriteTM  ! Писать на ТМ
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_WriteTM(  )
.head 5 +  Function: GetDayStrByNum ! Возвращает строку 'день', 'дня', 'дней' 
.head 6 -  Description: Возвращает строку 'день', 'дня', 'дней' 
в зависимости от кол-ва дней - параметра nDays
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nDays
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_GetDayStrByNum( nDays )
.head 5 +  Function: P_Fac  ! Оплатить по факт остатку в контролере (Старая версия Compatible)
.head 6 -  Description: Оплата документа по факт остатку
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: nRefP
.head 7 -  String: sVdat
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nFli
.head 7 -  Number: nFlg
.head 7 -  Number: nFetchRes
.head 7 -  String: sErrTxt
.head 7 -  Number: nRefL
.head 7 -  Number: nRef
.head 7 -  String: sTT
.head 6 +  Actions
.head 7 -  Set nRef=nRefP
.head 7 +  While TRUE
.head 8 -  ! Лочим запись в OPER
.head 8 +  If not SqlPrepareAndExecute(hSql(), 
   "SELECT tt,refl,sos INTO :sTT,:nRefL,:m_nSos FROM oper WHERE ref=:nRef FOR UPDATE OF sos NOWAIT")
.head 9 -  Set sErrTxt = 'Ошибка компиляции SQL выражения'
.head 9 -  Break
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set sErrTxt = 'Нет документа Ref:'||SalNumberToStrX(nRef, 0)
.head 9 -  Break
.head 8 -  ! Оплата реф
.head 8 +  If m_nSos < 5 
.head 9 +  If not SqlPrepareAndExecute(hSql(), T("
   SELECT fli,flags[35,35],flags[38,38] INTO :nFli,:m_nFbi,:nFlg FROM tts WHERE tt=:sTT "))
.head 10 -  Set sErrTxt = 'Ошибка компиляции SQL выражения'
.head 10 -  Break
.head 9 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Set sErrTxt = 'Нет транзакции TT:'||sTT
.head 10 -  Break
.head 9 +  If not Pay(2,nRef,MMddyyyyToDate(sVdat),'',NUMBER_Null,NUMBER_Null,'',NUMBER_Null,NUMBER_Null,'')
.head 10 -  Set sErrTxt = 'Неуспех при фактической оплате'
.head 10 -  Break
.head 9 +  If nFli = 1 and (nFlg=0 or nFlg=1 or nFlg=3) 
.head 10 +  If not SetDocR(nRef, TRUE)
.head 11 -  Set sErrTxt = 'Нет документа Ref: '||SalNumberToStrX(nRef, 0)
.head 11 -  Break
.head 10 +  If m_nSos = 5 ! Наступила дата валютирования
.head 11 +  If not ..iSep()
.head 12 -  Set sErrTxt = SalNumberToStrX(m_nErr, 0)||'. Не удалось передать документ для отправки в СЭП'
.head 12 -  Break
.head 8 +  If nRefL
.head 9 -  Set nRef = nRefL
.head 8 +  Else
.head 9 +  If nRef != nRefP
.head 10 +  If not SetDocR(nRefP, TRUE)
.head 11 -  Set sErrTxt = 'Нет документа Ref: '||SalNumberToStrX(nRefP, 0)
.head 11 -  Break
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
.head 5 +  Function: DynTT2 ! Оплатить транзакцию с связанными операциями
.head 6 -  Description: Новая оплата связанных транзакций
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  String: sDatV
.head 7 -  Number: nFetchRes
.head 6 +  Actions
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  While TRUE
.head 8 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 9 +  If not SqlPLSQLCommand(hSql(), 
   "gl.DYNTT2( m_nSos,m_nFlg,m_nPyD,m_nRef,m_dDatV1,m_dDatV2, 
         m_sTT,m_nDk,A.Kv,A.Bank,A.Nls,A.S,B.Kv,B.Bank,B.Nls,B.S,m_nSq,m_nNom )")
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
.head 9 +  If not SqlPLSQLCommand(hSql(), "gl.PAYV(Pay, Ref, DatV, TT, Dk, KvA, NlsA, SA, KvB, NlsB, SB)"    ) 
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
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call DSig_InsertCert2DB()
.head 5 +  Function: GetHexChar
.head 6 -  Description: возвращает символ hex по заданному числу
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nVal
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_GetHexChar( nVal )
.head 5 +  Function: GetSepSignMsg
.head 6 -  Description: возвращает описание ошибки 
инициализации/наложения/снятия ЭЦП СЭП НБУ
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nCode
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_GetSepSignMsg( nCode )
.head 5 +  Function: UNIFormatMessage
.head 6 -  Description: возвращает описание ошибки ЭЦП UNI
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nErrorCode
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_UNIFormatMessage( nErrorCode )
.head 5 +  Function: UNIFormatGSSMessage
.head 6 -  Description: возвращает описание ошибки ЭЦП UNI функций GSS
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: minor_status
.head 7 -  Number: status_value
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_UNIFormatGSSMessage( minor_status,status_value )
.head 5 +  Function: CredFormatMessage
.head 6 -  Description: Возвращает описание ошибок для функций библиотеки CreateCred.dll
.head 6 +  Returns
.head 7 -  String:
.head 6 +  Parameters
.head 7 -  Number: nErrorCode
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_CredFormatMessage( nErrorCode )
.head 5 +  Function: iSignData
.head 6 -  Description: Возвращает подписываемую строку для внутренней ЭЦП
.head 6 +  Returns
.head 7 -  String:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Return DSig_iSignData( m_nRef )
.head 5 +  Function: PutVis
.head 6 -  Description: Вставка внутренней подписи (новой)
.head 6 -  Returns
.head 6 +  Parameters
.head 7 -  Number: nGrp
.head 7 -  Number: nStat
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  ! Call Debug('cDoc.PutVis(): 
m_lsSignIntHex='||m_lsSignIntHex||'
m_lsSignExtHex='||m_lsSignExtHex
)
.head 7 -  Return DSig_PutVis( m_nRef,m_sTT,nGrp,nStat,
m_sOperId,m_lsSignIntHex,m_lsSignExtHex )
.head 5 +  Function: LockCheckSignStore
.head 6 -  Description: Блокируем документ, Проверяем ЭЦП, Накладываем ЭЦП, Сохраняем в БД
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: p_nRef        ! референс документа
.head 7 -  Number: p_nCheckId    ! код группы контроля/визирования
.head 7 -  Number: p_nStatus     ! Статус визы:1-визировал,2-оплатил,3-сторнировал
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: n2Pay
.head 7 -  Number: n2Sig
.head 6 +  Actions
.head 7 -  ! Работаем только с новой системой визирования
.head 7 +  If GetGlobalOptionEx('INTSIGN')!=2
.head 8 -  Return TRUE
.head 7 -  ! Лочим документ + получаем флаги оплаты и ЭЦП
.head 7 +  If not SqlPLSQLCommand(hSql(),"chk.lock_doc(p_nRef,p_nCheckId,n2Pay,n2Sig)")
.head 8 -  Call SaveErrorToLog( 'Ошибка блокирования документа. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0) )
.head 8 -  Return FALSE
.head 7 +  If (n2Sig & DEF_INT_SIGN)
.head 8 +  If p_nStatus!=3
.head 9 -  ! Проверяем предыдущую ЭЦП только если это не сторнирование
.head 9 +  If NOT cDoc.cDocInt(99,p_nCheckId)
.head 10 -  Call SaveErrorToLog( 'Ошибка при проверке внутренней ЭЦП. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0)
 )
.head 10 -  Return FALSE
.head 8 -  ! Накладываем ЭЦП
.head 8 +  If not cDoc.sDocInt(99,p_nCheckId)
.head 9 -  Call SaveErrorToLog( 'Ошибка при наложении внутренней ЭЦП. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0)
 )
.head 9 -  Return FALSE
.head 7 +  If (n2Sig & DEF_EXT_SIGN)
.head 8 -  Set cDoc.m_sOperId=GetIdOper()
.head 8 +  If not cDoc.sDoc( )
.head 9 -  Call SaveErrorToLog( 'Ошибка при наложении внешней ЭЦП. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0)
 )
.head 9 -  Return FALSE
.head 7 +  If not cDoc.PutVis(p_nCheckId,p_nStatus)
.head 8 -  Call SaveErrorToLog( 'Ошибка при записи данных визы в БД. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0)
||', Status='||SalNumberToStrX(p_nStatus,0)
 )
.head 8 -  Return FALSE
.head 7 -  Return TRUE
.head 5 +  Function: LockSignStore
.head 6 -  Description: Блокируем документ, Накладываем ЭЦП, Сохраняем в БД
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 +  Parameters
.head 7 -  Number: p_nRef        ! референс документа
.head 7 -  Number: p_nCheckId    ! код группы контроля/визирования
.head 7 -  Number: p_nStatus     ! Статус визы:1-визировал,2-оплатил,3-сторнировал
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: n2Pay
.head 7 -  Number: n2Sig
.head 6 +  Actions
.head 7 -  ! Работаем только с новой системой визирования
.head 7 +  If GetGlobalOptionEx('INTSIGN')!=2
.head 8 -  Return TRUE
.head 7 -  ! Лочим документ + получаем флаги оплаты и ЭЦП
.head 7 +  If not SqlPLSQLCommand(hSql(),"chk.lock_doc(p_nRef,p_nCheckId,n2Pay,n2Sig)")
.head 8 -  Call SaveErrorToLog( 'Ошибка блокирования документа. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0) )
.head 8 -  Return FALSE
.head 7 +  If (n2Sig & DEF_INT_SIGN)
.head 8 -  ! Накладываем ЭЦП
.head 8 +  If not cDoc.sDocInt(99,p_nCheckId)
.head 9 -  Call SaveErrorToLog( 'Ошибка при наложении внутренней ЭЦП. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0)
 )
.head 9 -  Return FALSE
.head 7 +  If (n2Sig & DEF_EXT_SIGN)
.head 8 -  Set cDoc.m_sOperId=GetIdOper()
.head 8 +  If not cDoc.sDoc( )
.head 9 -  Call SaveErrorToLog( 'Ошибка при наложении внешней ЭЦП. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0)
 )
.head 9 -  Return FALSE
.head 7 +  If not cDoc.PutVis(p_nCheckId,p_nStatus)
.head 8 -  Call SaveErrorToLog( 'Ошибка при записи данных визы в БД. '
||'REF='||SalNumberToStrX(p_nRef,0)||', GRP='||SalNumberToStrX(p_nCheckId,0)
||', Status='||SalNumberToStrX(p_nStatus,0)
 )
.head 8 -  Return FALSE
.head 7 -  Return TRUE
.head 3 +  Functional Class: cStorona
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
