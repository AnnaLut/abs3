.head 0 +  Application Description: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! KLOP_BOB.APL - Принятие решений операционистом по   !
!                документам от "электронных" клиентов !
! ООО "Унити-Барс" (C) 1998 - 2005                    !
! Разработчик: Марийко Б.Г.                           !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

История изменений:

29/11/2001(SERG)
в табл. params добавлен параметр
CLNTSEC - способ фильтрации платежей эл.кл.
0(или отсутствует) - по исполнителю
1 - по группам доступа
    [(nls,kv) in (select nls,kv from saldo)]
Соответственно изменены диалоги dlg_klp0 и dlg_klp
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000003000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000B20000 002C000000030000 0003000000020000 00AA010000FCFFFF
0040: FFE2FFFFFF000000 0000000000EC0100 0039010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D02000000075769 6E646F777307776F
0080: 7A77726174000001 800200FFFFFFFF00 000000000000002C 0000000000000001
00A0: 000000FFFFFFFFFF FFFFFFFCFFFFFFE9 FFFFFF2C0000002C 000000B202000079
00C0: 0100000000000000 000000030000000F 4170706C69636174 696F6E4974656D07
00E0: 57696E646F777307 646C675F6B6C7000 000000
.enddata
.data DT_MAKERUNDLG
0000: 020000000015513A 5C43454E54555241 5C6E65776170702E 65786515513A5C43
0020: 454E545552415C6E 65776170702E646C 6C15513A5C43454E 545552415C6E6577
0040: 6170702E61706300 0001010115513A5C 43454E545552415C 6E65776170702E72
0060: 756E15513A5C4345 4E545552415C6E65 776170702E646C6C 15513A5C43454E54
0080: 5552415C6E657761 70702E6170630000 010101185C424152 5339385C42494E5C
00A0: 6B6C6F705F626F62 2E617064165C4241 525339385C42494E 5C6E65776170702E
00C0: 646C6C165C424152 5339385C42494E5C 6E65776170702E61 7063000001010115
00E0: 513A5C43454E5455 52415C6E65776170 702E61706C15513A 5C43454E54555241
0100: 5C6E65776170702E 646C6C15513A5C43 454E545552415C6E 65776170702E6170
0120: 630000010101
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
0000: 0818B80BB80B2500
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
.head 2 -  File Include: Docfun6.apl
.head 2 -  File Include: Constant.apl
.head 2 -  File Include: Ttp32.apl
.head 2 -  File Include: VTTBLWIN.APL
.head 2 -  File Include: VTSTR.APL
.head 2 -  File Include: Xsalcpt.apl
.head 2 -  ! File Include: qcktabs.apl
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
.head 3 -  Date/Time: dd/MM/yyyy
.head 3 -  Number: #000
.head 3 -  Number: ###00000
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
.head 2 -  Resources
.head 2 +  Variables
.head 3 -  String: sWW
.head 3 -  Number: nAN
.head 3 -  Number: nFetchRes
.head 3 -  Number: nGetSum
.head 3 -  Number: nTipPoisk
.head 3 -  String: AMFO
.head 3 -  Number: nckv
.head 3 -  !
.head 3 -  Number: nKURSresult
.head 3 -  String: sKOD_G
.head 3 -  String: sKOD_N
.head 3 -  String: sKOD_B
.head 3 -  !
.head 3 -  Boolean: bAUTO
.head 2 +  Internal Functions
.head 3 +  Function: KLOP                       ! __exported
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nPar
.head 5 -  String: sOp1
.head 5 -  String: sOp2
.head 5 -  String: sOp3
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  ! Call SalModalDialog(dlg_klp, hWndForm)
.head 5 -  ! Call SalCreateWindow(dlg_klp0, hWndForm)
.head 5 +  If nPar = 0
.head 6 -  Call SalCreateWindow(dlg_klp0, hWndMDI, sOp1, sOp2, sOp3)
.head 5 +  Else If nPar = 3
.head 6 -  Call SalCreateWindow(dlg_klp3, hWndMDI, sOp1, sOp2, sOp3) !! конверсия
.head 5 +  Else If nPar = 6
.head 6 -  Call SalCreateWindow(dlg_klp6, hWndMDI, sOp1, sOp2, sOp3) !! загранперевод
.head 5 +  Else If nPar = 7
.head 6 -  Call SalCreateWindow(dlg_klp7, hWndMDI, sOp1, sOp2, sOp3) !! пл.поручение в инвалюте
                                                          !! для погашения кредита
.head 3 +  Function: GetKlientName
.head 4 -  Description: получить наименование клиента
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  String: sxxcccc
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sNMK
.head 4 +  Actions
.head 5 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT nvl(nmkk,nmk)
     INTO   :sNMK
     FROM   customer
     WHERE  sab=SUBSTR(:sxxcccc,3,4)"))
