SET DEFINE OFF;
MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  1 as FUNCID,
  '��: �������� ��������� �� ' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  NULL as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '80' as FORM_NAME,
  NULL as CHECK_FUNC,
  '/barsroot/CreditUi/NewCredit/?custtype=3&nd=:ND&sos=:SOS' as WEB_FORM_NAME,
  80 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  2 as FUNCID,
  '��: ������� �� ��������,���''����� � ��' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '106' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CC_W017[NSIFUNCTION][ACCESSCODE=>2][PROC=>PUL.Set_Mas_Ini(''ND'',:ND,''X''); PUL.Set_Mas_Ini(''ACCC'',:ACC8,''ACCC''); PUL.Set_Mas_Ini(''RNK'',:RNK,''RNK'')][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  106 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  3 as FUNCID,
  '��: �������� ��� ��� �������� ��' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'EACH' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '83' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CC_W_LIM1_EXT[NSIFUNCTION][ACCESSCODE=>0][PROC=>PUL.PUT(''ND'',:ND);PUL.PUT(''ACC8'',:ACC8)][EXEC=>BEFORE][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]' as WEB_FORM_NAME,
  83 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  4 as FUNCID,
  '��: ������ ���� ������������' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '79' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CC_W_GLK1[NSIFUNCTION][ACCESSCODE=>0][PROC=>PUL.Set_Mas_Ini(''ND'',:ND, ''X'' )][EXEC=>BEFORE][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]' as WEB_FORM_NAME,
  79 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  5 as FUNCID,
  '��: �������� ������������' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '65' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_ZAL_ND[NSIFUNCTION][ACCESSCODE=>5][PROC=>PUL.Set_Mas_Ini(''ND'',:ND,''X''); PUL.Set_Mas_Ini(''ACCC'',:ACC8, ''ACCC'')][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  65 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  6 as FUNCID,
  '��: ���./��������� ��' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '55' as FORM_NAME,
  NULL as CHECK_FUNC,
  '/barsroot/CreditUi/NewCredit/?custtype=2&nd=:ND&tagOnly=true' as WEB_FORM_NAME,
  55 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  85 as FUNCID,
  '��: ������ �볺���' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '155' as FORM_NAME,
  NULL as CHECK_FUNC,
  '/barsroot/clientregister/registration.aspx?readonly=1&rnk=:RNK' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  84 as FUNCID,
  '��: ������ ���� ������������' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '79' as FORM_NAME,
  NULL as CHECK_FUNC,
  '/barsroot/CreditUi/glk/Index/?id=:ND' as WEB_FORM_NAME,
  79 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  83 as FUNCID,
  '��: ������������ �������/���' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'EACH' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '65' as FORM_NAME,
  NULL as CHECK_FUNC,
  '/barsroot/CreditUi/provide/Index/?id=:ND' as WEB_FORM_NAME,
  65 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  7 as FUNCID,
  '��: ������  �������  �/� �� ��/�����������' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'EACH' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '58' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CCK_PL_INS1[NSIFUNCTION][ACCESSCODE=>2][PROC=>PUL.Set_Mas_Ini(''ND'',:ND,''X'')][EXEC=>BEFORE][DESCR=>������ ��� �� ��: ������  �������  �/� �� ��/�����������][showDialogWindow=>false]' as WEB_FORM_NAME,
  58 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  8 as FUNCID,
  '��: ���������� ���������/���������� ���' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '107' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CC_VP_DOSR[ACCESSCODE=>0][DESCR=>���������� ��������� /���������/���������� ���/][showDialogWindow=>false][CONDITIONS=> nd=:ND]' as WEB_FORM_NAME,
  107 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  10 as FUNCID,
  '��: �������� ����� ������� �� ��' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '111' as FORM_NAME,
  NULL as CHECK_FUNC,
  '/barsroot/customerlist/custacc.aspx?type=3&nd=:ND' as WEB_FORM_NAME,
  111 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  38 as FUNCID,
  '�� ��: 4 ����������� ³������,  ����, ���� ��� ��, �� ����������� ' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  NULL as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_cck1(14,null)][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  11 as FUNCID,
  '��: ��������� �������������� ����' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '37' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CC_SOB_U[ACCESSCODE=>0][PROC=>PUL.Set_Mas_Ini(''ND'',:ND,''X'')][EXEC=>BEFORE][showDialogWindow=>false][CONDITIONS=> nd=:ND]' as WEB_FORM_NAME,
  37 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  18 as FUNCID,
  '��: ���� ��� ���������������� ��' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '51' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CCK_RESTR[NSIFUNCTION][CONDITIONS=>ND=:ND][ACCESSCODE=>2][showDialogWindow=>false]
' as WEB_FORM_NAME,
  51 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  45 as FUNCID,
  '��: ������ ���� �� ��������' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '86' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CC_SOB_WF[ACCESSCODE=>1][PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�,TYPE=S),:E(SEM=��,TYPE=S)][EXEC=>BEFORE]' as WEB_FORM_NAME,
  86 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  99 as FUNCID,
  '��: ����� �������� �� ' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '75' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_CCK_ZF[ACCESSCODE=>1][DESCR=>��: ����� �������� ��]' as WEB_FORM_NAME,
  75 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  23 as FUNCID,
  '��: ��䳿 �� �������� ��' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '93' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CC_SOB[ACCESSCODE=>1][PROC=>PUL.Set_Mas_Ini(''ND'',:ND,''X'')][EXEC=>BEFORE][showDialogWindow=>false][CONDITIONS=> nd=:ND]' as WEB_FORM_NAME,
  93 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  25 as FUNCID,
  '��: ������������� �������� �������� ������������' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  NULL as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '105' as FORM_NAME,
  NULL as CHECK_FUNC,
  '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_fl&rnk=:RNK' as WEB_FORM_NAME,
  105 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  31 as FUNCID,
  '�� ��: 1.����������� ³������,  ����, ����' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  NULL as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_cck1(11,:E)][PAR=>:E(SEM=���� ��,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  32 as FUNCID,
  '�� ��: 2 ����������� ³������,  ����, ����  ��� �� � �����.�� SG ' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  NULL as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_cck1(12,:E)][PAR=>:E(SEM=���� ��,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  33 as FUNCID,
  '�� ��: 3 ����������� ³������,  ����, ���� ��� �� � �����.������' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  NULL as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_cck1(13,null)][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  40 as FUNCID,
  '�� ��: 5 ����������� ³������,  ����, ���� ���  ��Ĳ������  ��' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'EACH' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  NULL as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_INTEREST_CCK_ND[NSIFUNCTION][ACCESSCODE=>2][PROC=>PUL.PUT(''ND'',:ND);p_interest_cck1( - 999,:E)][PAR=>:E(SEM=���� ��,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  39 as FUNCID,
  '�� ��: 5 ����������� ³������,  ����, ���� ��� ������  ��' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  NULL as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_INTEREST_CCK_ND[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_cck1( - :R,:E)][PAR=>:E(SEM=���� ��,TYPE=D), :R(SEM=���_��,TYPE=N)][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  34 as FUNCID,
  '�� ��: 3 ����������� ³������,  ����, ���� ��� �� � �����.������ (������)' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  NULL as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_cck1(15,null)][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011627 as TABID,
  555 as FUNCID,
  '�� ��: 1.����������� ³������,  ����, ����' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  NULL as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>cck_ui.p_cck_interest(11,:E)][PAR=>:E(SEM=���� ��,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]' as WEB_FORM_NAME,
  NULL as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;

COMMIT;