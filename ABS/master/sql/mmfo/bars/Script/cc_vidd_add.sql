SET DEFINE OFF; 

MERGE INTO BARS.CC_VIDD A USING
 (SELECT
  1614 as VIDD,
  1 as CUSTTYPE,
  2 as TIPD,
  'Залучення 1614 - (депозити) міжнародних та інвестиційних банків' as NAME,
  NULL as SPS
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  VIDD, CUSTTYPE, TIPD, NAME, SPS)
VALUES (
  B.VIDD, B.CUSTTYPE, B.TIPD, B.NAME, B.SPS)
WHEN MATCHED THEN
UPDATE SET 
  A.CUSTTYPE = B.CUSTTYPE,
  A.TIPD = B.TIPD,
  A.NAME = B.NAME,
  A.SPS = B.SPS;

MERGE INTO BARS.CC_VIDD A USING
 (SELECT
  1625 as VIDD,
  1 as CUSTTYPE,
  2 as TIPD,
  'Залучення 1625 - Корот. кред що отриманi вiд мiжнар. та iнвест. банкiв' as NAME,
  NULL as SPS
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  VIDD, CUSTTYPE, TIPD, NAME, SPS)
VALUES (
  B.VIDD, B.CUSTTYPE, B.TIPD, B.NAME, B.SPS)
WHEN MATCHED THEN
UPDATE SET 
  A.CUSTTYPE = B.CUSTTYPE,
  A.TIPD = B.TIPD,
  A.NAME = B.NAME,
  A.SPS = B.SPS;

MERGE INTO BARS.CC_VIDD A USING
 (SELECT
  1626 as VIDD,
  1 as CUSTTYPE,
  2 as TIPD,
  'Залучення 1626 - Довг. кредити що отримані від міжн. та інвест. банків' as NAME,
  NULL as SPS
  FROM DUAL) B
ON (A.VIDD = B.VIDD)
WHEN NOT MATCHED THEN 
INSERT (
  VIDD, CUSTTYPE, TIPD, NAME, SPS)
VALUES (
  B.VIDD, B.CUSTTYPE, B.TIPD, B.NAME, B.SPS)
WHEN MATCHED THEN
UPDATE SET 
  A.CUSTTYPE = B.CUSTTYPE,
  A.TIPD = B.TIPD,
  A.NAME = B.NAME,
  A.SPS = B.SPS;
update cc_vidd set tipd = 2 where vidd like '16%' and tipd = 1;
commit;
/
