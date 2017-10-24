begin
MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  1 as BUS_MOD_ID,
  '�������� �������� ����� �� ������������� ��������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  2 as BUS_MOD_ID,
  '����������� ������� �� ������������ ���������� � ����� �������� ��� ������/FVTPL ��� ������������ �������� ���������� �����������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  3 as BUS_MOD_ID,
  '�������� �������� ����� �� ���������� ��������� �������� ������ (����� � ����ϻ) �� �� �������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  4 as BUS_MOD_ID,
  '����������� ������� �� ������������ ���������� � ����� �������� ��� ������/FVTPL ��� �������� ������ ������ �� ����������� ��������� ����������� �������������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  5 as BUS_MOD_ID,
  '�������� �������� ����� �� �������������� �� ������ ���������� �� ��� �� �������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  6 as BUS_MOD_ID,
  '�������� �������� ����� �� �������������� ���������, �������� ��������� ��������� (������� �� �������� ����������)' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  7 as BUS_MOD_ID,
  '���������� ��� �������� �������� ����� �� �������������� ��������� (�������������� ���������), �������� ����������� ������� ���������� �� ��������������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  8 as BUS_MOD_ID,
  '�������� �������� ����� �� �������������� ���������, �������� ����������� ������� ��������� ������������, ����������� �� ��������� �������� ���������� �� �����' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  9 as BUS_MOD_ID,
  '�������� �������� ����� �� ���������, �������� ������� �����������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  10 as BUS_MOD_ID,
  '��� �������� �������� ����� �� ���������, �������� ����� �����������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  11 as BUS_MOD_ID,
  '�������� �������� ������ �� ���������, �������� ����-������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  12 as BUS_MOD_ID,
  '�������� �������� ����� �� ���������, �������� �������� ������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  13 as BUS_MOD_ID,
  '�������� ������� �� ���������� �������� (������� � ������������)' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  14 as BUS_MOD_ID,
  '�������� �������� ����� �� ������ �������������� ���������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;

MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  15 as BUS_MOD_ID,
  '�������� �������� ����� �� ���������� ����������� �������������' as BUS_MOD_NAME
  FROM DUAL) B
ON (A.BUS_MOD_ID = B.BUS_MOD_ID)
WHEN NOT MATCHED THEN 
INSERT (
  BUS_MOD_ID, BUS_MOD_NAME)
VALUES (
  B.BUS_MOD_ID, B.BUS_MOD_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.BUS_MOD_NAME = B.BUS_MOD_NAME;
end;
/
COMMIT;
