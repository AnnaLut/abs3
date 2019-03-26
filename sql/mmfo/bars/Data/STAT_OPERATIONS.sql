prompt ... 

SET DEFINE OFF;
MERGE INTO BARS.STAT_OPERATIONS A USING
 (SELECT
  1 as ID,
  '������ �����' as NAME,
  1 as BEGIN_STATUS,
  2 as END_STATUS,
  'H' as NEED_SIGN
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, BEGIN_STATUS, END_STATUS, NEED_SIGN)
VALUES (
  B.ID, B.NAME, B.BEGIN_STATUS, B.END_STATUS, B.NEED_SIGN)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.BEGIN_STATUS = B.BEGIN_STATUS,
  A.END_STATUS = B.END_STATUS,
  A.NEED_SIGN = B.NEED_SIGN;
MERGE INTO BARS.STAT_OPERATIONS A USING
 (SELECT
  2 as ID,
  '������ �����' as NAME,
  2 as BEGIN_STATUS,
  7 as END_STATUS,
  'N' as NEED_SIGN
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, BEGIN_STATUS, END_STATUS, NEED_SIGN)
VALUES (
  B.ID, B.NAME, B.BEGIN_STATUS, B.END_STATUS, B.NEED_SIGN)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.BEGIN_STATUS = B.BEGIN_STATUS,
  A.END_STATUS = B.END_STATUS,
  A.NEED_SIGN = B.NEED_SIGN;
MERGE INTO BARS.STAT_OPERATIONS A USING
 (SELECT
  3 as ID,
  '³�������' as NAME,
  7 as BEGIN_STATUS,
  8 as END_STATUS,
  'Y' as NEED_SIGN
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, BEGIN_STATUS, END_STATUS, NEED_SIGN)
VALUES (
  B.ID, B.NAME, B.BEGIN_STATUS, B.END_STATUS, B.NEED_SIGN)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.BEGIN_STATUS = B.BEGIN_STATUS,
  A.END_STATUS = B.END_STATUS,
  A.NEED_SIGN = B.NEED_SIGN;
MERGE INTO BARS.STAT_OPERATIONS A USING
 (SELECT
  0 as ID,
  '������������' as NAME,
  0 as BEGIN_STATUS,
  1 as END_STATUS,
  'N' as NEED_SIGN
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, BEGIN_STATUS, END_STATUS, NEED_SIGN)
VALUES (
  B.ID, B.NAME, B.BEGIN_STATUS, B.END_STATUS, B.NEED_SIGN)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.BEGIN_STATUS = B.BEGIN_STATUS,
  A.END_STATUS = B.END_STATUS,
  A.NEED_SIGN = B.NEED_SIGN;
COMMIT;