SET DEFINE OFF; 

MERGE INTO BARS.CC_VIDD A USING
 (SELECT
  1614 as VIDD,
  1 as CUSTTYPE,
  2 as TIPD,
  '��������� 1614 - (��������) ���������� �� ������������� �����' as NAME,
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
  '��������� 1625 - �����. ���� �� �������i �i� �i����. �� i�����. ����i�' as NAME,
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
  '��������� 1626 - ����. ������� �� ������� �� ���. �� ������. �����' as NAME,
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
