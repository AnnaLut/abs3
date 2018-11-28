MERGE INTO INPUT_STATE A USING
 (SELECT
  -1 as ID,
  'g_in_new_req' as CONST_N,
  '����� �����' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, CONST_N, NAME)
VALUES (
  B.ID, B.CONST_N, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.CONST_N = B.CONST_N,
  A.NAME = B.NAME;

MERGE INTO INPUT_STATE A USING
 (SELECT
  0 as ID,
  'g_in_convert' as CONST_N,
  '����� ������������' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, CONST_N, NAME)
VALUES (
  B.ID, B.CONST_N, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.CONST_N = B.CONST_N,
  A.NAME = B.NAME;

MERGE INTO INPUT_STATE A USING
 (SELECT
  1 as ID,
  'g_in_req_add_2_queen' as CONST_N,
  '����� ���������� �� ����� �� �������.' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, CONST_N, NAME)
VALUES (
  B.ID, B.CONST_N, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.CONST_N = B.CONST_N,
  A.NAME = B.NAME;

MERGE INTO INPUT_STATE A USING
 (SELECT
  2 as ID,
  'g_in_req_start_proc' as CONST_N,
  '��������� ������� ������.' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, CONST_N, NAME)
VALUES (
  B.ID, B.CONST_N, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.CONST_N = B.CONST_N,
  A.NAME = B.NAME;

MERGE INTO INPUT_STATE A USING
 (SELECT
  3 as ID,
  'g_in_req_proc_err' as CONST_N,
  '������� ������� ������.' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, CONST_N, NAME)
VALUES (
  B.ID, B.CONST_N, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.CONST_N = B.CONST_N,
  A.NAME = B.NAME;

MERGE INTO INPUT_STATE A USING
 (SELECT
  4 as ID,
  'g_in_req_procesed' as CONST_N,
  '����� ������ ���������.' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, CONST_N, NAME)
VALUES (
  B.ID, B.CONST_N, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.CONST_N = B.CONST_N,
  A.NAME = B.NAME;

MERGE INTO INPUT_STATE A USING
 (SELECT
  5 as ID,
  'g_in_resp_sended' as CONST_N,
  '³������ ����������.' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, CONST_N, NAME)
VALUES (
  B.ID, B.CONST_N, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.CONST_N = B.CONST_N,
  A.NAME = B.NAME;

MERGE INTO INPUT_STATE A USING
 (SELECT
  6 as ID,
  'g_in_resp_send_err' as CONST_N,
  '������� ��� �������� ������.' as NAME
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, CONST_N, NAME)
VALUES (
  B.ID, B.CONST_N, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.CONST_N = B.CONST_N,
  A.NAME = B.NAME;

COMMIT;