.head 5 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set sNMK = 'Наименование клиента невозможно идентифицировать'
.head 5 -  Return SalStrTrimX(sNMK)
.head 2 -  Named Menus
.head 2 +  Class Definitions
.head 3 +  Functional Class: cDocV
.head 4 -  Description:
.head 4 +  Derived From
.head 5 -  Class: cDoc
.head 4 -  Class Variables
.head 4 +  Instance Variables
.head 5 -  String: s1
.head 5 -  String: s2
.head 5 -  String: s3
.head 4 +  Functions
.head 5 +  Function: iDop
.head 6 -  Description:
.head 6 +  Returns
.head 7 -  Boolean:
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 -  Local variables
.head 6 +  Actions
.head 7 -  Call SqlPrepareAndExecute(hSql(), "
     INSERT
     INTO   operw (ref,tag,value)
     VALUES (:cDoc.m_nRef,'KLVZA',:s1)")
.head 7 -  Call SqlPrepareAndExecute(hSql(), "
     INSERT
     INTO   operw (ref,tag,value)
     VALUES (:cDoc.m_nRef,'71A  ',:s1)")
.head 7 -  Call SqlPrepareAndExecute(hSql(), "
     INSERT
     INTO   operw (ref,tag,value)
     VALUES (:cDoc.m_nRef,'KLVKV',:s2)")
.head 7 +  ! If Len(s3) > 0
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     INSERT
     INTO   operw (ref,tag,value)
     VALUES (:cDoc.m_nRef,'72   ',:s3)")
.head 7 -  Call SqlPrepareAndExecute(hSql(), "
     INSERT
     INTO   operw (ref,tag,value)
     VALUES (:cDoc.m_nRef,'TERM ',:s3)")
.head 7 -  Call SqlPrepareAndExecute(hSql(), "
     INSERT
     INTO   operw (ref,tag,value)
     VALUES (:cDoc.m_nRef,'NOS_A','0')")
.head 7 -  Call SqlPrepareAndExecute(hSql(), "
     INSERT
     INTO   operw (ref,tag,value)
     VALUES (:cDoc.m_nRef,'f    ','MT 103')")
.head 7 -  Return TRUE
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton:
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
.head 1 +  Dialog Box: wozwrat
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Выберите причину возврата
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   2.84"
.head 4 -  Top:    0.492"
.head 4 -  Width:  6.575"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.607"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Bold
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: выбор или ввод текста для запоминания текста возврата
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.262"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Courier New Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Combo Box: combo1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.095"
.head 5 -  Width:  5.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.31"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  String Type: String
.head 4 -  Maximum Data Length: 40
.head 4 -  Sorted? Yes
.head 4 -  Always Show List? Yes
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalListPopulate(hWndItem, hSql(), T('
     SELECT TRIM(prwo)
     FROM   klp_wozw
     WHERE  neom=:nAN'))
.head 6 -  Set sWW = ''
.head 5 +  On SAM_Click
.head 6 -  Set sWW = combo1
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalSendMsg(pbOk, SAM_Click, 0, 0)
.head 5 +  On SAM_Validate
.head 6 +  If SalStrLeftX(SalStrTrimX(combo1), 1) = '*'
.head 7 -  Return VALIDATE_Cancel
.head 6 +  Else
.head 7 -  Set sWW = combo1
.head 7 -  Return VALIDATE_Ok
.head 3 +  Pushbutton: pbAdd
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Добавить
.head 4 -  Window Location and Size
.head 5 -  Left:   5.186"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.292"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Yellow
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalStrLength(SalStrTrimX(sWW)) > 0
.head 7 -  ! Добавляем в комбобокс и в базу
.head 7 -  ! Call SalMessageBox(sWW, '', MB_Ok)
.head 7 -  Set nI = 0
.head 7 +  While nI <= SalListQueryCount(combo1)
.head 8 +  If SalStrTrimX(sWW) = SalStrTrimX(SalListQueryTextX(combo1, nI))
.head 9 -  Break
.head 8 -  Set nI = nI + 1
.head 7 +  If nI > SalListQueryCount(combo1)
.head 8 -  Call SalListAdd(combo1, SalStrTrimX(sWW))
.head 8 +  If SqlPrepareAndExecute(hSql(), T('
   INSERT
   INTO   klp_wozw (neom,prwo)
   VALUES (:nAN,:sWW)'))
.head 9 -  ! Call SqlCommitEx(hSql(),
         'Добавлена новая причина возврата')
.head 9 -  Call SqlCommit(hSql())
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выбрать
.head 4 -  Window Location and Size
.head 5 -  Left:   5.186"
.head 5 -  Top:    0.488"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.292"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отмена
.head 4 -  Window Location and Size
.head 5 -  Left:   5.186"
.head 5 -  Top:    0.905"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.292"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set sWW = ''
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: nI
.head 2 -  Message Actions
.head 1 +  Dialog Box: poisk
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Поиск документа
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   4.175"
.head 4 -  Top:    1.156"
.head 4 -  Width:  3.386"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.976"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Bold
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: поиск документа
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.262"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Courier New Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Pushbutton: pbSumma
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: По сумме документа
.head 4 -  Window Location and Size
.head 5 -  Left:   0.486"
.head 5 -  Top:    0.073"
.head 5 -  Width:  2.743"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.292"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F1
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(poisk,
     SalModalDialog(getSumma, hWndForm))
.head 3 +  Pushbutton: pbOplata
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Документ к оплате
.head 4 -  Window Location and Size
.head 5 -  Left:   0.486"
.head 5 -  Top:    0.488"
.head 5 -  Width:  2.743"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.292"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F2
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(poisk, 2)
.head 3 +  Pushbutton: pbWozwrat
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Возращенный документ
.head 4 -  Window Location and Size
.head 5 -  Left:   0.486"
.head 5 -  Top:    0.905"
.head 5 -  Width:  2.743"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.292"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F3
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(poisk, 3)
.head 3 +  Pushbutton: pbOtkaz
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отказ
.head 4 -  Window Location and Size
.head 5 -  Left:   0.486"
.head 5 -  Top:    1.321"
.head 5 -  Width:  2.743"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(poisk, 0)
.head 3 +  Picture: pic1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.071"
.head 5 -  Width:  0.371"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \Bars98\RESOURCE\BMP\Bf1.bmp
.head 4 -  Storage: Internal
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Round
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 2
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: Dark Gray
.head 4 -  Message Actions
.head 3 +  Picture: pic2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.488"
.head 5 -  Width:  0.371"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \Bars98\RESOURCE\BMP\bf2.bmp
.head 4 -  Storage: External
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Round
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 2
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: Green
.head 4 -  Message Actions
.head 3 +  Picture: pic3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.905"
.head 5 -  Width:  0.371"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \Bars98\RESOURCE\BMP\bf3.bmp
.head 4 -  Storage: External
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Round
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 2
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: Marigold
.head 4 -  Message Actions
.head 3 +  Picture: picesc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    1.321"
.head 5 -  Width:  0.371"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  File Name: \Bars98\RESOURCE\BMP\besc.bmp
.head 4 -  Storage: External
.head 4 -  Picture Transparent Color: None
.head 4 -  Fit: Scale
.head 4 -  Scaling
.head 5 -  Width:  100
.head 5 -  Height:  100
.head 4 -  Corners: Round
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 2
.head 4 -  Tile To Parent? No
.head 4 -  Border Color: Default
.head 4 -  Background Color: Black
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 +  If nTipPoisk = 0
.head 5 -  Call SalSetFocus(pbOtkaz)
.head 4 +  Else If nTipPoisk = 1
.head 5 -  Call SalSetFocus(pbSumma)
.head 4 +  Else If nTipPoisk = 2
.head 5 -  Call SalSetFocus(pbOplata)
.head 4 +  Else If nTipPoisk = 3
.head 5 -  Call SalSetFocus(pbWozwrat)
.head 1 +  Dialog Box: document
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Текущий документ
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.513"
.head 4 -  Top:    -0.021"
.head 4 -  Width:  9.343"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.5"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Arial Cyr
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold-Italic
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: показ документа
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.262"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Data Field: dftitle
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
.head 6 -  Left:   0.586"
.head 6 -  Top:    0.092"
.head 6 -  Width:  5.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: №
.head 4 -  Resource Id: 6136
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.886"
.head 5 -  Top:    0.092"
.head 5 -  Width:  0.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfND
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 10
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.186"
.head 6 -  Top:    0.092"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfDATA
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
.head 6 -  Left:   4.586"
.head 6 -  Top:    0.344"
.head 6 -  Width:  1.283"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Платник -
.head 4 -  Resource Id: 6137
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.76"
.head 5 -  Width:  1.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfNAMA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.286"
.head 6 -  Top:    0.76"
.head 6 -  Width:  4.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Банк платника
.head 4 -  Resource Id: 6138
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    1.177"
.head 5 -  Width:  2.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfBANKA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    1.344"
.head 6 -  Width:  3.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Код банку
.head 4 -  Resource Id: 6139
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.386"
.head 5 -  Top:    1.177"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfMFOA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 12
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.286"
.head 6 -  Top:    1.323"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Одержувач -
.head 4 -  Resource Id: 6141
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    1.927"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfNAMB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.286"
.head 6 -  Top:    1.927"
.head 6 -  Width:  4.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Банк одержувача
.head 4 -  Resource Id: 6142
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    2.344"
.head 5 -  Width:  2.314"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfBANKB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    2.51"
.head 6 -  Width:  3.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Код банку
.head 4 -  Resource Id: 6143
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.386"
.head 5 -  Top:    2.344"
.head 5 -  Width:  1.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfMFOB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 12
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.286"
.head 6 -  Top:    2.49"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 12
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.786"
.head 6 -  Top:    1.344"
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.229"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfCodeCurrency
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 3
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.486"
.head 6 -  Top:    0.76"
.head 6 -  Width:  0.683"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Uppercase
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: ДЕБЕТ                                  СУМА
.head 4 -  Resource Id: 6145
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.886"
.head 5 -  Top:    1.094"
.head 5 -  Width:  3.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfNLSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.886"
.head 6 -  Top:    1.344"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.229"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: КРЕДИТ
.head 4 -  Resource Id: 6146
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.886"
.head 5 -  Top:    2.01"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfNLSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.886"
.head 6 -  Top:    2.26"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.229"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Сума літерами
.head 4 -  Resource Id: 6147
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    2.76"
.head 5 -  Width:  2.314"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Multiline Field: mlSumPr
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
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    2.906"
.head 6 -  Width:  9.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.583"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 -  Background Text: Призначення платежу
.head 4 -  Resource Id: 6148
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    3.51"
.head 5 -  Width:  2.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Multiline Field: mlNAZN
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
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    3.656"
.head 6 -  Width:  9.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.583"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ok
.head 4 -  Window Location and Size
.head 5 -  Left:   3.186"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(document, 0)
.head 3 +  Pushbutton: pbEsc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ok
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    3.906"
.head 5 -  Width:  8.657"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.333"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? No
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Yellow
.head 4 -  Background Color: Dark Gray
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(document, 0)
.head 3 +  Data Field: dfKODDOK
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
.head 6 -  Left:   7.986"
.head 6 -  Top:    0.094"
.head 6 -  Width:  1.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: від
.head 4 -  Resource Id: 30542
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.086"
.head 5 -  Top:    0.344"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Код
.head 4 -  Resource Id: 30543
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.927"
.head 5 -  Width:  0.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfKODA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.286"
.head 6 -  Top:    0.927"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.229"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Код
.head 4 -  Resource Id: 47258
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    2.094"
.head 5 -  Width:  0.829"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfKODB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.286"
.head 6 -  Top:    2.094"
.head 6 -  Width:  1.7"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Line
.head 4 -  Resource Id: 47259
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.086"
.head 5 -  Begin Y:  1.573"
.head 5 -  End X:  5.286"
.head 5 -  End Y:  1.573"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Background Text: Одержано банком
.head 4 -  Resource Id: 47244
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.286"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.9"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: "__" _________200__ р.
.head 4 -  Resource Id: 47257
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.986"
.head 5 -  Top:    0.51"
.head 5 -  Width:  2.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 47256
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.086"
.head 5 -  Begin Y:  2.74"
.head 5 -  End X:  5.286"
.head 5 -  End Y:  2.74"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 47255
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.786"
.head 5 -  Top:    2.49"
.head 5 -  Width:  1.9"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: рах.N
.head 4 -  Resource Id: 47254
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.286"
.head 5 -  Top:    1.344"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: рах.N
.head 4 -  Resource Id: 47253
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.286"
.head 5 -  Top:    2.26"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: рах.N
.head 4 -  Resource Id: 47252
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.286"
.head 5 -  Top:    2.51"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: р.
.head 4 -  Resource Id: 47251
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.986"
.head 5 -  Top:    0.344"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 47250
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    4.74"
.head 5 -  Width:  0.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.333"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: М.П.
.head 4 -  Resource Id: 47249
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    4.844"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbPrinterSetup
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Принтер
.head 4 -  Window Location and Size
.head 5 -  Left:   4.086"
.head 5 -  Top:    4.99"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDisableWindow(pbPrint)
.head 6 -  Call SalDisableWindow(pbPrinterSetup)
.head 6 -  Call SalDisableWindow(pbOk)
.head 6 -  Call SalDisableWindow(document)
.head 6 -  Call SalPrtSetup(sDevice, sDriver, sPort, FALSE)
.head 6 -  Call SalPrtSetDefault(sDevice, sDriver, sPort)
.head 6 -  Call SalEnableWindow(pbPrint)
.head 6 -  Call SalEnableWindow(document)
.head 6 -  Call SalEnableWindow(pbPrinterSetup)
.head 6 -  Call SalEnableWindow(pbOk)
.head 6 -  Call SalSetFocus(pbPrinterSetup)
.head 3 -  Background Text: Підписи платника
.head 4 -  Resource Id: 47248
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.986"
.head 5 -  Top:    4.927"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Проведено банком
.head 4 -  Resource Id: 47247
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.186"
.head 5 -  Top:    4.51"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: "__" _________200__ р.
.head 4 -  Resource Id: 47246
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.886"
.head 5 -  Top:    4.677"
.head 5 -  Width:  2.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Підпис банку
.head 4 -  Resource Id: 47245
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.386"
.head 5 -  Top:    4.927"
.head 5 -  Width:  1.829"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Pushbutton: pbPrint
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Печать
.head 4 -  Window Location and Size
.head 5 -  Left:   5.386"
.head 5 -  Top:    4.99"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalHideWindow(pbPrint)
.head 6 -  Call SalHideWindow(pbPrinterSetup)
.head 6 -  Call SalHideWindow(pbOk)
.head 6 -  Call SalHideWindow(dfDaval)
.head 6 -  Call SalHideWindow(dfDAVAL)
.head 6 -  Call SalHideWindow(dfR)
.head 6 -  Call SalPrtPrintForm(document)
.head 6 -  Call SalShowWindow(pbPrint)
.head 6 -  Call SalShowWindow(pbPrinterSetup)
.head 6 -  Call SalShowWindow(pbOk)
.head 6 +  If d_DAVAL != DATETIME_Null
.head 7 -  Call SalShowWindow(dfDaval)
.head 7 -  Call SalShowWindow(dfDAVAL)
.head 7 -  Call SalShowWindow(dfR)
.head 6 -  Call SalSetFocus(pbPrint)
.head 3 -  Line
.head 4 -  Resource Id: 47260
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  5.786"
.head 5 -  Begin Y:  1.323"
.head 5 -  End X:  5.786"
.head 5 -  End Y:  2.49"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 47262
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  7.686"
.head 5 -  Begin Y:  1.323"
.head 5 -  End X:  7.686"
.head 5 -  End Y:  2.49"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 47261
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  7.686"
.head 5 -  Begin Y:  2.74"
.head 5 -  End X:  9.186"
.head 5 -  End Y:  2.74"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 47263
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.886"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 47266
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  5.786"
.head 5 -  Begin Y:  1.573"
.head 5 -  End X:  9.186"
.head 5 -  End Y:  1.573"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 47265
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  5.786"
.head 5 -  Begin Y:  1.323"
.head 5 -  End X:  9.186"
.head 5 -  End Y:  1.323"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 47264
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  5.786"
.head 5 -  Begin Y:  2.24"
.head 5 -  End X:  7.686"
.head 5 -  End Y:  2.24"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 +  Data Field: dfDaval
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
.head 6 -  Left:   1.886"
.head 6 -  Top:    0.51"
.head 6 -  Width:  2.529"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Fixedsys
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Royal Blue
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfDAVAL
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
.head 6 -  Left:   4.586"
.head 6 -  Top:    0.51"
.head 6 -  Width:  1.286"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Royal Blue
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfR
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
.head 6 -  Left:   5.986"
.head 6 -  Top:    0.51"
.head 6 -  Width:  0.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Fixedsys
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Royal Blue
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: df_title1
.head 3 -  String: d_ND1
.head 3 -  Date/Time: d_DATA1
.head 3 -  String: d_NAMA1
.head 3 -  String: d_BNK_A1
.head 3 -  String: d_MFOA1
.head 3 -  String: d_NAMB1
.head 3 -  String: d_BNK_B1
.head 3 -  String: d_MFOB1
.head 3 -  Number: d_S1
.head 3 -  String: dfCodeCurrency1
.head 3 -  String: d_NLSA1
.head 3 -  String: d_NLSB1
.head 3 -  String: ml_SumPr1
.head 3 -  String: d_NAZN1
.head 3 -  String: d_KOKA
.head 3 -  String: d_KOKB
.head 3 -  String: d_KODO
.head 3 -  Date/Time: d_DAVAL
.head 2 +  Window Variables
.head 3 -  String: sDevice
.head 3 -  String: sDriver
.head 3 -  String: sPort
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndItem)
.head 4 -  Set dftitle = df_title1
.head 4 -  Set dfND = SalStrTrimX(d_ND1)
.head 4 -  Set dfDATA = d_DATA1
.head 4 -  Set dfNAMA = SalStrTrimX(d_NAMA1)
.head 4 -  Set dfBANKA = SalStrTrimX(d_BNK_A1)
.head 4 -  Set dfMFOA = SalStrTrimX(d_MFOA1)
.head 4 -  Set dfNAMB = SalStrTrimX(d_NAMB1)
.head 4 -  Set dfBANKB = SalStrTrimX(d_BNK_B1)
.head 4 -  Set dfMFOB = SalStrTrimX(d_MFOB1)
.head 4 -  Set dfS = d_S1
.head 4 -  Set dfCodeCurrency = SalStrTrimX(dfCodeCurrency1)
.head 4 -  Set dfNLSA = SalStrTrimX(d_NLSA1)
.head 4 -  Set dfNLSB = SalStrTrimX(d_NLSB1)
.head 4 -  Set mlSumPr = ml_SumPr1
.head 4 -  Set mlNAZN = SalStrTrimX(d_NAZN1)
.head 4 -  Set dfKODA = SalStrTrimX(d_KOKA)
.head 4 -  Set dfKODB = SalStrTrimX(d_KOKB)
.head 4 -  Set dfKODDOK = SalStrTrimX(d_KODO)
.head 4 +  If d_DAVAL = DATETIME_Null
.head 5 -  Call SalHideWindow(dfDaval)
.head 5 -  Call SalHideWindow(dfDAVAL)
.head 5 -  Call SalHideWindow(dfR)
.head 4 +  Else
.head 5 -  Call SalShowWindow(dfDaval)
.head 5 -  Call SalShowWindow(dfDAVAL)
.head 5 -  Call SalShowWindow(dfR)
.head 5 -  Set dfDaval = 'Дата валютування'
.head 5 -  Set dfDAVAL = d_DAVAL
.head 5 -  Set dfR = 'р.'
.head 4 -  Call SalSetFocus(pbOk)
.head 1 +  Dialog Box: document2
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Текущий документ
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   1.088"
.head 4 -  Top:    0.177"
.head 4 -  Width:  9.343"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.5"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Arial Cyr
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold-Italic
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: показ документов с обработкой
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.262"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Data Field: dftitle
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
.head 6 -  Left:   3.286"
.head 6 -  Top:    0.092"
.head 6 -  Width:  2.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: №
.head 4 -  Resource Id: 56299
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.886"
.head 5 -  Top:    0.092"
.head 5 -  Width:  0.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfND
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 10
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.186"
.head 6 -  Top:    0.092"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfDATA
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
.head 6 -  Left:   4.586"
.head 6 -  Top:    0.344"
.head 6 -  Width:  1.283"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Платник -
.head 4 -  Resource Id: 56300
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.76"
.head 5 -  Width:  1.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfNAMA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.286"
.head 6 -  Top:    0.76"
.head 6 -  Width:  4.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Банк платника
.head 4 -  Resource Id: 56301
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    1.177"
.head 5 -  Width:  2.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfBANKA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    1.344"
.head 6 -  Width:  3.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Код банку
.head 4 -  Resource Id: 56302
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.386"
.head 5 -  Top:    1.177"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfMFOA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 12
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.286"
.head 6 -  Top:    1.323"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Одержувач -
.head 4 -  Resource Id: 56303
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    1.927"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfNAMB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.286"
.head 6 -  Top:    1.927"
.head 6 -  Width:  4.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Банк одержувача
.head 4 -  Resource Id: 56304
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    2.344"
.head 5 -  Width:  2.314"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfBANKB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 38
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    2.51"
.head 6 -  Width:  3.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Код банку
.head 4 -  Resource Id: 56305
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.386"
.head 5 -  Top:    2.344"
.head 5 -  Width:  1.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfMFOB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 12
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.286"
.head 6 -  Top:    2.49"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 12
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.786"
.head 6 -  Top:    1.344"
.head 6 -  Width:  1.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.229"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfCodeCurrency
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 3
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.486"
.head 6 -  Top:    0.76"
.head 6 -  Width:  0.683"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Uppercase
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: ДЕБЕТ                                  СУМА
.head 4 -  Resource Id: 56306
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.886"
.head 5 -  Top:    1.094"
.head 5 -  Width:  3.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Data Field: dfNLSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.886"
.head 6 -  Top:    1.344"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.229"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: КРЕДИТ
.head 4 -  Resource Id: 56307
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.886"
.head 5 -  Top:    2.01"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfNLSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.886"
.head 6 -  Top:    2.26"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.229"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Сума літерами
.head 4 -  Resource Id: 56308
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    2.76"
.head 5 -  Width:  2.314"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Multiline Field: mlSumPr
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
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    2.906"
.head 6 -  Width:  9.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.583"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalSetFocus(pbPrinterSetup)
.head 3 -  Background Text: Призначення платежу
.head 4 -  Resource Id: 56309
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    3.51"
.head 5 -  Width:  2.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Face Color
.head 3 +  Multiline Field: mlNAZN
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
.head 5 -  Vertical Scroll? No
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    3.656"
.head 6 -  Width:  9.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.583"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 4 +  Message Actions
.head 5 +  On SAM_SetFocus
.head 6 -  Call SalSetFocus(pbEsc)
.head 3 +  Data Field: dfKODDOK
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
.head 6 -  Left:   7.986"
.head 6 -  Top:    0.094"
.head 6 -  Width:  1.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: від
.head 4 -  Resource Id: 56310
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.086"
.head 5 -  Top:    0.344"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Код
.head 4 -  Resource Id: 56311
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.927"
.head 5 -  Width:  0.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfKODA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.286"
.head 6 -  Top:    0.927"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.229"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Код
.head 4 -  Resource Id: 56312
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    2.094"
.head 5 -  Width:  0.829"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfKODB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.286"
.head 6 -  Top:    2.094"
.head 6 -  Width:  1.7"
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
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Line
.head 4 -  Resource Id: 56313
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.086"
.head 5 -  Begin Y:  1.573"
.head 5 -  End X:  5.286"
.head 5 -  End Y:  1.573"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Background Text: Одержано банком
.head 4 -  Resource Id: 56314
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.286"
.head 5 -  Top:    0.344"
.head 5 -  Width:  1.9"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: "__" _________200__ р.
.head 4 -  Resource Id: 56315
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.986"
.head 5 -  Top:    0.51"
.head 5 -  Width:  2.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 56316
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  0.086"
.head 5 -  Begin Y:  2.74"
.head 5 -  End X:  5.286"
.head 5 -  End Y:  2.74"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 56317
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.786"
.head 5 -  Top:    2.49"
.head 5 -  Width:  1.9"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: рах.N
.head 4 -  Resource Id: 56318
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.286"
.head 5 -  Top:    1.344"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: рах.N
.head 4 -  Resource Id: 56319
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.286"
.head 5 -  Top:    2.26"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: рах.N
.head 4 -  Resource Id: 56320
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.286"
.head 5 -  Top:    2.51"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: р.
.head 4 -  Resource Id: 56321
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   5.986"
.head 5 -  Top:    0.344"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 56322
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    4.573"
.head 5 -  Width:  0.8"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.333"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: М.П.
.head 4 -  Resource Id: 56323
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.286"
.head 5 -  Top:    4.927"
.head 5 -  Width:  0.5"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Center
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Підписи платника
.head 4 -  Resource Id: 56324
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.986"
.head 5 -  Top:    4.76"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Проведено банком
.head 4 -  Resource Id: 56325
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.186"
.head 5 -  Top:    4.344"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: "__" _________200__ р.
.head 4 -  Resource Id: 56326
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   6.886"
.head 5 -  Top:    4.51"
.head 5 -  Width:  2.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Підпис банку
.head 4 -  Resource Id: 56327
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.386"
.head 5 -  Top:    4.76"
.head 5 -  Width:  1.829"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: None
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfOstatokNLS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.814"
.head 6 -  Top:    1.594"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Periwinkle
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfSummaWithO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 14
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.814"
.head 6 -  Top:    1.76"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Periwinkle
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfOstc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 13
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.786"
.head 6 -  Top:    1.594"
.head 6 -  Width:  1.471"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfOstcWithO
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 13
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.786"
.head 6 -  Top:    1.76"
.head 6 -  Width:  1.471"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Dark Green
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbPrinterSetup
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Принтер
.head 4 -  Window Location and Size
.head 5 -  Left:   0.986"
.head 5 -  Top:    4.99"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDisableWindow(pbPrint)
.head 6 -  Call SalDisableWindow(pbPrinterSetup)
.head 6 -  Call SalDisableWindow(pbF10)
.head 6 -  Call SalDisableWindow(pbF3)
.head 6 -  Call SalDisableWindow(pbF4)
.head 6 -  Call SalDisableWindow(pbF8)
.head 6 -  Call SalDisableWindow(pbEsc)
.head 6 -  Call SalDisableWindow(document2)
.head 6 -  Call SalDisableWindow(pbHome)
.head 6 -  Call SalDisableWindow(pbEnd)
.head 6 -  Call SalDisableWindow(pbUp)
.head 6 -  Call SalDisableWindow(pbDown)
.head 6 -  Call SalPrtSetup(sDevice, sDriver, sPort, FALSE)
.head 6 -  Call SalPrtSetDefault(sDevice, sDriver, sPort)
.head 6 -  Call SalEnableWindow(pbPrint)
.head 6 -  Call SalEnableWindow(document2)
.head 6 -  Call SalEnableWindow(pbPrinterSetup)
.head 6 -  Call SalEnableWindow(pbF10)
.head 6 -  Call SalEnableWindow(pbF3)
.head 6 -  Call SalEnableWindow(pbF4)
.head 6 -  Call SalEnableWindow(pbF8)
.head 6 -  Call SalEnableWindow(pbEsc)
.head 6 -  Call SalEnableWindow(pbHome)
.head 6 -  Call SalEnableWindow(pbEnd)
.head 6 -  Call SalEnableWindow(pbUp)
.head 6 -  Call SalEnableWindow(pbDown)
.head 6 -  Call SalSetFocus(pbPrinterSetup)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Выбрать принтер и его установки')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbPrint
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Печать
.head 4 -  Window Location and Size
.head 5 -  Left:   1.986"
.head 5 -  Top:    4.99"
.head 5 -  Width:  1.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F5
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalHideWindow(pbPrint)
.head 6 -  Call SalHideWindow(pbPrinterSetup)
.head 6 -  Call SalHideWindow(pbF10)
.head 6 -  Call SalHideWindow(pbF3)
.head 6 -  Call SalHideWindow(pbF4)
.head 6 -  ! Call SalHideWindow(pbF6)
.head 6 -  Call SalHideWindow(pbF7)
.head 6 -  Call SalHideWindow(pbF8)
.head 6 -  Call SalHideWindow(pbEsc)
.head 6 -  Call SalHideWindow(pbHome)
.head 6 -  Call SalHideWindow(pbEnd)
.head 6 -  Call SalHideWindow(pbUp)
.head 6 -  Call SalHideWindow(pbDown)
.head 6 -  Call SalHideWindow(dfOstatokNLS)
.head 6 -  Call SalHideWindow(dfSummaWithO)
.head 6 -  Call SalHideWindow(dfOstc)
.head 6 -  Call SalHideWindow(dfOstcWithO)
.head 6 -  Call SalHideWindow(dfPometka)
.head 6 -  Call SalHideWindow(dfTxtWozw)
.head 6 -  Call SalHideWindow(dfDaval)
.head 6 -  Call SalHideWindow(dfDAVAL)
.head 6 -  Call SalHideWindow(dfR)
.head 6 -  Call SalPrtPrintForm(document2)
.head 6 -  Call SalShowWindow(pbPrint)
.head 6 -  Call SalShowWindow(pbPrinterSetup)
.head 6 -  Call SalShowWindow(pbF10)
.head 6 -  Call SalShowWindow(pbF3)
.head 6 -  Call SalShowWindow(pbF4)
.head 6 -  ! Call SalShowWindow(pbF6)
.head 6 -  Call SalShowWindow(pbF7)
.head 6 -  Call SalShowWindow(pbF8)
.head 6 -  Call SalShowWindow(pbEsc)
.head 6 -  Call SalShowWindow(pbHome)
.head 6 -  Call SalShowWindow(pbEnd)
.head 6 -  Call SalShowWindow(pbUp)
.head 6 -  Call SalShowWindow(pbDown)
.head 6 -  Call SalShowWindow(dfOstatokNLS)
.head 6 -  Call SalShowWindow(dfSummaWithO)
.head 6 -  Call SalShowWindow(dfOstc)
.head 6 -  Call SalShowWindow(dfOstcWithO)
.head 6 -  Call SalShowWindow(dfPometka)
.head 6 -  Call SalShowWindow(dfTxtWozw)
.head 6 +  If dDaVal != DATETIME_Null
.head 7 -  Call SalShowWindow(dfDaval)
.head 7 -  Call SalShowWindow(dfDAVAL)
.head 7 -  Call SalShowWindow(dfR)
.head 6 -  Call SalSetFocus(pbPrint)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отпечатать документ')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbUp
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: PbUp
.head 4 -  Window Location and Size
.head 5 -  Left:   3.086"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Ascend_.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Перейти к предыдущему документу')
.head 5 +  On SAM_Click
.head 6 +  If nI > 0
.head 7 -  Call EraseDok()
.head 7 -  Set nI = nI - 1
.head 7 -  Set sNaePon = srrr[nI]
.head 7 -  Set dNaePon = drrr[nI]
.head 7 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbDown
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: PgDn
.head 4 -  Window Location and Size
.head 5 -  Left:   3.686"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Descend_.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Перейти к следующему документу')
.head 5 +  On SAM_Click
.head 6 +  If nI < nKwo
.head 7 -  Call EraseDok()
.head 7 -  Set nI = nI + 1
.head 7 -  Set sNaePon = srrr[nI]
.head 7 -  Set dNaePon = drrr[nI]
.head 7 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbHome
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Home
.head 4 -  Window Location and Size
.head 5 -  Left:   4.286"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Перейти к первому документу')
.head 5 +  On SAM_Click
.head 6 +  If nI > 0
.head 7 -  Call EraseDok()
.head 7 -  Set nI = 0
.head 7 -  Set sNaePon = srrr[nI]
.head 7 -  Set dNaePon = drrr[nI]
.head 7 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbEnd
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: End
.head 4 -  Window Location and Size
.head 5 -  Left:   4.886"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.6"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Перейти к последнему документу')
.head 5 +  On SAM_Click
.head 6 +  If nI < nKwo
.head 7 -  Call EraseDok()
.head 7 -  Set nI = nKwo
.head 7 -  Set sNaePon = srrr[nI]
.head 7 -  Set dNaePon = drrr[nI]
.head 7 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbF3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: F3
.head 4 -  Window Location and Size
.head 5 -  Left:   5.586"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F3
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If nFl = 0 or nFl = NUMBER_Null !! можно отметить на ВОЗВРАТ
.head 7 +  If SalModalDialog(wozwrat, hWndForm) != -1
.head 8 +  If Len(SalStrTrimX(sWW)) > 0
.head 9 -  Set sNae = Left(sNaePon, 12)
.head 9 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 9 +  If SqlPrepareAndExecute(hSql(), "
   UPDATE klp
   SET    fl=1,prwo=:sWW
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon")
.head 10 -  Call SqlCommit(hSql())
.head 10 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить документ на ВОЗВРАТ')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbF4
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: F4
.head 4 -  Window Location and Size
.head 5 -  Left:   5.986"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F4
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If nFl = 0 or nFl = NUMBER_Null !! можно отметить к ОПЛАТЕ
.head 7 -  Set sNae = Left(sNaePon, 12)
.head 7 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 7 +  If SqlPrepareAndExecute(hSql(), "
   UPDATE klp
   SET    fl=2
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon")
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 7 +  Else
.head 8 -  Call SqlRollback(hSql())
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить документ к ОПЛАТЕ')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbF6
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: F6
.head 4 -  Window Location and Size
.head 5 -  Left:   6.386"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F6
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If nFl = 0 or nFl = NUMBER_Null !! можно отметить к КАРТОТЕКУ
.head 7 -  Set sNae = Left(sNaePon, 12)
.head 7 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 7 +  If SqlPrepareAndExecute(hSql(), "
   UPDATE klp
   SET    fl=3
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon")
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 7 +  Else
.head 8 -  Call SqlRollback(hSql())
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить документ в КАРТОТЕКУ')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbF7
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: F7
.head 4 -  Window Location and Size
.head 5 -  Left:   6.886"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F7
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set sNaePon = srrr[nI]
.head 6 -  Set dNaePon = drrr[nI]
.head 6 -  Set nTipPoisk = SalModalDialog(poisk, hWndForm)
.head 6 -  Set sNae = Left(sNaePon, 12)
.head 6 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 6 +  If nTipPoisk = 1
.head 7 +  If bAUTO
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT k.naex || SUBSTR('0000000000' || k.pond, -10),k.datad
     INTO   :sNaePonT,:dNaePonT
     FROM   klp k, customer c
     WHERE  ((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.s/100=:nGetSum and
            SUBSTR(k.naex,3,4)=:sSab0 and k.fl<4 and k.noauto is not null and c.sab=:sSab0 and c.stmt=6
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT k.naex || SUBSTR('0000000000' || k.pond, -10),k.datad
     INTO   :sNaePonT,:dNaePonT
     FROM   klp k, customer c
     WHERE  (((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.s/100=:nGetSum and
            SUBSTR(k.naex,3,4)=:sSab0 and k.fl<4 and c.sab=:sSab0 and stmt=6) or
            (((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.s/100=:nGetSum and
            SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0 and k.fl<4 and c.sab=:sSab0 and stmt=5)
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set nT = 0
.head 8 +  While nT <= nKwo
.head 9 +  If srrr[nT] = sNaePonT and drrr[nT] = dNaePonT
.head 10 -  Set nI = nT
.head 10 -  Set sNaePon = sNaePonT
.head 10 -  Set dNaePon = dNaePonT
.head 10 -  Call EraseDok()
.head 10 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 10 -  Break
.head 9 -  Set nT = nT + 1
.head 6 +  Else If nTipPoisk = 2
.head 7 +  If bAUTO
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT k.naex || SUBSTR('0000000000' || k.pond, -10),k.datad
     INTO   :sNaePonT,:dNaePonT
     FROM   klp k, customer c
     WHERE  ((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.fl=2 and SUBSTR(k.naex,3,4)=:sSab0 and
            k.noauto is not null and c.sab=sSab0 and c.stmt=6
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT k.naex || SUBSTR('0000000000' || k.pond, -10),k.datad
     INTO   :sNaePonT,:dNaePonT
     FROM   klp k, customer c
     WHERE  (((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.fl=2 and SUBSTR(k.naex,3,4)=:sSab0 and
            c.sab=:sSab0 and c.stmt=6) or (((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.fl=2 and
            SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0 and c.sab=:sSab0 and c.stmt=5)
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set nT = 0
.head 8 +  While nT <= nKwo
.head 9 +  If srrr[nT] = sNaePonT and drrr[nT] = dNaePonT
.head 10 -  Set nI = nT
.head 10 -  Set sNaePon = sNaePonT
.head 10 -  Set dNaePon = dNaePonT
.head 10 -  Call EraseDok()
.head 10 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 10 -  Break
.head 9 -  Set nT = nT + 1
.head 6 +  Else If nTipPoisk = 3
.head 7 +  If bAUTO
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT k.naex || SUBSTR('0000000000' || k.pond, -10),k.datad
     INTO   :sNaePonT,:dNaePonT
     FROM   klp k, customer c
     WHERE  ((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.fl=1 and SUBSTR(k.naex,3,4)=:sSab0 and
            k.noauto is not null and c.sab=:sSab0 and c.stmt=6
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT k.naex || SUBSTR('0000000000' || k.pond, -10),k.datad
     INTO   :sNaePonT,:dNaePonT
     FROM   klp k, customer c
     WHERE  (((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.fl=1 and SUBSTR(k.naex,3,4)=:sSab0 and
            c.sab=:sSab0 and c.stmt=6) or (((k.naex=:sNae and k.pond>:sPon) or k.naex>:sNae) and k.fl=1 and
            SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0 and c.sab=:sSab0 and c.stmt=5)
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set nT = 0
.head 8 +  While nT <= nKwo
.head 9 +  If srrr[nT] = sNaePonT and drrr[nT] = dNaePonT
.head 10 -  Set nI = nT
.head 10 -  Set sNaePon = sNaePonT
.head 10 -  Set dNaePon = dNaePonT
.head 10 -  Call EraseDok()
.head 10 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 10 -  Break
.head 9 -  Set nT = nT + 1
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Поиск документа от текущей позиции вниз')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbF8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: F8
.head 4 -  Window Location and Size
.head 5 -  Left:   7.286"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F8
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If (nFl = 1 and Left(sPrwo, 1) != '*') or nFl = 2 or nFl = 3 !! можно снять отметку
.head 7 -  Set sNae = Left(sNaePon, 12)
.head 7 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 7 +  If SqlPrepareAndExecute(hSql(), "
   UPDATE klp
   SET    fl=0,prwo=''
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon")
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Call DokNaePon(sNaePon, dNaePon, FALSE)
.head 7 +  Else
.head 8 -  Call SqlRollback(hSql())
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Сбросить пометку с документа')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbF10
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: F10
.head 4 -  Window Location and Size
.head 5 -  Left:   7.686"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F10
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Green
.head 4 -  Background Color: 3D Shadow Color
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox("Вы уверены ?", "Обработать и выйти", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 -  Set nIndex = 0
.head 7 -  Call SalArraySetUpperBound(ssNaePon, 1, -1)
.head 7 -  Call SalArraySetUpperBound(nnFl, 1, -1)
.head 7 -  Call SalArraySetUpperBound(nnNeom, 1, -1)
.head 7 -  Call SalArraySetUpperBound(nnS, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssNls, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssMfo, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssMfoa, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssNlsp, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssNaimp, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssNd, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssText1, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssPond, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssPrwo, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssNaex, 1, -1)
.head 7 -  Call SalArraySetUpperBound(nnCkv, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssKokb, 1, -1)
.head 7 -  Call SalArraySetUpperBound(nnVob, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ddDatad, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ssKoka, 1, -1)
.head 7 -  Call SalArraySetUpperBound(ddDaVal, 1, -1)
.head 7 +  If bAUTO
.head 8 -  Call SqlPrepareAndExecute(hSqlAux2(), "
     SELECT k.ref,k.fl,k.eom,k.s,k.nls,k.mfo,k.nlsp,k.naimp,k.nd,k.text1,k.pond,k.prwo,k.naex,k.kv,k.kokb,
            k.vob,k.datad,k.koka,k.daval,k.naimo,k.drec
     INTO   :nRefKlp,:nFl,:nNeom,:nS,:sNls,:sMfo,:sNlsp,:sNaimp,:sNd,:sText1,:sPond,:sPrwo,:sNaex,:nCkv,:sKokb,
            :nVob,:dDatad,:sKoka,:dDaVal,:sNaimo,:sVspo
     FROM   klp k, customer c
     WHERE  k.eom=:nAN and k.fl>0 and k.fl<4 and SUBSTR(k.naex,3,4)=:sSab0 and k.noauto is not null and
            c.sab=:sSab0 and c.stmt=6
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute(hSqlAux2(), "
     SELECT k.ref,k.fl,k.eom,k.s,k.nls,k.mfo,k.nlsp,k.naimp,k.nd,k.text1,k.pond,k.prwo,k.naex,k.kv,k.kokb,
            k.vob,k.datad,k.koka,k.daval,k.naimo,substr(nvl(k.mfoa,:AMFO),1,12),k.drec
     INTO   :nRefKlp,:nFl,:nNeom,:nS,:sNls,:sMfo,:sNlsp,:sNaimp,:sNd,:sText1,:sPond,:sPrwo,:sNaex,:nCkv,:sKokb,
            :nVob,:dDatad,:sKoka,:dDaVal,:sNaimo,:sMfoa,:sVspo
     FROM   klp k, customer c
     WHERE  (k.eom=:nAN and k.fl>0 and k.fl<4 and SUBSTR(k.naex,3,4)=:sSab0 and c.sab=:sSab0 and c.stmt=6) or
            (k.eom=:nAN and k.fl>0 and k.fl<4 and SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0 and
            c.sab=:sSab0 and c.stmt=5)
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 7 +  While SqlFetchNext(hSqlAux2(), nFetchRes)
.head 8 -  Set ssNaePon[nIndex] = sNaex || Right('0000000000' || SalStrTrimX(sPond), 10)
.head 8 -  Set nnRefKlp[nIndex] = nRefKlp
.head 8 -  Set nnFl[nIndex] = nFl
.head 8 -  Set nnNeom[nIndex] = nNeom
.head 8 -  Set nnS[nIndex] = nS
.head 8 -  Set ssNls[nIndex] = sNls
.head 8 -  Set ssMfo[nIndex] = sMfo
.head 8 -  Set ssMfoa[nIndex] = sMfoa
.head 8 -  Set ssNlsp[nIndex] = sNlsp
.head 8 -  Set ssNaimp[nIndex] = sNaimp
.head 8 -  Set ssNd[nIndex] = sNd
.head 8 -  Set ssText1[nIndex] = sText1
.head 8 -  Set ssPond[nIndex] = sPond
.head 8 -  Set ssPrwo[nIndex] = sPrwo
.head 8 -  Set ssNaex[nIndex] = sNaex
.head 8 -  Set nnCkv[nIndex] = nCkv
.head 8 -  Set ssKokb[nIndex] = sKokb
.head 8 -  Set nnVob[nIndex] = nVob
.head 8 -  Set ddDatad[nIndex] = dDatad
.head 8 -  Set ssKoka[nIndex] = sKoka
.head 8 -  Set ddDaVal[nIndex] = dDaVal
.head 8 -  Set nIndex = nIndex + 1
.head 8 -  ! Call DebugN(nFetchRes)
.head 7 -  Call SalArrayDimCount(ssNaePon, nIndex)
.head 7 -  Call SalArrayGetUpperBound(ssNaePon, nIndex, nElemCount)
.head 7 -  Set nIndex = 0
.head 7 +  While nIndex <= nElemCount
.head 8 -  Set sNaePon = ssNaePon[nIndex]
.head 8 -  Set dNaePon = ddDatad[nIndex]
.head 8 -  Set nRefKlp = nnRefKlp[nIndex]
.head 8 -  Set nFl = nnFl[nIndex]
.head 8 -  Set nNeom = nnNeom[nIndex]
.head 8 -  Set nS = nnS[nIndex]
.head 8 -  Set sNls = ssNls[nIndex]
.head 8 -  Set sMfo = ssMfo[nIndex]
.head 8 -  Set sMfoa = ssMfoa[nIndex]
.head 8 -  Set sNlsp = ssNlsp[nIndex]
.head 8 -  Set sNaimp = ssNaimp[nIndex]
.head 8 -  Set sNd = ssNd[nIndex]
.head 8 -  Set sText1 = ssText1[nIndex]
.head 8 -  Set sPond = ssPond[nIndex]
.head 8 -  Set sPrwo = ssPrwo[nIndex]
.head 8 -  Set sNaex = ssNaex[nIndex]
.head 8 -  Set nCkv = nnCkv[nIndex]
.head 8 -  Set sKokb = ssKokb[nIndex]
.head 8 -  Set nVob = nnVob[nIndex]
.head 8 -  Set dDatad = ddDatad[nIndex]
.head 8 -  Set sKoka = ssKoka[nIndex]
.head 8 -  Set dDaVal = ddDaVal[nIndex]
.head 8 +  If nFl = 1 ! возвратить
.head 9 -  Set sNae = Left(sNaePon, 12)
.head 9 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 9 +  If SqlPrepareAndExecute(hSqlAux3(), '
   UPDATE klp
   SET    fl=9
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon')
.head 10 -  Set sOper = Right(Str(10000+nNeom), 4)
.head 10 +  If SqlPrepareAndExecute(hSqlAux3(), T("
   INSERT
   INTO   klpoow (sab,oper,mfoa,nlsa,mfob,nlsb,namb,s,nd,nazn,pond,prwo,nfia,tip)
   VALUES (:sSab0,:sOper,:sMfoa,:sNls,:sMfo,:sNlsp,:sNaimp,:nS,:sNd,:sText1,:sPond,:sPrwo,:sNaex,'W')"))
.head 11 -  Call SqlCommit(hSqlAux3())
.head 11 -  Call MessageNoWait('Возвращен "электронный" док.' || SalStrTrimX(sNd) || ', МФО плат.=' || sMfoa ||
     '), Счёт плат.=' || sNls || ', МФО получ.=' || sMfo || ', Счёт получ.=' || sNlsp || ', Сумма=' ||
     SalNumberToStrX(nS/100, 2) || ', Получатель - ' || sNaimp || ', Назначение платежа - ' || sText1,
     'Сообщение', .3, 0)
.head 10 +  Else
.head 11 -  Call SqlRollback(hSqlAux3())
.head 9 +  Else
.head 10 -  Call SqlRollback(hSqlAux3())
.head 8 +  Else If nFl = 2 ! к оплате
.head 9 -  Set sMaket = IifS(nVob=3, '3', IifS(SalStrTrimX(sMfo)=AMFO, '1', '2'))
.head 9 -  Set nDk = Max(1, Val(sMaket)-1)
.head 9 -  Set nVobBars = IifN(nVob=3, 7, IifN(nVob=6, 6, 1))
.head 9 -  Set sNAMAs = sNaimo
.head 9 +  If Len(sNAMAs) = 0
.head 10 -  Set sNAMAs = 'Плательщик не идентифицирован'
.head 10 +  If nVob = 1 or nVob = 6
.head 11 +  If SqlPrepareAndExecute(hSqlAux3(), T('
   SELECT nvl(c.nmkk,c.nmk)
   INTO   :sNAMAs
   FROM   customer c, accounts a
   WHERE  a.nls=:sNls and a.kv=:nCkv and c.rnk=a.rnk'))
.head 12 -  Call SqlFetchNext(hSqlAux3(), nFetchRes)
.head 10 +  Else
.head 11 +  If SqlPrepareAndExecute(hSqlAux3(), T('
   SELECT nvl(c.nmkk,c.nmk)
   INTO   :sNAMAs
   FROM   customer c, accounts a
   WHERE  a.nls=:sNlsp and a.kv=:nCkv and c.rnk=a.rnk'))
.head 12 -  Call SqlFetchNext(hSqlAux3(), nFetchRes)
.head 9 -  !
.head 9 -  ! Set nAcc = 0
.head 9 -  ! Set nOSTB = 0
.head 9 +  ! If SqlPrepareAndExecute(hSqlAux3(), T('
   SELECT a.acc,a.ostb
   INTO   :nAcc,:nOSTB
   FROM   accounts a
   WHERE  a.nls=:sNls and a.kv=:nCkv'))
.head 10 -  Call SqlFetchNext(hSqlAux3(), nFetchRes)
.head 9 -  ! Set sVspo = IifS(dDaVal=DATETIME_Null, '', '#D' || SalFmtFormatDateTime(dDaVal, 'yyMMdd') || '#')
.head 9 -  ! Set bRoll = FALSE
.head 9 +  ! If nOSTB < nS
.head 10 -  ! Лимит
.head 10 +  If SqlPrepareAndExecute(hSqlAux3(), T('
   SELECT a8.ostb
   INTO   :nOSTB8
   FROM   accounts a8, v862 v
   WHERE  v.acc6=:nAcc and v.acc8=a8.acc and a8.ostb>0'))
.head 11 +  If not SqlFetchNext(hSqlAux3(), nFetchRes)
.head 12 -  Set nOSTB8 = 0
.head 10 +  Else 
.head 11 -  Set bRoll = TRUE
.head 10 +  If nOSTB+nOSTB8 >= nS
.head 11 -  ! Лимит есть
.head 11 -  Set sMaket = Str(Val(sMaket)+2)
.head 10 +  ! Else
.head 11 -  ! Лимита нет, ждите поступлений
.head 9 -  ! If not bRoll
.head 9 +  If nRefKlp = NUMBER_Null
.head 10 -  ! Call cDoc.SetDoc(0, 'KL' || sMaket, nDk, nVob, sNd, dDatad, GetBankDate(), GetBankDate(), GetBankDate(),
     SalStrTrimX(sNls), sNAMAs, AMFO, '', nCkv, nS, SalStrTrimX(sKoka), SalStrTrimX(sNlsp), sNaimp,
     SalStrTrimX(sMfo), '', nCkv, nS, SalStrTrimX(sKokb), sText1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  ! Call cDoc.SetDoc(0, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, sNd, dDatad,
     GetBankDate(), IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal),
     IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal), IifS(nDk=1, sNls, sNlsp), IifS(nDk=1, sNAMAs, sNaimp),
     IifS(nDk=1, sMfoa, sMfo), '', nCkv, nS, IifS(nDk=1, sKoka, sKokb), IifS(nDk=1, sNlsp, sNls),
     IifS(nDk=1, sNaimp, sNAMAs), IifS(nDk=1, sMfo, sMfoa), '', nCkv, nS, IifS(nDk=1, sKokb, sKoka), sText1,
     sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  ! Call cDoc.SetDoc(0, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, sNd, dDatad,
     GetBankDate(), GetBankDate(), GetBankDate(), IifS(nDk=1, sNls, sNlsp), IifS(nDk=1, sNAMAs, sNaimp),
     IifS(nDk=1, sMfoa, sMfo), '', nCkv, nS, IifS(nDk=1, sKoka, sKokb), IifS(nDk=1, sNlsp, sNls),
     IifS(nDk=1, sNaimp, sNAMAs), IifS(nDk=1, sMfo, sMfoa), '', nCkv, nS, IifS(nDk=1, sKokb, sKoka), sText1,
     sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  Call cDoc.SetDoc(0, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, sNd, dDatad,
     GetBankDate(), GetBankDate(), IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal),
     IifS(nDk=1, sNls, sNlsp), IifS(nDk=1, sNAMAs, sNaimp), IifS(nDk=1, sMfoa, sMfo), '', nCkv, nS,
     IifS(nDk=1, sKoka, sKokb), IifS(nDk=1, sNlsp, sNls), IifS(nDk=1, sNaimp, sNAMAs),
     IifS(nDk=1, sMfo, sMfoa), '', nCkv, nS, IifS(nDk=1, sKokb, sKoka), sText1, sVspo, GetIdOper(), '',
     NUMBER_Null, 0)
.head 10 -  ! Set cDoc.m_nNom = IifN(nDk=2, 0, nS) - Max(nOSTB, 0)
.head 10 -  Set cDoc.m_nNom = IifN(nDk=2, 0, nS)
.head 10 +  If cDoc.oDoc()
.head 11 -  Set nRef = cDoc.m_nRef
.head 11 -  Set sNae = Left(sNaePon, 12)
.head 11 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 11 +  If SqlPrepareAndExecute(hSqlAux3(), '
   UPDATE klp
   SET    fl=8
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon')
.head 12 -  Set sOper = Right(Str(10000+nNeom), 4)
.head 12 -  Set bUIklp = SqlPrepareAndExecute(hSqlAux3(), T("
    UPDATE klpond
    SET    ref=:nRef
    WHERE  pond=:sPond and filename=:sNaex"))
.head 12 -  Set nCountUpd = 0
.head 12 -  Call SqlGetModifiedRows(hSqlAux3(), nCountUpd)
.head 12 +  If nCountUpd = 0
.head 13 -  Set bUIklp = SqlPrepareAndExecute(hSqlAux3(), T("
    INSERT
    INTO   klpond (ref,pond,filename)
    VALUES (:nRef,:sPond,:sNaex)"))
.head 12 +  If bUIklp
.head 13 -  Call SqlCommit(hSqlAux3())
.head 13 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(sNd) || ', (Ref=' || Str(nRef) ||
     ', МФО плат.=' || sMfoa || '), Счёт плат.=' || sNls || ', МФО получ.=' || sMfo ||
     ', Счёт получ.=' || sNlsp || ', Сумма=' || SalNumberToStrX(nS/100, 2) || ', Получатель - ' ||
     sNaimp || ', Назначение платежа - ' || sText1, 'Сообщение', .3, 0)
.head 12 +  Else
.head 13 -  Call SqlRollback(hSqlAux3())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSqlAux3())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSqlAux3())
.head 9 +  Else
.head 10 -  Call SaveInfoToLog('KLOP_BOB(2): cDoc.SetDoc(ref==>' || Str(nRefKlp) || ')')
.head 10 -  ! Call cDoc.SetDoc(nRefKlp, 'KL' || sMaket, nDk, nVob, sNd, dDatad, GetBankDate(), GetBankDate(),
     GetBankDate(), SalStrTrimX(sNls), sNAMAs, AMFO, '', nCkv, nS, SalStrTrimX(sKoka), SalStrTrimX(sNlsp),
     sNaimp, SalStrTrimX(sMfo), '', nCkv, nS, SalStrTrimX(sKokb), sText1, sVspo, GetIdOper(), '',
     NUMBER_Null, 0)
.head 10 -  ! Call cDoc.SetDoc(nRefKlp, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, sNd, dDatad,
     GetBankDate(), IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal),
     IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal), IifS(nDk=1, sNls, sNlsp), IifS(nDk=1, sNAMAs, sNaimp),
     IifS(nDk=1, sMfoa, sMfo), '', nCkv, nS, IifS(nDk=1, sKoka, sKokb), IifS(nDk=1, sNlsp, sNls),
     IifS(nDk=1, sNaimp, sNAMAs), IifS(nDk=1, sMfo, sMfoa), '', nCkv, nS, IifS(nDk=1, sKokb, sKoka), sText1,
     sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  ! Call cDoc.SetDoc(nRefKlp, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, sNd, dDatad,
     GetBankDate(), GetBankDate(), GetBankDate(), IifS(nDk=1, sNls, sNlsp), IifS(nDk=1, sNAMAs, sNaimp),
     IifS(nDk=1, sMfoa, sMfo), '', nCkv, nS, IifS(nDk=1, sKoka, sKokb), IifS(nDk=1, sNlsp, sNls),
     IifS(nDk=1, sNaimp, sNAMAs), IifS(nDk=1, sMfo, sMfoa), '', nCkv, nS, IifS(nDk=1, sKokb, sKoka), sText1,
     sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  Call cDoc.SetDoc(nRefKlp, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, sNd, dDatad,
     GetBankDate(), GetBankDate(), IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal),
     IifS(nDk=1, sNls, sNlsp), IifS(nDk=1, sNAMAs, sNaimp), IifS(nDk=1, sMfoa, sMfo), '', nCkv, nS,
     IifS(nDk=1, sKoka, sKokb), IifS(nDk=1, sNlsp, sNls), IifS(nDk=1, sNaimp, sNAMAs),
     IifS(nDk=1, sMfo, sMfoa), '', nCkv, nS, IifS(nDk=1, sKokb, sKoka), sText1, sVspo, GetIdOper(), '',
     NUMBER_Null, 0)
.head 10 -  ! Set cDoc.m_nNom = IifN(nDk=2, 0, nS) - Max(nOSTB, 0)
.head 10 -  Set cDoc.m_nNom = IifN(nDk=2, 0, nS)
.head 10 -  Set cDoc.m_sRef_A = Str(nRefKlp)
.head 10 +  If cDoc.sDoc()
.head 11 +  If cDoc.iDoc()
.head 12 +  If cDoc.oDoc()
.head 13 -  Set nRef = cDoc.m_nRef
.head 13 -  Call SaveInfoToLog('KLOP_BOB(2): cDoc.oDoc() return ref==>' || Str(cDoc.m_nRef))
.head 13 -  Set sNae = Left(sNaePon, 12)
.head 13 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 13 +  If SqlPrepareAndExecute(hSqlAux3(), '
   UPDATE klp
   SET    fl=8
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon')
.head 14 -  Set sOper = Right(Str(10000+nNeom), 4)
.head 14 -  Set bUIklp = SqlPrepareAndExecute(hSqlAux3(), T("
    UPDATE klpond
    SET    ref=:nRef
    WHERE  pond=:sPond and filename=:sNaex"))
.head 14 -  Set nCountUpd = 0
.head 14 -  Call SqlGetModifiedRows(hSqlAux3(), nCountUpd)
.head 14 +  If nCountUpd = 0
.head 15 -  Set bUIklp = SqlPrepareAndExecute(hSqlAux3(), T("
    INSERT
    INTO   klpond (ref,pond,filename)
    VALUES (:nRef,:sPond,:sNaex)"))
.head 14 +  If bUIklp
.head 15 -  Call SqlCommit(hSqlAux3())
.head 15 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(sNd) || ', (Ref=' || Str(nRef) ||
     ', МФО плат.=' || sMfoa || '), Счёт плат.=' || sNls || ', МФО получ.=' || sMfo ||
     ', Счёт получ.=' || sNlsp || ', Сумма=' || SalNumberToStrX(nS/100, 2) || ', Получатель - ' ||
     sNaimp || ', Назначение платежа - ' || sText1, 'Сообщение', .3, 0)
.head 14 +  Else
.head 15 -  Call SqlRollback(hSqlAux3())
.head 13 +  Else
.head 14 -  Call SqlRollback(hSqlAux3())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSqlAux3())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSqlAux3())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSqlAux3())
.head 9 +  ! Else 
.head 10 -  Call SqlRollback(hSqlAux3())
.head 8 +  Else If nFl = 3 ! в картотеку
.head 9 -  Set nMaket = IifN(SalStrTrimX(sMfo)=AMFO, 2, 1)
.head 9 -  Set nDk = 1
.head 9 +  If Len(sNaimo) = 0
.head 10 -  Call SqlPrepareAndExecute(hSqlAux3(), T('
     SELECT nvl(nmkk,nmk)
     INTO   :sNAMAs
     FROM   customer c, accounts a
     WHERE  a.nls=:sNls and a.kv=:nCkv and c.rnk=a.rnk'))
.head 10 +  If not SqlFetchNext(hSqlAux3(), nFetchRes)
.head 11 -  Set sNAMAs = 'Плательщик не идентифицирован'
.head 9 +  Else
.head 10 -  Set sNAMAs = sNaimo
.head 9 -  ! Set sVspo = IifS(dDaVal=DATETIME_Null, '', '#D' || SalFmtFormatDateTime(dDaVal, 'yyMMdd') || '#')
.head 9 +  If nRefKlp = NUMBER_Null
.head 10 -  ! Call cDoc.SetDoc(0, 'K2A', nDk, nVob, sNd, dDatad, GetBankDate(),
     IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal), IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal),
     SalStrTrimX(sNls), sNAMAs, SalStrTrimX(sMfoa), '', nCkv, nS, SalStrTrimX(sKoka), SalStrTrimX(sNlsp),
     sNaimp, SalStrTrimX(sMfo), '', nCkv, nS, SalStrTrimX(sKokb), sText1, sVspo, GetIdOper(), '', NUMBER_Null,
     0)
.head 10 -  ! Call cDoc.SetDoc(0, 'K2A', nDk, nVob, sNd, dDatad, GetBankDate(), GetBankDate(), GetBankDate(),
     SalStrTrimX(sNls), sNAMAs, SalStrTrimX(sMfoa), '', nCkv, nS, SalStrTrimX(sKoka), SalStrTrimX(sNlsp),
     sNaimp, SalStrTrimX(sMfo), '', nCkv, nS, SalStrTrimX(sKokb), sText1, sVspo, GetIdOper(), '', NUMBER_Null,
     0)
.head 10 -  Call cDoc.SetDoc(0, 'K2A', nDk, nVob, sNd, dDatad, GetBankDate(), GetBankDate(),
     IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal), SalStrTrimX(sNls), sNAMAs, SalStrTrimX(sMfoa), '',
     nCkv, nS, SalStrTrimX(sKoka), SalStrTrimX(sNlsp), sNaimp, SalStrTrimX(sMfo), '', nCkv, nS,
     SalStrTrimX(sKokb), sText1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 +  If cDoc.oDoc()
.head 11 -  Set nRef = cDoc.m_nRef
.head 11 -  Set sNae = Left(sNaePon, 12)
.head 11 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 11 +  If SqlPrepareAndExecute(hSqlAux3(), '
   UPDATE klp
   SET    fl=7
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon')
.head 12 -  Set sOper = Right(Str(10000+nNeom), 4)
.head 12 -  Set bUIklp = SqlPrepareAndExecute(hSqlAux3(), T("
    UPDATE klpond
    SET    ref=:nRef
    WHERE  pond=:sPond and filename=:sNaex"))
.head 12 -  Set nCountUpd = 0
.head 12 -  Call SqlGetModifiedRows(hSqlAux3(), nCountUpd)
.head 12 +  If nCountUpd = 0
.head 13 -  Set bUIklp = SqlPrepareAndExecute(hSqlAux3(), T("
    INSERT
    INTO   klpond (ref,pond,filename)
    VALUES (:nRef,:sPond,:sNaex)"))
.head 12 +  If bUIklp
.head 13 -  Call SqlCommit(hSqlAux3())
.head 13 -  Call MessageNoWait('В картотеку "электронный" док.' || SalStrTrimX(sNd) || ', (Ref=' || Str(nRef) ||
     ', МФО плат.=' || sMfoa || '), Счёт плат.=' || sNls || ', МФО получ.=' || sMfo || ', Счёт получ.='
     || sNlsp || ', Сумма=' || SalNumberToStrX(nS/100, 2) || ', Получатель - ' || sNaimp ||
     ', Назначение платежа - ' || sText1, 'Сообщение', .3, 0)
.head 12 +  Else
.head 13 -  Call SqlRollback(hSqlAux3())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSqlAux3())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSqlAux3())
.head 9 +  Else
.head 10 -  ! Call cDoc.SetDoc(nRefKlp, 'K2A', nDk, nVob, sNd, dDatad, GetBankDate(),
     IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal), IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal),
     SalStrTrimX(sNls), sNAMAs, SalStrTrimX(sMfoa), '', nCkv, nS, SalStrTrimX(sKoka), SalStrTrimX(sNlsp),
     sNaimp, SalStrTrimX(sMfo), '', nCkv, nS, SalStrTrimX(sKokb), sText1, sVspo, GetIdOper(), '', NUMBER_Null,
     0)
.head 10 -  ! Call cDoc.SetDoc(nRefKlp, 'K2A', nDk, nVob, sNd, dDatad, GetBankDate(), GetBankDate(), GetBankDate(),
     SalStrTrimX(sNls), sNAMAs, SalStrTrimX(sMfoa), '', nCkv, nS, SalStrTrimX(sKoka), SalStrTrimX(sNlsp),
     sNaimp, SalStrTrimX(sMfo), '', nCkv, nS, SalStrTrimX(sKokb), sText1, sVspo, GetIdOper(), '', NUMBER_Null,
     0)
.head 10 -  Call cDoc.SetDoc(nRefKlp, 'K2A', nDk, nVob, sNd, dDatad, GetBankDate(), GetBankDate(),
     IifD(dDaVal=DATETIME_Null, GetBankDate(), dDaVal), SalStrTrimX(sNls), sNAMAs, SalStrTrimX(sMfoa), '',
     nCkv, nS, SalStrTrimX(sKoka), SalStrTrimX(sNlsp), sNaimp, SalStrTrimX(sMfo), '', nCkv, nS,
     SalStrTrimX(sKokb), sText1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  Set cDoc.m_sRef_A = Str(nRefKlp)
.head 10 +  If cDoc.sDoc()
.head 11 +  If cDoc.iDoc()
.head 12 +  If cDoc.oDoc()
.head 13 -  Set nRef = cDoc.m_nRef
.head 13 -  Set sNae = Left(sNaePon, 12)
.head 13 -  Set sPon = Str(Val(Right(sNaePon, 10)))
.head 13 +  If SqlPrepareAndExecute(hSqlAux3(), '
   UPDATE klp
   SET    fl=7
   WHERE  naex=:sNae and pond=:sPon and datad=:dNaePon')
.head 14 -  Set sOper = Right(Str(10000+nNeom), 4)
.head 14 -  Set bUIklp = SqlPrepareAndExecute(hSqlAux3(), T("
    UPDATE klpond
    SET    ref=:nRef
    WHERE  pond=:sPond and filename=:sNaex"))
.head 14 -  Set nCountUpd = 0
.head 14 -  Call SqlGetModifiedRows(hSqlAux3(), nCountUpd)
.head 14 +  If nCountUpd = 0
.head 15 -  Set bUIklp = SqlPrepareAndExecute(hSqlAux3(), T("
    INSERT
    INTO   klpond (ref,pond,filename)
    VALUES (:nRef,:sPond,:sNaex)"))
.head 14 +  If bUIklp
.head 15 -  Call SqlCommit(hSqlAux3())
.head 15 -  Call MessageNoWait('В картотеку "электронный" док.' || SalStrTrimX(sNd) || ', (Ref=' || Str(nRef) ||
     ', МФО плат.=' || sMfoa || '), Счёт плат.=' || sNls || ', МФО получ.=' || sMfo ||
     ', Счёт получ.=' || sNlsp || ', Сумма=' || SalNumberToStrX(nS/100, 2) || ', Получатель - ' ||
     sNaimp || ', Назначение платежа - ' || sText1, 'Сообщение', .3, 0)
.head 14 +  Else
.head 15 -  Call SqlRollback(hSqlAux3())
.head 13 +  Else
.head 14 -  Call SqlRollback(hSqlAux3())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSqlAux3())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSqlAux3())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSqlAux3())
.head 8 -  Set nIndex = nIndex + 1
.head 7 -  Call SalDestroyWindow(document2)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Обработать помеченные на ВОЗВРАТ, к ОПЛАТЕ и в КАРТОТЕКУ документы и выйти')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 +  Pushbutton: pbEsc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Esc
.head 4 -  Window Location and Size
.head 5 -  Left:   8.086"
.head 5 -  Top:    4.99"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Salmon
.head 4 -  Background Color: Dark Gray
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox("Вы уверены ?", "Отложить обработку", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отложить обработку с сохранением пометок')
.head 5 +  On WM_KeyDown
.head 6 -  Call ClearDok(wParam)
.head 3 -  Line
.head 4 -  Resource Id: 56328
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  5.786"
.head 5 -  Begin Y:  1.323"
.head 5 -  End X:  5.786"
.head 5 -  End Y:  2.49"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 56329
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  7.686"
.head 5 -  Begin Y:  1.323"
.head 5 -  End X:  7.686"
.head 5 -  End Y:  2.49"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 56330
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  7.686"
.head 5 -  Begin Y:  2.74"
.head 5 -  End X:  9.186"
.head 5 -  End Y:  2.74"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Frame
.head 4 -  Resource Id: 56331
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   7.886"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Solid
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: Default
.head 4 -  Background Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 56332
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  5.786"
.head 5 -  Begin Y:  1.573"
.head 5 -  End X:  9.186"
.head 5 -  End Y:  1.573"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 56333
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  5.786"
.head 5 -  Begin Y:  1.323"
.head 5 -  End X:  9.186"
.head 5 -  End Y:  1.323"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 -  Line
.head 4 -  Resource Id: 56334
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Coordinates
.head 5 -  Begin X:  5.786"
.head 5 -  Begin Y:  2.24"
.head 5 -  End X:  7.686"
.head 5 -  End Y:  2.24"
.head 4 -  Visible? Yes
.head 4 -  Line Style: Solid
.head 4 -  Line Thickness: 1
.head 4 -  Line Color: Default
.head 3 +  Data Field: dfPometka
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
.head 6 -  Left:   -0.014"
.head 6 -  Top:    0.01"
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfTxtWozw
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 40
.head 5 -  Data Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   -0.014"
.head 6 -  Top:    0.177"
.head 6 -  Width:  3.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 8
.head 5 -  Font Enhancement: Bold-Italic
.head 5 -  Text Color: Red
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfDaval
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
.head 6 -  Left:   1.886"
.head 6 -  Top:    0.51"
.head 6 -  Width:  2.529"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Fixedsys
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Royal Blue
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfDAVAL
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
.head 6 -  Left:   4.586"
.head 6 -  Top:    0.51"
.head 6 -  Width:  1.286"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Center
.head 5 -  Format: dd/MM/yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Royal Blue
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: dfR
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
.head 6 -  Left:   5.986"
.head 6 -  Top:    0.51"
.head 6 -  Width:  0.4"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Fixedsys
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Royal Blue
.head 5 -  Background Color: Gray
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: DokNaePon
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  String: sNaePon1
.head 5 -  Date/Time: dNaePon1
.head 5 -  Boolean: bBadData
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sNae1
.head 5 -  String: sPon1
.head 4 +  Actions
.head 5 -  Set sNae1 = Left(sNaePon1, 12)
.head 5 -  Set sPon1 = Str(Val(Right(sNaePon1, 10)))
.head 5 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT naex,nd,datad,nls,mfo,naimp,nlsp,s/100,fl,text1,kokb,koka,koko,prwo,kv,vob,daval,naimo,
            substr(nvl(mfoa,:AMFO),1,12)
     INTO   :sNaex,:sNd,:dDatad,:sNls,:sMfo,:sNaimp,:sNlsp,:nS,:nFl,:sText1,:sKokb,:sKoka,:sKoko,:sPrwo,:nKv,:nVob,
            :dDaVal,:sNaimo,:sMfoa
     FROM   klp
     WHERE  naex=:sNae1 and pond=:sPon1 and datad=:dNaePon1")
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 +  If not DopustMfo(sMfoa) and nFl != 1
.head 6 -  Set sPrwo = '*Недопустимое МФО плательщика'
.head 6 -  Set nFl = 1
.head 5 +  If not DopustMfo(sMfo) and nFl != 1
.head 6 -  Set sPrwo = '*Недопустимое МФО получателя'
.head 6 -  Set nFl = 1
.head 5 +  ! Else If (dDatad > GetBankDate() or dDatad+10 < GetBankDate()) and nFl = 0 and bBadData
.head 6 -  Set sPrwo = 'Ошибка даты документа'
.head 6 -  Set nFl = 1
.head 5 +  Else If (dDatad > GetBankDate() or dDatad+30 < GetBankDate()) and nFl = 0 and bBadData
.head 6 -  Set sPrwo = 'Ошибка даты документа'
.head 6 -  Set nFl = 1
.head 5 +  If Left(sNaex, 1) = 'D'
.head 6 +  If nVob = 1 or nVob = 6
.head 7 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a, customer c
     WHERE  a.nls=:sNls and a.kv=:nKv and c.rnk=a.rnk and c.sab is not null and
            c.sab=substr(:sNaex,8,1)||substr(:sNaex,-3) and a.acc=i.acc and nvl(i.pers,0)=1"))
.head 7 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 8 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a, customer c, klp_top k
     WHERE  a.nls=:sNls and a.kv=:nKv and k.rnk=a.rnk and k.rnkp=c.rnk and c.sab is not null and
            c.sab=substr(:sNaex,8,1)||substr(:sNaex,-3) and a.acc=i.acc and nvl(i.high,0)=1"))
.head 8 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 9 -  Set sPrwo = '*Запрет на дебет счёта ' || sNls
.head 9 -  Set nFl = 1
.head 6 +  Else
.head 7 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a, customer c
     WHERE  a.nls=:sNlsp and a.kv=:nKv and c.rnk=a.rnk and c.sab is not null and
            c.sab=substr(:sNaex,8,1)||substr(:sNaex,-3) and a.acc=i.acc and nvl(i.pers,0)=1"))
.head 7 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 8 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a, customer c, klp_top k
     WHERE  a.nls=:sNlsp and a.kv=:nKv and k.rnk=a.rnk and k.rnkp=c.rnk and c.sab is not null and
            c.sab=substr(:sNaex,8,1)||substr(:sNaex,-3) and a.acc=i.acc and nvl(i.high,0)=1"))
.head 8 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 9 -  Set sPrwo = '*Запрет на дебет счёта ' || sNlsp
.head 9 -  Set nFl = 1
.head 5 +  Else
.head 6 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a
     WHERE  a.nls=:sNls and a.kv=:nKv and a.acc=i.acc"))
.head 6 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 7 -  Set sPrwo = '*Запрет на дебет счёта ' || sNls
.head 7 -  Set nFl = 1
.head 5 +  If nFl = 1
.head 6 +  If SqlPrepareAndExecute(hSqlAux2(), "
   UPDATE klp
   SET    fl=1,prwo=:sPrwo
   WHERE  naex=:sNae1 and pond=:sPon1 and datad=:dNaePon1")
.head 7 -  Call SqlCommit(hSqlAux2())
.head 6 +  Else
.head 7 -  Call SqlRollback(hSqlAux2())
.head 5 -  Set sKv = GetLcv(nKv)
.head 5 -  Call SalSetWindowText(hWndForm, ' (' || Str(nI+1) || ' из ' || Str(nKwo+1) || ') ' || IifS(nKwo=0, 'Единственный д',
     IifS(nI=0, 'Первый д', IifS(nI=nKwo, 'Последний д', 'Д'))) || 'окумент N°' || sNd)
.head 5 -  Set dfPometka = ''
.head 5 -  Set dfTxtWozw = ''
.head 5 -  Call SalColorSet(dfPometka, COLOR_IndexWindowText, COLOR_Gray)
.head 5 +  If nFl = 2
.head 6 -  Set dfPometka = 'к ОПЛАТЕ'
.head 6 -  Call SalColorSet(dfPometka, COLOR_IndexWindowText, COLOR_DarkGreen)
.head 5 +  Else If nFl = 1
.head 6 -  Set dfPometka = 'на ВОЗВРАТ'
.head 6 -  Call SalColorSet(dfPometka, COLOR_IndexWindowText, COLOR_Red)
.head 6 -  Set dfTxtWozw = '(' || sPrwo || ')'
.head 5 +  Else If nFl = 3
.head 6 -  Set dfPometka = 'в КАРТОТЕКУ'
.head 6 -  Call SalColorSet(dfPometka, COLOR_IndexWindowText, COLOR_Blue)
.head 5 +  If nVob = 1 or nVob = 0 or nVob = 6
.head 6 -  Set dftitle = 'Платіжне доручення'
.head 6 -  Set sKODO = '0410001'
.head 5 +  Else If nVob = 2
.head 6 -  Set dftitle = 'Платіжна вимога-доручення'
.head 6 -  Set sKODO = '0410002'
.head 5 +  Else If nVob = 3
.head 6 -  Set dftitle = 'Платіжна вимога'
.head 6 -  Set sKODO = '0410007'
.head 5 +  Else If nVob = 7
.head 6 -  Set dftitle = 'Реєстр чеків'
.head 6 -  Set sKODO = '0401007'
.head 5 -  Set dfND = SalStrTrimX(sNd)
.head 5 -  Set dfDATA = dDatad
.head 5 +  If dDaVal = DATETIME_Null
.head 6 -  Call SalHideWindow(dfDaval)
.head 6 -  Call SalHideWindow(dfDAVAL)
.head 6 -  Call SalHideWindow(dfR)
.head 5 +  Else
.head 6 -  Call SalShowWindow(dfDaval)
.head 6 -  Call SalShowWindow(dfDAVAL)
.head 6 -  Call SalShowWindow(dfR)
.head 6 -  Set dfDAVAL = dDaVal
.head 5 +  If Len(sNaimo) = 0
.head 6 -  Set dfNAMA = GetValueStr("
    SELECT nvl(c.nmkk,c.nmk)
    FROM   customer c, accounts a
    WHERE  a.nls='" || sNls || "' and  a.kv=" || Str(nKv) || " and c.rnk=a.rnk")
.head 6 +  If Len(dfNAMA) = 0
.head 7 -  Set dfNAMA = 'Плательщик не идентифицирован'
.head 5 +  Else
.head 6 -  Set dfNAMA = sNaimo
.head 5 -  ! Set dfBANKA = GetBankName()
.head 5 -  Set dfBANKA = GetValueStr('
    SELECT nb
    FROM   banks
    WHERE  mfo=' || sMfoa)
.head 5 +  If Len(dfBANKA) = 0
.head 6 -  Set dfBANKA = 'Банк с МФО ' || sMfoa
.head 5 -  ! Set dfMFOA = GetBankMfo()
.head 5 -  Set dfMFOA = sMfoa
.head 5 -  Set dfNAMB = sNaimp
.head 5 -  Set dfBANKB = GetValueStr('
    SELECT nb
    FROM   banks
    WHERE  mfo=' || sMfo)
.head 5 +  If Len(dfBANKB) = 0
.head 6 -  Set dfBANKB = 'Банк с МФО ' || sMfo
.head 5 -  Set dfMFOB = sMfo
.head 5 -  Set dfS = nS
.head 5 -  Set dfCodeCurrency = GetLcv(nKv) !! 'UAH'
.head 5 -  Set dfNLSA = sNls
.head 5 -  Set dfNLSB = sNlsp
.head 5 +  If nKv = 980
.head 6 -  Set mlSumPr = SumPr(nS*100, 'F', 'грн', 'коп.')
.head 5 +  Else
.head 6 -  Set mlSumPr = SumPr(nS*100, 'F', dfCodeCurrency, 'hun')
.head 5 -  Set mlNAZN = sText1
.head 5 -  Set dfKODA = sKoka
.head 5 -  Set dfKODB = sKokb
.head 5 -  Set dfKODDOK = sKODO
.head 5 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT ostc
     INTO   :nOstc
     FROM   accounts
     WHERE  nls=:sNls and kv=:nKv"))
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set dfOstc = nOstc/100
.head 5 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT sum(s)
     INTO   :nKoplate
     FROM   klp
     WHERE  nls=:sNls and kv=:nKv and eom=:nAN and fl=2 and vob<>3"))
.head 5 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set dfOstcWithO = dfOstc - nKoplate/100
.head 5 -  Call SalColorSet(dfOstcWithO, COLOR_IndexWindowText, IifN(dfOstcWithO<0, COLOR_Red, COLOR_DarkGreen))
.head 5 +  If nVob = 3
.head 6 -  Call SalHideWindow(dfOstcWithO)
.head 5 +  Else
.head 6 -  Call SalShowWindow(dfOstcWithO)
.head 3 +  Function: ClearDok
.head 4 -  Description:
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Number: nwParam
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If (nI = 0 and (nwParam = 33 or nwParam = 36)) or (nI = nKwo and (nwParam = 34 or nwParam = 35)) or nwParam < 33 or
   nwParam > 36
.head 6 -  ! никуда не двигаться
.head 5 +  Else
.head 6 -  Call EraseDok()
.head 6 +  If nwParam = 33      !! PgUp
.head 7 -  Call SalSendMsg(pbUp, SAM_Click, 0, 0)
.head 6 +  Else If nwParam = 34 !! PgDn
.head 7 -  Call SalSendMsg(pbDown, SAM_Click, 0, 0)
.head 6 +  Else If nwParam = 35 !! End
.head 7 -  Call SalSendMsg(pbEnd, SAM_Click, 0, 0)
.head 6 +  Else If nwParam = 36 !! Home
.head 7 -  Call SalSendMsg(pbHome, SAM_Click, 0, 0)
.head 3 +  Function: EraseDok
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set dfND = ''
.head 5 -  Set dfDATA = DATETIME_Null
.head 5 -  Set dfNAMA = ''
.head 5 -  Set dfBANKA = ''
.head 5 -  Set dfMFOA = ''
.head 5 -  Set dfNAMB = ''
.head 5 -  Set dfBANKB = ''
.head 5 -  Set dfMFOB = ''
.head 5 -  Set dfS = NUMBER_Null
.head 5 -  Set dfCodeCurrency = ''
.head 5 -  Set dfNLSA = ''
.head 5 -  Set dfNLSB = ''
.head 5 -  Set mlSumPr = ''
.head 5 -  Set mlNAZN = ''
.head 5 -  Set dfKODDOK = ''
.head 5 -  Set dfKODA = ''
.head 5 -  Set dfKODB = ''
.head 5 -  Set dfOstc = NUMBER_Null
.head 5 -  Set dfOstcWithO = NUMBER_Null
.head 5 -  ! Set dfTxtWozw = ''
.head 5 -  ! Set dfPometka = ''
.head 2 +  Window Parameters
.head 3 -  String: sSab0
.head 3 -  String: sNmk0
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  String: sDevice
.head 3 -  String: sDriver
.head 3 -  String: sPort
.head 3 -  String: srrr[*]
.head 3 -  Date/Time: drrr[*]
.head 3 -  Number: nKwo
.head 3 -  Number: nI
.head 3 -  String: sNaex
.head 3 -  String: sNd
.head 3 -  Date/Time: dDatad
.head 3 -  String: sNls
.head 3 -  String: sMfo
.head 3 -  String: sMfoa
.head 3 -  String: sNaimp
.head 3 -  String: sNlsp
.head 3 -  Number: nS
.head 3 -  Number: nFl
.head 3 -  String: sText1
.head 3 -  String: sKokb
.head 3 -  String: sKoka
.head 3 -  String: sKoko
.head 3 -  String: sPrwo
.head 3 -  String: sKv
.head 3 -  Number: nKv
.head 3 -  Number: nVob
.head 3 -  !
.head 3 -  ! String: sRowid
.head 3 -  String: sNaePon
.head 3 -  Date/Time: dNaePon
.head 3 -  String: sPon
.head 3 -  String: sNae
.head 3 -  String: sKODO
.head 3 -  !
.head 3 -  Number: nOstc
.head 3 -  Number: nKoplate
.head 3 -  !
.head 3 -  Number: nT
.head 3 -  ! String: sRowidT
.head 3 -  String: sNaePonT
.head 3 -  Date/Time: dNaePonT
.head 3 -  !
.head 3 -  Number: nNeom
.head 3 -  String: sPond
.head 3 -  Number: nCkv
.head 3 -  String: sOper
.head 3 -  String: AMFO
.head 3 -  String: sMaket
.head 3 -  String: sNAMAs
.head 3 -  String: sNAMBs
.head 3 -  String: sVspo
.head 3 -  ! Long String: lsSign
.head 3 -  Number: nRef
.head 3 -  Number: nDk
.head 3 -  !
.head 3 -  : cDoc
.head 4 -  Class: cDoc
.head 3 -  !
.head 3 -  ! String: ssRowid[*]
.head 3 -  String: ssNaePon[*]
.head 3 -  Number: nnRefKlp[*]
.head 3 -  Number: nRefKlp
.head 3 -  Number: nnFl[*]
.head 3 -  Number: nnNeom[*]
.head 3 -  Number: nnS[*]
.head 3 -  String: ssNls[*]
.head 3 -  String: ssMfo[*]
.head 3 -  String: ssMfoa[*]
.head 3 -  String: ssNlsp[*]
.head 3 -  String: ssNaimp[*]
.head 3 -  String: ssNd[*]
.head 3 -  String: ssText1[*]
.head 3 -  String: ssPond[*]
.head 3 -  String: ssPrwo[*]
.head 3 -  String: ssNaex[*]
.head 3 -  Number: nnCkv[*]
.head 3 -  String: ssKokb[*]
.head 3 -  Number: nnVob[*]
.head 3 -  Date/Time: ddDatad[*]
.head 3 -  String: ssKoka[*]
.head 3 -  !
.head 3 -  Number: nIndex
.head 3 -  Number: nElemCount
.head 3 -  !
.head 3 -  ! Boolean: bSberBank
.head 3 -  !
.head 3 -  Number: nMaket
.head 3 -  !
.head 3 -  ! Number: nAcc
.head 3 -  ! Number: nOSTB
.head 3 -  ! Number: nOSTB8
.head 3 -  !
.head 3 -  String: sTmp
.head 3 -  ! Boolean: bRoll
.head 3 -  !
.head 3 -  Date/Time: dDaVal
.head 3 -  Date/Time: ddDaVal[*]
.head 3 -  !
.head 3 -  Boolean: bUIklp
.head 3 -  Number: nCountUpd
.head 3 -  !
.head 3 -  String: sNaimo
.head 3 -  !
.head 3 -  Number: nVobBars
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndItem)
.head 4 -  Set AMFO = GetBankMfo()
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_Green)
.head 4 -  Call XSalTooltipSetDelay(200, 30000)
.head 4 -  ! Set bSberBank = GetBankMfo()='300465'
.head 4 +  ! If SqlPrepareAndExecute(hSql(), "
   SELECT val
   INTO   :sTmp
   FROM   params
   WHERE  par='KL_BOB'")
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set bSberBank = sTmp='1'
.head 4 -  Set dfOstatokNLS = 'Сумма на счёте'
.head 4 -  Set dfSummaWithO = 'С учетом д-тов'
.head 4 -  Set dfDaval = 'Дата валютування'
.head 4 -  Set dfR = 'р.'
.head 4 +  ! If bSberBank
.head 5 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT naex || SUBSTR('0000000000' || pond, -10),datad
     INTO   :sNaePon,:dNaePon
     FROM   klp
     WHERE  eom=:nAN and fl<7 and SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0
     ORDER BY naex || SUBSTR('0000000000' || pond, -10)")
.head 4 +  ! Else
.head 5 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT naex || SUBSTR('0000000000' || pond, -10),datad
     INTO   :sNaePon,:dNaePon
     FROM   klp
     WHERE  eom=:nAN and fl<7 and SUBSTR(naex,3,4)=:sSab0
     ORDER BY naex || SUBSTR('0000000000' || pond, -10)")
.head 4 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT k.naex || SUBSTR('0000000000' || k.pond, -10),k.datad
     INTO   :sNaePon,:dNaePon
     FROM   klp k, customer c
     WHERE  (k.eom=:nAN and k.fl<7 and SUBSTR(k.naex,3,4)=:sSab0 and c.sab=:sSab0 and c.stmt=6) or
            (k.eom=:nAN and k.fl<7 and SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0 and c.sab=:sSab0 and c.stmt=5)
     ORDER BY k.naex || SUBSTR('0000000000' || k.pond, -10)")
.head 4 -  Set nI = 0
.head 4 +  While SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set srrr[nI] = sNaePon
.head 5 -  Set drrr[nI] = dNaePon
.head 5 -  Set nI = nI + 1
.head 4 -  Set nKwo = nI - 1
.head 4 -  Set nI = 0
.head 4 -  Set sNaePon = srrr[0]
.head 4 -  Set dNaePon = drrr[0]
.head 4 -  Call DokNaePon(sNaePon, dNaePon, TRUE)
.head 4 -  Call SalDisableWindow(pbF6)
.head 4 -  Call SalSetFocus(pbDown)
.head 3 +  On SAM_Destroy
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
.head 4 -  Call XSalTooltipSetDelay(200, 4000)
.head 1 +  Dialog Box: getSumma
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Введите сумму
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   7.583"
.head 4 -  Top:    1.156"
.head 4 -  Width:  2.943"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 0.667"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Arial Cyr
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold-Italic
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: ввод суммы документа для поиска
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.262"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Data Field: df1
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
.head 6 -  Left:   0.086"
.head 6 -  Top:    0.073"
.head 6 -  Width:  2.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: ###000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  ! On SAM_Validate
.head 6 -  Set nGetSum = df1
.head 6 -  Return VALIDATE_Ok
.head 6 -  Call SalEndDialog(getSumma, 0)
.head 5 +  On WM_Char
.head 6 -  ! Call DebugN(wParam)
.head 6 +  ! If wParam = 10 or wParam = 13
.head 7 -  Set nGetSum = df1
.head 7 -  Call SalEndDialog(getSumma, 1)
.head 6 +  If wParam = 27
.head 7 -  ! Set nGetSum = 0
.head 7 -  Call SalEndDialog(getSumma, 0)
.head 3 +  Pushbutton: pb1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ok
.head 4 -  Window Location and Size
.head 5 -  Left:   2.386"
.head 5 -  Top:    0.073"
.head 5 -  Width:  0.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nGetSum = df1
.head 6 -  Call SalEndDialog(getSumma, 1)
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set df1 = nGetSum
.head 1 +  Dialog Box: dlg_klp
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
.head 4 -  Left:   0.25"
.head 4 -  Top:    0.156"
.head 4 -  Width:  13.333"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.833"
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
.head 3 +  Pushbutton: pbF3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Возвратить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    1.738"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F3
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf3_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 +  If SalModalDialog(wozwrat, hWndForm) != -1
.head 8 -  Set nRow = TBL_MinRow
.head 8 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 9 -  Call SalTblFetchRow(tbl2, nRow)
.head 9 +  If (tbl2.cfl = NUMBER_Null or tbl2.cfl = 0) and Len(SalStrTrimX(sWW)) > 0
.head 10 -  Set tbl2.colow = 'W'
.head 10 -  Set tbl2.cfl = 1
.head 10 -  Set tbl2.cprwo = sWW
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call VisTblAutoSizeColumn(tbl2, hWndNULL)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить на возврат выбранные документы')
.head 3 +  Pushbutton: pbF4
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: К оплате
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    2.238"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F4
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf4_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cfl = NUMBER_Null or tbl2.cfl = 0
.head 9 -  Set tbl2.colow = 'O'
.head 9 -  Set tbl2.cfl = 2
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить выбранные документы к оплате')
.head 3 +  Pushbutton: pbF6
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: В картотеку
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    2.738"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F6
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf6_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cfl = NUMBER_Null or tbl2.cfl = 0
.head 9 -  Set tbl2.colow = 'K'
.head 9 -  Set tbl2.cfl = 3
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить выбранные документы в картотеку')
.head 3 +  Pushbutton: pbF5
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Печать
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    3.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F5
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf5_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Set nckv = Val(tbl2.ckv)
.head 8 +  If Len(tbl2.cnaimo) = 0
.head 9 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nvl(c.nmkk,c.nmk)
     INTO   :d_NAMAs
     FROM   customer c, accounts a
     WHERE  a.nls=:tbl2.cnls and a.kv=:nckv and c.rnk=a.rnk'))
.head 9 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 10 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 8 +  Else
.head 9 -  Set d_NAMAs = tbl2.cnaimo
.head 8 -  Set nDk = IifN(tbl2.cvob=0 or tbl2.cvob=1 or tbl2.cvob=6 or tbl2.cvob=2 or tbl2.cvob=4, 1, 2)
.head 8 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nb
     INTO   :d_BNK_Bs
     FROM   banks
     WHERE  mfo=:tbl2.cmfo'))
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set d_BNK_Bs = 'Банк с МФО ' || SalStrTrimX(tbl2.cmfo)
.head 8 -  !
.head 8 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nb
     INTO   :d_BNK_As
     FROM   banks
     WHERE  mfo=:tbl2.cmfoa'))
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set d_BNK_As = 'Банк с МФО ' || SalStrTrimX(tbl2.cmfoa)
.head 8 -  Call DocsPrintFromParam(0, Val(tbl2.ckv), tbl2.cvob, tbl2.cnd, tbl2.cmfoa, tbl2.ckoka, d_BNK_As, tbl2.cnls,
     d_NAMAs, tbl2.cs*100, NUMBER_Null, nDk, tbl2.cmfo, tbl2.ckokb, d_BNK_Bs, tbl2.cnlsp, tbl2.cnaimp,
     Val(tbl2.ckv), tbl2.cs*100, tbl2.ctext1, tbl2.cdatad, PRINT_DOC)
.head 8 -  ! Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отпечатать текущий документ')
.head 3 +  Pushbutton: pbF7
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Поиск
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    3.821"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F7
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf7_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nTipPoisk = SalModalDialog(poisk, hWndForm)
.head 6 +  If nTipPoisk = 1
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 8 -  Call SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 7 +  Else
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cs = nGetSum
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If not nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 6 +  Else If nTipPoisk = 2
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If NOT SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'O'
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If not nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 6 +  Else If nTipPoisk = 3
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If NOT SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'W'
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If NOT nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Поиск документа от текущей позиции вниз')
.head 3 +  Pushbutton: pbF8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Снять отметку
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    4.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F8
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf8_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If (tbl2.cfl = 1 and Left(tbl2.cprwo, 1) != '*') or tbl2.cfl = 2 or tbl2.cfl = 3
.head 9 -  Set tbl2.colow = ' '
.head 9 -  Set tbl2.cfl = 0
.head 9 -  Set tbl2.cprwo = ''
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Сбросить пометки с выбранных документов')
.head 3 +  Pushbutton: pbF9
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Документ
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    4.821"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F9
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf9_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 +  If tbl2.cvob = 1 or tbl2.cvob = 0 or tbl2.cvob = 6
.head 8 -  Set df_titles = 'Платіжне доручення'
.head 8 -  Set sKODO = '0410001'
.head 7 +  If tbl2.cvob = 2
.head 8 -  Set df_titles = 'Платіжна вимога-доручення'
.head 8 -  Set sKODO = '0410002'
.head 7 +  If tbl2.cvob = 3
.head 8 -  Set df_titles = 'Платіжна вимога'
.head 8 -  Set sKODO = '0410007'
.head 7 +  If tbl2.cvob = 7
.head 8 -  Set sKODO='0401007'
.head 8 -  Set df_titles = 'Реєстр чеків'
.head 7 -  Set d_MFOAs = tbl2.cmfoa
.head 7 -  Set nckv = Val(tbl2.ckv)
.head 7 +  If Len(tbl2.cnaimo) = 0
.head 8 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nvl(c.nmkk,c.nmk)
     INTO   :d_NAMAs
     FROM   customer c, accounts a
     WHERE  a.nls=:tbl2.cnls and a.kv=:nckv and c.rnk=a.rnk'))
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 7 +  Else
.head 8 -  Set d_NAMAs = tbl2.cnaimo
.head 7 -  ! Set d_BNK_As = GetBankName()
.head 7 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nb
     INTO   :d_BNK_As
     FROM   banks
     WHERE  mfo=:tbl2.cmfoa'))
.head 7 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set d_BNK_As = 'Банк с МФО ' || tbl2.cmfoa
.head 7 -  !
.head 7 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nb
     INTO   :d_BNK_Bs
     FROM   banks
     WHERE  mfo=:tbl2.cmfo'))
.head 7 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set d_BNK_Bs = 'Банк с МФО ' || tbl2.cmfo
.head 7 -  ! Set dfCodeCurrencys = 'UAH'
.head 7 -  Set dfCodeCurrencys = GetLcv(Val(tbl2.ckv))
.head 7 -  Set d_Ss = tbl2.cs*100
.head 7 +  If Val(tbl2.ckv) = 980
.head 8 -  Set ml_SumPrs = SumPr(d_Ss, 'F', 'грн', 'коп.')
.head 7 +  Else
.head 8 -  Set ml_SumPrs = SumPr(d_Ss, 'F', dfCodeCurrencys, 'hun')
.head 7 -  Call SalModalDialog(document, hWndForm, df_titles, tbl2.cnd, tbl2.cdatad, d_NAMAs, d_BNK_As, d_MFOAs, tbl2.cnaimp,
     d_BNK_Bs, tbl2.cmfo, tbl2.cs, dfCodeCurrencys, tbl2.cnls, tbl2.cnlsp, ml_SumPrs, tbl2.ctext1, tbl2.ckoka,
     tbl2.ckokb, sKODO, tbl2.cdaval)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Просмотр выбранного документа')
.head 3 +  Pushbutton: pb10
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обработать
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    5.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F10
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold-Italic
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf10_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox("Вы уверены ?", "Обработать и выйти", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 -  Call SalDisableWindow(pbF3)
.head 7 -  Call SalDisableWindow(pbF4)
.head 7 -  Call SalDisableWindow(pbF5)
.head 7 -  ! Call SalDisableWindow(pbF6)
.head 7 -  Call SalDisableWindow(pbF7)
.head 7 -  Call SalDisableWindow(pbF8)
.head 7 -  Call SalDisableWindow(pbF9)
.head 7 -  Call SalDisableWindow(pb10)
.head 7 -  Call SalDisableWindow(pbEsc)
.head 7 -  Set bX = FALSE
.head 7 +  If SalTblAnyRows(tbl2, ROW_Edited, 0)
.head 8 +  If SqlPrepare(hSql(), '
   UPDATE klp
   SET    prwo=:tbl2.cprwo,fl=:tbl2.cfl
   WHERE  naex=:tbl2.cnaex and pond=:tbl2.cpond and datad=:tbl2.cdatad and fl<4')
.head 9 -  Call SalTblDoUpdates(tbl2, hSql(), TRUE)
.head 9 -  Call SqlCommit(hSql())
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 8 -  Call SalTblSetContext(tbl2, nRow)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'W' ! возвратить
.head 9 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klp
   SET    fl=9
   WHERE  naex=:tbl2.cnaex and pond=:tbl2.cpond and datad=:tbl2.cdatad and fl<4')
.head 10 -  Set nCountUpd = 0
.head 10 -  Call SqlGetModifiedRows(hSql(), nCountUpd)
.head 10 +  If nCountUpd = 1
.head 11 -  Set sSab = Subs(tbl2.cnaex, 8, 1) || Right(tbl2.cnaex, 3)
.head 11 +  If GetValueStr("
   SELECT to_char(nvl(stmt,0))
   FROM   customer
   WHERE  sab='"||sSab||"'")!='5'
.head 12 -  Set sSab = Subs(tbl2.cnaex, 3, 4)
.head 11 -  Set sOper = Right(Str(10000+tbl2.ceom), 4)
.head 11 -  Set n100 = tbl2.cs*100
.head 11 +  If SqlPrepareAndExecute(hSql(), T("
   INSERT
   INTO   klpoow (sab,oper,mfoa,nlsa,mfob,nlsb,namb,s,nd,nazn,pond,prwo,nfia,tip)
   VALUES (:sSab,:sOper,:tbl2.cmfoa,:tbl2.cnls,:tbl2.cmfo,:tbl2.cnlsp,:tbl2.cnaimp,:n100,:tbl2.cnd,
           :tbl2.ctext1,:tbl2.cpond,:tbl2.cprwo,:tbl2.cnaex,'W')"))
.head 12 -  Call SqlCommit(hSql())
.head 12 -  Call SalTblSetContext(tbl2, nRow)
.head 12 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 12 -  Set tbl2.colow = 'w'
.head 12 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_Salmon)
.head 12 -  Call MessageNoWait('Возвращен "электронный" док.' || SalStrTrimX(tbl2.cnd) || '), МФО плат.=' ||
     tbl2.cmfoa || ', Счёт плат.=' || tbl2.cnls || ', МФО получ.=' || tbl2.cmfo || ', Счёт получ.=' ||
     tbl2.cnlsp || ', Сумма=' || SalNumberToStrX(tbl2.cs, 2) || ', Получатель - ' || tbl2.cnaimp ||
     ', Назначение платежа - ' || tbl2.ctext1, 'Сообщение', .1, 0)
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 8 +  Else If tbl2.colow = 'O' ! к оплате
.head 9 -  Set sMaket = IifS(tbl2.cvob=3, '3', IifS(SalStrTrimX(tbl2.cmfo)=AMFO, '1', '2'))
.head 9 -  Set nDk = Max(1,Val(sMaket)-1)
.head 9 -  Set nVobBars = IifN(tbl2.cvob=3, 7, IifN(tbl2.cvob=6, 6, 1))
.head 9 -  Set nckv = Val(tbl2.ckv)
.head 9 -  ! Set nAcc = 0
.head 9 -  ! Set nOSTB = 0
.head 9 -  !
.head 9 -  Set d_NAMAs = tbl2.cnaimo
.head 9 +  If Len(d_NAMAs) = 0
.head 10 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 10 +  If tbl2.cvob = 1 or tbl2.cvob = 6
.head 11 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT nvl(c.nmkk,c.nmk)
   INTO   :d_NAMAs
   FROM   customer c, accounts a
   WHERE  a.nls=:tbl2.cnls and a.kv=:nckv and c.rnk=a.rnk'))
.head 12 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 10 +  Else
.head 11 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT nvl(c.nmkk,c.nmk)
   INTO   :d_NAMAs
   FROM   customer c, accounts a
   WHERE  a.nls=:tbl2.cnlsp and a.kv=:nckv and c.rnk=a.rnk'))
.head 12 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  !
.head 9 +  ! If SqlPrepareAndExecute(hSql(), T('
   SELECT a.acc,a.ostb
   INTO   :nAcc,:nOSTB
   FROM   accounts a
   WHERE  a.nls=:tbl2.cnls and a.kv=:nckv'))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  !
.head 9 -  ! Set sVspo = IifS(tbl2.cdaval=DATETIME_Null, '', '#D' || SalFmtFormatDateTime(tbl2.cdaval, 'yyMMdd') || '#')
.head 9 -  Set sVspo = tbl2.cvspo
.head 9 -  ! Set bRoll = FALSE
.head 9 +  ! If nOSTB < tbl2.cs*100
.head 10 -  ! Лимит
.head 10 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT a8.ostb
   INTO   :nOSTB8
   FROM   accounts a8, v862 v
   WHERE  v.acc6=:nAcc and v.acc8=a8.acc and a8.ostb>0'))
.head 11 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 12 -  Set nOSTB8 = 0
.head 10 +  Else 
.head 11 -  Set bRoll = TRUE
.head 10 +  If nOSTB+nOSTB8 >= tbl2.cs*100
.head 11 -  ! Лимит есть
.head 11 -  Set sMaket = Str(Val(sMaket)+2)
.head 10 +  Else 
.head 11 -  ! Лимита нет, ждите поступлений
.head 9 -  ! If not bRoll
.head 9 -  Set nFltek = 0
.head 9 +  If SqlPrepareAndExecute(hSql(), '
   SELECT fl
   INTO   :nFltek
   FROM   klp
   WHERE  naex=:tbl2.cnaex and pond=:tbl2.cpond')
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  ! поставить If fl по документу = еще 2, то обрабатывать, иначе - нет
.head 9 +  If nFltek = 2
.head 10 +  If tbl2.crefKLP = NUMBER_Null
.head 11 -  ! Call cDoc.SetDoc(0, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, tbl2.cnd,
     tbl2.cdatad, GetBankDate(), IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval), IifS(nDk=1, tbl2.cnls, tbl2.cnlsp),
     IifS(nDk=1, d_NAMAs, tbl2.cnaimp), IifS(nDk=1, tbl2.cmfoa, tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckoka, tbl2.ckokb), IifS(nDk=1, tbl2.cnlsp, tbl2.cnls),
     IifS(nDk=1, tbl2.cnaimp, d_NAMAs), IifS(nDk=1, tbl2.cmfo, tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckokb, tbl2.ckoka), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 11 -  ! Call cDoc.SetDoc(0, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, tbl2.cnd,
     tbl2.cdatad, GetBankDate(), GetBankDate(), GetBankDate(), IifS(nDk=1, tbl2.cnls, tbl2.cnlsp),
     IifS(nDk=1, d_NAMAs, tbl2.cnaimp), IifS(nDk=1, tbl2.cmfoa, tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckoka, tbl2.ckokb), IifS(nDk=1, tbl2.cnlsp, tbl2.cnls),
     IifS(nDk=1, tbl2.cnaimp, d_NAMAs), IifS(nDk=1, tbl2.cmfo, tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckokb, tbl2.ckoka), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 11 -  Call cDoc.SetDoc(0, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars, tbl2.cnd,
     tbl2.cdatad, GetBankDate(), GetBankDate(), IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval),
     IifS(nDk=1, tbl2.cnls, tbl2.cnlsp), IifS(nDk=1, d_NAMAs, tbl2.cnaimp),
     IifS(nDk=1, tbl2.cmfoa, tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckoka, tbl2.ckokb), IifS(nDk=1, tbl2.cnlsp, tbl2.cnls),
     IifS(nDk=1, tbl2.cnaimp, d_NAMAs), IifS(nDk=1, tbl2.cmfo, tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckokb, tbl2.ckoka), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 11 +  If cDoc.oDoc()
.head 12 -  Set nRef = cDoc.m_nRef
.head 12 -  Call SalTblSetContext(tbl2, nRow)
.head 12 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 12 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klp
   SET    fl=8
   WHERE  naex=:tbl2.cnaex and pond=:tbl2.cpond and datad=:tbl2.cdatad and fl<4')
.head 13 -  Set nCountUpd = 0
.head 13 -  Call SqlGetModifiedRows(hSql(), nCountUpd)
.head 13 +  If nCountUpd = 1
.head 14 -  Set sSab = Subs(tbl2.cnaex, 8, 1) || Right(tbl2.cnaex, 3)
.head 14 +  If GetValueStr("
   SELECT to_char(nvl(stmt,0))
   FROM   customer
   WHERE  sab='"||sSab||"'")!='5'
.head 15 -  Set sSab = Subs(tbl2.cnaex, 3, 4)
.head 14 -  Set sOper = Right(Str(10000+tbl2.ceom), 4)
.head 14 -  Set bUIklp = SqlPrepareAndExecute(hSql(), T("
    UPDATE klpond
    SET    ref=:nRef
    WHERE  pond=:tbl2.cpond and filename=:tbl2.cnaex"))
.head 14 -  Set nCountUpd = 0
.head 14 -  Call SqlGetModifiedRows(hSql(), nCountUpd)
.head 14 +  If nCountUpd = 0
.head 15 -  Set bUIklp = SqlPrepareAndExecute(hSql(), T("
    INSERT
    INTO   klpond (ref,pond,filename)
    VALUES (:nRef,:tbl2.cpond,:tbl2.cnaex)"))
.head 14 +  If bUIklp
.head 15 -  Call SqlCommit(hSql())
.head 15 -  Set tbl2.colow = 'o'
.head 15 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightGreen)
.head 15 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(tbl2.cnd) || ', (Ref=' || Str(nRef)
     || ', МФО плат.=' || tbl2.cmfoa || '), Счёт плат.=' || tbl2.cnls || ', МФО получ.=' ||
     tbl2.cmfo || ', Счёт получ.=' || tbl2.cnlsp || ', Сумма=' || SalNumberToStrX(tbl2.cs, 2) ||
     ', Получатель - ' || tbl2.cnaimp || ', Назначение платежа - ' || tbl2.ctext1, 'Сообщение',
     .1, 0)
.head 14 +  Else
.head 15 -  Call SqlRollback(hSql())
.head 13 +  Else
.head 14 -  Call SqlRollback(hSql())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.SetDoc(ref==>' || Str(tbl2.crefKLP) || ')')
.head 11 -  ! Call cDoc.SetDoc(tbl2.crefKLP, 'KL' || sMaket, nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatad, GetBankDate(),
     GetBankDate(), GetBankDate(), SalStrTrimX(tbl2.cnls), d_NAMAs, AMFO, '', Val(tbl2.ckv), tbl2.cs*100,
     SalStrTrimX(tbl2.ckoka), SalStrTrimX(tbl2.cnlsp), tbl2.cnaimp, SalStrTrimX(tbl2.cmfo), '',
     Val(tbl2.ckv), tbl2.cs*100, SalStrTrimX(tbl2.ckokb), tbl2.ctext1, sVspo, GetIdOper(), '',
     NUMBER_Null, 0)
.head 11 -  ! Call cDoc.SetDoc(tbl2.crefKLP, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars,
     tbl2.cnd, tbl2.cdatad, GetBankDate(), IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval), IifS(nDk=1, tbl2.cnls, tbl2.cnlsp),
     IifS(nDk=1, d_NAMAs, tbl2.cnaimp), IifS(nDk=1, tbl2.cmfoa, tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckoka, tbl2.ckokb), IifS(nDk=1, tbl2.cnlsp, tbl2.cnls),
     IifS(nDk=1, tbl2.cnaimp, d_NAMAs), IifS(nDk=1, tbl2.cmfo, tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckokb, tbl2.ckoka), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 11 -  ! Call cDoc.SetDoc(tbl2.crefKLP, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars,
     tbl2.cnd, tbl2.cdatad, GetBankDate(), GetBankDate(), GetBankDate(), IifS(nDk=1, tbl2.cnls, tbl2.cnlsp),
     IifS(nDk=1, d_NAMAs, tbl2.cnaimp), IifS(nDk=1, tbl2.cmfoa, tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckoka, tbl2.ckokb), IifS(nDk=1, tbl2.cnlsp, tbl2.cnls),
     IifS(nDk=1, tbl2.cnaimp, d_NAMAs), IifS(nDk=1, tbl2.cmfo, tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckokb, tbl2.ckoka), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 11 -  Call cDoc.SetDoc(tbl2.crefKLP, IifS(sMaket='1', sOp1, IifS(sMaket='2', sOp2, sOp3)), nDk, nVobBars,
     tbl2.cnd, tbl2.cdatad, GetBankDate(), GetBankDate(),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval), IifS(nDk=1, tbl2.cnls, tbl2.cnlsp),
     IifS(nDk=1, d_NAMAs, tbl2.cnaimp), IifS(nDk=1, tbl2.cmfoa, tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckoka, tbl2.ckokb), IifS(nDk=1, tbl2.cnlsp, tbl2.cnls),
     IifS(nDk=1, tbl2.cnaimp, d_NAMAs), IifS(nDk=1, tbl2.cmfo, tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100,
     IifS(nDk=1, tbl2.ckokb, tbl2.ckoka), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 11 -  ! Call DebugN(cDoc.m_nRef)
.head 11 -  ! Set cDoc.m_nNom = IifN(nDk=2, 0, tbl2.cs*100) - Max(nOSTB, 0)
.head 11 -  Set cDoc.m_nNom = IifN(nDk=2, 0, tbl2.cs*100)
.head 11 -  Set cDoc.m_sRef_A = Str(tbl2.crefKLP)
.head 11 +  If cDoc.sDoc()
.head 12 +  If cDoc.iDoc()
.head 13 +  If cDoc.oDoc()
.head 14 -  Set nRef = cDoc.m_nRef
.head 14 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.oDoc() return ref==>' || Str(cDoc.m_nRef))
.head 14 -  Call SalTblSetContext(tbl2, nRow)
.head 14 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 14 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klp
   SET    fl=8
   WHERE  naex=:tbl2.cnaex and pond=:tbl2.cpond and datad=:tbl2.cdatad')
.head 15 -  Set sSab = Subs(tbl2.cnaex, 8, 1) || Right(tbl2.cnaex, 3)
.head 15 +  If GetValueStr("
   SELECT to_char(nvl(stmt,0))
   FROM   customer
   WHERE  sab='"||sSab||"'")!='5'
.head 16 -  Set sSab = Subs(tbl2.cnaex, 3, 4)
.head 15 -  Set sOper = Right(Str(10000+tbl2.ceom), 4)
.head 15 -  Set bUIklp = SqlPrepareAndExecute(hSql(), T("
    UPDATE klpond
    SET    ref=:nRef
    WHERE  pond=:tbl2.cpond and filename=:tbl2.cnaex"))
.head 15 -  Set nCountUpd = 0
.head 15 -  Call SqlGetModifiedRows(hSql(), nCountUpd)
.head 15 +  If nCountUpd = 0
.head 16 -  Set bUIklp = SqlPrepareAndExecute(hSql(), T("
    INSERT
    INTO   klpond (ref,pond,filename)
    VALUES (:nRef,:tbl2.cpond,:tbl2.cnaex)"))
.head 15 +  If bUIklp
.head 16 -  Call SqlCommit(hSql())
.head 16 -  Set tbl2.colow = 'o'
.head 16 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightGreen)
.head 16 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(tbl2.cnd) || ', (Ref=' ||
     Str(nRef) || ', МФО плат.=' || tbl2.cmfoa || '), Счёт плат.=' || tbl2.cnls ||
     ', МФО получ.=' || tbl2.cmfo || ', Счёт получ.=' || tbl2.cnlsp || ', Сумма=' ||
     SalNumberToStrX(tbl2.cs, 2) || ', Получатель - ' || tbl2.cnaimp ||
     ', Назначение платежа - ' || tbl2.ctext1, 'Сообщение', .1, 0)
.head 15 +  Else
.head 16 -  Call SqlRollback(hSql())
.head 14 +  Else
.head 15 -  Call SqlRollback(hSql())
.head 13 +  Else
.head 14 -  Call SqlRollback(hSql())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 9 +  ! Else 
.head 10 -  Call SqlRollback(hSql())
.head 8 +  Else If tbl2.colow = 'K' ! в картотеку
.head 9 -  Set nMaket = IifN(SalStrTrimX(tbl2.cmfo)=AMFO, 2, 1)
.head 9 -  Set nDk = 1
.head 9 -  !
.head 9 -  Set nMaket = Val(IifS(tbl2.cvob=3, '3', IifS(SalStrTrimX(tbl2.cmfo)=AMFO, '1', '2')))
.head 9 -  Set nDk = Max(1,nMaket-1)
.head 9 -  Set nckv = Val(tbl2.ckv)
.head 9 +  If Len(tbl2.cnaimo) = 0
.head 10 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nvl(c.nmkk,c.nmk)
     INTO   :d_NAMAs
     FROM   customer c, accounts a
     WHERE  a.nls=:tbl2.cnls and a.kv=:nckv and c.rnk=a.rnk'))
.head 10 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 11 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 9 +  Else
.head 10 -  Set d_NAMAs = tbl2.cnaimo
.head 9 -  ! Set sVspo = IifS(tbl2.cdaval=DATETIME_Null, '', '#D' || SalFmtFormatDateTime(tbl2.cdaval, 'yyMMdd') || '#')
.head 9 -  Set sVspo = tbl2.cvspo
.head 9 +  If tbl2.crefKLP = NUMBER_Null
.head 10 -  ! Call cDoc.SetDoc(0, 'K2A', nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatad, GetBankDate(),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval), SalStrTrimX(tbl2.cnls), d_NAMAs,
     SalStrTrimX(tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100, SalStrTrimX(tbl2.ckoka),
     SalStrTrimX(tbl2.cnlsp), tbl2.cnaimp, SalStrTrimX(tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     SalStrTrimX(tbl2.ckokb), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  ! Call cDoc.SetDoc(0, 'K2A', nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatad, GetBankDate(), GetBankDate(), GetBankDate(),
     SalStrTrimX(tbl2.cnls), d_NAMAs, SalStrTrimX(tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100,
     SalStrTrimX(tbl2.ckoka), SalStrTrimX(tbl2.cnlsp), tbl2.cnaimp, SalStrTrimX(tbl2.cmfo), '', Val(tbl2.ckv),
     tbl2.cs*100, SalStrTrimX(tbl2.ckokb), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  Call cDoc.SetDoc(0, 'K2A', nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatad, GetBankDate(), GetBankDate(),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval), SalStrTrimX(tbl2.cnls), d_NAMAs,
     SalStrTrimX(tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100, SalStrTrimX(tbl2.ckoka),
     SalStrTrimX(tbl2.cnlsp), tbl2.cnaimp, SalStrTrimX(tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     SalStrTrimX(tbl2.ckokb), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 +  If cDoc.oDoc()
.head 11 -  Set nRef = cDoc.m_nRef
.head 11 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klp
   SET    fl=7
   WHERE  naex=:tbl2.cnaex and pond=:tbl2.cpond and datad=:tbl2.cdatad and fl<4')
.head 12 -  Set nCountUpd = 0
.head 12 -  Call SqlGetModifiedRows(hSql(), nCountUpd)
.head 12 +  If nCountUpd = 1
.head 13 -  Set sSab = Subs(tbl2.cnaex, 8, 1) || Right(tbl2.cnaex, 3)
.head 13 +  If GetValueStr("
   SELECT to_char(nvl(stmt,0))
   FROM   customer
   WHERE  sab='"||sSab||"'")!='5'
.head 14 -  Set sSab = Subs(tbl2.cnaex, 3, 4)
.head 13 -  Set sOper = Right(Str(10000+tbl2.ceom), 4)
.head 13 -  Set bUIklp = SqlPrepareAndExecute(hSql(), T("
    UPDATE klpond
    SET    ref=:nRef
    WHERE  pond=:tbl2.cpond and filename=:tbl2.cnaex"))
.head 13 -  Set nCountUpd = 0
.head 13 -  Call SqlGetModifiedRows(hSql(), nCountUpd)
.head 13 +  If nCountUpd = 0
.head 14 -  Set bUIklp = SqlPrepareAndExecute(hSql(), T("
    INSERT
    INTO   klpond (ref,pond,filename)
    VALUES (:nRef,:tbl2.cpond,:tbl2.cnaex)"))
.head 13 +  If bUIklp
.head 14 -  Call SqlCommit(hSql())
.head 14 -  Call SalTblSetContext(tbl2, nRow)
.head 14 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 14 -  Set tbl2.colow = 'k'
.head 14 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightPeriwinkle)
.head 14 -  Call MessageNoWait('В картотеку "электронный" док.' || SalStrTrimX(tbl2.cnd) || ', (Ref=' || Str(nRef)
     || ', МФО плат.=' || tbl2.cmfoa || '), Счёт плат.=' || tbl2.cnls || ', МФО получ.=' || tbl2.cmfo
     || ', Счёт получ.=' || tbl2.cnlsp || ', Сумма=' || SalNumberToStrX(tbl2.cs, 2) ||
     ', Получатель - ' || tbl2.cnaimp || ', Назначение платежа - ' || tbl2.ctext1, 'Сообщение', .1, 0)
.head 13 +  Else
.head 14 -  Call SqlRollback(hSql())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  ! Call cDoc.SetDoc(tbl2.crefKLP, 'K2A', nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatad, GetBankDate(),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval), SalStrTrimX(tbl2.cnls), d_NAMAs,
     SalStrTrimX(tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100, SalStrTrimX(tbl2.ckoka),
     SalStrTrimX(tbl2.cnlsp), tbl2.cnaimp, SalStrTrimX(tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     SalStrTrimX(tbl2.ckokb), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  ! Call cDoc.SetDoc(tbl2.crefKLP, 'K2A', nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatad, GetBankDate(), GetBankDate(),
     GetBankDate(), SalStrTrimX(tbl2.cnls), d_NAMAs, SalStrTrimX(tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100,
     SalStrTrimX(tbl2.ckoka), SalStrTrimX(tbl2.cnlsp), tbl2.cnaimp, SalStrTrimX(tbl2.cmfo), '', Val(tbl2.ckv),
     tbl2.cs*100, SalStrTrimX(tbl2.ckokb), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  Call cDoc.SetDoc(tbl2.crefKLP, 'K2A', nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatad, GetBankDate(), GetBankDate(),
     IifD(tbl2.cdaval=DATETIME_Null, GetBankDate(), tbl2.cdaval), SalStrTrimX(tbl2.cnls), d_NAMAs,
     SalStrTrimX(tbl2.cmfoa), '', Val(tbl2.ckv), tbl2.cs*100, SalStrTrimX(tbl2.ckoka),
     SalStrTrimX(tbl2.cnlsp), tbl2.cnaimp, SalStrTrimX(tbl2.cmfo), '', Val(tbl2.ckv), tbl2.cs*100,
     SalStrTrimX(tbl2.ckokb), tbl2.ctext1, sVspo, GetIdOper(), '', NUMBER_Null, 0)
.head 10 -  Set cDoc.m_sRef_A = Str(tbl2.crefKLP)
.head 10 +  If cDoc.sDoc()
.head 11 +  If cDoc.iDoc()
.head 12 +  If cDoc.oDoc()
.head 13 -  Set nRef = cDoc.m_nRef
.head 13 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klp
   SET    fl=7
   WHERE  naex=:tbl2.cnaex and pond=:tbl2.cpond and datad=:tbl2.cdatad and fl<4')
.head 14 -  Set nCountUpd = 0
.head 14 -  Call SqlGetModifiedRows(hSql(), nCountUpd)
.head 14 +  If nCountUpd = 1
.head 15 -  Set sSab = Subs(tbl2.cnaex, 8, 1) || Right(tbl2.cnaex, 3)
.head 15 +  If GetValueStr("
   SELECT to_char(nvl(stmt,0))
   FROM   customer
   WHERE  sab='"||sSab||"'")!='5'
.head 16 -  Set sSab = Subs(tbl2.cnaex, 3, 4)
.head 15 -  Set sOper = Right(Str(10000+tbl2.ceom), 4)
.head 15 -  Set bUIklp = SqlPrepareAndExecute(hSql(), T("
    UPDATE klpond
    SET    ref=:nRef
    WHERE  pond=:tbl2.cpond and filename=:tbl2.cnaex"))
.head 15 -  Set nCountUpd = 0
.head 15 -  Call SqlGetModifiedRows(hSql(), nCountUpd)
.head 15 +  If nCountUpd = 0
.head 16 -  Set bUIklp = SqlPrepareAndExecute(hSql(), T("
    INSERT
    INTO   klpond (ref,pond,filename)
    VALUES (:nRef,:tbl2.cpond,:tbl2.cnaex)"))
.head 15 +  If bUIklp
.head 16 -  Call SqlCommit(hSql())
.head 16 -  Call SalTblSetContext(tbl2, nRow)
.head 16 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 16 -  Set tbl2.colow = 'k'
.head 16 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightPeriwinkle)
.head 16 -  Call MessageNoWait('В картотеку "электронный" док.' || SalStrTrimX(tbl2.cnd) || ', (Ref=' ||
     Str(nRef) || ', МФО плат.=' || tbl2.cmfoa || '), Счёт плат.=' || tbl2.cnls || ', МФО получ.='
     || tbl2.cmfo || ', Счёт получ.=' || tbl2.cnlsp || ', Сумма=' || SalNumberToStrX(tbl2.cs, 2)
     || ', Получатель - ' || tbl2.cnaimp || ', Назначение платежа - ' || tbl2.ctext1, 'Сообщение',
     .1, 0)
.head 15 +  Else
.head 16 -  Call SqlRollback(hSql())
.head 14 +  Else
.head 15 -  Call SqlRollback(hSql())
.head 13 +  Else
.head 14 -  Call SqlRollback(hSql())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 7 -  Set bX = TRUE
.head 7 -  Call SalDestroyWindow(dlg_klp)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Обработать помеченные на ВОЗВРАТ и к ОПЛАТЕ документы и выйти')
.head 3 +  Pushbutton: pbEsc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отложить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    5.905"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold-Italic
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Besc_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox("Вы уверены ?", "Отложить обработку", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 +  If SalTblAnyRows(tbl2, ROW_Edited, 0)
.head 8 +  If SqlPrepare(hSql(), '
   UPDATE klp
   SET    prwo=:tbl2.cprwo,fl=:tbl2.cfl
   WHERE  naex=:tbl2.cnaex and pond=:tbl2.cpond and datad=:tbl2.cdatad and fl<4')
.head 9 -  Call SalTblDoUpdates(tbl2, hSql(), TRUE)
.head 9 -  Call SqlCommitEx(hSql(), 'Обновление KLP')
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  ! Call SalEndDialog(dlg_klp, 0)
.head 7 -  Call SalDestroyWindow(dlg_klp)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отложить обработку с сохранением пометок')
.head 3 +  ! Data Field: daf1
.winattr
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
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Height: Default
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
.end
.head 4 +  Message Actions
.head 5 +  On WM_Char
.head 6 -  Call SalMessageBox(SalNumberToStrX(wParam , 0), 'wParam', MB_Ok)
.head 3 +  Child Table: tbl2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    -0.012"
.head 6 -  Width:  11.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 6.5"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colow
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
_
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 1
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.25"
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
.head 5 +  Column: ceom
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер ЭВМ
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
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
.head 5 +  Column: cvob
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2
.head 6 -  Data Type: Number
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
.head 5 +  Column: cnd
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.675"
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
.head 5 +  Column: cdatad
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Дата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  0.538"
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
.head 5 +  Column: cmfoa
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: МФО
плательщика
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 12
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.713"
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
.head 5 +  Column: cnls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Счёт
плательщика
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.725"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: cmfo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: МФО
получателя
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 12
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.713"
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
.head 5 +  Column: cnlsp
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Счёт
получателя
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.713"
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
.head 5 +  Column: cs
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Сумма
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.7"
.head 6 -  Width Editable? Yes
.head 6 -  Format: ###000
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: cprwo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Причина
возврата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.95"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: ckv
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.471"
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
.head 5 +  Column: cnaimp
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
получателя
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 38
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.475"
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
.head 5 +  Column: ctext1
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назначение
платежа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 160
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.25"
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
.head 5 +  Column: cisp
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Исполнитель
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 12
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.957"
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
.head 5 +  Column: ckoka
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ОКПО
плательщика
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ckokb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ОКПО
получателя
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Right
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ckoko
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: ОКПО, за кого платеж
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.071"
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
.head 5 +  Column: cnaex
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Имя
файла
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 12
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.688"
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
.head 5 +  Column: cpdp1
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Подпись 1
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Long String
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
.head 5 +  Column: cfl
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Флаг
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  1.386"
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
.head 5 +  Column: cpond
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Порядковый
номер док.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  ! Column: cRowid
.winattr
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: признак корр.
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
.end
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: csort
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Порядок сортировки
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.914"
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
.head 5 +  Column: cdaval
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата валютирования
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Left
.head 6 -  Width:  1.914"
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
.head 5 +  Column: crefKLP
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Референс
документа
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.188"
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
.head 5 +  Column: cnaimo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
отправителя
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.188"
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
.head 5 +  Column: cvspo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
отправителя
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.188"
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
.head 5 +  Function: Ostatki
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nKv
.head 7 -  Number: nOstc
.head 7 -  Number: nKoplate
.head 7 -  String: sNls
.head 7 -  Number: nRow1
.head 6 +  Actions
.head 7 -  Set nKv = Val(tbl2.ckv)
.head 7 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT nls,ostc
     INTO   :sNls,:nOstc
     FROM   accounts
     WHERE  nls=:tbl2.cnls and kv=:nKv"))
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set df1 = sNls
.head 8 -  Set df2 = nOstc/100
.head 7 -  Set nKoplate = 0
.head 7 -  Set nRow1 = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tbl2, nRow1, 0, 0)
.head 8 -  Call SalTblFetchRow(tbl2, nRow1)
.head 8 +  If tbl2.colow = 'O' ! к оплате
.head 9 +  If tbl2.cvob != 3
.head 10 -  Set nKoplate = nKoplate + tbl2.cs
.head 7 -  Set df3 = df2 - nKoplate
.head 7 -  Call SalColorSet(df3, COLOR_IndexWindowText, IifN(df3<0, COLOR_Red, COLOR_DarkGreen))
.head 4 +  Window Variables
.head 5 -  Boolean: bFL1
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTblSetLockedColumns(tbl2, 1)
.head 6 -  Set bFL1 = FALSE
.head 6 +  ! If bSberBank
.head 7 +  If nCLNTSEC = 1 ! Работаем по счетам из SALDO
.head 8 -  Call SalTblPopulate(hWndItem, hSql(), '
     SELECT ref,eom,naex,vob,nd,datad,nls,mfo,naimp,nlsp,s/100,text1,isp,kokb,koka,koko,prwo,pdp1,fl,pond,
            TO_CHAR(kv),naimo
     INTO   :crefKLP,:ceom,:cnaex,:cvob,:cnd,:cdatad,:cnls,:cmfo,:cnaimp,:cnlsp,:cs,:ctext1,:cisp,:ckokb,:ckoka,
            :ckoko,:cprwo,:cpdp1,:cfl,:cpond,:ckv,:cnaimo
     FROM   klp
     WHERE  (nls,kv) in (select nls,kv
                         from saldo) and fl<7 and SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0
     ORDER BY datad,pond', TBL_FillAll)
.head 7 +  Else ! Работаем по исполнителю
.head 8 -  Call SalTblPopulate(hWndItem, hSql(), '
     SELECT ref,eom,naex,vob,nd,datad,nls,mfo,naimp,nlsp,s/100,text1,isp,kokb,koka,koko,prwo,pdp1,fl,pond,
            TO_CHAR(kv),naimo
     INTO   :crefKLP,:ceom,:cnaex,:cvob,:cnd,:cdatad,:cnls,:cmfo,:cnaimp,:cnlsp,:cs,:ctext1,:cisp,:ckokb,:ckoka,
            :ckoko,:cprwo,:cpdp1,:cfl,:cpond,:ckv,:cnaimo
     FROM   klp
     WHERE  eom=:nAN and fl<7 and SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0', TBL_FillAll)
.head 6 +  ! Else
.head 7 +  If nCLNTSEC = 1 ! Работаем по счетам из SALDO
.head 8 -  Call SalTblPopulate(hWndItem, hSql(), '
     SELECT ref,eom,naex,vob,nd,datad,nls,mfo,naimp,nlsp,s/100,text1,isp,kokb,koka,koko,prwo,pdp1,fl,pond,
            TO_CHAR(kv),daval,naimo
     INTO   :crefKLP,:ceom,:cnaex,:cvob,:cnd,:cdatad,:cnls,:cmfo,:cnaimp,:cnlsp,:cs,:ctext1,:cisp,:ckokb,:ckoka,
            :ckoko,:cprwo,:cpdp1,:cfl,:cpond,:ckv,:cdaval,:cnaimo
     FROM   klp
     WHERE  (nls,kv) in (select nls,kv
                         from saldo) and fl<7 and SUBSTR(naex,3,4)=:sSab0
     ORDER BY datad,pond', TBL_FillAll)
.head 7 +  Else ! Работаем по исполнителю
.head 8 -  Call SalTblPopulate(hWndItem, hSql(), '
     SELECT ref,eom,naex,vob,nd,datad,nls,mfo,naimp,nlsp,s/100,text1,isp,kokb,koka,koko,prwo,pdp1,fl,pond,
            TO_CHAR(kv),daval,naimo
     INTO :crefKLP,:ceom,:cnaex,:cvob,:cnd,:cdatad,:cnls,:cmfo,:cnaimp,:cnlsp,:cs,:ctext1,:cisp,:ckokb,:ckoka,
          :ckoko,:cprwo,:cpdp1,:cfl,:cpond,:ckv,:cdaval,:cnaimo
     FROM klp
     WHERE eom=:nAN and fl<7 and SUBSTR(naex,3,4)=:sSab0', TBL_FillAll)
.head 6 +  If nCLNTSEC = 1 ! Работаем по счетам из SALDO
.head 7 -  Call SalTblPopulate(hWndItem, hSql(), '
     SELECT k.ref,k.eom,k.naex,k.vob,k.nd,k.datad,k.nls,k.mfo,k.naimp,k.nlsp,k.s/100,k.text1,k.isp,k.kokb,k.koka,
            k.koko,k.prwo,k.pdp1,k.fl,k.pond,TO_CHAR(k.kv),k.daval,k.naimo,k.drec
     INTO   :crefKLP,:ceom,:cnaex,:cvob,:cnd,:cdatad,:cnls,:cmfo,:cnaimp,:cnlsp,:cs,:ctext1,:cisp,:ckokb,:ckoka,
            :ckoko,:cprwo,:cpdp1,:cfl,:cpond,:ckv,:cdaval,:cnaimo,:cvspo
     FROM   klp k, customer c
     WHERE  ((k.nls,k.kv) in (select nls,kv
                              from saldo) and k.fl<7 and SUBSTR(k.naex,3,4)=:sSab0 and c.sab=:sSab0 and
                                              c.stmt=6) or
            ((k.nls,k.kv) in (select nls,kv
                              from saldo) and k.fl<7 and SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0 and
                                              c.sab=:sSab0 and c.stmt=5)
     ORDER BY k.datad,k.pond', TBL_FillAll)
.head 6 +  Else ! Работаем по исполнителю
.head 7 -  Call SalTblPopulate(hWndItem, hSql(), '
     SELECT k.ref,k.eom,k.naex,k.vob,k.nd,k.datad,k.nls,k.mfo,k.naimp,k.nlsp,k.s/100,k.text1,k.isp,k.kokb,k.koka,
            k.koko,k.prwo,k.pdp1,k.fl,k.pond,TO_CHAR(k.kv),k.daval,k.naimo,substr(nvl(k.mfoa,:AMFO),1,12),k.drec
     INTO   :crefKLP,:ceom,:cnaex,:cvob,:cnd,:cdatad,:cnls,:cmfo,:cnaimp,:cnlsp,:cs,:ctext1,:cisp,:ckokb,:ckoka,
            :ckoko,:cprwo,:cpdp1,:cfl,:cpond,:ckv,:cdaval,:cnaimo,:cmfoa,:cvspo
     FROM   klp k, customer c
     WHERE  (k.eom=:nAN and k.fl<7 and SUBSTR(k.naex,3,4)=:sSab0 and c.sab=:sSab0 and c.stmt=6) or
            (k.eom=:nAN and k.fl<7 and SUBSTR(naex,8,1) || SUBSTR(naex,10,3)=:sSab0 and c.sab=:sSab0 and c.stmt=5)',
            TBL_FillAll)
.head 6 -  Call SalTblSetFocusRow(tbl2, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set bFL1 = TRUE
.head 6 +  If cfl = 1
.head 7 -  Set colow = 'W'
.head 6 +  If cfl = 2
.head 7 -  Set colow = 'O'
.head 6 +  If cfl = 3
.head 7 -  Set colow = 'K'
.head 6 +  If not DopustMfo(cmfoa) and cfl != 1
.head 7 -  Set colow = 'W'
.head 7 -  Set cprwo = '*Недопустимое МФО ' || IifS(cvob=3, 'получателя', 'плательщика')
.head 7 -  Set cfl = 1
.head 6 +  If not DopustMfo(cmfo) and cfl != 1
.head 7 -  Set colow = 'W'
.head 7 -  Set cprwo = '*Недопустимое МФО ' || IifS(cvob=3, 'плательщика', 'получателя')
.head 7 -  Set cfl = 1
.head 6 +  ! Else If (cdatad > dtBD or cdatad+10 < dtBD) and cfl = 0
                                              ! cfl != 1
.head 7 -  Set colow = 'W'
.head 7 -  Set cprwo = 'Ошибка даты документа'
.head 7 -  Set cfl = 1
.head 6 +  Else If (cdatad > dtBD or cdatad+30 < dtBD) and cfl = 0
                                              ! cfl != 1
.head 7 -  Set colow = 'W'
.head 7 -  Set cprwo = 'Ошибка даты документа'
.head 7 -  Set cfl = 1
.head 6 +  If Left(cnaex, 1) = 'D'
.head 7 +  If cvob = 1 or cvob = 6
.head 8 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a, customer c
     WHERE  a.nls=:cnls and a.kv=:ckv and c.rnk=a.rnk and c.sab=substr(:cnaex,8,1)||substr(:cnaex,-3) and
            a.acc=i.acc and nvl(i.pers,0)=1"))
.head 8 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 9 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a, customer c, klp_top k
     WHERE  a.nls=:cnls and a.kv=:ckv and k.rnk=a.rnk and c.rnk=k.rnkp and
            c.sab=substr(:cnaex,8,1)||substr(:cnaex,-3) and a.acc=i.acc and nvl(i.high,0)=1"))
.head 9 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 10 -  Set cprwo = '*Запрет на дебет счёта ' || cnls
.head 10 -  Set colow = 'W'
.head 10 -  Set cfl = 1
.head 7 +  Else
.head 8 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a, customer c
     WHERE  a.nls=:cnlsp and a.kv=:ckv and c.rnk=a.rnk and c.sab=substr(:cnaex,8,1)||substr(:cnaex,-3) and
            a.acc=i.acc and nvl(i.pers,0)=1"))
.head 8 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 9 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a, customer c, klp_top k
     WHERE  a.nls=:cnlsp and a.kv=:ckv and k.rnk=a.rnk and c.rnk=k.rnkp and
            c.sab=substr(:cnaex,8,1)||substr(:cnaex,-3) and a.acc=i.acc and nvl(i.high,0)=1"))
.head 9 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 10 -  Set cprwo = '*Запрет на дебет счёта ' || cnlsp
.head 10 -  Set colow = 'W'
.head 10 -  Set cfl = 1
.head 6 +  Else
.head 7 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a
     WHERE  a.nls=:cnls and a.kv=:ckv and a.acc=i.acc"))
.head 7 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 8 -  Set cprwo = '*Запрет на дебет счёта ' || cnls
.head 8 -  Set colow = 'W'
.head 8 -  Set cfl = 1
.head 6 -  Set csort = Subs(cnaex, 8, 1) || Right(cnaex, 3) || Right(Str(Val(cpond)+100000000), 8)
.head 6 -  Set sTmp = Subs(cnaex, 8, 1) || Right(cnaex, 3)
.head 6 +  If GetValueStr("
   SELECT to_char(nvl(stmt,0))
   FROM   customer
   WHERE  sab='"||sTmp||"'")!='5'
.head 7 -  Set csort = Subs(cnaex, 3, 4) || Right(Str(Val(cpond)+100000000), 8)
.head 6 -  Set ckv = Right(Str(Val(ckv)+1000), 3)
.head 5 +  On SAM_CreateComplete
.head 6 +  If bFL1
.head 7 -  Call SalTblSortRows(tbl2, SalTblQueryColumnPos(csort), TBL_SortIncreasing)
.head 7 -  Call VisTblAutoSizeColumn(tbl2, hWndNULL)
.head 7 -  Call SalTblSetFocusRow(tbl2, 0)
.head 7 -  Call SalTblSetRowFlags(tbl2, 0, ROW_Selected, TRUE)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Документы "электронных" клиентов отсутствуют !', 'Предупреждение', 0, 1)
.head 7 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  On SAM_RowSetContext
.head 6 -  Call Ostatki()
.head 5 +  On SAM_SetFocus
.head 6 -  Call Ostatki()
.head 3 -  Group Box: Сумма на счёте
.head 4 -  Resource Id: 35800
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    -0.012"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.75"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Group Box: к ОПЛАТЕ
.head 4 -  Resource Id: 35801
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    0.905"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: df1
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.179"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: С учетом д-тов
.head 4 -  Resource Id: 35802
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    0.762"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: df2
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.429"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: df3
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    1.179"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sSab0
.head 3 -  String: sNmk0
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  String: df_titles
.head 3 -  String: d_NDs
.head 3 -  Date/Time: d_DATAs
.head 3 -  String: d_NAMAs
.head 3 -  String: d_BNK_As
.head 3 -  String: d_MFOAs
.head 3 -  String: d_NAMBs
.head 3 -  String: d_BNK_Bs
.head 3 -  String: d_MFOBs
.head 3 -  Number: d_Ss
.head 3 -  String: dfCodeCurrencys
.head 3 -  String: d_NLSAs
.head 3 -  String: d_NLSBs
.head 3 -  String: ml_SumPrs
.head 3 -  String: d_NAZNs
.head 3 -  String: sMaket
.head 3 -  Number: nDk
.head 3 -  String: sVspo
.head 3 -  Number: nRef
.head 3 -  ! Long String: lsSign
.head 3 -  !
.head 3 -  Date/Time: dtBD
.head 3 -  Number: nRRR
.head 3 -  Window Handle: hWndTemp
.head 3 -  Number: nFla
.head 3 -  Number: n1234
.head 3 -  Number: n100
.head 3 -  !
.head 3 -  String: sSab
.head 3 -  String: sOper
.head 3 -  String: sKODO
.head 3 -  : cDoc
.head 4 -  Class: cDoc
.head 3 -  !
.head 3 -  ! Boolean: bSberBank
.head 3 -  !
.head 3 -  Number: nMaket
.head 3 -  !
.head 3 -  ! Number: nAcc
.head 3 -  ! Number: nOSTB
.head 3 -  ! Number: nOSTB8
.head 3 -  !
.head 3 -  String: sTmp
.head 3 -  ! Boolean: bRoll
.head 3 -  Number: nCLNTSEC
.head 3 -  !
.head 3 -  Boolean: bX
.head 3 -  !
.head 3 -  Boolean: bUIklp
.head 3 -  Number: nCountUpd
.head 3 -  !
.head 3 -  Number: nFltek
.head 3 -  !
.head 3 -  Number: nVobBars
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm, '       Принятие решений по "электронным" документам клиента ' || sSab0 || ' (' || sNmk0
     || ')')
.head 4 -  Call SalCenterWindow(hWndItem)
.head 4 -  Set bX = TRUE
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_Green)
.head 4 -  Call XSalTooltipSetDelay(200, 30000)
.head 4 -  Set nAN = GetUserId()
.head 4 -  Set dtBD = GetBankDate()
.head 4 -  Set nRRR = -1
.head 4 -  Set nTipPoisk = 4
.head 4 -  Set AMFO = GetBankMfo()
.head 4 -  ! Set bSberBank = AMFO='300465'
.head 4 -  ! Инициализация параметра CLNTSEC
.head 4 -  Set nCLNTSEC = GetGlobalOptionEx('CLNTSEC')
.head 4 -  Call SalDisableWindow(pbF6)
.head 3 +  On SAM_Close
.head 4 +  If not bX
.head 5 -  Return FALSE
.head 4 -  ! Call Debug('Close')
.head 4 -  Call SalSendMsg(dlg_klp.pbEsc, SAM_Click, 0, 0)
.head 3 +  On SAM_Destroy
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
.head 4 -  Call XSalTooltipSetDelay(200, 4000)
.head 4 -  ! Call SalSendMsg(dlg_klp0.tbl2, SAM_User, 0, 0)
.head 1 +  Form Window: dlg_klp0
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Работа с документами "электронных" клиентов
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
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   0.325"
.head 4 -  Top:    0.573"
.head 4 -  Width:  9.675"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.323"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold
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
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.138"
.head 6 -  Top:    0.479"
.head 6 -  Width:  9.175"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.333"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colSab
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
клиента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.838"
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
.head 5 +  Column: colKlient
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
клиента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.263"
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
.head 5 +  Column: colAlles
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Количество
документов
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.25"
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
.head 5 +  Column: colSumma
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: На сумму
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  2.313"
.head 6 -  Width Editable? Yes
.head 6 -  Format: #000
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
.head 5 -  Boolean: bFL1
.head 5 -  Number: nKrow
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set bFL1 = FALSE
.head 6 -  Set nKrow = 0
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  ! If bSberBank
.head 7 -  ! Call Debug('Ветка ВЕГА')
.head 7 +  If nCLNTSEC = 1 ! Работаем по счетам из SALDO
.head 8 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT c.sab,nvl(c.nmkk,c.nmk),sum(1),sum(k.s/100)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles,:tbl1.colSumma
     FROM   klp k, customer c
     WHERE  (k.nls,k.kv) in (select nls,kv from saldo) and k.fl<7 and
            SUBSTR(k.naex,8,1) || SUBSTR(k.naex,10,3)=c.sab and c.sab is not null and c.stmt=4
     GROUP BY c.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 +  Else ! Работаем по исполнителю
.head 8 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT c.sab,nvl(c.nmkk,c.nmk),sum(1),sum(k.s/100)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles,:tbl1.colSumma
     FROM   klp k, customer c
     WHERE  k.eom=:nAN and k.fl<7 and SUBSTR(k.naex,8,1) || SUBSTR(k.naex,10,3)=c.sab and c.sab is not null and
            c.stmt=4
     GROUP BY c.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 +  ! Else
.head 7 -  ! Call Debug('Ветка ICT')
.head 7 +  If nCLNTSEC = 1 ! Работаем по счетам из SALDO
.head 8 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT c.sab,nvl(c.nmkk,c.nmk),sum(1),sum(k.s/100)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles,:tbl1.colSumma
     FROM   klp k, customer c
     WHERE  (k.nls,k.kv) in (select nls,kv from saldo) and k.fl<7 and SUBSTR(k.naex,3,4)=c.sab and
            c.sab is not null and c.stmt in (5,6)
     GROUP BY c.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 +  Else ! Работаем по исполнителю
.head 8 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT c.sab,nvl(c.nmkk,c.nmk),sum(1),sum(k.s/100)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles,:tbl1.colSumma
     FROM   klp k, customer c
     WHERE  k.eom=:nAN and k.fl<7 and SUBSTR(k.naex,3,4)=c.sab and c.sab is not null and c.stmt in (5,6)
     GROUP BY c.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 +  If nCLNTSEC = 1 ! Работаем по счетам из SALDO
.head 7 -  ! Call SalTblPopulate(tbl1, hSql(), T('
     SELECT c.sab,nvl(c.nmkk,c.nmk),sum(1),sum(k.s/100)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles,:tbl1.colSumma
     FROM   klp k, customer c
     WHERE  (k.nls,k.kv) in (select nls,kv from saldo) and k.fl<7 and SUBSTR(k.naex,3,4)=c.sab and
            c.sab is not null and c.stmt in (5,6)
     GROUP BY c.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT c.sab,nvl(c.nmkk,c.nmk),sum(1),sum(k.s/100)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles,:tbl1.colSumma
     FROM   klp k, customer c
     WHERE  (k.nls,k.kv) in (select nls,kv from saldo) and k.fl<7 and c.sab is not null and
            ((SUBSTR(k.naex,3,4)=c.sab and c.stmt=6) or (SUBSTR(k.naex,8,1) || SUBSTR(k.naex,10,3)=c.sab and
            c.stmt=5))
     GROUP BY c.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 +  Else ! Работаем по исполнителю
.head 7 -  ! Call SalTblPopulate(tbl1, hSql(), T('
     SELECT c.sab,nvl(c.nmkk,c.nmk),sum(1),sum(k.s/100)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles,:tbl1.colSumma
     FROM   klp k, customer c
     WHERE  k.eom=:nAN and k.fl<7 and SUBSTR(k.naex,3,4)=c.sab and c.sab is not null and c.stmt in (5,6)
     GROUP BY c.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT c.sab,nvl(c.nmkk,c.nmk),sum(1),sum(k.s/100)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles,:tbl1.colSumma
     FROM   klp k, customer c
     WHERE  k.eom=:nAN and k.fl<7 and c.sab is not null and ((SUBSTR(k.naex,3,4)=c.sab and c.stmt=6) or
            (SUBSTR(k.naex,8,1) || SUBSTR(k.naex,10,3)=c.sab and c.stmt=5))
     GROUP BY c.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set bFL1 = TRUE
.head 6 -  Set nKrow = nKrow + 1
.head 5 +  On SAM_CreateComplete
.head 6 +  If bFL1
.head 7 -  Call SalTblSortRows(tbl1, SalTblQueryColumnPos(colSab),  TBL_SortIncreasing)
.head 7 -  Call SalTblSetFocusRow(tbl1, Min(nRow, nKrow-1))
.head 7 -  Call SalTblSetRowFlags(tbl1, Min(nRow, nKrow-1),  ROW_Selected, TRUE)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Документы "электронных" клиентов отсутствуют !', 'Предупреждение', 0, 1)
.head 7 -  Call SalDestroyWindow(dlg_klp0)
.head 5 +  On SAM_DoubleClick
.head 6 -  Set nRow = SalTblQueryContext(tbl1)
.head 6 +  If rbRee
.head 7 -  Call SalModalDialog(dlg_klp, hWndForm, tbl1.colSab, tbl1.colKlient, sOp1, sOp2, sOp3)
.head 6 +  Else If rbDok
.head 7 -  Call SalModalDialog(document2, hWndForm, tbl1.colSab, tbl1.colKlient, sOp1, sOp2, sOp3)
.head 6 -  Call SalTblReset(tbl1)
.head 6 -  Call SalSendMsg(tbl1, SAM_Create, 0, 0)
.head 6 -  Call SalSendMsg(tbl1, SAM_CreateComplete, 0, 0)
.head 3 +  Pushbutton: pb1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выбор
.head 4 -  Window Location and Size
.head 5 -  Left:   0.088"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.375"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSendMsg(tbl1, SAM_DoubleClick, 0, 0)
.head 3 +  Pushbutton: pb2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выход
.head 4 -  Window Location and Size
.head 5 -  Left:   1.388"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.375"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 3 +  Radio Button: rbRee
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Табличный формат
.head 4 -  Window Location and Size
.head 5 -  Left:   6.788"
.head 5 -  Top:    -0.01"
.head 5 -  Width:  2.4"
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
.head 3 +  Radio Button: rbDok
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Формат документа
.head 4 -  Window Location and Size
.head 5 -  Left:   6.788"
.head 5 -  Top:    0.24"
.head 5 -  Width:  2.4"
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
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  String: sValue
.head 3 -  String: sTmp
.head 3 -  ! Boolean: bSberBank
.head 3 -  Number: nCLNTSEC
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Call SalCenterWindow(hWndItem)
.head 4 -  ! Значение флажка СБ= вычитываем из PARAMS, если его там нет - то по МФО
.head 4 -  ! Set bSberBank = GetBankMfo()='300465'
.head 4 -  ! Инициализация параметра CLNTSEC
.head 4 -  Set nCLNTSEC = GetGlobalOptionEx('CLNTSEC')
.head 4 +  ! If SqlPrepareAndExecute(hSql(), "
   SELECT val
   INTO   :sTmp
   FROM   params
   WHERE  par='KL_BOB'")
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set bSberBank = sTmp='1'
.head 4 -  !
.head 4 -  Call PrepareWindow(hWndItem)
.head 4 -  Set nAN = GetUserId()
.head 4 -  Set nRow = 0
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  Call SalGetProfileString('EleOper', Str(1000+nAN), '0', sValue, GetProductName())
.head 4 -  Set bAUTO = Val(GetGlobalOption('KL_PAY'))=1
.head 4 +  ! If sValue = '0'
.head 5 -  Set rbRee = TRUE
.head 5 -  Set rbDok = FALSE
.head 4 +  ! Else
.head 5 -  Set rbRee = FALSE
.head 5 -  Set rbDok = TRUE
.head 4 -  Set rbRee = sValue='0'
.head 4 -  Set rbDok = sValue!='0'
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  Call SalSetProfileString('EleOper', Str(1000+nAN), IifS(rbRee, '0', '1'), GetProductName())
.head 1 +  Dialog Box: dlg_3
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
.head 4 -  Left:   0.0"
.head 4 -  Top:    0.0"
.head 4 -  Width:  13.333"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.833"
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
.head 3 +  Pushbutton: pbF2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Курс конверс.
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    1.81"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F2
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf2.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: White
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nKURSresult = tbl2.ckurskonv
.head 6 +  If SalModalDialog(TT_kurs, hWndForm, tbl2.ckurskonv) = 1
.head 7 -  Set tbl2.ckurskonv = nKURSresult
.head 7 -  Set tbl2.cidcontract = 1
.head 7 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    kurskonv=:tbl2.ckurskonv,idcontract=1
   WHERE  id=:tbl2.cid')
.head 8 -  Call SqlCommit(hSql())
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Изменение курса конверсии')
.head 3 +  Pushbutton: pbF3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Возвратить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    2.298"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F3
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf3_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 +  If SalModalDialog(wozwrat, hWndForm) != -1
.head 8 -  Set nRow = TBL_MinRow
.head 8 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 9 -  Call SalTblFetchRow(tbl2, nRow)
.head 9 +  If (tbl2.cfl = NUMBER_Null or tbl2.cfl = 0) and Len(SalStrTrimX(sWW)) > 0
.head 10 -  Set tbl2.colow = 'W'
.head 10 -  Set tbl2.cfl = 1
.head 10 -  Set tbl2.cprwo = sWW
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call VisTblAutoSizeColumn(tbl2, hWndNULL)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить на возврат выбранные документы')
.head 3 +  Pushbutton: pbF4
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: К оплате
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    2.798"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F4
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf4_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cfl = NUMBER_Null or tbl2.cfl = 0
.head 9 +  If tbl2.cidcontract = 1 and tbl2.ckurskonv != NUMBER_Null and tbl2.ckurskonv != 0
.head 10 -  Set tbl2.colow = 'O'
.head 10 -  Set tbl2.cfl = 2
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 +  Else
.head 10 -  Call MessageNoWait('Необходимо ОТКОРРЕКТИРОВАТЬ или ПОДТВЕРДИТЬ курс конверсии для документа ' || tbl2.cnd,
     'ВНИМАНИЕ !', 7, 1)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить выбранные документы к оплате')
.head 3 +  Pushbutton: pbF5
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Печать
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    3.31"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F5
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf5_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set sDir = GetTemplateDir() || "\\ZAY_KMS.QRP"
.head 6 -  Set sFileName = GetPrnDir() || '\\D' || Str(tbl2.cref) || '.za3'
.head 6 -  Set sRab = 'NMK,ADRES,OKPO,RUK,BUH,NLS,MFO,NB,KVA,SUMV,KURS,KVB,DATZ,REF,DATD,FIO,TEL'
.head 6 -  Set bU = FALSE
.head 6 -  Call SalReportPrintToFile(hWndForm, sDir, sFileName, sRab, sRab, 1, RPT_PrintAll, 1, 1, FALSE, nInd)
.head 6 -  Call zarez12(sFileName, 0, '')
.head 6 -  Call DosDirectPrint(sFileName)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отпечатать текущий документ')
.head 3 +  Pushbutton: pbF7
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Поиск
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    3.821"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F7
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf7_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nTipPoisk = SalModalDialog(poisk, hWndForm)
.head 6 +  If nTipPoisk = 1
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 8 -  Call SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 7 +  Else
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cs = nGetSum
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If not nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 6 +  Else If nTipPoisk = 2
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If NOT SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'O'
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If NOT nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 6 +  Else If nTipPoisk = 3
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If NOT SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'W'
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If NOT nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Поиск документа от текущей позиции вниз')
.head 3 +  Pushbutton: pbF8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Снять отметку
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    4.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F8
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf8_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If (tbl2.cfl = 1 and Left(tbl2.cprwo, 1) != '*') or tbl2.cfl = 2 or tbl2.cfl = 3
.head 9 -  Set tbl2.colow = ' '
.head 9 -  Set tbl2.cfl = 0
.head 9 -  Set tbl2.cprwo = ''
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Сбросить пометки с выбранных документов')
.head 3 +  Pushbutton: pbF9
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Документ
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    4.821"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F9
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf9_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set sDir = GetTemplateDir() || "\\ZAY_KMS.QRP"
.head 6 -  Set sFileName = GetPrnDir() || '\\D' || Str(tbl2.cref) || '.za3'
.head 6 -  ! Call Debug(sFileName)
.head 6 -  Set sRab = 'NMK,ADRES,OKPO,RUK,BUH,NLS,MFO,NB,KVA,SUMV,KURS,KVB,DATZ,REF,DATD,FIO,TEL'
.head 6 -  Set bU = FALSE
.head 6 -  ! Set nInd = RPT_NoToolbar
.head 6 -  Call SalReportPrintToFile(hWndForm, sDir, sFileName, sRab, sRab, 1, RPT_PrintAll, 1, 1, FALSE, nInd)
.head 6 -  ! Call DebugN(nInd)
.head 6 -  Call zarez12(sFileName, 0, '')
.head 6 -  Call DirectView(sFileName)
.head 6 -  ! Call DirectView(GetPrnDir() || '\\' || sFileName)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Просмотр выбранного документа')
.head 3 +  Pushbutton: pb10
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обработать
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    5.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F10
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold-Italic
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf10_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox('ЕСЛИ Вы НЕ ОТПЕЧАТАЛИ ПОМЕЧЕННЫЕ к оплате ДОКУМЕНТЫ, то сделать ЭТО Вы сможете только из АРХИВА,' ||
   ' СОГЛАСНЫ на обработку ?', "Обработать и выйти", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 -  Call SalDisableWindow(pbF2)
.head 7 -  Call SalDisableWindow(pbF3)
.head 7 -  Call SalDisableWindow(pbF4)
.head 7 -  Call SalDisableWindow(pbF5)
.head 7 -  Call SalDisableWindow(pbF7)
.head 7 -  Call SalDisableWindow(pbF8)
.head 7 -  Call SalDisableWindow(pbF9)
.head 7 -  Call SalDisableWindow(pb10)
.head 7 -  Call SalDisableWindow(pbEsc)
.head 7 -  Set bX = FALSE
.head 7 +  If SalTblAnyRows(tbl2, ROW_Edited, 0)
.head 8 +  If SqlPrepare(hSql(), '
   UPDATE klpv
   SET    prwo=:tbl2.cprwo,fl=:tbl2.cfl
   WHERE  id=:tbl2.cid')
.head 9 -  Call SalTblDoUpdates(tbl2, hSql(), TRUE)
.head 9 -  Call SqlCommit(hSql())
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 8 -  Call SalTblSetContext(tbl2, nRow)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'W' ! возвратить
.head 9 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    fl=9
   WHERE  id=:tbl2.cid')
.head 10 -  Set sSab = tbl2.csab
.head 10 -  Set sOper = Right(Str(10000+tbl2.cneom), 4)
.head 10 -  Set n100 = tbl2.cs*100
.head 10 +  If SqlPrepareAndExecute(hSql(), '
   SELECT S_zay_baop.NEXTVAL
   INTO   :nId
   FROM   DUAL') and SqlFetchNext(hSql(), nFetchRes)
.head 11 +  If SqlPrepareAndExecute(hSql(), T("
   INSERT
   INTO   zay_baop (id,tipkb,kod,textback,identkb,fnamekb)
   VALUES (:nId,:tbl2.ctipkb,88,:tbl2.cprwo,:tbl2.cidentkb,:tbl2.cfnamekb)"))
.head 12 -  Call SqlCommit(hSql())
.head 12 -  Call SalTblSetContext(tbl2, nRow)
.head 12 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 12 -  Set tbl2.colow = 'w'
.head 12 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_Salmon)
.head 12 -  Call MessageNoWait('Возвращен "электронный" док.' || SalStrTrimX(tbl2.cnd) || '), Счёт плат.=' ||
     tbl2.cnls || '(' || Str(tbl2.ckv) || '), Счёт получ.=' || tbl2.cnlsp || '(' || Str(tbl2.ckv) ||
     '), Сумма=' || SalNumberToStrX(tbl2.cs, 2), 'Сообщение', .1, 0)
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 8 +  Else If tbl2.colow = 'O' ! к оплате
.head 9 -  Set nDk = 1
.head 9 -  Set nckv = tbl2.ckv
.head 9 -  Set nAcc = 0
.head 9 -  Set nOSTB = 0
.head 9 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 9 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT nvl(c.nmkk,c.nmk),a.acc,a.ostb,c.okpo
   INTO   :d_NAMAs,:nAcc,:nOSTB,:sOkpoA
   FROM   customer c, accounts a
   WHERE  a.nls=:tbl2.cnls and a.kv=:nckv and c.rnk=a.rnk'))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.SetDoc(ref==>' || Str(tbl2.cref) || ')')
.head 9 -  ! Call DebugN(tbl2.ckv)
.head 9 -  ! Call DebugN(tbl2.ckv2)
.head 9 -  Call cDoc.SetDoc(tbl2.cref, tbl2.ctt, nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatd, GetBankDate(), GetBankDate(),
     GetBankDate(), SalStrTrimX(tbl2.cnls), d_NAMAs, AMFO, '', tbl2.ckv, tbl2.cs*100, sOkpoA,
     SalStrTrimX(tbl2.cnlsp), d_NAMAs, AMFO, '', tbl2.ckv2, tbl2.cs*100*tbl2.ckurskonv, sOkpoA,
     'КОНВЕРСІЯ ВАЛЮТИ ЗГІДНО ЗАЯВЦІ-ДОГОВОРУ КОМІСІЇ від ' || SalFmtFormatDateTime(tbl2.cdatd, 'dd-MM-yyyy ')
     || Str(tbl2.cs) || ' ' || GetLcv(tbl2.ckv) || ' в ' || Str(tbl2.cs*tbl2.ckurskonv) || ' ' ||
     GetLcv(tbl2.ckv2) || ' КУРС КОНВЕРСІЇ ' || Str(tbl2.ckurskonv), '', GetIdOper(), '', NUMBER_Null, 0)
.head 9 -  Set cDoc.m_nNom = tbl2.cs*100 - Max(nOSTB, 0)
.head 9 -  Set cDoc.m_sRef_A = Str(tbl2.cref)
.head 9 +  If cDoc.sDoc()
.head 10 +  If cDoc.iDoc()
.head 11 +  If cDoc.oDoc()
.head 12 +  If SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'TIPKB',:tbl2.ctipkb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'FN_KB',:tbl2.cfnamekb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'ID_KB',:tbl2.cidentkb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'DATKB',:tbl2.cdatedokkb)")
.head 13 -  Set nRef = cDoc.m_nRef
.head 13 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.oDoc() return ref==>' || Str(cDoc.m_nRef))
.head 13 -  Call SalTblSetContext(tbl2, nRow)
.head 13 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 13 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    fl=8
   WHERE  id=:tbl2.cid')
.head 14 -  ! вставить запись в zay_baop с кодом 0
.head 14 +  If SqlPrepareAndExecute(hSql(), '
   SELECT S_zay_baop.NEXTVAL
   INTO   :nId
   FROM   DUAL') and SqlFetchNext(hSql(), nFetchRes)
.head 15 +  If SqlPrepareAndExecute(hSql(), '
   INSERT
   INTO   zay_baop (id,tipkb,kod,identkb,fnamekb)
   VALUES (:nId,:tbl2.ctipkb,0,:tbl2.cidentkb,:tbl2.cfnamekb)')
.head 16 -  Call SqlCommit(hSql())
.head 16 -  Set tbl2.colow = 'o'
.head 16 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightGreen)
.head 16 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(tbl2.cnd) || ', (Ref=' || Str(nRef)
     || '), Счёт плат.=' || tbl2.cnls || ', Счёт получ.=' || tbl2.cnlsp || ', Сумма=' ||
     SalNumberToStrX(tbl2.cs, 2), 'Сообщение', .1, 0)
.head 15 +  Else
.head 16 -  Call SqlRollback(hSql())
.head 14 +  Else
.head 15 -  Call SqlRollback(hSql())
.head 13 +  Else
.head 14 -  Call SqlRollback(hSql())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 7 -  ! Call SalEnableWindow(pbF2)
.head 7 -  ! Call SalEnableWindow(pbF3)
.head 7 -  ! Call SalEnableWindow(pbF4)
.head 7 -  ! Call SalEnableWindow(pbF5)
.head 7 -  ! Call SalEnableWindow(pbF6)
.head 7 -  ! Call SalEnableWindow(pbF7)
.head 7 -  ! Call SalEnableWindow(pbF8)
.head 7 -  ! Call SalEnableWindow(pbF9)
.head 7 -  ! Call SalEnableWindow(pbF10)
.head 7 -  Set bX = TRUE
.head 7 -  Call SalDestroyWindow(dlg_3)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Обработать помеченные на ВОЗВРАТ и к ОПЛАТЕ документы и выйти')
.head 3 +  Pushbutton: pbEsc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отложить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    5.917"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold-Italic
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Besc_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox("Вы уверены ?", "Отложить обработку", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 +  If SalTblAnyRows(tbl2, ROW_Edited, 0)
.head 8 +  If SqlPrepare(hSql(), '
   UPDATE klpv
   SET    prwo=:tbl2.cprwo,fl=:tbl2.cfl
   WHERE  id=:tbl2.cid')
.head 9 -  Call SalTblDoUpdates(tbl2, hSql(), TRUE)
.head 9 -  Call SqlCommitEx(hSql(), 'Обновление KLPV')
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  ! Call SalEndDialog(dlg_3, 0)
.head 7 -  Call SalDestroyWindow(dlg_3)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отложить обработку с сохранением пометок')
.head 3 +  Child Table: tbl2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    -0.012"
.head 6 -  Width:  11.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 6.5"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colow
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
_
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 1
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.25"
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
.head 5 +  Column: cid
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Ид.
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
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
.head 5 +  Column: cref
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Референс
документа
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.188"
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
.head 5 +  Column: cneom
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер ЭВМ
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
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
.head 5 +  Column: csab
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
клиента
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 4
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
.head 5 +  Column: cfl
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Флаг
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  1.386"
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
.head 5 +  Column: cnls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Счёт А
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.375"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: cnd
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cdatd
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Дата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cs
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Сумма
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.838"
.head 6 -  Width Editable? Yes
.head 6 -  Format: ###000
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: ckv
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.563"
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
.head 5 +  Column: cdkreddog
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата
действия
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  0.875"
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
.head 5 +  Column: ckv2
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
вал(2)
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.663"
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
.head 5 +  Column: ckurskonv
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Курс
конверсии
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.088"
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
.head 5 +  Column: cidcontract ! здесь для отметки об изменении курса конверсии
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Изменение курса
конверсии (1 - да)
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.088"
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
.head 5 +  Column: cfnamekb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Имя
файла
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 12
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.688"
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
.head 5 +  Column: cidentkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Идентификатор
 документа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 16
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: ctipkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: номер
додатка
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: cdatedokkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата приема
документа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  1.338"
.head 6 -  Width Editable? Yes
.head 6 -  Format: DateTime
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
.head 5 +  Column: ctt
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
операции
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: String
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
.head 5 +  Column: cvob
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид
обработки
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: cnlsp
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Счёт Б
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.55"
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
.head 5 +  Column: cprwo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Причина
возврата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.863"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: csort
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Порядок
сортировки
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.914"
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
.head 5 +  Function: Ostatki
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nKv
.head 7 -  Number: nOstc
.head 7 -  Number: nKoplate
.head 7 -  String: sNls
.head 7 -  Number: nRow1
.head 6 +  Actions
.head 7 -  Set nKv = ckv
.head 7 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT nls,ostc
     INTO   :sNls,:nOstc
     FROM   accounts
     WHERE  nls=:tbl2.cnls and kv=:nKv"))
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set df1 = sNls
.head 8 -  Set df2 = nOstc/100
.head 7 -  Set nKoplate = 0
.head 7 -  Set nRow1 = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tbl2, nRow1, 0, 0)
.head 8 -  Call SalTblFetchRow(tbl2, nRow1)
.head 8 +  If tbl2.colow = 'O' ! к оплате
.head 9 -  Set nKoplate = nKoplate + tbl2.cs
.head 7 -  Set df3 = df2 - nKoplate
.head 7 -  Call SalColorSet(df3, COLOR_IndexWindowText,
     IifN(df3<0, COLOR_Red, COLOR_DarkGreen))
.head 4 +  Window Variables
.head 5 -  Boolean: bFL1
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTblSetLockedColumns(tbl2, 1)
.head 6 -  Set bFL1 = FALSE
.head 6 +  If bAUTO
.head 7 -  Call SalTblPopulate(hWndItem, hSql(), '
     SELECT id,ref,neom,sab,fl,nls,nd,datd,s/100,kv,dkreddog,kvkomiss,kurskonv,idcontract,fnamekb,identkb,tipkb,
            datedokkb,vob,nls,prwo
     INTO   :cid,:cref,:cneom,:csab,:cfl,:cnls,:cnd,:cdatd,:cs,:ckv,:cdkreddog,:ckv2,:ckurskonv,:cidcontract,
            :cfnamekb,:cidentkb,:ctipkb,:cdatedokkb,:cvob,:cnlsp,:cprwo
     FROM   klpv
     WHERE  neom=:nAN and fl<7 and sab=:sSab0 and tipkb=3 and noauto is not null',
     TBL_FillAll)
.head 6 +  Else
.head 7 -  Call SalTblPopulate(hWndItem, hSql(), '
     SELECT id,ref,neom,sab,fl,nls,nd,datd,s/100,kv,dkreddog,kvkomiss,kurskonv,idcontract,fnamekb,identkb,tipkb,
            datedokkb,vob,nls,prwo
     INTO   :cid,:cref,:cneom,:csab,:cfl,:cnls,:cnd,:cdatd,:cs,:ckv,:cdkreddog,:ckv2,:ckurskonv,:cidcontract,
            :cfnamekb,:cidentkb,:ctipkb,:cdatedokkb,:cvob,:cnlsp,:cprwo
     FROM   klpv
     WHERE  neom=:nAN and fl<7 and sab=:sSab0 and tipkb=3', TBL_FillAll)
.head 6 -  Call SalTblSetFocusRow(tbl2, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set bFL1 = TRUE
.head 6 +  If cfl = 1
.head 7 -  Set colow = 'W'
.head 6 +  If cfl = 2
.head 7 -  Set colow = 'O'
.head 6 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a
     WHERE  a.nls=:cnls and a.kv=:ckv and a.acc=i.acc"))
.head 6 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 7 -  Set cprwo = '*Запрет на дебет счёта ' || cnls
.head 7 -  Set colow = 'W'
.head 7 -  Set cfl = 1
.head 6 -  Set tbl2.ctt = sOp1
.head 6 -  If SqlPrepareAndExecute(hSqlAux2(), T("
   SELECT vob
   INTO   :tbl2.cvob
   FROM   tts_vob
   WHERE  tt=:tbl2.ctt")) and SqlFetchNext(hSqlAux2(), nFetchRes)
.head 6 +  Else
.head 7 -  ! Set tbl2.ctt = 'XXX'
.head 7 -  Set tbl2.cvob = 6
.head 6 -  Set csort = csab || cidentkb
.head 5 +  On SAM_CreateComplete
.head 6 +  If bFL1
.head 7 -  Call SalTblSortRows(tbl2, SalTblQueryColumnPos(csort), TBL_SortIncreasing)
.head 7 -  Call VisTblAutoSizeColumn(tbl2, hWndNULL)
.head 7 -  Call SalTblSetFocusRow(tbl2, 0)
.head 7 -  Call SalTblSetRowFlags(tbl2, 0, ROW_Selected, TRUE)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Документы "электронных" клиентов отсутствуют !', 'Предупреждение', 0, 1)
.head 7 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  On SAM_RowSetContext
.head 6 -  Call Ostatki()
.head 5 +  On SAM_SetFocus
.head 6 -  Call Ostatki()
.head 3 -  Group Box: Сумма на счёте
.head 4 -  Resource Id: 33848
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    -0.012"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.75"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Group Box: к ОПЛАТЕ
.head 4 -  Resource Id: 33849
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    0.905"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: df1
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.179"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: С учетом д-тов
.head 4 -  Resource Id: 33850
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    0.762"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: df2
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.429"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: df3
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    1.179"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sSab0
.head 3 -  String: sNmk0
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  String: df_titles
.head 3 -  String: d_NDs
.head 3 -  Date/Time: d_DATAs
.head 3 -  String: d_NAMAs
.head 3 -  String: d_BNK_As
.head 3 -  String: d_MFOAs
.head 3 -  ! String: d_NAMBs
.head 3 -  String: d_BNK_Bs
.head 3 -  String: d_MFOBs
.head 3 -  Number: d_Ss
.head 3 -  String: dfCodeCurrencys
.head 3 -  String: d_NLSAs
.head 3 -  String: d_NLSBs
.head 3 -  String: ml_SumPrs
.head 3 -  String: d_NAZNs
.head 3 -  String: sMaket
.head 3 -  Number: nDk
.head 3 -  String: sVspo
.head 3 -  Number: nRef
.head 3 -  ! Long String: lsSign
.head 3 -  !
.head 3 -  Date/Time: dtBD
.head 3 -  Number: nRRR
.head 3 -  Window Handle: hWndTemp
.head 3 -  Number: nFla
.head 3 -  Number: n1234
.head 3 -  Number: n100
.head 3 -  !
.head 3 -  String: sSab
.head 3 -  String: sOper
.head 3 -  String: sKODO
.head 3 -  : cDoc
.head 4 -  Class: cDoc
.head 3 -  !
.head 3 -  Number: nMaket
.head 3 -  !
.head 3 -  Number: nAcc
.head 3 -  Number: nOSTB
.head 3 -  Number: nOSTB8
.head 3 -  !
.head 3 -  String: sTmp
.head 3 -  ! Boolean: bRoll
.head 3 -  Number: nCLNTSEC
.head 3 -  !
.head 3 -  Boolean: bX
.head 3 -  !
.head 3 -  Boolean: bUIklp
.head 3 -  Number: nCountUpd
.head 3 -  !
.head 3 -  String: sOkpoA
.head 3 -  Number: nId
.head 3 -  String: sFileName
.head 3 -  String: NMK
.head 3 -  String: ADRES
.head 3 -  String: OKPO
.head 3 -  String: RUK
.head 3 -  String: BUH
.head 3 -  String: NLS
.head 3 -  String: MFO
.head 3 -  String: NB
.head 3 -  String: DATZ
.head 3 -  String: KVA
.head 3 -  String: KVB
.head 3 -  Number: SUMV
.head 3 -  Number: KURS
.head 3 -  String: REF
.head 3 -  String: DATD
.head 3 -  String: FIO
.head 3 -  String: TEL
.head 3 -  String: sDir
.head 3 -  String: sRab
.head 3 -  Number: nInd
.head 3 -  Boolean: bU
.head 3 -  !
.head 3 -  ! Number: nI
.head 3 -  String: sTemp
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm,'       Принятие решений по "электронным" документам клиента ' || sSab0 || ' (' || sNmk0 ||
     ')')
.head 4 -  Call SalCenterWindow(hWndItem)
.head 4 -  Set bX = TRUE
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_Green)
.head 4 -  Call XSalTooltipSetDelay(200, 30000)
.head 4 -  Set nAN = GetUserId()
.head 4 -  Set dtBD = GetBankDate()
.head 4 -  Set nRRR = -1
.head 4 -  Set nTipPoisk = 4
.head 4 -  Set AMFO = GetBankMfo()
.head 4 -  ! Инициализация параметра CLNTSEC
.head 4 -  Set nCLNTSEC = GetGlobalOptionEx('CLNTSEC')
.head 3 +  On SAM_Close
.head 4 +  If not bX
.head 5 -  Return FALSE
.head 3 +  On SAM_Destroy
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
.head 4 -  Call XSalTooltipSetDelay(200, 4000)
.head 3 +  On SAM_ReportStart
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFetchInit
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFetchNext
.head 4 +  If bU
.head 5 -  Return FALSE
.head 4 -  ! If SqlPrepareAndExecute(hSql(), '
   SELECT c.nmk,c.adr,o.ruk,o.buh,c.okpo,z.fio,z.tel
   INTO   :NMK,:ADRES,:RUK,:BUH,:OKPO,:FIO,:TEL
   FROM   customer c, corps o, cust_zay z
   WHERE  c.sab=:tbl2.csab and c.custtype in (2,3) and c.stmt=5 and c.rnk=o.rnk(+) and c.rnk=z.rnk(+)') and
   SqlFetchNext(hSql(), nFetchRes)
.head 4 -  If SqlPrepareAndExecute(hSql(), '
   SELECT c.nmk,c.adr,o.ruk,o.buh,c.okpo,z.fio,z.tel
   INTO   :NMK,:ADRES,:RUK,:BUH,:OKPO,:FIO,:TEL
   FROM   customer c, corps o, cust_zay z
   WHERE  c.sab=:tbl2.csab and c.custtype in (2,3) and c.stmt=6 and c.rnk=o.rnk(+) and c.rnk=z.rnk(+)') and
   SqlFetchNext(hSql(), nFetchRes)
.head 4 +  Else
.head 5 -  Set OKPO = ''
.head 5 -  Set NMK = ''
.head 5 -  Set ADRES = ''
.head 5 -  Set RUK = ''
.head 5 -  Set BUH = ''
.head 4 -  Set NLS = tbl2.cnls
.head 4 -  Set MFO = GetBankMfo()
.head 4 -  Set NB = GetBankName()
.head 4 -  Set KVA = GetLcv(tbl2.ckv)
.head 4 -  Set SUMV = tbl2.cs*100
.head 4 -  Set KURS = tbl2.ckurskonv
.head 4 -  Set KVB = GetLcv(tbl2.ckv2)
.head 4 +  If tbl2.cdkreddog = DATETIME_Null
.head 5 -  Set DATZ = ''
.head 4 +  Else
.head 5 -  Set DATZ = '"' || SalFmtFormatDateTime(tbl2.cdkreddog, 'd') || '" ' || GetMonthUkr(tbl2.cdkreddog, 'r') ||  ' ' ||
    SalFmtFormatDateTime(tbl2.cdkreddog, 'yyyy') || ' р.'
.head 4 -  ! Set DATZ = IifS(tbl2.cdkreddog=DATETIME_Null, '', '"' || SalFmtFormatDateTime(tbl2.cdkreddog, 'd') || '" ' ||
    GetMonthUkr(tbl2.cdkreddog, 'r') ||  ' ' || SalFmtFormatDateTime(tbl2.cdkreddog, 'yyyy') || ' р.')
.head 4 -  Set DATD = '"' || SalFmtFormatDateTime(tbl2.cdatd, 'd') || '" ' || GetMonthUkr(tbl2.cdatd, 'r') ||  ' ' ||
    SalFmtFormatDateTime(tbl2.cdatd, 'yyyy') || ' р.'
.head 4 -  Set REF = tbl2.cnd
.head 4 -  ! Call Debug(DATZ)
.head 4 -  Set bU = TRUE
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportNotify
.head 4 +  ! If lParam = RPT_BeforeBreakHeader2
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'DT_PRINT', 'Надруковано: ' || SalFmtFormatDateTime(
     SalDateCurrent(), "dd/MM/yyyy hhh:mm:ss"))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'PAX', "Рахунок")
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'ZAKL', IifS(PZ=1, 'Поточна', 'Заключна'))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'SHAP',
     "Nпп Документ   ВО    МФО    Кореспондент   СКП         Сума: ДЕБ КРЕД")
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'BPEM', BPEM)
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'AQH', AQH)
.head 5 -  Set DOS = 0
.head 5 -  Set NPP = 0
.head 5 -  Set KOS = 0
.head 5 -  Set S2 = S1
.head 5 -  Set FIO = 'Вик.' || ISP
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'VSA', ' Вхідне сальдо ' || DK(S1))
.head 4 +  ! If lParam = RPT_BeforeDetail
.head 5 +  If S < 0
.head 6 -  Set DOS = DOS - S
.head 5 +  Else 
.head 6 -  Set KOS = KOS + S
.head 5 -  Set NPP = NPP + 1
.head 5 -  Set S2 = S2 + S
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'NPP', NPP)
.head 4 +  ! If lParam = RPT_BeforeBreakFooter2
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'ISA', 'Вихідне сальдо ' || DK(S2))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'OBO', 'Всього оборотів ')
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'FIO', FIO)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'S2', S2)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'DOS', DOS)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'KOS', KOS)
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFinish
.head 4 -  ! Call DirectView(sFileName)
.head 1 +  Dialog Box: dlg_6
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
.head 4 -  Left:   0.25"
.head 4 -  Top:    0.156"
.head 4 -  Width:  13.333"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.833"
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
.head 3 +  Pushbutton: pbF2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Доп.реквизиты
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    1.81"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F2
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf2.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: White
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set sKOD_B = tbl2.ckod_b
.head 7 -  Set sKOD_N = tbl2.ckod_n
.head 7 -  Set sKOD_G = tbl2.ckod_g
.head 7 +  If SalModalDialog(TT_KOD_NBG, hWndForm, smKOD_B, smKOD_N, smKOD_G) = 1
.head 8 -  Set tbl2.ckod_b = sKOD_B
.head 8 -  Set tbl2.ckod_n = sKOD_N
.head 8 -  Set tbl2.ckod_g = sKOD_G
.head 8 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    kod_b=:tbl2.ckod_b,kod_n=:tbl2.ckod_n,kod_g=:tbl2.ckod_g
   WHERE  id=:tbl2.cid')
.head 9 -  Call SqlCommit(hSql())
.head 9 +  If (SalStrTrimX(tbl2.ckod_g) = '' or SalStrTrimX(tbl2.ckod_n) = '') and tbl2.colow = 'O'
.head 10 -  Set tbl2.colow = ' '
.head 10 -  Set tbl2.cfl = 0
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Доввод реквизитов документа для 1_ПБ')
.head 3 +  Pushbutton: pbF3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Возвратить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    2.298"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F3
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf3_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 +  If SalModalDialog(wozwrat, hWndForm) != -1
.head 8 -  Set nRow = TBL_MinRow
.head 8 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 9 -  Call SalTblFetchRow(tbl2, nRow)
.head 9 +  If (tbl2.cfl = NUMBER_Null or tbl2.cfl = 0) and Len(SalStrTrimX(sWW)) > 0
.head 10 -  Set tbl2.colow = 'W'
.head 10 -  Set tbl2.cfl = 1
.head 10 -  Set tbl2.cprwo = sWW
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call VisTblAutoSizeColumn(tbl2, hWndNULL)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить на возврат выбранные документы')
.head 3 +  Pushbutton: pbF4
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: К оплате
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    2.798"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F4
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf4_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
! SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cfl = NUMBER_Null or tbl2.cfl = 0
.head 9 -  Set tbl2.colow = 'O'
.head 9 -  Set tbl2.cfl = 2
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 +  ! If SalStrTrimX(tbl2.ckod_g) != '' and SalStrTrimX(tbl2.ckod_n) != ''
.head 10 -  Set tbl2.colow = 'O'
.head 10 -  Set tbl2.cfl = 2
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 +  ! Else
.head 10 -  Call MessageNoWait('Необходимо доввести дополнительные (для 1_ПБ) реквизиты документа ' || tbl2.cnd,
     'ВНИМАНИЕ !', 7, 1)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить выбранные документы к оплате')
.head 3 +  Pushbutton: pbF5
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Печать
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    3.31"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F5
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf5_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  ! If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
! SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Set nckv = tbl2.ckv
.head 8 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nmk,okpo
     INTO   :d_NAMAs,:sOkpoA
     FROM   customer c, cust_acc u, accounts a
     WHERE  a.nls=:tbl2.cnls and a.kv=:nckv and c.rnk=u.rnk and a.acc=u.acc'))
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 8 -  Set nDk = 1
.head 8 -  Call DocsPrintFromParam(0, tbl2.ckv, tbl2.cvob, tbl2.cnd, AMFO, sOkpoA, GetBankName(), tbl2.cnls, d_NAMAs,
     tbl2.cs*100, NUMBER_Null, nDk, AMFO, sOkpoA, d_BNK_Bs, tbl2.cnlsp, d_NAMAs, tbl2.ckv, tbl2.cs*100,
     'Конверсия валюты', tbl2.cdatd, PRINT_DOC)
.head 8 -  ! Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 6 -  Set sDir = GetTemplateDir() || "\\ZAY_ORD.QRP"
.head 6 -  Set sFileName = GetPrnDir() || '\\D' || Str(tbl2.cref) || '.za6'
.head 6 -  Set sRab = 'REF,DATZ,RUK,BUH,NB_A,CB_A,NK_A,CK_A,NLS_A,SUM,KV,SUMPR,NO1,NO2,NO3,NO4,NO5,BO1,BO2,BO3,BO4,BP1,BP2,BP3,'
    || 'BP4,NP1,NP2,NP3,NP4,ID_OPER,COUNTRY_B,COST,KV_COST,EXPRESS,ADRES,OKPO'
.head 6 -  Set bU = FALSE
.head 6 -  Call SalReportPrintToFile(hWndForm, sDir, sFileName, sRab, sRab, 1, RPT_PrintAll, 1, 1, FALSE, nInd)
.head 6 -  Call zarez12(sFileName, 0, '')
.head 6 -  Call DosDirectPrint(sFileName)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отпечатать текущий документ')
.head 3 +  Pushbutton: pbF7
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Поиск
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    3.821"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F7
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf7_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nTipPoisk = SalModalDialog(poisk, hWndForm)
.head 6 +  If nTipPoisk = 1
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 8 -  Call SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 7 +  Else
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cs = nGetSum
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If not nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 6 +  Else If nTipPoisk = 2
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If NOT SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'O'
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If NOT nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 6 +  Else If nTipPoisk = 3
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If NOT SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'W'
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If NOT nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Поиск документа от текущей позиции вниз')
.head 3 +  Pushbutton: pbF8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Снять отметку
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    4.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F8
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf8_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If (tbl2.cfl = 1 and Left(tbl2.cprwo, 1) != '*') or tbl2.cfl = 2 or tbl2.cfl = 3
.head 9 -  Set tbl2.colow = ' '
.head 9 -  Set tbl2.cfl = 0
.head 9 -  Set tbl2.cprwo = ''
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Сбросить пометки с выбранных документов')
.head 3 +  Pushbutton: pbF9
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Документ
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    4.821"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F9
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf9_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set sDir = GetTemplateDir() || "\\ZAY_ORD.QRP"
.head 6 -  Set sFileName = GetPrnDir() || '\\D' || Str(tbl2.cref) || '.za6'
.head 6 -  ! Call Debug(sFileName)
.head 6 -  Set sRab = 'REF,DATZ,RUK,BUH,NB_A,CB_A,NK_A,CK_A,NLS_A,SUM,KV,SUMPR,NO1,NO2,NO3,NO4,NO5,BO1,BO2,BO3,BO4,BP1,BP2,BP3,'
    || 'BP4,NP1,NP2,NP3,NP4,ID_OPER,COUNTRY_B,COST,KV_COST,EXPRESS,ADRES,OKPO'
.head 6 -  Set bU = FALSE
.head 6 -  ! Set nInd = RPT_NoToolbar
.head 6 -  Call SalReportPrintToFile(hWndForm, sDir, sFileName, sRab, sRab, 1, RPT_PrintAll, 1, 1, FALSE, nInd)
.head 6 -  ! Call DebugN(nInd)
.head 6 -  Call zarez12(sFileName, 0, '')
.head 6 -  ! Call Debug(GetPrnDir() || '\\' || sFileName)
.head 6 -  Call DirectView(sFileName)
.head 6 -  ! Call DirectView(GetPrnDir() || '\\' || sFileName)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Просмотр выбранного документа')
.head 3 +  Pushbutton: pb10
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обработать
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    5.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F10
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold-Italic
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf10_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox('ЕСЛИ Вы НЕ ОТПЕЧАТАЛИ ПОМЕЧЕННЫЕ к оплате ДОКУМЕНТЫ, то сделать ЭТО Вы сможете только из АРХИВА,' ||
   ' СОГЛАСНЫ на обработку ?', "Обработать и выйти", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 -  Call SalDisableWindow(pbF2)
.head 7 -  Call SalDisableWindow(pbF3)
.head 7 -  Call SalDisableWindow(pbF4)
.head 7 -  Call SalDisableWindow(pbF5)
.head 7 -  Call SalDisableWindow(pbF7)
.head 7 -  Call SalDisableWindow(pbF8)
.head 7 -  Call SalDisableWindow(pbF9)
.head 7 -  Call SalDisableWindow(pb10)
.head 7 -  Call SalDisableWindow(pbEsc)
.head 7 -  Set bX = FALSE
.head 7 +  If SalTblAnyRows(tbl2, ROW_Edited, 0)
.head 8 +  If SqlPrepare(hSql(), '
   UPDATE klpv
   SET    prwo=:tbl2.cprwo,fl=:tbl2.cfl
   WHERE  id=:tbl2.cid')
.head 9 -  Call SalTblDoUpdates(tbl2, hSql(), TRUE)
.head 9 -  Call SqlCommit(hSql())
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 8 -  Call SalTblSetContext(tbl2, nRow)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'W' ! возвратить
.head 9 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    fl=9
   WHERE  id=:tbl2.cid')
.head 10 -  Set sSab = tbl2.csab
.head 10 -  Set sOper = Right(Str(10000+tbl2.cneom), 4)
.head 10 -  Set n100 = tbl2.cs*100
.head 10 +  If SqlPrepareAndExecute(hSql(), '
   SELECT S_zay_baop.NEXTVAL
   INTO   :nId
   FROM   DUAL') and SqlFetchNext(hSql(), nFetchRes)
.head 11 +  If SqlPrepareAndExecute(hSql(), T("
   INSERT
   INTO   zay_baop (id,tipkb,kod,textback,identkb,fnamekb)
   VALUES (:nId,:tbl2.ctipkb,88,:tbl2.cprwo,:tbl2.cidentkb,:tbl2.cfnamekb)"))
.head 12 -  Call SqlCommit(hSql())
.head 12 -  Call SalTblSetContext(tbl2, nRow)
.head 12 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 12 -  Set tbl2.colow = 'w'
.head 12 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_Salmon)
.head 12 -  Call MessageNoWait('Возвращен "электронный" док.' || SalStrTrimX(tbl2.cnd) || '), Счёт А=' || tbl2.cnls ||
     ', Сумма=' || SalNumberToStrX(tbl2.cs, 2), 'Сообщение', .1, 0)
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 8 +  Else If tbl2.colow = 'O' ! к оплате
.head 9 -  Set nDk = 1
.head 9 -  ! Set nckv = tbl2.ckv
.head 9 -  Set nAcc = 0
.head 9 -  Set nOSTB = 0
.head 9 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 9 -  !
.head 9 -  Set sTT = tbl2.ctt
.head 9 -  Set sNLSorig = tbl2.cnls
.head 9 -  Set nKvKomiss = tbl2.ckvkomiss
.head 9 -  Set sTag72n = tbl2.ctag72n
.head 9 -  Set nKv = tbl2.ckv
.head 9 -  Set nSumma = tbl2.cs
.head 9 -  Set nRef = tbl2.cref
.head 9 -  Set nVob = tbl2.cvob
.head 9 -  Set sNd = tbl2.cnd
.head 9 -  Set dDatd = tbl2.cdatd
.head 9 -  Set sTag70 = tbl2.ctag70
.head 9 -  Set nTipkb = tbl2.ctipkb
.head 9 -  Set sFnamekb = tbl2.cfnamekb
.head 9 -  Set sIdentkb = tbl2.cidentkb
.head 9 -  Set dDatedokkb = tbl2.cdatedokkb
.head 9 -  Set sTag57a = tbl2.ctag57a
.head 9 -  ! Call Debug(sTag57a)
.head 9 -  !
.head 9 -  Set nNumTokens = SalStrTokenize(sTag57a, '', PutCrLf(), sToken57a)
.head 9 -  Set sBIC = sToken57a[nNumTokens-1]
.head 9 -  ! Set nSEB = Val(GetValueStr("
    SELECT to_char(gruppa)
    FROM   sw_banks
    WHERE  bic='" || sBIC || "%'"))
.head 9 -  Set nSEB = IifN(ValidateBIC(sBIC), Val(GetValueStr("
    SELECT to_char(gruppa)
    FROM   sw_banks
    WHERE  bic='" || sBIC || IifS(Len(sBIC)=8, "XXX", "") || "'")), 0)
.head 9 -  ! Call Debug(sBIC || ' --- ' || Str(nSEB) || ' --- ' || "
    SELECT to_char(gruppa)
    FROM   sw_banks
    WHERE  bic='" || sBIC || IifS(Len(sBIC)=8, "XXX", "") || "'")
.head 9 -  ! Call Debug(sBIC)
.head 9 -  !
.head 9 -  Set sTag59 = tbl2.ctag59
.head 9 -  Set sTag56 = tbl2.ctag56
.head 9 -  Set sKod_b = tbl2.ckod_b
.head 9 -  Set sKod_n = tbl2.ckod_n
.head 9 -  Set sKod_g = tbl2.ckod_g
.head 9 -  Set nIdd = tbl2.cid
.head 9 +  If tbl2.courbensha = 0
.head 10 -  Set sType = 'OUR'
.head 9 +  Else If tbl2.courbensha = 1
.head 10 -  Set sType = 'BEN'
.head 9 +  Else !! If tbl2.courbensha = 2
.head 10 -  Set sType = 'SHA'
.head 9 -  !
.head 9 +  ! If SqlPrepareAndExecute(hSql(), T('
   SELECT nlsk
   INTO   :sNLSK
   FROM   tts
   WHERE  tt=:sTT'))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  ! Set sNLSK = GetValueStr("
    SELECT nlsk
    FROM   tts
    WHERE  tt='" || sTT || "'")
.head 9 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT nvl(c.nmkk,c.nmk),a.acc,a.ostb,c.okpo,c.nmkv,decode(g.codcagent,3,0,4,0,5,1,6,1,0)
   INTO   :d_NAMAs,:nAcc,:nOSTB,:sOkpoA,:sNMKV,:nFizLJurL
   FROM   customer c, accounts a, codcagent g
   WHERE  a.nls=:sNLSorig and a.kv=:nKv and c.rnk=a.rnk and c.codcagent=g.codcagent'))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  !
.head 9 -  ! превентивно высчитываем комиссию в гривне и в валюте
.head 9 -  ! Set nSkomisVal = Val(GetValueStr("
    SELECT to_char(f_tarif_klw(1,'" || sType || "'," || Str(nKvKomiss) || "," || sTag72n || "," || Str(nKv) ||
           ",'" || sNLSorig || "'," || Str(nSumma*100) || "," || Str(nSEB) || "," || Str(nFizLJurL) || "))
    FROM   dual"))
.head 9 -  ! Set nSkomisGrn = Val(GetValueStr("
    SELECT to_char(f_tarif_klw(2,'" || sType || "'," || Str(nKvKomiss) || "," || sTag72n || "," || Str(nKv) ||
           ",'" || sNLSorig || "'," || Str(nSumma*100) || "," || Str(nSEB) || "," || Str(nFizLJurL) || "))
    FROM   dual"))
.head 9 -  Set nSkomisGrn = Val(GetValueStr("
    SELECT to_char(f_tarif_klz('" || sNLSorig || "'," || Str(nKv) || "," || Str(nSumma*100) || "))
    FROM   dual"))
.head 9 -  Set nSkomisVal = Val(GetValueStr("
    SELECT to_char(gl.p_ncurval(" || Str(nKv) || "," || Str(nSkomisGrn) || ",bankdate" || "))
    FROM   dual"))
.head 9 -  ! Set nSkomisGrn = Val(GetValueStr("
    SELECT to_char(f_tarif_klw(2,'" || sType || "'," || Str(nKv) || "," || sTag72n || "," || Str(nKv) || ",'" ||
           sNLSorig || "'," || Str(nSumma*100) || "))
    FROM   dual"))
.head 9 -  ! высчитываем дату валютирования перевода от срочности: X(X+1)/2
.head 9 +  ! If sTag72n = '0'
.head 10 -  Set nDatValut = 0 ! терміновий
.head 9 +  ! Else If sTag72n = '1'
.head 10 -  Set nDatValut = 1 ! строковий
.head 9 +  ! Else !! If sTag72n = '2'
.head 10 -  Set nDatValut = 3 ! звичайний
.head 9 -  Set nDatValut = Val(sTag72n)
.head 9 -  ! 0 - терміновий
  1 - строковий
  2 - звичайний
.head 9 -  If SqlPrepareAndExecute(hSql(), "
   SELECT Dat_Next_U(:dtBD,:nDatValut)
   INTO   :dDatValut
   FROM   dual") and SqlFetchNext(hSql(), nFetchRes)
.head 9 +  Else
.head 10 -  Set dDatValut = dtBD
.head 9 -  ! вычислить тип контрагента (ЮЛ или ФЛ) - выше уже вычислено (nFizLJurL)
.head 9 -  ! присвоить необходимые счета для основной операции: счётБ - T00
.head 9 +  If (sType = 'OUR' or sType = 'SHA')
.head 10 +  If sTag72n = '0'
.head 11 -  Set sNLS = sNLSorig
.head 10 +  Else !! sTag72n = '1' or sTag72n = '2'
.head 11 +  If nFizLJurL = 0
.head 12 -  Set sNLS = sNlsJurL
.head 11 +  Else
.head 12 -  Set sNLS = sNlsFizL
.head 9 +  Else !! sType = 'BEN'
.head 10 +  If nFizLJurL = 0
.head 11 -  Set sNLS = sNlsJurL
.head 10 +  Else
.head 11 -  Set sNLS = sNlsFizL
.head 9 -  Set sNLSK = sNlsT00
.head 9 -  Set sTT = sOp1
.head 9 +  If (sType = 'OUR' or sType = 'SHA')
.head 10 -  Set nS = nSumma*100
.head 9 +  Else
.head 10 -  Set nS = nSumma*100 - nSkomisVal
.head 9 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT nvl(c.nmkk,c.nmk),c.okpo
   INTO   :d_NAMBs,:sOkpoB
   FROM   customer c, accounts a
   WHERE  a.nls=:sNLSK and a.kv=:nKv and c.rnk=a.rnk'))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  !
.head 9 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.SetDoc(ref==>' || Str(nRef) || ')')
.head 9 -  ! Call cDoc.SetDoc(nRef, sTT, nDk, nVob, sNd, dDatd, dtBD, dDatValut, dtBD, sNLSorig, d_NAMAs, AMFO, '', nKv,
     nSumma*100, sOkpoA, sNLSK, d_NAMBs, AMFO, '', nKv, nSumma*100, sOkpoB, sTag70, '', GetIdOper(), '',
     NUMBER_Null, 0)
.head 9 -  ! Call cDoc.SetDoc(nRef, sTT, nDk, nVob, sNd, dDatd, dtBD, dDatValut, dtBD, sNLSorig, d_NAMAs, AMFO, '', nKv,
     nS, sOkpoA, sNLSK, d_NAMBs, AMFO, '', nKv, nS, sOkpoB, sTag70, '', GetIdOper(), '', NUMBER_Null, 0)
.head 9 -  Call cDoc.SetDoc(nRef, sTT, nDk, nVob, sNd, dDatd, dtBD, dtBD, dtBD, sNLSorig, d_NAMAs, AMFO, '', nKv, nS,
     sOkpoA, sNLSK, d_NAMBs, AMFO, '', nKv, nS, sOkpoB, sTag70, '', GetIdOper(), '', NUMBER_Null, 0)
.head 9 -  Set cDoc.m_nNom = nS - Max(nOSTB, 0)
.head 9 -  Set cDoc.m_sRef_A = Str(nRef)
.head 9 +  If cDoc.sDoc()
.head 10 -  ! Call SalTblSetContext(tbl2, nRow)
.head 10 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 10 +  ! If tbl2.courbensha = 0
.head 11 -  Set cDoc.s1 = 'OUR'
.head 10 +  ! Else If tbl2.courbensha = 1
.head 11 -  Set cDoc.s1 = 'BEN'
.head 10 +  ! Else !! If tbl2.courbensha = 2
.head 11 -  Set cDoc.s1 = 'SHA'
.head 10 -  Set cDoc.s1 = sType
.head 10 -  Set cDoc.s2 = Right('000' || Str(nKvKomiss), 3)
.head 10 -  ! Set cDoc.s3 = IifS(sTag72n='0', '/EARLY/', '')
.head 10 -  Set cDoc.s3 = sTag72n
.head 10 +  If cDoc.iDoc()
.head 11 -  ! Call cDoc.A.SetStorona(sNLSorig, d_NAMAs, AMFO, '', nKv, nSumma*100, sOkpoA)
.head 11 -  ! Call cDoc.A.SetStorona(sNLS, d_NAMAs, AMFO, '', nKv, nS, sOkpoA)
.head 11 -  ! Call cDoc.B.SetStorona(sNLSK, d_NAMBs, AMFO, '', nKv, nS, sOkpoB)
.head 11 -  Set cDoc.m_dDatV1 = dDatValut
.head 11 +  If cDoc.oDoc()
.head 12 +  ! If tbl2.courbensha = 0
.head 13 -  Set sOURBENSHA = 'OUR'
.head 12 +  ! Else If tbl2.courbensha = 1
.head 13 -  Set sOURBENSHA = 'BEN'
.head 12 +  ! Else !! If tbl2.courbensha = 2
.head 13 -  Set sOURBENSHA = 'SHA'
.head 12 -  ! Set sKLVKV = Right('000' || Str(tbl2.ckvkomiss), 3)
.head 12 -  ! Call SalTblSetContext(tbl2, nRow)
.head 12 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 12 -  ! If SqlPrepareAndExecute(hSql(), "
   UPDATE oper
   SET    nlsa=:sNLSorig,s=:nSumma*100,s2=:nSumma*100
   WHERE  ref=:cDoc.m_nRef")
.head 12 -  Set sTag57a = VisStrSubstitute(Left(sTag57a, Len(sTag57a)-1), Chr(10), PutCrLf())
.head 12 -  Set sTag59 = VisStrSubstitute(Left(sTag59, Len(sTag59)-1), Chr(10), PutCrLf())
.head 12 -  Set sTag56 = VisStrSubstitute(Left(sTag56, Len(sTag56)-1), Chr(10), PutCrLf())
.head 12 -  Set sTag70 = VisStrSubstitute(Left(sTag70, Len(sTag70)-1), Chr(10), PutCrLf())
.head 12 -  ! удаление двойных 0D0A
.head 12 -  Set sTag57a = VisStrSubstitute(sTag57a, Repl(PutCrLf(), 2), PutCrLf())
.head 12 -  Set sTag59 = VisStrSubstitute(sTag59, Repl(PutCrLf(), 2), PutCrLf())
.head 12 -  Set sTag56 = VisStrSubstitute(sTag56, Repl(PutCrLf(), 2), PutCrLf())
.head 12 -  Set sTag70 = VisStrSubstitute(sTag70, Repl(PutCrLf(), 2), PutCrLf())
.head 12 -  ! удаление концевых 0D0A
.head 12 +  If Right(sTag57a, 2) = PutCrLf()
.head 13 -  Set sTag57a = Left(sTag57a, Len(sTag57a)-2)
.head 12 +  If Right(sTag59, 2) = PutCrLf()
.head 13 -  Set sTag59 = Left(sTag59, Len(sTag59)-2)
.head 12 +  If Right(sTag56, 2) = PutCrLf()
.head 13 -  Set sTag56 = Left(sTag56, Len(sTag56)-2)
.head 12 +  If Right(sTag70, 2) = PutCrLf()
.head 13 -  Set sTag70 = Left(sTag70, Len(sTag70)-2)
.head 12 +  ! If Len(sBIC) > 10
.head 13 -  Set sTag57 = '57A  '
.head 13 -  Set sValueTag57 = sBIC
.head 12 +  ! Else
.head 13 -  Set sTag57 = '57D  '
.head 13 -  Set sValueTag57 = sTag57a
.head 12 -  ! Set sTag57 = IifS(Len(sBIC)>0, '57A  ', '57D  ')
.head 12 -  ! Set sValueTag57 = IifS(Len(sBIC)>0, sBIC, sTag57a)
.head 12 -  Set sTag57 = IifS(ValidateBIC(sBIC), '57A  ', '57D  ')
.head 12 -  Set sValueTag57 = IifS(ValidateBIC(sBIC), sBIC, sTag57a)
.head 12 +  If SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'TIPKB',:nTipkb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'FN_KB',:sFnamekb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'ID_KB',:sIdentkb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'DATKB',:dDatedokkb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,:sTag57,:sValueTag57)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'59   ',:sTag59)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'56   ',:sTag56)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'70   ',:sTag70)") !! and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'72   ',:sTag72n)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'KLVZA',:sType)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'KLVKV',:sKLVKV)")
.head 13 -  ! If SqlPLSQLCommand(hSql(), "bars_swift_msg.docmsg_document_validate(cDoc.m_nRef)")
.head 13 -  ! Call SalTblSetContext(tbl2, nRow)
.head 13 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 13 +  If Len(SalStrTrimX(sKod_b)) > 0
.head 14 -  Call SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'KOD_B',:sKod_b)")
.head 13 +  If Len(SalStrTrimX(sKod_n)) > 0
.head 14 -  Call SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'KOD_N',:sKod_n)")
.head 13 +  If Len(SalStrTrimX(sKod_g)) > 0
.head 14 -  Call SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'KOD_G',:sKod_g)")
.head 13 -  !
.head 13 +  If sType = 'BEN'
.head 14 -  Set s71F = GetLcv(nKv) || '0,'
.head 14 -  Call SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'71F  ',:s71F)")
.head 14 -  Set s33B = GetLcv(nKv) || Str(nS/100)
.head 14 -  Set nI = At('.', s33B)
.head 14 +  If nI = 0
.head 15 -  Set s33B = s33B || ','
.head 14 +  Else
.head 15 -  Set s33B = Left(s33B, nI-1) || ',' || Right(s33B, Len(s33B)-nI)
.head 14 -  Call SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'33B  ',:s33B)")
.head 13 -  !
.head 13 -  Set nRef = cDoc.m_nRef
.head 13 -  !
.head 13 -  ! "родить" первую дочернюю операцию
.head 13 -  ! Call SalTblSetContext(tbl2, nRow)
.head 13 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 13 -  ! SEB - выкидываю
.head 13 +  ! If nKvKomiss = nVal !! 980
.head 14 -  Set sTT = sOp3
.head 14 -  Set nS1 = nSkomisGrn
.head 14 -  Set nS2 = nS1
.head 13 +  ! Else
.head 14 -  Set sTT = sOp2
.head 14 -  Set nS1 = nSkomisVal
.head 14 -  Set nS2 = nSkomisGrn
.head 13 +  ! If (sType = 'OUR' or sType = 'SHA')
.head 14 -  Set sNLS = sNLSorig
.head 13 +  ! Else !! sType = 'BEN'
.head 14 +  If nFizLJurL = 0
.head 15 -  Set sNLS = sNlsJurL
.head 14 +  Else 
.head 15 -  Set sNLS = sNlsFizL
.head 13 -  ! Set sNLSK = sNls6val
.head 13 +  ! If SqlPrepareAndExecute(hSql(), '
   SELECT to_number(substr(flags,38,1))
   INTO   :nFLG
   FROM   tts
   WHERE  tt=:sTT') and SqlFetchNext(hSql(), nFetchRes)
.head 14 -  ! paytt1
.head 14 -  !
.head 14 -  ! Call Debug('paytt1 .. ' ||                   PutCrLf() ||
           'sType=    ' || sType          || PutCrLf() ||
           'sTag72n=  ' || sTag72n        || PutCrLf() ||
           'nFLG=     ' || Str(nFLG)      || PutCrLf() ||
           'nRef=     ' || Str(nRef)      || PutCrLf() ||
           'sTT=      ' || sTT            || PutCrLf() ||
           'nKvKomiss=' || Str(nKvKomiss) || PutCrLf() ||
           'sNLS=     ' || sNLS           || PutCrLf() ||
           'nS1=      ' || Str(nS1)       || PutCrLf() ||
           'nVal=     ' || Str(nVal)      || PutCrLf() ||
           'sNLSK=    ' || sNLSK          || PutCrLf() ||
           'nS2=      ' || Str(nS2))
.head 14 -  ! Call SalTblSetContext(tbl2, nRow)
.head 14 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 14 +  If cDoc.PayTT(nFLG, nRef, dtBD, sTT, nDk, nKvKomiss, sNLS, nS1, nVal, sNLSK, nS2)
.head 15 -  ! paytt2
.head 15 -  ! Call SalTblSetContext(tbl2, nRow)
.head 15 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 15 -  Set sNLS = sNLSorig
.head 15 +  If (sType = 'OUR' or sType = 'SHA') and sTag72n = '0'
.head 16 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.oDoc() return ref==>' || Str(cDoc.m_nRef))
.head 16 -  Call SalTblSetContext(tbl2, nRow)
.head 16 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 16 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    fl=8
   WHERE  id=:nIdd')
.head 17 -  ! вставить запись в zay_baop с кодом 0
.head 17 +  If SqlPrepareAndExecute(hSql(), '
   SELECT S_zay_baop.NEXTVAL
   INTO   :nId
   FROM   DUAL') and SqlFetchNext(hSql(), nFetchRes)
.head 18 -  ! Call SalTblSetContext(tbl2, nRow)
.head 18 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 18 +  If SqlPrepareAndExecute(hSql(), '
   INSERT
   INTO   zay_baop (id,tipkb,kod,identkb,fnamekb)
   VALUES (:nId,:nTipkb,0,:sIdentkb,:sFnamekb)')
.head 19 -  Call SalTblSetContext(tbl2, nRow)
.head 19 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 19 -  Call SqlCommit(hSql())
.head 19 -  Set tbl2.colow = 'o'
.head 19 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightGreen)
.head 19 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(sNd) || ', (Ref=' || Str(nRef)
     || '), Счёт А=' || sNLSorig || ', Сумма=' || SalNumberToStrX(nSumma, 2), 'Сообщение', .1,
     0)
.head 18 +  Else 
.head 19 -  Call SqlRollback(hSql())
.head 17 +  Else 
.head 18 -  Call SqlRollback(hSql())
.head 16 +  Else 
.head 17 -  Call SqlRollback(hSql())
.head 15 +  Else 
.head 16 -  ! Call SalTblSetContext(tbl2, nRow)
.head 16 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 16 +  If nFizLJurL = 0
.head 17 -  Set sNLSK = sNlsJurL
.head 16 +  Else 
.head 17 -  Set sNLSK = sNlsFizL
.head 16 -  Set sTT = sOp1
.head 16 -  Set nS = nSumma*100
.head 16 +  If SqlPrepareAndExecute(hSql(), '
   SELECT to_number(substr(flags,38,1))
   INTO   :nFLG
   FROM   tts
   WHERE  tt=:sTT') and SqlFetchNext(hSql(), nFetchRes)
.head 17 -  ! Call SalTblSetContext(tbl2, nRow)
.head 17 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 17 -  ! Call Debug('paytt2..' ||              PutCrLf() ||
           'sType=  ' || sType     || PutCrLf() ||
           'sTag72n=' || sTag72n   || PutCrLf() ||
           'nFLG=   ' || Str(nFLG) || PutCrLf() ||
           'nRef=   ' || Str(nRef) || PutCrLf() ||
           'sTT=    ' || sTT       || PutCrLf() ||
           'nKv=    ' || Str(nKv)  || PutCrLf() ||
           'sNLS=   ' || sNLS      || PutCrLf() ||
           'nS=     ' || Str(nS)   || PutCrLf() ||
           'nKv=    ' || Str(nKv)  || PutCrLf() ||
           'sNLSK=  ' || sNLSK     || PutCrLf() ||
           'nS=     ' || Str(nS))
.head 17 -  ! Call SalTblSetContext(tbl2, nRow)
.head 17 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 17 +  If cDoc.PayTT(nFLG, nRef, dtBD, sTT, nDk, nKv, sNLS, nS, nKv, sNLSK, nS)
.head 18 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.oDoc() return ref==>' || Str(cDoc.m_nRef))
.head 18 -  ! Call SalTblSetContext(tbl2, nRow)
.head 18 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 18 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    fl=8
   WHERE  id=:nIdd')
.head 19 -  ! вставить запись в zay_baop с кодом 0
.head 19 +  If SqlPrepareAndExecute(hSql(), '
   SELECT S_zay_baop.NEXTVAL
   INTO   :nId
   FROM   DUAL') and SqlFetchNext(hSql(), nFetchRes)
.head 20 -  ! Call SalTblSetContext(tbl2, nRow)
.head 20 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 20 +  If SqlPrepareAndExecute(hSql(), '
   INSERT
   INTO   zay_baop (id,tipkb,kod,identkb,fnamekb)
   VALUES (:nId,:nTipkb,0,:sIdentkb,:sFnamekb)')
.head 21 -  Call SalTblSetContext(tbl2, nRow)
.head 21 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 21 -  Call SqlCommit(hSql())
.head 21 -  Set tbl2.colow = 'o'
.head 21 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightGreen)
.head 21 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(sNd) || ', (Ref=' ||
     Str(nRef) || '), Счёт А=' || sNLSorig || ', Сумма=' || SalNumberToStrX(nSumma, 2),
     'Сообщение', .1, 0)
.head 20 +  Else 
.head 21 -  Call SqlRollback(hSql())
.head 19 +  Else 
.head 20 -  Call SqlRollback(hSql())
.head 18 +  Else 
.head 19 -  Call SqlRollback(hSql())
.head 17 +  Else 
.head 18 -  Call SqlRollback(hSql())
.head 16 +  Else 
.head 17 -  Call SqlRollback(hSql())
.head 14 +  Else 
.head 15 -  Call SqlRollback(hSql())
.head 13 +  ! Else
.head 14 -  Call SqlRollback(hSql())
.head 13 -  ! SEB
.head 13 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.oDoc() return ref==>' || Str(cDoc.m_nRef))
.head 13 -  Call SalTblSetContext(tbl2, nRow)
.head 13 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 13 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    fl=8
   WHERE  id=:nIdd')
.head 14 -  ! вставить запись в zay_baop с кодом 0
.head 14 +  If SqlPrepareAndExecute(hSql(), '
   SELECT S_zay_baop.NEXTVAL
   INTO   :nId
   FROM   DUAL') and SqlFetchNext(hSql(), nFetchRes)
.head 15 -  ! Call SalTblSetContext(tbl2, nRow)
.head 15 -  ! Call SalTblSetFocusRow(tbl2, nRow)
.head 15 +  If SqlPrepareAndExecute(hSql(), '
   INSERT
   INTO   zay_baop (id,tipkb,kod,identkb,fnamekb)
   VALUES (:nId,:nTipkb,0,:sIdentkb,:sFnamekb)')
.head 16 -  Call SalTblSetContext(tbl2, nRow)
.head 16 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 16 -  Call SqlCommit(hSql())
.head 16 -  Set tbl2.colow = 'o'
.head 16 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightGreen)
.head 16 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(sNd) || ', (Ref=' || Str(nRef) ||
     '), Счёт А=' || sNLSorig || ', Сумма=' || SalNumberToStrX(nSumma, 2), 'Сообщение', .1, 0)
.head 15 +  Else
.head 16 -  Call SqlRollback(hSql())
.head 14 +  Else
.head 15 -  Call SqlRollback(hSql())
.head 13 +  Else
.head 14 -  Call SqlRollback(hSql())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 7 -  ! Call SalEnableWindow(pbF2)
.head 7 -  ! Call SalEnableWindow(pbF3)
.head 7 -  ! Call SalEnableWindow(pbF4)
.head 7 -  ! Call SalEnableWindow(pbF5)
.head 7 -  ! Call SalEnableWindow(pbF6)
.head 7 -  ! Call SalEnableWindow(pbF7)
.head 7 -  ! Call SalEnableWindow(pbF8)
.head 7 -  ! Call SalEnableWindow(pbF9)
.head 7 -  ! Call SalEnableWindow(pbF10)
.head 7 -  Set bX = TRUE
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Обработать помеченные на ВОЗВРАТ и к ОПЛАТЕ документы и выйти')
.head 3 +  Pushbutton: pbEsc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отложить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    5.917"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold-Italic
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Besc_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox("Вы уверены ?", "Отложить обработку", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 +  If SalTblAnyRows(tbl2, ROW_Edited, 0)
.head 8 +  If SqlPrepare(hSql(), '
   UPDATE klpv
   SET    prwo=:tbl2.cprwo,fl=:tbl2.cfl
   WHERE  id=:tbl2.cid')
.head 9 -  Call SalTblDoUpdates(tbl2, hSql(), TRUE)
.head 9 -  Call SqlCommitEx(hSql(), 'Обновление KLPV')
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отложить обработку с сохранением пометок')
.head 3 +  ! Data Field: daf1
.winattr
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
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Height: Default
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
.end
.head 4 +  Message Actions
.head 5 +  On WM_Char
.head 6 -  Call SalMessageBox(SalNumberToStrX(wParam , 0), 'wParam', MB_Ok)
.head 3 +  Child Table: tbl2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    -0.012"
.head 6 -  Width:  11.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 6.5"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colow
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
_
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 1
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.25"
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
.head 5 +  Column: cid
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Ид.
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
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
.head 5 +  Column: cref
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Референс
документа
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.188"
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
.head 5 +  Column: cneom
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер ЭВМ
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
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
.head 5 +  Column: csab
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
клиента
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 4
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
.head 5 +  Column: cfl
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Флаг
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  1.386"
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
.head 5 +  Column: cnls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Счёт А
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.375"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: cnd
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cdatd
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Дата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cs
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Сумма
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.838"
.head 6 -  Width Editable? Yes
.head 6 -  Format: ###000
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: ckv
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.563"
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
.head 5 +  Column: ctag59
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Одержувач
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ctag57a
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ctag56
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ctag70
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ctag72n
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ckodop
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ccountry
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
страны

.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: courbensha
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Умови
переказу
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ckvkomiss
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Валюта
комисии
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cfnamekb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Имя
файла
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 12
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.688"
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
.head 5 +  Column: cidentkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Идентификатор
 документа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 16
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: ctipkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: номер
додатка
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: cdatedokkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата приема
документа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  1.338"
.head 6 -  Width Editable? Yes
.head 6 -  Format: DateTime
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
.head 5 +  Column: ctt
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
операции
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: String
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
.head 5 +  Column: ckod_b
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
банка
(1ПБ)
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
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
.head 5 +  Column: ckod_n
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
назн.плат.
(1ПБ)
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: ckod_g
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код государства-
бенефициара
(1ПБ)
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.688"
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
.head 5 +  Column: cvob
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид
обработки
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: cprwo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Причина
возврата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.863"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: csort
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Порядок
сортировки
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.914"
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
.head 5 +  Function: Ostatki
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nKv
.head 7 -  Number: nOstc
.head 7 -  Number: nKoplate
.head 7 -  String: sNls
.head 7 -  Number: nRow1
.head 6 +  Actions
.head 7 -  Set nKv = ckv
.head 7 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT nls,ostc
     INTO   :sNls,:nOstc
     FROM   accounts
     WHERE  nls=:tbl2.cnls and kv=:nKv"))
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set df1 = sNls
.head 8 -  Set df2 = nOstc/100
.head 7 -  Set nKoplate = 0
.head 7 -  Set nRow1 = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tbl2, nRow1, 0, 0)
.head 8 -  Call SalTblFetchRow(tbl2, nRow1)
.head 8 +  If tbl2.colow = 'O' ! к оплате
.head 9 -  Set nKoplate = nKoplate + tbl2.cs
.head 7 -  Set df3 = df2 - nKoplate
.head 7 -  Call SalColorSet(df3, COLOR_IndexWindowText, IifN(df3<0, COLOR_Red, COLOR_DarkGreen))
.head 4 +  Window Variables
.head 5 -  Boolean: bFL1
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTblSetLockedColumns(tbl2, 1)
.head 6 -  Set bFL1 = FALSE
.head 6 -  ! Call SqlSetLongBindDatatype(11, 23)
.head 6 -  ! Call SqlSetLongBindDatatype(12, 23)
.head 6 -  ! Call SqlSetLongBindDatatype(13, 23)
.head 6 -  ! Call SqlSetLongBindDatatype(14, 23)
.head 6 +  If bAUTO
.head 7 -  Call SalTblPopulate(hWndItem, hSql(), "
     SELECT id,ref,neom,sab,fl,nls,nd,datd,s/100,kv,tag59,tag57a,tag56,tag70,tag72n,kodop,country,ourbensha,
            kvkomiss,fnamekb,identkb,tipkb,datedokkb,vob,kod_b,kod_n,kod_g,prwo
     INTO   :cid,:cref,:cneom,:csab,:cfl,:cnls,:cnd,:cdatd,:cs,:ckv,:ctag59,:ctag57a,:ctag56,:ctag70,:ctag72n,
            :ckodop,:ccountry,:courbensha,:ckvkomiss,:cfnamekb,:cidentkb,:ctipkb,:cdatedokkb,:cvob,:ckod_b,:ckod_n,
            :ckod_g,:cprwo
     FROM   klpv
     WHERE  neom=:nAN and fl<7 and sab=:sSab0 and tipkb=6 and noauto is not null", TBL_FillAll)
.head 6 +  Else
.head 7 -  Call SalTblPopulate(hWndItem, hSql(), "
     SELECT id,ref,neom,sab,fl,nls,nd,datd,s/100,kv,tag59,tag57a,tag56,tag70,tag72n,kodop,country,ourbensha,
            kvkomiss,fnamekb,identkb,tipkb,datedokkb,vob,kod_b,kod_n,kod_g,prwo
     INTO   :cid,:cref,:cneom,:csab,:cfl,:cnls,:cnd,:cdatd,:cs,:ckv,:ctag59,:ctag57a,:ctag56,:ctag70,:ctag72n,
            :ckodop,:ccountry,:courbensha,:ckvkomiss,:cfnamekb,:cidentkb,:ctipkb,:cdatedokkb,:cvob,:ckod_b,:ckod_n,
            :ckod_g,:cprwo
     FROM   klpv
     WHERE  neom=:nAN and fl<7 and sab=:sSab0 and tipkb=6", TBL_FillAll)
.head 6 -  Call SalTblSetFocusRow(tbl2, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set bFL1 = TRUE
.head 6 +  If cfl = 1
.head 7 -  Set colow = 'W'
.head 6 +  If cfl = 2
.head 7 -  Set colow = 'O'
.head 6 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a
     WHERE  a.nls=:cnls and a.kv=:ckv and a.acc=i.acc"))
.head 6 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 7 -  Set cprwo = '*Запрет на дебет счёта ' || cnls
.head 7 -  Set colow = 'W'
.head 7 -  Set cfl = 1
.head 6 -  Set csort = csab || cidentkb
.head 6 +  ! If courbensha = 0
.head 7 -  Set tbl2.ctt = sOp1
.head 6 +  ! Else If courbensha = 1
.head 7 -  Set tbl2.ctt = sOp2
.head 6 +  ! Else If courbensha = 2
.head 7 -  Set tbl2.ctt = sOp3
.head 6 -  Set tbl2.ctt = sOp1
.head 6 -  If SqlPrepareAndExecute(hSqlAux2(), T("
   SELECT vob
   INTO   :tbl2.cvob
   FROM   tts_vob
   WHERE  tt=:tbl2.ctt")) and SqlFetchNext(hSqlAux2(), nFetchRes)
.head 6 +  Else
.head 7 -  ! Set tbl2.ctt = 'XXX'
.head 7 -  Set tbl2.cvob = 6
.head 5 +  On SAM_CreateComplete
.head 6 +  If bFL1
.head 7 -  Call SalTblSortRows(tbl2, SalTblQueryColumnPos(csort), TBL_SortIncreasing)
.head 7 -  Call VisTblAutoSizeColumn(tbl2, hWndNULL)
.head 7 -  Call SalTblSetFocusRow(tbl2, 0)
.head 7 -  Call SalTblSetRowFlags(tbl2, 0, ROW_Selected, TRUE)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Документы "электронных" клиентов отсутствуют !', 'Предупреждение', 0, 1)
.head 7 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  On SAM_RowSetContext
.head 6 -  Call Ostatki()
.head 5 +  On SAM_SetFocus
.head 6 -  Call Ostatki()
.head 3 -  Group Box: Сумма на счёте
.head 4 -  Resource Id: 577
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    -0.012"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.75"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Group Box: к ОПЛАТЕ
.head 4 -  Resource Id: 578
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    0.905"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: df1
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.179"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: С учетом д-тов
.head 4 -  Resource Id: 579
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    0.762"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: df2
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.429"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: df3
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    1.179"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: ValidateBIC
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  String: sBic
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nI
.head 5 -  Number: nValue
.head 4 +  Actions
.head 5 +  If Len(sBic) >= 8 and Len(sBic) <= 11
.head 6 -  Set nI = 1
.head 6 +  While nI <= Len(sBic)
.head 7 -  Set nValue = Asc(SalStrUpperX(Subs(sBic, nI, 1)))
.head 7 +  If (nValue >= 65 and nValue <= 90) or (nValue >= 48 and nValue <= 57 and nI > 1)
.head 8 -  ! good
.head 7 +  Else
.head 8 -  Return FALSE
.head 7 -  Set nI = nI + 1
.head 6 -  Return TRUE
.head 5 +  Else
.head 6 -  Return FALSE
.head 2 +  Window Parameters
.head 3 -  String: sSab0
.head 3 -  String: sNmk0
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  String: df_titles
.head 3 -  String: d_NDs
.head 3 -  Date/Time: d_DATAs
.head 3 -  String: d_NAMAs
.head 3 -  String: d_BNK_As
.head 3 -  String: d_MFOAs
.head 3 -  String: d_NAMBs
.head 3 -  String: d_BNK_Bs
.head 3 -  String: d_MFOBs
.head 3 -  Number: d_Ss
.head 3 -  String: dfCodeCurrencys
.head 3 -  String: d_NLSAs
.head 3 -  String: d_NLSBs
.head 3 -  String: ml_SumPrs
.head 3 -  String: d_NAZNs
.head 3 -  String: sMaket
.head 3 -  Number: nDk
.head 3 -  String: sVspo
.head 3 -  Number: nRef
.head 3 -  ! Long String: lsSign
.head 3 -  !
.head 3 -  Date/Time: dtBD
.head 3 -  Number: nRRR
.head 3 -  Window Handle: hWndTemp
.head 3 -  Number: nFla
.head 3 -  Number: n1234
.head 3 -  Number: n100
.head 3 -  !
.head 3 -  String: sSab
.head 3 -  String: sOper
.head 3 -  String: sKODO
.head 3 -  : cDoc
.head 4 -  Class: cDocV
.head 3 -  !
.head 3 -  Number: nMaket
.head 3 -  !
.head 3 -  Number: nAcc
.head 3 -  Number: nOSTB
.head 3 -  Number: nOSTB8
.head 3 -  !
.head 3 -  String: sTmp
.head 3 -  ! Boolean: bRoll
.head 3 -  ! Number: nCLNTSEC
.head 3 -  !
.head 3 -  Boolean: bX
.head 3 -  !
.head 3 -  Boolean: bUIklp
.head 3 -  Number: nCountUpd
.head 3 -  !
.head 3 -  String: sOkpoA
.head 3 -  String: sOkpoB
.head 3 -  Number: nId
.head 3 -  String: sFileName
.head 3 -  String: NMK
.head 3 -  String: ADRES
.head 3 -  String: RUK
.head 3 -  String: BUH
.head 3 -  String: NLS
.head 3 -  String: MFO
.head 3 -  String: NB
.head 3 -  String: DATZ
.head 3 -  String: KVA
.head 3 -  String: KVB
.head 3 -  Number: SUM
.head 3 -  Number: KURS
.head 3 -  String: sDir
.head 3 -  String: sRab
.head 3 -  Number: nInd
.head 3 -  Boolean: bU
.head 3 -  !
.head 3 -  String: NK_A
.head 3 -  String: NB_A
.head 3 -  String: CB_A
.head 3 -  String: CK_A
.head 3 -  String: NLS_A
.head 3 -  String: KV
.head 3 -  String: NLS_B
.head 3 -  String: NB_B
.head 3 -  String: CONTRACT
.head 3 -  String: ID_OPER
.head 3 -  String: COUNTRY_B
.head 3 -  Number: COST
.head 3 -  Number: EXPRESS
.head 3 -  String: NB_C
.head 3 -  String: REF
.head 3 -  String: SUMPR
.head 3 -  String: CK_B
.head 3 -  String: ADD_B
.head 3 -  String: CB_B
.head 3 -  String: SW_B
.head 3 -  String: CB_C
.head 3 -  String: SW_C
.head 3 -  String: ITEM
.head 3 -  String: KV_COST
.head 3 -  String: NK_B
.head 3 -  String: AK_B
.head 3 -  !
.head 3 -  String: NO1
.head 3 -  String: NO2
.head 3 -  String: NO3
.head 3 -  String: NO4
.head 3 -  String: NO5
.head 3 -  String: BO1
.head 3 -  String: BO2
.head 3 -  String: BO3
.head 3 -  String: BO4
.head 3 -  String: BP1
.head 3 -  String: BP2
.head 3 -  String: BP3
.head 3 -  String: BP4
.head 3 -  String: NP1
.head 3 -  String: NP2
.head 3 -  String: NP3
.head 3 -  String: NP4
.head 3 -  !
.head 3 -  Number: nI
.head 3 -  String: sTemp
.head 3 -  String: smKOD_B[*]
.head 3 -  String: smKOD_N[*]
.head 3 -  String: smKOD_G[*]
.head 3 -  !
.head 3 -  String: sNLSK
.head 3 -  String: sNMKV
.head 3 -  String: smTemp[*]
.head 3 -  !
.head 3 -  ! String: sOURBENSHA
.head 3 -  ! String: sKLVKV
.head 3 -  !
.head 3 -  String: OKPO
.head 3 -  !
.head 3 -  String: sNlsT00
.head 3 -  String: sNls6val
.head 3 -  String: sNlsFizL
.head 3 -  String: sNls6grn
.head 3 -  String: sNlsJurL
.head 3 -  !
.head 3 -  Number: nFizLJurL
.head 3 -  Number: nDatValut
.head 3 -  Date/Time: dDatValut
.head 3 -  String: sType
.head 3 -  Number: nSkomisVal
.head 3 -  Number: nSkomisGrn
.head 3 -  String: sTT
.head 3 -  String: sNLS
.head 3 -  Number: nS
.head 3 -  Number: nVal
.head 3 -  Number: nFLG
.head 3 -  Number: nS1
.head 3 -  Number: nS2
.head 3 -  Number: nSumma
.head 3 -  String: sNLSorig
.head 3 -  Number: nKvKomiss
.head 3 -  String: sTag72n
.head 3 -  String: sTag70
.head 3 -  Number: nKv
.head 3 -  Number: nVob
.head 3 -  String: sNd
.head 3 -  Date/Time: dDatd
.head 3 -  Number: nTipkb
.head 3 -  String: sFnamekb
.head 3 -  String: sIdentkb
.head 3 -  Date/Time: dDatedokkb
.head 3 -  String: sTag57a
.head 3 -  String: sTag59
.head 3 -  String: sTag56
.head 3 -  String: sKod_b
.head 3 -  String: sKod_n
.head 3 -  String: sKod_g
.head 3 -  Number: nIdd
.head 3 -  Number: nNumTokens
.head 3 -  String: sBIC
.head 3 -  String: sToken57a[*]
.head 3 -  Number: nSEB
.head 3 -  !
.head 3 -  String: sValueTag57
.head 3 -  String: sTag57
.head 3 -  !
.head 3 -  String: s71F
.head 3 -  String: s33B
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm, '       Принятие решений по "электронным" документам клиента ' || sSab0 || ' (' || sNmk0
     || ')')
.head 4 -  Call SalCenterWindow(hWndItem)
.head 4 -  Set bX = TRUE
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_Green)
.head 4 -  Call XSalTooltipSetDelay(200, 30000)
.head 4 -  Set nAN = GetUserId()
.head 4 -  Set dtBD = GetBankDate()
.head 4 -  Set nVal = GetBaseVal()
.head 4 -  Set nRRR = -1
.head 4 -  Set nTipPoisk = 4
.head 4 -  Set AMFO = GetBankMfo()
.head 4 -  ! Инициализация параметра CLNTSEC
.head 4 -  ! Set nCLNTSEC = GetGlobalOptionEx('CLNTSEC')
.head 4 -  Call SalArraySetUpperBound(smKOD_B, 1, -1)
.head 4 -  Call SalArraySetUpperBound(smKOD_N, 1, -1)
.head 4 -  Call SalArraySetUpperBound(smKOD_G, 1, -1)
.head 4 +  If SqlPrepareAndExecute(hSql(), "
   SELECT substr('000' || ltrim(rtrim(regnum)), -3) || ' ' || name
   INTO   :sTemp
   FROM   bopbank
   WHERE  regnum is not null
   ORDER BY 1")
.head 5 -  Set smKOD_B[0] = ''
.head 5 -  Set nI = 1
.head 5 +  While SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set smKOD_B[nI] = sTemp
.head 6 -  Set nI = nI + 1
.head 4 +  If SqlPrepareAndExecute(hSql(), "
   SELECT transcode || ' ' || transdesc
   INTO   :sTemp
   FROM   bopcode
   WHERE  transcode is not null
   ORDER BY 1")
.head 5 -  Set smKOD_N[0] = ''
.head 5 -  Set nI = 1
.head 5 +  While SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set smKOD_N[nI] = sTemp
.head 6 -  Set nI = nI + 1
.head 4 +  If SqlPrepareAndExecute(hSql(), "
   SELECT kodc || ' ' || country
   INTO   :sTemp
   FROM   bopcount
   WHERE  kodc is not null
   ORDER BY 1")
.head 5 -  Set smKOD_G[0] = ''
.head 5 -  Set nI = 1
.head 5 +  While SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set smKOD_G[nI] = sTemp
.head 6 -  Set nI = nI + 1
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(TRUE)
.head 4 -  ! вычитать необходимые параметры из операций для определения счетов при обработке загранпереводов
.head 4 -  ! есть три операции - основная sOp1 (например - CWW) и
  две как-бы дочерних sOp2 и sOp3 для комиссии (CWG - гривна, CWV - инвалюта)
.head 4 -  If SqlPrepareAndExecute(hSql(), '
   SELECT nlsb
   INTO   :sNlsT00
   FROM   tts
   WHERE  tt=:sOp1') and SqlFetchNext(hSql(), nFetchRes)
.head 4 +  Else
.head 5 -  Call MessageNoWait('Невозможно определить необходимые счета из операции ' || sOp1, 'ОШИБКА!', 17, 1)
.head 5 -  Call SalEndDialog(hWndForm, 0)
.head 4 -  If SqlPrepareAndExecute(hSql(), '
   SELECT nlsk,nlsa
   INTO   :sNls6val,:sNlsFizL
   FROM   tts
   WHERE  tt=:sOp2') and SqlFetchNext(hSql(), nFetchRes)
.head 4 +  Else
.head 5 -  Call MessageNoWait('Невозможно определить необходимые счета из операции ' || sOp2, 'ОШИБКА!', 17, 1)
.head 5 -  Call SalEndDialog(hWndForm, 0)
.head 4 -  If SqlPrepareAndExecute(hSql(), '
   SELECT nlsk,nlsa
   INTO   :sNls6grn,:sNlsJurL
   FROM   tts
   WHERE  tt=:sOp3') and SqlFetchNext(hSql(), nFetchRes)
.head 4 +  Else
.head 5 -  Call MessageNoWait('Невозможно определить необходимые счета из операции ' || sOp3, 'ОШИБКА!', 17, 1)
.head 5 -  Call SalEndDialog(hWndForm, 0)
.head 4 -  ! 1) счёт T00       - sNlsT00
  2) счёт 6110 грн. - sNls6grn
  3) счёт 6110 вал. - sNls6val
  4) счёт 2602 ЮЛ   - sNlsJurL
  5) счёт 2622 ФЛ   - sNlsFizL
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Close
.head 4 +  If not bX
.head 5 -  Return FALSE
.head 3 +  On SAM_Destroy
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
.head 4 -  Call XSalTooltipSetDelay(200, 4000)
.head 3 +  On SAM_ReportStart
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFetchInit
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFetchNext
.head 4 +  If bU
.head 5 -  Return FALSE
.head 4 +  ! If SqlPrepareAndExecute(hSql(), '
   SELECT c.nmkv,c.nmk,c.adr,o.ruk,o.buh,c.okpo
   INTO   :NK_A,:NMK,:ADRES,:RUK,:BUH,:OKPO
   FROM   customer c, corps o
   WHERE  c.sab=:tbl2.csab and c.custtype in (2,3) and c.stmt=5 and c.rnk=o.rnk(+)') and SqlFetchNext(hSql(), nFetchRes)
.head 5 -  ! Set ADRES = SalStrTrimX(ADRES) || ', код ' || SalStrTrimX(KODOKPO)
.head 4 +  If SqlPrepareAndExecute(hSql(), '
   SELECT c.nmkv,c.nmk,c.adr,o.ruk,o.buh,c.okpo
   INTO   :NK_A,:NMK,:ADRES,:RUK,:BUH,:OKPO
   FROM   customer c, corps o
   WHERE  c.sab=:tbl2.csab and c.custtype in (2,3) and c.stmt=6 and c.rnk=o.rnk(+)') and SqlFetchNext(hSql(), nFetchRes)
.head 5 -  ! Set ADRES = SalStrTrimX(ADRES) || ', код ' || SalStrTrimX(KODOKPO)
.head 4 +  Else
.head 5 -  Set NK_A = ''
.head 5 -  Set NMK = ''
.head 5 -  Set ADRES = ''
.head 5 -  Set RUK = ''
.head 5 -  Set BUH = ''
.head 5 -  Set OKPO = ''
.head 4 -  Set REF = tbl2.cnd
.head 4 -  Set DATZ = '"' || SalFmtFormatDateTime(tbl2.cdatd, 'd') || '" ' || GetMonthUkr(tbl2.cdatd, 'r') ||  ' ' ||
    SalFmtFormatDateTime(tbl2.cdatd, 'yyyy') || ' р.'
.head 4 -  Set NB_A = GetGlobalOption('KLV_BANK')
  ! 'Akcionernij bank "SEB BANK"'
  ! GetBankName()
.head 4 -  Set CB_A = GetGlobalOption('KLV_CITY')
  ! 'm. Kiyiv'
  ! '.Київ, Україна'
.head 4 -  Set CK_A = 'Ukraine, Kiev'
.head 4 -  Set NLS_A = tbl2.cnls || ' ' || GetLcv(tbl2.ckv)
.head 4 -  Set SUM = tbl2.cs*100
.head 4 -  Set KV = GetLcv(tbl2.ckv)
.head 4 -  Call SalStrTokenize(tbl2.ctag59, '', Chr(13) || Chr(10), smTemp)
.head 4 -  Set NO1 = smTemp[0]
.head 4 -  Set NO2 = smTemp[1]
.head 4 -  Set NO3 = smTemp[2]
.head 4 -  Set NO4 = smTemp[3]
.head 4 -  Set NO5 = smTemp[4]
.head 4 -  ! Call DebugN(Len(tbl2.ctag59))
.head 4 -  ! Call Debug('tbl2.ctag59 = ' || tbl2.ctag59 || Chr(13) ||
           'NO1 = ' || NO1 || Chr(13) ||
           'NO2 = ' || NO2 || Chr(13) ||
           'NO3 = ' || NO3 || Chr(13) ||
           'NO4 = ' || NO4 || Chr(13) ||
           'NO5 = ' || NO5)
.head 4 -  Call SalStrTokenize(tbl2.ctag57a, '', Chr(13) || Chr(10), smTemp)
.head 4 -  Set BO1 = smTemp[0]
.head 4 -  Set BO2 = smTemp[1]
.head 4 -  Set BO3 = smTemp[2]
.head 4 -  Set BO4 = smTemp[3]
.head 4 -  Call SalStrTokenize(tbl2.ctag56, '', Chr(13) || Chr(10), smTemp)
.head 4 -  Set BP1 = smTemp[0]
.head 4 -  Set BP2 = smTemp[1]
.head 4 -  Set BP3 = smTemp[2]
.head 4 -  Set BP4 = smTemp[3]
.head 4 -  Call SalStrTokenize(tbl2.ctag70, '', Chr(13) || Chr(10), smTemp)
.head 4 -  Set NP1 = smTemp[0]
.head 4 -  Set NP2 = smTemp[1]
.head 4 -  Set NP3 = smTemp[2]
.head 4 -  Set NP4 = smTemp[3]
.head 4 -  Set ID_OPER = Str(tbl2.ckodop)
.head 4 -  Set COUNTRY_B = Str(tbl2.ccountry)
.head 4 -  Set COST = tbl2.courbensha
.head 4 -  Set EXPRESS = Val(tbl2.ctag72n)
.head 4 -  ! Call Debug(KV)
.head 4 -  If SqlPrepareAndExecute(hSql(), "
   SELECT SUBSTR(f_sumpr(:SUM,to_char(kv),NVL(gender,'M')),1,200)
   INTO   :SUMPR
   FROM   tabval
   WHERE  lcv=:KV") and SqlFetchNext(hSql(), nFetchRes)
.head 4 +  Else
.head 5 -  ! Set SUMPR = SumPr(SUM, 'M', KV, '')
.head 5 -  Set SUMPR = ''
.head 4 -  Set KV_COST = GetLcv(tbl2.ckvkomiss)
.head 4 -  ! Call Debug(KV_COST)
.head 4 -  !
.head 4 -  Set NK_B = ''
.head 4 -  Set AK_B = ''
.head 4 -  Set CK_B = ''
.head 4 -  Set ADD_B = ''
.head 4 -  Set NB_B = ''
.head 4 -  Set CB_B = ''
.head 4 -  Set SW_B = ''
.head 4 -  Set NB_C = ''
.head 4 -  Set CB_C = ''
.head 4 -  Set SW_C = ''
.head 4 -  Set ITEM = ''
.head 4 -  Set bU = TRUE
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportNotify
.head 4 +  ! If lParam = RPT_BeforeBreakHeader2
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'DT_PRINT', 'Надруковано: ' ||
     SalFmtFormatDateTime(SalDateCurrent(), "dd/MM/yyyy hhh:mm:ss"))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'PAX', "Рахунок")
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'ZAKL', IifS(PZ=1, 'Поточна', 'Заключна'))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'SHAP',
     "Nпп Документ   ВО    МФО    Кореспондент   СКП         Сума: ДЕБ КРЕД")
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'BPEM', BPEM)
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'AQH', AQH)
.head 5 -  Set DOS = 0
.head 5 -  Set NPP = 0
.head 5 -  Set KOS = 0
.head 5 -  Set S2 = S1
.head 5 -  Set FIO = 'Вик.' || ISP
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'VSA', ' Вхідне сальдо ' || DK(S1))
.head 4 +  ! If lParam = RPT_BeforeDetail
.head 5 +  If S < 0
.head 6 -  Set DOS = DOS - S
.head 5 +  Else 
.head 6 -  Set KOS = KOS + S
.head 5 -  Set NPP = NPP + 1
.head 5 -  Set S2 = S2 + S
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'NPP', NPP)
.head 4 +  ! If lParam = RPT_BeforeBreakFooter2
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'ISA', 'Вихідне сальдо ' || DK(S2))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'OBO', 'Всього оборотів ')
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'FIO', FIO)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'S2', S2)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'DOS', DOS)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'KOS', KOS)
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFinish
.head 4 -  ! Call DirectView(sFileName)
.head 1 +  Dialog Box: dlg_7
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
.head 4 -  Left:   0.25"
.head 4 -  Top:    0.156"
.head 4 -  Width:  13.333"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 6.833"
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
.head 3 +  ! Pushbutton: pbF2
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Доп.реквизиты
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    1.81"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F2
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf2.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: White
.end
.head 4 +  Message Actions 
.head 5 +  ! On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set sKOD_B = tbl2.ckod_b
.head 7 -  Set sKOD_N = tbl2.ckod_n
.head 7 -  Set sKOD_G = tbl2.ckod_g
.head 7 +  If SalModalDialog(TT_KOD_NBG, hWndForm, smKOD_B, smKOD_N, smKOD_G) = 1
.head 8 -  Set tbl2.ckod_b = sKOD_B
.head 8 -  Set tbl2.ckod_n = sKOD_N
.head 8 -  Set tbl2.ckod_g = sKOD_G
.head 8 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    kod_b=:tbl2.ckod_b,kod_n=:tbl2.ckod_n,kod_g=:tbl2.ckod_g
   WHERE  id=:tbl2.cid')
.head 9 -  Call SqlCommit(hSql())
.head 9 +  If (SalStrTrimX(tbl2.ckod_g) = '' or SalStrTrimX(tbl2.ckod_n) = '') and tbl2.colow = 'O'
.head 10 -  Set tbl2.colow = ' '
.head 10 -  Set tbl2.cfl = 0
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Доввод реквизитов документа для 1_ПБ')
.head 3 +  Pushbutton: pbF3
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Возвратить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    2.298"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F3
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf3_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 +  If SalModalDialog(wozwrat, hWndForm) != -1
.head 8 -  Set nRow = TBL_MinRow
.head 8 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 9 -  Call SalTblFetchRow(tbl2, nRow)
.head 9 +  If (tbl2.cfl = NUMBER_Null or tbl2.cfl = 0) and Len(SalStrTrimX(sWW)) > 0
.head 10 -  Set tbl2.colow = 'W'
.head 10 -  Set tbl2.cfl = 1
.head 10 -  Set tbl2.cprwo = sWW
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call VisTblAutoSizeColumn(tbl2, hWndNULL)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить на возврат выбранные документы')
.head 3 +  Pushbutton: pbF4
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: К оплате
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    2.798"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F4
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf4_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cfl = NUMBER_Null or tbl2.cfl = 0
.head 9 -  Set tbl2.colow = 'O'
.head 9 -  Set tbl2.cfl = 2
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 +  ! If SalStrTrimX(tbl2.ckod_g) != '' and SalStrTrimX(tbl2.ckod_n) != ''
.head 10 -  Set tbl2.colow = 'O'
.head 10 -  Set tbl2.cfl = 2
.head 10 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 9 +  ! Else
.head 10 -  Call MessageNoWait('Необходимо доввести дополнительные (для 1_ПБ) реквизиты ' || 'документа ' || tbl2.cnd,
     'ВНИМАНИЕ !', 7, 1)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Пометить выбранные документы к оплате')
.head 3 +  Pushbutton: pbF5
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Печать
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    3.31"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F5
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf5_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  ! If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Set nckv = tbl2.ckv
.head 8 -  Call SqlPrepareAndExecute(hSql(), T('
     SELECT nmk,okpo
     INTO   :d_NAMAs,:sOkpoA
     FROM   customer c, cust_acc u, accounts a
     WHERE  a.nls=:tbl2.cnls and a.kv=:nckv and c.rnk=u.rnk and a.acc=u.acc'))
.head 8 +  If not SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 8 -  Set nDk = 1
.head 8 -  Call DocsPrintFromParam(0, tbl2.ckv, tbl2.cvob, tbl2.cnd, AMFO, sOkpoA, GetBankName(), tbl2.cnls, d_NAMAs,
     tbl2.cs*100, NUMBER_Null, nDk, AMFO, sOkpoA, d_BNK_Bs, tbl2.cnlsp, d_NAMAs, tbl2.ckv, tbl2.cs*100,
     'Конверсия валюты', tbl2.cdatd, PRINT_DOC)
.head 8 -  ! Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 6 -  Set sDir = GetTemplateDir() || "\\ZAY_ORDK.QRP"
.head 6 -  Set sFileName = GetPrnDir() || '\\D' || Str(tbl2.cref) || '.za7'
.head 6 -  Set sRab = 'REF,DATZ,RUK,BUH,NMK,OKPO,ADRES,NLS_V,SUM,SUMPR,KV,NLS_CR,NAZN,N_CR,DAT_CR,KV_COST'
.head 6 -  Set bU = FALSE
.head 6 -  Call SalReportPrintToFile(hWndForm, sDir, sFileName, sRab, sRab, 1, RPT_PrintAll, 1, 1, FALSE, nInd)
.head 6 -  Call zarez12(sFileName, 0, '')
.head 6 -  Call DosDirectPrint(sFileName)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отпечатать текущий документ')
.head 3 +  Pushbutton: pbF7
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Поиск
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    3.821"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F7
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf7_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nTipPoisk = SalModalDialog(poisk, hWndForm)
.head 6 +  If nTipPoisk = 1
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 8 -  Call SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 7 +  Else
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.cs = nGetSum
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If not nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 6 +  Else If nTipPoisk = 2
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If NOT SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'O'
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If NOT nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 6 +  Else If nTipPoisk = 3
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  If NOT SalTblQueryFocus(tbl2, nRRR, hWndTemp)
.head 8 -  Set nRRR = -1
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Set nRow = IifN(nRRR=-1, TBL_MinRow, nRRR)
.head 7 -  Set nFla = FALSE
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'W'
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, TRUE)
.head 9 -  Set nFla = TRUE
.head 9 -  Break
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 +  If NOT nFla
.head 8 -  Call SalTblSetRowFlags(tbl2, nRRR, ROW_Selected, TRUE)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRRR)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Поиск документа от текущей позиции вниз')
.head 3 +  Pushbutton: pbF8
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Снять отметку
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    4.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F8
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf8_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tbl2, ROW_Selected, 0)
.head 7 -  Set nRow = TBL_MinRow
!          SalTblQueryContext(tbl2)
.head 7 +  While SalTblFindNextRow(tbl2, nRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If (tbl2.cfl = 1 and Left(tbl2.cprwo, 1) != '*') or tbl2.cfl = 2 or tbl2.cfl = 3
.head 9 -  Set tbl2.colow = ' '
.head 9 -  Set tbl2.cfl = 0
.head 9 -  Set tbl2.cprwo = ''
.head 9 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Edited, TRUE)
.head 8 -  Call SalTblSetRowFlags(tbl2, nRow, ROW_Selected, FALSE)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 7 -  Call tbl2.Ostatki()
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Сбросить пометки с выбранных документов')
.head 3 +  Pushbutton: pbF9
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Документ
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    4.821"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.5"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F9
.head 4 -  Font Name: Default
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf9_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Black
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set sDir = GetTemplateDir() || "\\ZAY_ORDK.QRP"
.head 6 -  Set sFileName = GetPrnDir() || '\\D' || Str(tbl2.cref) || '.za7'
.head 6 -  ! Call Debug(sFileName)
.head 6 -  Set sRab = 'REF,DATZ,RUK,BUH,NMK,OKPO,ADRES,NLS_V,SUM,SUMPR,KV,NLS_CR,NAZN,N_CR,DAT_CR,KV_COST'
.head 6 -  Set bU = FALSE
.head 6 -  ! Set nInd = RPT_NoToolbar
.head 6 -  Call SalReportPrintToFile(hWndForm, sDir, sFileName, sRab, sRab, 1, RPT_PrintAll, 1, 1, FALSE, nInd)
.head 6 -  ! Call DebugN(nInd)
.head 6 -  Call zarez12(sFileName, 0, '')
.head 6 -  Call DirectView(sFileName)
.head 6 -  ! Call DirectView(GetPrnDir() || '\\' || sFileName)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Просмотр выбранного документа')
.head 3 +  Pushbutton: pb10
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Обработать
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    5.321"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: F10
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold-Italic
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Bf10_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox('ЕСЛИ Вы НЕ ОТПЕЧАТАЛИ ПОМЕЧЕННЫЕ к оплате ДОКУМЕНТЫ, то сделать ЭТО Вы сможете только из АРХИВА,' ||
   ' СОГЛАСНЫ на обработку ?', "Обработать и выйти", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 -  ! Call SalDisableWindow(pbF2)
.head 7 -  Call SalDisableWindow(pbF3)
.head 7 -  Call SalDisableWindow(pbF4)
.head 7 -  Call SalDisableWindow(pbF5)
.head 7 -  Call SalDisableWindow(pbF7)
.head 7 -  Call SalDisableWindow(pbF8)
.head 7 -  Call SalDisableWindow(pbF9)
.head 7 -  Call SalDisableWindow(pb10)
.head 7 -  Call SalDisableWindow(pbEsc)
.head 7 -  Set bX = FALSE
.head 7 +  If SalTblAnyRows(tbl2, ROW_Edited, 0)
.head 8 +  If SqlPrepare(hSql(), '
   UPDATE klpv
   SET    prwo=:tbl2.cprwo,fl=:tbl2.cfl
   WHERE  id=:tbl2.cid')
.head 9 -  Call SalTblDoUpdates(tbl2, hSql(), TRUE)
.head 9 -  Call SqlCommit(hSql())
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  Set nRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tbl2, nRow, 0, 0)
.head 8 -  Call SalTblFetchRow(tbl2, nRow)
.head 8 -  Call SalTblSetContext(tbl2, nRow)
.head 8 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 8 +  If tbl2.colow = 'W' ! возвратить
.head 9 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    fl=9
   WHERE  id=:tbl2.cid')
.head 10 -  Set sSab = tbl2.csab
.head 10 -  Set sOper = Right(Str(10000+tbl2.cneom), 4)
.head 10 -  Set n100 = tbl2.cs*100
.head 10 +  If SqlPrepareAndExecute(hSql(), '
   SELECT S_zay_baop.NEXTVAL
   INTO   :nId
   FROM   DUAL') and SqlFetchNext(hSql(), nFetchRes)
.head 11 +  If SqlPrepareAndExecute(hSql(), T("
   INSERT
   INTO   zay_baop (id,tipkb,kod,textback,identkb,fnamekb)
   VALUES (:nId,:tbl2.ctipkb,88,:tbl2.cprwo,:tbl2.cidentkb,:tbl2.cfnamekb)"))
.head 12 -  Call SqlCommit(hSql())
.head 12 -  Call SalTblSetContext(tbl2, nRow)
.head 12 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 12 -  Set tbl2.colow = 'w'
.head 12 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_Salmon)
.head 12 -  Call MessageNoWait('Возвращен "электронный" док.' || SalStrTrimX(tbl2.cnd) || '), Счёт А=' || tbl2.cnls ||
     ', Сумма=' || SalNumberToStrX(tbl2.cs, 2), 'Сообщение', .1, 0)
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 8 +  Else If tbl2.colow = 'O' ! к оплате
.head 9 -  Set nDk = 1
.head 9 -  Set nckv = tbl2.ckv
.head 9 -  Set nAcc = 0
.head 9 -  Set nOSTB = 0
.head 9 -  Set d_NAMAs = 'Плательщик не идентифицирован'
.head 9 +  ! If SqlPrepareAndExecute(hSql(), T('
   SELECT nlsk
   INTO   :sNLSK
   FROM   tts
   WHERE  tt=:tbl2.ctt'))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT nvl(c.nmkk,c.nmk),a.acc,a.ostb,c.okpo,c.nmkv
   INTO   :d_NAMAs,:nAcc,:nOSTB,:sOkpoA,:sNMKV
   FROM   customer c, accounts a
   WHERE  a.nls=:tbl2.cnls and a.kv=:nckv and c.rnk=a.rnk'))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 +  If SqlPrepareAndExecute(hSql(), T('
   SELECT nvl(c.nmkk,c.nmk),c.okpo
   INTO   :d_NAMBs,:sOkpoB
   FROM   customer c, accounts a
   WHERE  a.nls=:tbl2.cnlsb and a.kv=:tbl2.ckv and c.rnk=a.rnk'))
.head 10 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 9 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.SetDoc(ref==>' || Str(tbl2.cref) || ')')
.head 9 -  Call cDoc.SetDoc(tbl2.cref, tbl2.ctt, nDk, tbl2.cvob, tbl2.cnd, tbl2.cdatd, GetBankDate(), GetBankDate(),
     GetBankDate(), tbl2.cnls, d_NAMAs, AMFO, '', tbl2.ckv, tbl2.cs*100, sOkpoA, tbl2.cnlsb, d_NAMBs, AMFO, '',
     tbl2.ckv, tbl2.cs*100, sOkpoB, tbl2.ctag70, '', GetIdOper(), '', NUMBER_Null, 0)
.head 9 -  Set cDoc.m_nNom = tbl2.cs*100 - Max(nOSTB, 0)
.head 9 -  Set cDoc.m_sRef_A = Str(tbl2.cref)
.head 9 +  If cDoc.sDoc()
.head 10 +  If cDoc.iDoc()
.head 11 +  If cDoc.oDoc()
.head 12 +  If SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'TIPKB',:tbl2.ctipkb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'FN_KB',:tbl2.cfnamekb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'ID_KB',:tbl2.cidentkb)") and
   SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'DATKB',:tbl2.cdatedokkb)")
.head 13 +  ! If Len(SalStrTrimX(tbl2.ckod_b)) > 0
.head 14 -  Call SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'KOD_B',:tbl2.ckod_b)")
.head 13 +  ! If Len(SalStrTrimX(tbl2.ckod_n)) > 0
.head 14 -  Call SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'KOD_N',:tbl2.ckod_b)")
.head 13 +  ! If Len(SalStrTrimX(tbl2.ckod_g)) > 0
.head 14 -  Call SqlPrepareAndExecute(hSql(), "
   INSERT
   INTO   operw (ref,tag,value)
   VALUES (:cDoc.m_nRef,'KOD_G',:tbl2.ckod_b)")
.head 13 -  Set nRef = cDoc.m_nRef
.head 13 -  Call SaveInfoToLog('KLOP_BOB(1): cDoc.oDoc() return ref==>' || Str(cDoc.m_nRef))
.head 13 -  Call SalTblSetContext(tbl2, nRow)
.head 13 -  Call SalTblSetFocusRow(tbl2, nRow)
.head 13 +  If SqlPrepareAndExecute(hSql(), '
   UPDATE klpv
   SET    fl=8
   WHERE  id=:tbl2.cid')
.head 14 -  ! вставить запись в zay_baop с кодом 0
.head 14 +  If SqlPrepareAndExecute(hSql(), '
   SELECT S_zay_baop.NEXTVAL
   INTO   :nId
   FROM   DUAL') and SqlFetchNext(hSql(), nFetchRes)
.head 15 +  If SqlPrepareAndExecute(hSql(), '
   INSERT
   INTO   zay_baop (id,tipkb,kod,identkb,fnamekb)
   VALUES (:nId,:tbl2.ctipkb,0,:tbl2.cidentkb,:tbl2.cfnamekb)')
.head 16 -  Call SqlCommit(hSql())
.head 16 -  Set tbl2.colow = 'o'
.head 16 -  Call XSalTblSetRowBackColor(tbl2, nRow, COLOR_LightGreen)
.head 16 -  Call MessageNoWait('Оплачен "электронный" док.' || SalStrTrimX(tbl2.cnd) || ', (Ref=' || Str(nRef)
     || '), Счёт А=' || tbl2.cnls || ', Счёт Б=' || SalNumberToStrX(tbl2.cs, 2), 'Сообщение', .1,
     0)
.head 15 +  Else
.head 16 -  Call SqlRollback(hSql())
.head 14 +  Else
.head 15 -  Call SqlRollback(hSql())
.head 13 +  Else
.head 14 -  Call SqlRollback(hSql())
.head 12 +  Else
.head 13 -  Call SqlRollback(hSql())
.head 11 +  Else
.head 12 -  Call SqlRollback(hSql())
.head 10 +  Else
.head 11 -  Call SqlRollback(hSql())
.head 9 +  Else
.head 10 -  Call SqlRollback(hSql())
.head 7 -  ! Call SalEnableWindow(pbF2)
.head 7 -  ! Call SalEnableWindow(pbF3)
.head 7 -  ! Call SalEnableWindow(pbF4)
.head 7 -  ! Call SalEnableWindow(pbF5)
.head 7 -  ! Call SalEnableWindow(pbF6)
.head 7 -  ! Call SalEnableWindow(pbF7)
.head 7 -  ! Call SalEnableWindow(pbF8)
.head 7 -  ! Call SalEnableWindow(pbF9)
.head 7 -  ! Call SalEnableWindow(pbF10)
.head 7 -  Set bX = TRUE
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Обработать помеченные на ВОЗВРАТ и к ОПЛАТЕ документы и выйти')
.head 3 +  Pushbutton: pbEsc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отложить
.head 4 -  Window Location and Size
.head 5 -  Left:   11.15"
.head 5 -  Top:    5.917"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Bold-Italic
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Besc_.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalMessageBeep(-1)
.head 6 +  If SalMessageBox("Вы уверены ?", "Отложить обработку", MB_YesNo | MB_IconQuestion) = IDYES
.head 7 +  If SalTblAnyRows(tbl2, ROW_Edited, 0)
.head 8 +  If SqlPrepare(hSql(), '
   UPDATE klpv
   SET    prwo=:tbl2.cprwo,fl=:tbl2.cfl
   WHERE  id=:tbl2.cid')
.head 9 -  Call SalTblDoUpdates(tbl2, hSql(), TRUE)
.head 9 -  Call SqlCommitEx(hSql(), 'Обновление KLPV')
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 7 -  Call SalDestroyWindow(hWndForm)
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText(lParam, 'Отложить обработку с сохранением пометок')
.head 3 +  ! Data Field: daf1
.winattr
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
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Height: Default
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
.end
.head 4 +  Message Actions
.head 5 +  On WM_Char
.head 6 -  Call SalMessageBox(SalNumberToStrX(wParam , 0), 'wParam', MB_Ok)
.head 3 +  Child Table: tbl2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.083"
.head 6 -  Top:    -0.012"
.head 6 -  Width:  11.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 6.5"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colow
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
_
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 1
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.25"
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
.head 5 +  Column: cid
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Ид.
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
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
.head 5 +  Column: cref
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Референс
документа
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.188"
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
.head 5 +  Column: cneom
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер ЭВМ
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
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
.head 5 +  Column: csab
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
клиента
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 4
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
.head 5 +  Column: cfl
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Флаг
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  1.386"
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
.head 5 +  Column: cnls
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Счёт А
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.375"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: cnd
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 10
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cdatd
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Дата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cs
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Сумма
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.838"
.head 6 -  Width Editable? Yes
.head 6 -  Format: ###000
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: ckv
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
вал.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.563"
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
.head 5 +  Column: cnlsb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: 
Счёт Б
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 14
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.375"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: ctag70
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назначение
платежа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 160
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cnkreddog
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
кред.договора
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.813"
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
.head 5 +  Column: cdkreddog
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата
кред.договора
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  0.813"
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
.head 5 +  Column: ckvkomiss
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код вал.
комиссии
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.563"
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
.head 5 +  Column: cfnamekb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Имя
файла
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 12
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.688"
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
.head 5 +  Column: cidentkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Идентификатор
 документа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 16
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: ctipkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: номер
додатка
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: cdatedokkb
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Дата приема
документа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: Date/Time
.head 6 -  Justify: Center
.head 6 -  Width:  1.338"
.head 6 -  Width Editable? Yes
.head 6 -  Format: DateTime
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
.head 5 +  Column: ctt
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
операции
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: String
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
.head 5 +  Column: ckod_b
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
банка
(1ПБ)
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
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
.head 5 +  Column: ckod_n
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
назн.плат.
(1ПБ)
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: ckod_g
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код государства-
бенефициара
(1ПБ)
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  1.688"
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
.head 5 +  Column: cvob
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вид
обработки
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 8
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  1.225"
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
.head 5 +  Column: cprwo
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Причина
возврата
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.863"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Drop Down List
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
.head 5 +  Column: csort
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Порядок
сортировки
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.914"
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
.head 5 +  Function: Ostatki
.head 6 -  Description:
.head 6 -  Returns
.head 6 -  Parameters
.head 6 -  Static Variables
.head 6 +  Local variables
.head 7 -  Number: nKv
.head 7 -  Number: nOstc
.head 7 -  Number: nKoplate
.head 7 -  String: sNls
.head 7 -  Number: nRow1
.head 6 +  Actions
.head 7 -  Set nKv = ckv
.head 7 -  Call SqlPrepareAndExecute(hSql(), T("
     SELECT nls,ostc
     INTO   :sNls,:nOstc
     FROM   accounts
     WHERE  nls=:tbl2.cnls and kv=:nKv"))
.head 7 +  If SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set df1 = sNls
.head 8 -  Set df2 = nOstc/100
.head 7 -  Set nKoplate = 0
.head 7 -  Set nRow1 = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tbl2, nRow1, 0, 0)
.head 8 -  Call SalTblFetchRow(tbl2, nRow1)
.head 8 +  If tbl2.colow = 'O' ! к оплате
.head 9 -  Set nKoplate = nKoplate + tbl2.cs
.head 7 -  Set df3 = df2 - nKoplate
.head 7 -  Call SalColorSet(df3, COLOR_IndexWindowText, IifN(df3<0, COLOR_Red, COLOR_DarkGreen))
.head 4 +  Window Variables
.head 5 -  Boolean: bFL1
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 -  Call SalTblSetLockedColumns(tbl2, 1)
.head 6 -  Set bFL1 = FALSE
.head 6 +  If bAUTO
.head 7 -  Call SalTblPopulate(hWndItem, hSql(), "
     SELECT id,ref,neom,sab,fl,nls,nd,datd,s/100,kv,tag70,nlspog,nkreddog,dkreddog,kvkomiss,fnamekb,identkb,tipkb,
            datedokkb,kod_b,kod_n,kod_g,vob,prwo
     INTO   :cid,:cref,:cneom,:csab,:cfl,:cnls,:cnd,:cdatd,:cs,:ckv,:ctag70,:cnlsb,:cnkreddog,:cdkreddog,:ckvkomiss,
            :cfnamekb,:cidentkb,:ctipkb,:cdatedokkb,:ckod_b,:ckod_n,:ckod_g,:cvob,:cprwo
     FROM   klpv
     WHERE  neom=:nAN and fl<7 and sab=:sSab0 and tipkb=7 and noauto is not null", TBL_FillAll)
.head 6 +  Else
.head 7 -  Call SalTblPopulate(hWndItem, hSql(), "
     SELECT id,ref,neom,sab,fl,nls,nd,datd,s/100,kv,tag70,nlspog,nkreddog,dkreddog,kvkomiss,fnamekb,identkb,tipkb,
            datedokkb,kod_b,kod_n,kod_g,vob,prwo
     INTO :cid,:cref,:cneom,:csab,:cfl,:cnls,:cnd,:cdatd,:cs,:ckv,:ctag70,:cnlsb,:cnkreddog,:cdkreddog,:ckvkomiss,
          :cfnamekb,:cidentkb,:ctipkb,:cdatedokkb,:ckod_b,:ckod_n,:ckod_g,:cvob,:cprwo
     FROM klpv
     WHERE neom=:nAN and fl<7 and sab=:sSab0 and tipkb=7", TBL_FillAll)
.head 6 -  Call SalTblSetFocusRow(tbl2, 0)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set bFL1 = TRUE
.head 6 +  If cfl = 1
.head 7 -  Set colow = 'W'
.head 6 +  If cfl = 2
.head 7 -  Set colow = 'O'
.head 6 -  Call SqlPrepareAndExecute(hSqlAux2(), T("
     SELECT i.acc
     FROM   acci i, accounts a
     WHERE  a.nls=:cnls and a.kv=:ckv and a.acc=i.acc"))
.head 6 +  If not SqlFetchNext(hSqlAux2(), nFetchRes)
.head 7 -  Set cprwo = '*Запрет на дебет счёта ' || cnls
.head 7 -  Set colow = 'W'
.head 7 -  Set cfl = 1
.head 6 -  ! Set tbl2.ctt = sOp1
.head 6 -  Set tbl2.ctt = IifS(tbl2.ckvkomiss=980, sOp1, IifS(sOp2!=STRING_Null, sOp2, sOp1))
.head 6 -  If SqlPrepareAndExecute(hSqlAux2(), T("
   SELECT vob
   INTO   :tbl2.cvob
   FROM   tts_vob
   WHERE  tt=:tbl2.ctt")) and SqlFetchNext(hSqlAux2(), nFetchRes)
.head 6 +  Else
.head 7 -  ! Set tbl2.ctt = 'XXX'
.head 7 -  Set tbl2.cvob = 6
.head 6 -  Set csort = csab || cidentkb
.head 5 +  On SAM_CreateComplete
.head 6 +  If bFL1
.head 7 -  Call SalTblSortRows(tbl2, SalTblQueryColumnPos(csort), TBL_SortIncreasing)
.head 7 -  Call VisTblAutoSizeColumn(tbl2, hWndNULL)
.head 7 -  Call SalTblSetFocusRow(tbl2, 0)
.head 7 -  Call SalTblSetRowFlags(tbl2, 0, ROW_Selected, TRUE)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Документы "электронных" клиентов отсутствуют !', 'Предупреждение', 0, 1)
.head 7 -  Call SalEndDialog(hWndForm, 0)
.head 5 +  On SAM_RowSetContext
.head 6 -  Call Ostatki()
.head 5 +  On SAM_SetFocus
.head 6 -  Call Ostatki()
.head 3 -  Group Box: Сумма на счёте
.head 4 -  Resource Id: 36237
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    -0.012"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.75"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Group Box: к ОПЛАТЕ
.head 4 -  Resource Id: 36238
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    0.905"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.583"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: df1
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.179"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.167"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Blue
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: С учетом д-тов
.head 4 -  Resource Id: 36239
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.183"
.head 5 -  Top:    0.762"
.head 5 -  Width:  2.0"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: df2
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    0.429"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: df3
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
.head 6 -  Left:   11.283"
.head 6 -  Top:    1.179"
.head 6 -  Width:  1.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? No
.head 5 -  Justify: Right
.head 5 -  Format: #000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: 10
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sSab0
.head 3 -  String: sNmk0
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  String: df_titles
.head 3 -  String: d_NDs
.head 3 -  Date/Time: d_DATAs
.head 3 -  String: d_NAMAs
.head 3 -  String: d_BNK_As
.head 3 -  String: d_MFOAs
.head 3 -  String: d_NAMBs
.head 3 -  String: d_BNK_Bs
.head 3 -  String: d_MFOBs
.head 3 -  Number: d_Ss
.head 3 -  String: dfCodeCurrencys
.head 3 -  String: d_NLSAs
.head 3 -  String: d_NLSBs
.head 3 -  String: ml_SumPrs
.head 3 -  String: d_NAZNs
.head 3 -  String: sMaket
.head 3 -  Number: nDk
.head 3 -  String: sVspo
.head 3 -  Number: nRef
.head 3 -  ! Long String: lsSign
.head 3 -  !
.head 3 -  Date/Time: dtBD
.head 3 -  Number: nRRR
.head 3 -  Window Handle: hWndTemp
.head 3 -  Number: nFla
.head 3 -  Number: n1234
.head 3 -  Number: n100
.head 3 -  !
.head 3 -  String: sSab
.head 3 -  String: sOper
.head 3 -  String: sKODO
.head 3 -  : cDoc
.head 4 -  Class: cDoc
.head 3 -  !
.head 3 -  Number: nMaket
.head 3 -  !
.head 3 -  Number: nAcc
.head 3 -  Number: nOSTB
.head 3 -  Number: nOSTB8
.head 3 -  !
.head 3 -  String: sTmp
.head 3 -  ! Boolean: bRoll
.head 3 -  Number: nCLNTSEC
.head 3 -  !
.head 3 -  Boolean: bX
.head 3 -  !
.head 3 -  Boolean: bUIklp
.head 3 -  Number: nCountUpd
.head 3 -  !
.head 3 -  String: sOkpoA
.head 3 -  String: sOkpoB
.head 3 -  Number: nId
.head 3 -  String: sFileName
.head 3 -  String: NMK
.head 3 -  String: ADRES
.head 3 -  String: RUK
.head 3 -  String: BUH
.head 3 -  String: NLS
.head 3 -  String: MFO
.head 3 -  String: NB
.head 3 -  String: DATZ
.head 3 -  String: KVA
.head 3 -  String: KVB
.head 3 -  Number: SUM
.head 3 -  Number: KURS
.head 3 -  String: sDir
.head 3 -  String: sRab
.head 3 -  Number: nInd
.head 3 -  Boolean: bU
.head 3 -  !
.head 3 -  String: NK_A
.head 3 -  String: NB_A
.head 3 -  String: CB_A
.head 3 -  String: CK_A
.head 3 -  String: NLS_A
.head 3 -  String: KV
.head 3 -  String: NLS_B
.head 3 -  String: NB_B
.head 3 -  String: CONTRACT
.head 3 -  String: ID_OPER
.head 3 -  String: COUNTRY_B
.head 3 -  Number: COST
.head 3 -  Number: EXPRESS
.head 3 -  String: NB_C
.head 3 -  String: REF
.head 3 -  String: SUMPR
.head 3 -  String: CK_B
.head 3 -  String: ADD_B
.head 3 -  String: CB_B
.head 3 -  String: SW_B
.head 3 -  String: CB_C
.head 3 -  String: SW_C
.head 3 -  String: ITEM
.head 3 -  String: KV_COST
.head 3 -  String: NK_B
.head 3 -  String: AK_B
.head 3 -  String: OKPO
.head 3 -  String: NLS_V
.head 3 -  String: NLS_CR
.head 3 -  String: NAZN
.head 3 -  String: N_CR
.head 3 -  Date/Time: DAT_CR
.head 3 -  !
.head 3 -  Number: nI
.head 3 -  String: sTemp
.head 3 -  ! String: smKOD_B[*]
.head 3 -  ! String: smKOD_N[*]
.head 3 -  ! String: smKOD_G[*]
.head 3 -  !
.head 3 -  ! String: sNLSK
.head 3 -  String: sNMKV
.head 3 -  String: smTemp[*]
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalSetWindowText(hWndForm, '       Принятие решений по "электронным" документам клиента ' || sSab0 || ' (' || sNmk0
     || ')')
.head 4 -  Call SalCenterWindow(hWndItem)
.head 4 -  Set bX = TRUE
.head 4 -  Call XSalTooltipSetUserDefault()
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_Green)
.head 4 -  Call XSalTooltipSetDelay(200, 30000)
.head 4 -  Set nAN = GetUserId()
.head 4 -  Set dtBD = GetBankDate()
.head 4 -  Set nRRR = -1
.head 4 -  Set nTipPoisk = 4
.head 4 -  Set AMFO = GetBankMfo()
.head 4 -  ! Инициализация параметра CLNTSEC
.head 4 -  Set nCLNTSEC = GetGlobalOptionEx('CLNTSEC')
.head 4 -  ! Call SalDisableWindow(pbF2)
.head 4 -  ! Call SalArraySetUpperBound(smKOD_B, 1, -1)
.head 4 -  ! Call SalArraySetUpperBound(smKOD_N, 1, -1)
.head 4 -  ! Call SalArraySetUpperBound(smKOD_G, 1, -1)
.head 4 +  ! If SqlPrepareAndExecute(hSql(), "
   SELECT substr('000' || ltrim(rtrim(regnum)), -3) || ' ' || name
   INTO   :sTemp
   FROM   bopbank
   WHERE  regnum is not null
   ORDER BY 1")
.head 5 -  Set smKOD_B[0] = ''
.head 5 -  Set nI = 1
.head 5 +  While SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set smKOD_B[nI] = sTemp
.head 6 -  Set nI = nI + 1
.head 4 +  ! If SqlPrepareAndExecute(hSql(), "
   SELECT transcode || ' ' || transdesc
   INTO   :sTemp
   FROM   bopcode
   WHERE  transcode is not null
   ORDER BY 1")
.head 5 -  Set smKOD_N[0] = ''
.head 5 -  Set nI = 1
.head 5 +  While SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set smKOD_N[nI] = sTemp
.head 6 -  Set nI = nI + 1
.head 4 +  ! If SqlPrepareAndExecute(hSql(), "
   SELECT kodc || ' ' || country
   INTO   :sTemp
   FROM   bopcount
   WHERE  kodc is not null
   ORDER BY 1")
.head 5 -  Set smKOD_G[0] = ''
.head 5 -  Set nI = 1
.head 5 +  While SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set smKOD_G[nI] = sTemp
.head 6 -  Set nI = nI + 1
.head 3 +  On SAM_Close
.head 4 +  If not bX
.head 5 -  Return FALSE
.head 3 +  On SAM_Destroy
.head 4 -  Call XSalTooltipSetColors(COLOR_Black, COLOR_White)
.head 4 -  Call XSalTooltipSetDelay(200, 4000)
.head 3 +  On SAM_ReportStart
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFetchInit
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFetchNext
.head 4 +  If bU
.head 5 -  Return FALSE
.head 4 -  ! If SqlPrepareAndExecute(hSql(), '
   SELECT c.okpo,c.nmk,c.adr,o.ruk,o.buh
   INTO   :OKPO,:NMK,:ADRES,:RUK,:BUH
   FROM   customer c, corps o
   WHERE  c.sab=:tbl2.csab and c.custtype in (2,3) and c.stmt=5 and c.rnk=o.rnk(+)') and SqlFetchNext(hSql(), nFetchRes)
.head 4 -  If SqlPrepareAndExecute(hSql(), '
   SELECT c.okpo,c.nmk,c.adr,o.ruk,o.buh
   INTO   :OKPO,:NMK,:ADRES,:RUK,:BUH
   FROM   customer c, corps o
   WHERE  c.sab=:tbl2.csab and c.custtype in (2,3) and c.stmt=6 and c.rnk=o.rnk(+)') and SqlFetchNext(hSql(), nFetchRes)
.head 4 +  Else
.head 5 -  Set OKPO = ''
.head 5 -  Set NMK = ''
.head 5 -  Set ADRES = ''
.head 5 -  Set RUK = ''
.head 5 -  Set BUH = ''
.head 4 -  Set REF = tbl2.cnd
.head 4 -  Set DATZ = '"' || SalFmtFormatDateTime(tbl2.cdatd, 'd') || '" ' || GetMonthUkr(tbl2.cdatd, 'r') ||  ' ' ||
    SalFmtFormatDateTime(tbl2.cdatd, 'yyyy') || ' р.'
.head 4 -  Set NLS_V = tbl2.cnls
.head 4 -  Set NLS_CR = tbl2.cnlsb
.head 4 -  Set SUM = tbl2.cs*100
.head 4 -  Set KV = GetLcv(tbl2.ckv)
.head 4 -  Set NAZN = tbl2.ctag70
.head 4 -  Set N_CR = tbl2.cnkreddog
.head 4 -  Set DAT_CR = tbl2.cdkreddog
.head 4 -  If SqlPrepareAndExecute(hSql(), "
   SELECT SUBSTR(f_sumpr(:SUM,to_char(kv),NVL(gender,'M')),1,200)
   INTO   :SUMPR
   FROM   tabval
   WHERE  lcv=:KV") and SqlFetchNext(hSql(), nFetchRes)
.head 4 +  Else
.head 5 -  Set SUMPR = ''
.head 4 -  Set KV_COST = GetLcv(tbl2.ckvkomiss)
.head 4 -  Set bU = TRUE
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportNotify
.head 4 +  ! If lParam = RPT_BeforeBreakHeader2
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'DT_PRINT', 'Надруковано: ' || SalFmtFormatDateTime(
     SalDateCurrent(), "dd/MM/yyyy hhh:mm:ss"))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'PAX', "Рахунок")
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'ZAKL', IifS(PZ=1, 'Поточна', 'Заключна'))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'SHAP',
     "Nпп Документ   ВО    МФО    Кореспондент   СКП         Сума: ДЕБ КРЕД")
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'BPEM', BPEM)
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'AQH', AQH)
.head 5 -  Set DOS = 0
.head 5 -  Set NPP = 0
.head 5 -  Set KOS = 0
.head 5 -  Set S2 = S1
.head 5 -  Set FIO = 'Вик.' || ISP
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'VSA', ' Вхідне сальдо ' || DK(S1))
.head 4 +  ! If lParam = RPT_BeforeDetail
.head 5 +  If S < 0
.head 6 -  Set DOS = DOS - S
.head 5 +  Else 
.head 6 -  Set KOS = KOS + S
.head 5 -  Set NPP = NPP + 1
.head 5 -  Set S2 = S2 + S
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'NPP', NPP)
.head 4 +  ! If lParam = RPT_BeforeBreakFooter2
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'ISA', 'Вихідне сальдо ' || DK(S2))
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'OBO', 'Всього оборотів ')
.head 5 -  Call SalReportSetStringVar(SalNumberToWindowHandle(wParam), 'FIO', FIO)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'S2', S2)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'DOS', DOS)
.head 5 -  Call SalReportSetNumberVar(SalNumberToWindowHandle(wParam), 'KOS', KOS)
.head 4 -  Return TRUE
.head 3 +  On SAM_ReportFinish
.head 4 -  ! Call DirectView(sFileName)
.head 1 +  Form Window: dlg_klp3
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Работа с ЗАЯВКАМИ на КОНВЕРСИЮ "электронных" клиентов
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
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   1.263"
.head 4 -  Top:    0.177"
.head 4 -  Width:  7.35"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.125"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold
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
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.088"
.head 6 -  Top:    0.49"
.head 6 -  Width:  6.888"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.115"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colSab
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
клиента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.838"
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
.head 5 +  Column: colKlient
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
клиента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.263"
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
.head 5 +  Column: colAlles
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Количество
документов
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.25"
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
.head 5 +  ! Column: colSumma
.winattr
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: На сумму
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  2.313"
.head 6 -  Width Editable? Yes
.head 6 -  Format: #000
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
.head 6 -  List Values 
.head 6 -  Message Actions 
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Boolean: bFL1
.head 5 -  Number: nKrow
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set bFL1 = FALSE
.head 6 -  Set nKrow = 0
.head 6 -  ! Call Debug('Ветка ICT')
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If bAUTO
.head 7 -  ! Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=3 and k.noauto is not null and c.sab is not null and
            c.stmt=5
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=3 and k.noauto is not null and c.sab is not null and
            c.stmt=6
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 +  Else
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM klpv k, customer c
     WHERE k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=3 and c.sab is not null and c.stmt=5
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM klpv k, customer c
     WHERE k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=3 and c.sab is not null and c.stmt=6
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set bFL1 = TRUE
.head 6 -  Set nKrow = nKrow + 1
.head 5 +  On SAM_CreateComplete
.head 6 +  If bFL1
.head 7 -  Call SalTblSortRows(tbl1, SalTblQueryColumnPos(colSab),  TBL_SortIncreasing)
.head 7 -  Call SalTblSetFocusRow(tbl1, Min(nRow, nKrow-1))
.head 7 -  Call SalTblSetRowFlags(tbl1, Min(nRow, nKrow-1),  ROW_Selected, TRUE)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Документы "электронных" клиентов отсутствуют !', 'Предупреждение', 0, 1)
.head 7 -  Call SalDestroyWindow(dlg_klp3)
.head 5 +  On SAM_DoubleClick
.head 6 -  Set nRow = SalTblQueryContext(tbl1)
.head 6 -  Call SalModalDialog(dlg_3, hWndForm, tbl1.colSab, tbl1.colKlient, sOp1, sOp2, sOp3)
.head 6 -  Call SalTblReset(tbl1)
.head 6 -  Call SalSendMsg(tbl1, SAM_Create, 0, 0)
.head 6 -  Call SalSendMsg(tbl1, SAM_CreateComplete, 0, 0)
.head 3 +  Pushbutton: pb1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выбор
.head 4 -  Window Location and Size
.head 5 -  Left:   0.088"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.375"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSendMsg(tbl1, SAM_DoubleClick, 0, 0)
.head 3 +  Pushbutton: pb2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выход
.head 4 -  Window Location and Size
.head 5 -  Left:   1.388"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.375"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 3 +  ! Radio Button: rbRee
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Табличный формат
.head 4 -  Window Location and Size
.head 5 -  Left:   6.788"
.head 5 -  Top:    -0.01"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 -  Message Actions 
.head 3 +  ! Radio Button: rbDok
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Формат документа
.head 4 -  Window Location and Size
.head 5 -  Left:   6.788"
.head 5 -  Top:    0.24"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 -  Message Actions 
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  String: sValue
.head 3 -  String: sTmp
.head 3 -  ! Boolean: bSberBank
.head 3 -  ! Number: nCLNTSEC
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Call SalCenterWindow(hWndItem)
.head 4 -  ! Значение флажка СБ= вычитываем из PARAMS, если его там нет - то по МФО
.head 4 -  ! Set bSberBank = GetBankMfo()='300465'
.head 4 -  ! Инициализация параметра CLNTSEC
.head 4 -  ! Set nCLNTSEC = GetGlobalOptionEx('CLNTSEC')
.head 4 +  ! If SqlPrepareAndExecute(hSql(), "
   SELECT val
   INTO   :sTmp
   FROM   params
   WHERE  par='KL_BOB'")
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set bSberBank = sTmp='1'
.head 4 -  !
.head 4 -  Call PrepareWindow(hWndItem)
.head 4 -  Set nAN = GetUserId()
.head 4 -  Set nRow = 0
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  Call SalGetProfileString('EleOper', Str(1000+nAN), '0', sValue, GetProductName())
.head 4 -  Set bAUTO = Val(GetGlobalOption('KL_PAY'))=1
.head 4 -  ! Set rbRee = sValue='0'
.head 4 -  ! Set rbDok = sValue!='0'
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  ! Call SalSetProfileString('EleOper', Str(1000+nAN),
     IifS(rbRee, '0', '1'), GetProductName())
.head 1 +  Form Window: dlg_klp6
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Работа с ПЛАТЕЖНЫМИ ПОРУЧЕНИЯМИ в инвалюте "электронных" клиентов
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
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   1.575"
.head 4 -  Top:    0.281"
.head 4 -  Width:  7.338"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.104"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold
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
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.088"
.head 6 -  Top:    0.49"
.head 6 -  Width:  6.875"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 4.104"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colSab
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
клиента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.838"
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
.head 5 +  Column: colKlient
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
клиента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.263"
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
.head 5 +  Column: colAlles
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Количество
документов
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.25"
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
.head 5 +  ! Column: colSumma
.winattr
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: На сумму
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  2.313"
.head 6 -  Width Editable? Yes
.head 6 -  Format: #000
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
.head 6 -  List Values 
.head 6 -  Message Actions 
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Boolean: bFL1
.head 5 -  Number: nKrow
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set bFL1 = FALSE
.head 6 -  Set nKrow = 0
.head 6 -  ! Call Debug('Ветка ICT')
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If bAUTO
.head 7 -  ! Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=6 and k.noauto is not null and c.sab is not null and
            c.stmt=5
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=6 and k.noauto is not null and c.sab is not null and
            c.stmt=6
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 +  Else
.head 7 -  ! Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=6 and c.sab is not null and c.stmt=5
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=6 and c.sab is not null and c.stmt=6
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set bFL1 = TRUE
.head 6 -  Set nKrow = nKrow + 1
.head 5 +  On SAM_CreateComplete
.head 6 +  If bFL1
.head 7 -  Call SalTblSortRows(tbl1, SalTblQueryColumnPos(colSab),  TBL_SortIncreasing)
.head 7 -  Call SalTblSetFocusRow(tbl1, Min(nRow, nKrow-1))
.head 7 -  Call SalTblSetRowFlags(tbl1, Min(nRow, nKrow-1),  ROW_Selected, TRUE)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Документы "электронных" клиентов отсутствуют !', 'Предупреждение', 0, 1)
.head 7 -  Call SalDestroyWindow(dlg_klp6)
.head 5 +  On SAM_DoubleClick
.head 6 -  Set nRow = SalTblQueryContext(tbl1)
.head 6 -  Call SalModalDialog(dlg_6, hWndForm, tbl1.colSab, tbl1.colKlient, sOp1, sOp2, sOp3)
.head 6 -  Call SalTblReset(tbl1)
.head 6 -  Call SalSendMsg(tbl1, SAM_Create, 0, 0)
.head 6 -  Call SalSendMsg(tbl1, SAM_CreateComplete, 0, 0)
.head 3 +  Pushbutton: pb1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выбор
.head 4 -  Window Location and Size
.head 5 -  Left:   0.088"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.375"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSendMsg(tbl1, SAM_DoubleClick, 0, 0)
.head 3 +  Pushbutton: pb2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выход
.head 4 -  Window Location and Size
.head 5 -  Left:   1.388"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.375"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 3 +  ! Radio Button: rbRee
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Табличный формат
.head 4 -  Window Location and Size
.head 5 -  Left:   6.788"
.head 5 -  Top:    -0.01"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 -  Message Actions 
.head 3 +  ! Radio Button: rbDok
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Формат документа
.head 4 -  Window Location and Size
.head 5 -  Left:   6.788"
.head 5 -  Top:    0.24"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 -  Message Actions 
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  String: sValue
.head 3 -  ! String: sTmp
.head 3 -  ! Boolean: bSberBank
.head 3 -  ! Number: nCLNTSEC
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Call SalCenterWindow(hWndItem)
.head 4 -  ! Значение флажка СБ= вычитываем из PARAMS, если его там нет - то по МФО
.head 4 -  ! Set bSberBank = GetBankMfo()='300465'
.head 4 -  ! Инициализация параметра CLNTSEC
.head 4 -  ! Set nCLNTSEC = GetGlobalOptionEx('CLNTSEC')
.head 4 +  ! If SqlPrepareAndExecute(hSql(), "
   SELECT val
   INTO   :sTmp
   FROM   params
   WHERE  par='KL_BOB'")
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set bSberBank = sTmp='1'
.head 4 -  !
.head 4 -  Call PrepareWindow(hWndItem)
.head 4 -  Set nAN = GetUserId()
.head 4 -  Set nRow = 0
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  Call SalGetProfileString('EleOper', Str(1000+nAN), '0', sValue, GetProductName())
.head 4 -  Set bAUTO = Val(GetGlobalOption('KL_PAY'))=1
.head 4 -  ! Set rbRee = sValue='0'
.head 4 -  ! Set rbDok = sValue!='0'
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  ! Call SalSetProfileString('EleOper', Str(1000+nAN),
     IifS(rbRee, '0', '1'), GetProductName())
.head 1 +  Form Window: dlg_klp7
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Работа с ПЛАТЕЖНЫМИ ПОРУЧЕНИЯМИ в инвалюте для погашения кредита "электронных" клиентов
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
.head 3 -  Resizable? Yes
.head 3 -  Window Location and Size
.head 4 -  Left:   1.3"
.head 4 -  Top:    0.188"
.head 4 -  Width:  7.35"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 4.906"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold
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
.head 3 +  Child Table: tbl1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.088"
.head 6 -  Top:    0.49"
.head 6 -  Width:  6.888"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.885"
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
.head 5 -  Maximum Rows in Memory: 10000
.head 5 -  Discardable? No
.head 4 +  Contents
.head 5 +  Column: colSab
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
клиента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  0.838"
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
.head 5 +  Column: colKlient
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Наименование
клиента
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.263"
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
.head 5 +  Column: colAlles
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Количество
документов
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.25"
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
.head 5 +  ! Column: colSumma
.winattr
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: На сумму
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  2.313"
.head 6 -  Width Editable? Yes
.head 6 -  Format: #000
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
.head 6 -  List Values 
.head 6 -  Message Actions 
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Boolean: bFL1
.head 5 -  Number: nKrow
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set bFL1 = FALSE
.head 6 -  Set nKrow = 0
.head 6 -  ! Call Debug('Ветка ICT')
.head 6 -  Call SalWaitCursor(TRUE)
.head 6 +  If bAUTO
.head 7 -  ! Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=7 and k.noauto is not null and c.sab is not null and
            c.stmt=5
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=7 and k.noauto is not null and c.sab is not null and
            c.stmt=6
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 +  Else
.head 7 -  ! Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=7 and c.sab is not null and c.stmt=5
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 7 -  Call SalTblPopulate(tbl1, hSql(), T('
     SELECT k.sab,nvl(c.nmkk,c.nmk),sum(1)
     INTO   :tbl1.colSab,:tbl1.colKlient,:tbl1.colAlles
     FROM   klpv k, customer c
     WHERE  k.neom=:nAN and k.fl<7 and k.sab=c.sab and k.tipkb=7 and c.sab is not null and c.stmt=6
     GROUP BY k.sab,nvl(c.nmkk,c.nmk)'), TBL_FillAll)
.head 6 -  Call SalWaitCursor(FALSE)
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set bFL1 = TRUE
.head 6 -  Set nKrow = nKrow + 1
.head 5 +  On SAM_CreateComplete
.head 6 +  If bFL1
.head 7 -  Call SalTblSortRows(tbl1, SalTblQueryColumnPos(colSab),  TBL_SortIncreasing)
.head 7 -  Call SalTblSetFocusRow(tbl1, Min(nRow, nKrow-1))
.head 7 -  Call SalTblSetRowFlags(tbl1, Min(nRow, nKrow-1),  ROW_Selected, TRUE)
.head 6 +  Else
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call MessageNoWait('Документы "электронных" клиентов отсутствуют !', 'Предупреждение', 0, 1)
.head 7 -  Call SalDestroyWindow(dlg_klp7)
.head 5 +  On SAM_DoubleClick
.head 6 -  Set nRow = SalTblQueryContext(tbl1)
.head 6 -  Call SalModalDialog(dlg_7, hWndForm, tbl1.colSab, tbl1.colKlient, sOp1, sOp2, sOp3)
.head 6 -  Call SalTblReset(tbl1)
.head 6 -  Call SalSendMsg(tbl1, SAM_Create, 0, 0)
.head 6 -  Call SalSendMsg(tbl1, SAM_CreateComplete, 0, 0)
.head 3 +  Pushbutton: pb1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выбор
.head 4 -  Window Location and Size
.head 5 -  Left:   0.088"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.375"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Dark Green
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalSendMsg(tbl1, SAM_DoubleClick, 0, 0)
.head 3 +  Pushbutton: pb2
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выход
.head 4 -  Window Location and Size
.head 5 -  Left:   1.388"
.head 5 -  Top:    0.073"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.375"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: 12
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Red
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalDestroyWindow(hWndForm)
.head 3 +  ! Radio Button: rbRee
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Табличный формат
.head 4 -  Window Location and Size
.head 5 -  Left:   6.788"
.head 5 -  Top:    -0.01"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 -  Message Actions 
.head 3 +  ! Radio Button: rbDok
.winattr
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Формат документа
.head 4 -  Window Location and Size
.head 5 -  Left:   6.788"
.head 5 -  Top:    0.24"
.head 5 -  Width:  2.4"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.25"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 -  Message Actions 
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sOp1
.head 3 -  String: sOp2
.head 3 -  String: sOp3
.head 2 +  Window Variables
.head 3 -  Number: nRow
.head 3 -  String: sValue
.head 3 -  String: sTmp
.head 3 -  ! Boolean: bSberBank
.head 3 -  ! Number: nCLNTSEC
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Call SalCenterWindow(hWndItem)
.head 4 -  ! Значение флажка СБ= вычитываем из PARAMS, если его там нет - то по МФО
.head 4 -  ! Set bSberBank = GetBankMfo()='300465'
.head 4 -  ! Инициализация параметра CLNTSEC
.head 4 -  ! Set nCLNTSEC = GetGlobalOptionEx('CLNTSEC')
.head 4 +  ! If SqlPrepareAndExecute(hSql(), "
   SELECT val
   INTO   :sTmp
   FROM   params
   WHERE  par='KL_BOB'")
.head 5 +  If SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Set bSberBank = sTmp='1'
.head 4 -  !
.head 4 -  Call PrepareWindow(hWndItem)
.head 4 -  Set nAN = GetUserId()
.head 4 -  Set nRow = 0
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  Call SalGetProfileString('EleOper', Str(1000+nAN), '0', sValue, GetProductName())
.head 4 -  Set bAUTO = Val(GetGlobalOption('KL_PAY'))=1
.head 4 -  ! Set rbRee = sValue='0'
.head 4 -  ! Set rbDok = sValue!='0'
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On SAM_Destroy
.head 4 -  Call SalUseRegistry(TRUE, GetCompanyName())
.head 4 -  ! Call SalSetProfileString('EleOper', Str(1000+nAN),
     IifS(rbRee, '0', '1'), GetProductName())
.head 1 +  Dialog Box: TT_kurs
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Введите или измените дополнительные реквизиты
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   2.488"
.head 4 -  Top:    0.958"
.head 4 -  Width:  8.1"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 0.938"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Arial Cyr
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold-Italic
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: корректировка курса конверсии
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.262"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ok
.head 4 -  Window Location and Size
.head 5 -  Left:   0.071"
.head 5 -  Top:    0.052"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.573"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: 9
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Indexgo.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set nKURSresult = dfKurs
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 -  Background Text: Введите курс конверсии
.head 4 -  Resource Id: 34784
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.786"
.head 5 -  Top:    0.24"
.head 5 -  Width:  3.114"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.24"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: 11
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfKurs
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.086"
.head 6 -  Top:    0.208"
.head 6 -  Width:  1.686"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.24"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: ###00000
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отказ
.head 4 -  Window Location and Size
.head 5 -  Left:   1.386"
.head 5 -  Top:    0.052"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.573"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Stop.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nKURS
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Set dfKurs = nKURSresult
.head 4 -  Call SalSetFocus(dfKurs)
.head 1 +  Dialog Box: TT_KOD_NBG
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Введите или измените дополнительные реквизиты
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.45"
.head 4 -  Top:    1.719"
.head 4 -  Width:  10.543"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.906"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Arial Cyr
.head 3 -  Font Size: 10
.head 3 -  Font Enhancement: Bold-Italic
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: выбор кода операции и номера счёта для конверсии
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: 0.262"
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 10
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Ok
.head 4 -  Window Location and Size
.head 5 -  Left:   0.686"
.head 5 -  Top:    1.031"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.573"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: 9
.head 4 -  Font Enhancement: Bold
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Indexgo.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set sKOD_B = Left(cmbKOD_B, 3)
.head 6 -  Set sKOD_N = Left(cmbKOD_N, 7)
.head 6 -  Set sKOD_G = Left(cmbKOD_G, 3)
.head 6 -  Call SalEndDialog(hWndForm, 1)
.head 3 -  Background Text: Введите КОД банка (1-ПБ)
.head 4 -  Resource Id: 581
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.073"
.head 5 -  Width:  4.343"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: 11
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Введите КОД назначения платежа (1-ПБ)
.head 4 -  Resource Id: 583
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.406"
.head 5 -  Width:  4.343"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: 11
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Введите КОД государства бенеф. (1-ПБ)
.head 4 -  Resource Id: 584
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.1"
.head 5 -  Top:    0.729"
.head 5 -  Width:  4.343"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: 11
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Combo Box: cmbKOD_G
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.529"
.head 5 -  Top:    0.677"
.head 5 -  Width:  5.857"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.26"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  String Type: String
.head 4 -  Maximum Data Length: Default
.head 4 -  Sorted? Yes
.head 4 -  Always Show List? No
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbKOD_B
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.543"
.head 5 -  Top:    0.031"
.head 5 -  Width:  5.857"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.927"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  String Type: String
.head 4 -  Maximum Data Length: Default
.head 4 -  Sorted? Yes
.head 4 -  Always Show List? No
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  Combo Box: cmbKOD_N
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   4.529"
.head 5 -  Top:    0.365"
.head 5 -  Width:  5.857"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.594"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  String Type: String
.head 4 -  Maximum Data Length: Default
.head 4 -  Sorted? Yes
.head 4 -  Always Show List? No
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  List Initialization
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbCancel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отказ
.head 4 -  Window Location and Size
.head 5 -  Left:   2.671"
.head 5 -  Top:    1.031"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.573"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Stop.bmp
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: smKOD_B[*]
.head 3 -  String: smKOD_N[*]
.head 3 -  String: smKOD_G[*]
.head 2 +  Window Variables
.head 3 -  Number: nI
.head 3 -  Number: nIstart1
.head 3 -  Number: nIstart2
.head 3 -  Number: nIstart3
.head 3 -  Number: nKOD_B
.head 3 -  Number: nKOD_N
.head 3 -  Number: nKOD_G
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SalListClear(cmbKOD_B)
.head 4 -  Call SalListClear(cmbKOD_N)
.head 4 -  Call SalListClear(cmbKOD_G)
.head 4 -  Call SalArrayGetUpperBound(smKOD_B, 1, nKOD_B)
.head 4 -  Call SalArrayGetUpperBound(smKOD_N, 1, nKOD_N)
.head 4 -  Call SalArrayGetUpperBound(smKOD_G, 1, nKOD_G)
.head 4 -  !
.head 4 -  Set nI = 0
.head 4 +  While nI <= nKOD_B
.head 5 -  Call SalListAdd(cmbKOD_B, smKOD_B[nI])
.head 5 +  If Left(smKOD_B[nI], 3) = sKOD_B
.head 6 -  Set nIstart1 = nI
.head 5 -  Set nI = nI + 1
.head 4 -  Set cmbKOD_B = smKOD_B[nIstart1]
.head 4 -  !
.head 4 -  Set nI = 0
.head 4 +  While nI <= nKOD_N
.head 5 -  Call SalListAdd(cmbKOD_N, smKOD_N[nI])
.head 5 +  If Left(smKOD_N[nI], 7) = sKOD_N
.head 6 -  Set nIstart2 = nI
.head 5 -  Set nI = nI + 1
.head 4 -  Set cmbKOD_N = smKOD_N[nIstart2]
.head 4 -  !
.head 4 -  Set nI = 0
.head 4 +  While nI <= nKOD_G
.head 5 -  Call SalListAdd(cmbKOD_G, smKOD_G[nI])
.head 5 +  If Left(smKOD_G[nI], 3) = sKOD_G
.head 6 -  Set nIstart3 = nI
.head 5 -  Set nI = nI + 1
.head 4 -  Set cmbKOD_G = smKOD_G[nIstart3]
.head 1 +  ! cQuickTabsDialog: dlg_klp2
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Picture: picTabs
.data CLASSPROPS
0000: 5461624F7269656E 746174696F6E0001 000000546162546F 704D617267696E00
0020: 0200300000546162 466F726D50616765 73001200646C675F 6B6C7009646F6375
0040: 6D656E7432000054 6162447261775374 796C65000B005769 6E39355374796C65
0060: 0000546162426F74 746F6D4D61726769 6E000500302E3435 0000546162506167
0080: 65436F756E740002 003100005461624C 6162656C73002400 20D2E0E1EBE8F7ED
00A0: E0FF20F4EEF0ECE0 200920D4EEF0ECE0 20E4EEEAF3ECE5ED F2E0200000546162
00C0: 4E616D6573001600 5462646C675F6B6C 70095462646F6B75 6D656E7432000054
00E0: 616252696768744D 617267696E000200 3000005461624375 7272656E74000A00
0100: 5462646C675F6B6C 7000005461624C65 66744D617267696E 0002003000000000
0120: 0000000000000000 0000000000000000 00000000
.enddata
.data CLASSPROPSSIZE
0000: 3401
.enddata
.data INHERITPROPS
0000: 0100
.enddata
.head 4 -  Message Actions
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  String: sSab0
.head 3 -  String: sNmk0
.head 2 -  Window Variables
.head 2 -  Message Actions
