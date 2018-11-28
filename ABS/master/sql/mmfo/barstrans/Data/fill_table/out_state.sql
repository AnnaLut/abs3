MERGE INTO OUT_STATE A USING
 (SELECT
  -1 as ID,
  'g_out_new_req' as CONST_N,
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

MERGE INTO OUT_STATE A USING
 (SELECT
  0 as ID,
  'g_out_req_add_2_queen' as CONST_N,
  '����� ���������� �� ����� �� �������' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  1 as ID,
  'g_out_req_start_proc' as CONST_N,
  '��������� ������� ������' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  2 as ID,
  'g_out_req_send_res_id' as CONST_N,
  '����� ����������(�������� ��)' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  3 as ID,
  'g_out_req_send_err' as CONST_N,
  '������� ��� �������� ������' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  4 as ID,
  'g_out_chk_state_add_2_queen' as CONST_N,
  '���������� �� ����� �� ��������� ������� �������' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  5 as ID,
  'g_out_chk_state_start_send' as CONST_N,
  '��������� �������� ��������� ��������� ������� �������' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  6 as ID,
  'g_out_chk_state_in_proc' as CONST_N,
  '�������� ������ ������: "����� � �������".' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  7 as ID,
  'g_out_chk_state_proc' as CONST_N,
  '�������� ������ ������: "����� ���������".' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  8 as ID,
  'g_out_chk_state_err' as CONST_N,
  '�������� ������ ������: "������� ������� ������".' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  9 as ID,
  'g_out_chk_send_err' as CONST_N,
  '������� �������� ������ ��� ��������� �������.' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  10 as ID,
  'g_out_get_data_add_2_queen' as CONST_N,
  '����� �� ��������� ����� ���������� �� �����.' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  11 as ID,
  'g_out_get_data_in_proc' as CONST_N,
  '��������� �������� ������ �� ��������� �����.' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  12 as ID,
  'g_out_get_data_resive' as CONST_N,
  '��� ��������.' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  13 as ID,
  'g_out_get_data_err' as CONST_N,
  '������� ��������� �����.' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  14 as ID,
  'g_out_new_req_err' as CONST_N,
  '��������� ������ �������� � ���������.' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  15 as ID,
  'g_out_new_req_done' as CONST_N,
  '����� �������� ������.' as NAME
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

MERGE INTO OUT_STATE A USING
 (SELECT
  16 as ID,
  'g_out_all_req_err' as CONST_N,
  '�� ������ �������� � ���������.' as NAME
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
