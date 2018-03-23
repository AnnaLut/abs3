SET DEFINE OFF;
Begin
MERGE INTO BARS.ACCOUNTS_FIELD A USING
 (SELECT
  'INTRT' as TAG,
  '������� ��������� ������' as NAME,
  NULL as DELETED,
  1 as USE_IN_ARCH
  FROM DUAL) B
ON (A.TAG = B.TAG)
WHEN NOT MATCHED THEN 
INSERT (
  TAG, NAME, DELETED, USE_IN_ARCH)
VALUES (
  B.TAG, B.NAME, B.DELETED, B.USE_IN_ARCH)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DELETED = B.DELETED,
  A.USE_IN_ARCH = B.USE_IN_ARCH;

MERGE INTO BARS.ACCOUNTS_FIELD A USING
 (SELECT
  'ND_REST' as TAG,
  '��������� �� �������� �������� ���� ����������������' as NAME,
  NULL as DELETED,
  1 as USE_IN_ARCH
  FROM DUAL) B
ON (A.TAG = B.TAG)
WHEN NOT MATCHED THEN 
INSERT (
  TAG, NAME, DELETED, USE_IN_ARCH)
VALUES (
  B.TAG, B.NAME, B.DELETED, B.USE_IN_ARCH)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DELETED = B.DELETED,
  A.USE_IN_ARCH = B.USE_IN_ARCH;
end;
/
COMMIT;
