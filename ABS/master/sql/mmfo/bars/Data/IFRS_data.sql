Begin
MERGE INTO BARS.IFRS A USING
 (SELECT
  'AC' as IFRS_ID,
  '������������ �������' as IFRS_NAME
  FROM DUAL) B
ON (A.IFRS_ID = B.IFRS_ID)
WHEN NOT MATCHED THEN 
INSERT (
  IFRS_ID, IFRS_NAME)
VALUES (
  B.IFRS_ID, B.IFRS_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.IFRS_NAME = B.IFRS_NAME;

MERGE INTO BARS.IFRS A USING
 (SELECT
  'FVOCI' as IFRS_ID,
  '����������� ������� �� ������������ ���������� � ����� ����� �������� ������' as IFRS_NAME
  FROM DUAL) B
ON (A.IFRS_ID = B.IFRS_ID)
WHEN NOT MATCHED THEN 
INSERT (
  IFRS_ID, IFRS_NAME)
VALUES (
  B.IFRS_ID, B.IFRS_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.IFRS_NAME = B.IFRS_NAME;

MERGE INTO BARS.IFRS A USING
 (SELECT
  'FVTPL/Other' as IFRS_ID,
  '����������� ������� �� ������������ ���������� � ����� �������� ��� ������' as IFRS_NAME
  FROM DUAL) B
ON (A.IFRS_ID = B.IFRS_ID)
WHEN NOT MATCHED THEN 
INSERT (
  IFRS_ID, IFRS_NAME)
VALUES (
  B.IFRS_ID, B.IFRS_NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.IFRS_NAME = B.IFRS_NAME;
end;
/
COMMIT;
