MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  43 as ID,
  '��������� ��������� ��������� ��������, � ���� ���� �� �����������, �� ������� ��������� �������� ������������' as NAME,
  0 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  69 as ID,
  '���������� �볺���� ���������� ��������, �� �������� ����������� ����������� ����������' as NAME,
  0 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  70 as ID,
  '��������� �볺���� ������ � ��������� ���������� �������� �� ����, �� ������� �� �������� ��������� 150 000 �������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  72 as ID,
  '�볺��-�������� �����, ����� ����������� �������� (����������) ��� �����, �� ����� ����� �������������� ��������� �� ������ ���, ������� �� ������� ��� ��������� � ������������ ������������ ��������, ��� ���� ���� ����������� �������� �������, ��� ���� �������� �� ���������� ������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  73 as ID,
  '������� �볺���� ����� �� ������ �� ��������� ������������������� �������� (���������)' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  74 as ID,
  '����������� ����� � �������� ����� �� ����, �� ������� �� �������� ��������� 150 000 ���. �� ����������� �� ������� �������� ���, ������� � ������ �������� �����, �������� �����, ���������� ���������� �������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  75 as ID,
  '��������� ����� �� ���������-���������� ����������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  76 as ID,
  '��������� �볺���� ���������� �������� ���� �����-������� ������ ������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  77 as ID,
  '����������� ������ ��������� ��� ��������� ��������� �������� ����� ������������ (�����������), ���� ����������� (����������) ������ ��������� ����� ��� ������������ ������� (����������) �������� � ������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  78 as ID,
  '������� ��������� ������� �� ������� �볺���, ���� ��������� �������� ������� ����� ���� ������ �볺���� ��� ���� �������������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  79 as ID,
  '��������� ���������/�������/���������� ��������� ��������, �����, ������� �� ����� ����������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  80 as ID,
  '��������� �������� �����/������� ��� ����������� ����� ������� ������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  200 as ID,
  '����������� ������� �����' as NAME,
  0 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  202 as ID,
  '�볺��, ���� ����� ��������� ������������/����������� ��� �������� ������ �� ����, OFAC, ��' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  204 as ID,
  '��������� �볺���� ��� ������ �� ������� ���������/ ����������, �� ����� ����� ���������� �������� ������� ������������� �������� (����������)' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  205 as ID,
  '������������ ����� ������� �볺���� �� ��� ��������� ������������� ��/��� ����������� �볺��� (���������� �������� �볺���) ����������� ���������� ��� ������� ���������� � ����� �������� ���� � �����' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  206 as ID,
  '�볺�� �� ����� ����� ���� ������������ ��������� ���������� ��� �볺��� �� ����� �������� ����������/���������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  207 as ID,
  '���������� �볺���� ���������� ��������, �� ����� ������ ���������' as NAME,
  1 as INUSE
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, INUSE)
VALUES (
  B.ID, B.NAME, B.INUSE)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.INUSE = B.INUSE;

COMMIT;
