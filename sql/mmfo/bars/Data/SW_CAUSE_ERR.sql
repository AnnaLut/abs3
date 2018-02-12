MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  1001 as ID,
  '������� � � ��� � ������� � ��' as NAME,
  NULL as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  1002 as ID,
  '������� � � � ������� � ���' as NAME,
  NULL as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  1 as ID,
  '���������� ������' as NAME,
  '1' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  2 as ID,
  '����������� ����� ��-���' as NAME,
  '2' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  4 as ID,
  '��������� � ��� ��-���' as NAME,
  '4' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  8 as ID,
  '������� ������� ���� (������������)' as NAME,
  '8' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  3 as ID,
  '���������� ������ + ����������� ����� ��-���' as NAME,
  '1+2' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  7 as ID,
  '���������� ������ + ����������� ����� ��-��� + ��������� � ��� ��-���' as NAME,
  '1+2+4' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  15 as ID,
  '���������� ������ + ����������� ����� ��-��� + ��������� � ��� ��-��� + ������� ������� ���� (������������)' as NAME,
  '1+2+4+8' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  6 as ID,
  '����������� ����� ��-��� + ��������� � ��� ��-���' as NAME,
  '2+4' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  14 as ID,
  '����������� ����� ��-��� + ��������� � ��� ��-��� + ������� ������� ���� (������������)' as NAME,
  '2+4+8' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  5 as ID,
  '���������� ������ + ��������� � ��� ��-���' as NAME,
  '1+4' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  9 as ID,
  '���������� ������ + ������� ������� ���� (������������)' as NAME,
  '1+8' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  10 as ID,
  '����������� ����� ��-��� + ������� ������� ���� (������������)' as NAME,
  '2+8' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  11 as ID,
  '���������� ������ + ����������� ����� ��-��� + ������� ������� ���� (������������)' as NAME,
  '1+2+8' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  12 as ID,
  '��������� � ��� ��-��� + ������� ������� ���� (������������)' as NAME,
  '4+8' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  13 as ID,
  '���������� ������ + ��������� � ��� ��-��� + ������� ������� ���� (������������)' as NAME,
  '1+4+8' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  16 as ID,
  '����������� ����� ��-���' as NAME,
  '16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  17 as ID,
  '���������� ������ + ����������� ����� ��-���' as NAME,
  '1+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  18 as ID,
  '����������� ����� ��-��� + ����������� ����� ��-���' as NAME,
  '2+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  19 as ID,
  '���������� ������ + ����������� ����� ��-��� + ����������� ����� ��-���' as NAME,
  '1+2+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  20 as ID,
  '��������� � ��� ��-��� + ����������� ����� ��-���' as NAME,
  '4+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  21 as ID,
  '���������� ������ + ��������� � ��� ��-��� + ����������� ����� ��-���' as NAME,
  '1+4+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  22 as ID,
  '����������� ����� ��-��� + ��������� � ��� ��-��� + ����������� ����� ��-���' as NAME,
  '2+4+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  23 as ID,
  '���������� ������ + ����������� ����� ��-��� + ��������� � ��� ��-��� + ����������� ����� ��-���' as NAME,
  '1+2+4+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  24 as ID,
  '������� ������� ���� (������������) + ����������� ����� ��-���' as NAME,
  '8+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  25 as ID,
  '���������� ������ + ������� ������� ���� (������������) + ����������� ����� ��-���' as NAME,
  '1+8+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  27 as ID,
  '���������� ������ + ����������� ����� ��-��� + ������� ������� ���� (������������) + ����������� ����� ��-���' as NAME,
  '1+2+8+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  28 as ID,
  '��������� � ��� ��-��� + ������� ������� ���� (������������) + ����������� ����� ��-���' as NAME,
  '4+8+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  29 as ID,
  '���������� ������ + ��������� � ��� ��-��� + ������� ������� ���� (������������) + ����������� ����� ��-���' as NAME,
  '1+4+8+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  26 as ID,
  '����������� ����� ��-��� + ������� ������� ���� (������������) + ����������� ����� ��-���' as NAME,
  '2+8+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  30 as ID,
  '����������� ����� ��-��� + ��������� � ��� ��-��� + ������� ������� ���� (������������) + ����������� ����� ��-���' as NAME,
  '2+4+8+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  31 as ID,
  '���������� ������ + ����������� ����� ��-��� + ��������� � ��� ��-��� + ������� ������� ���� (������������) + ����������� ����� ��-���' as NAME,
  '1+2+4+8+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

  COMMIT;
