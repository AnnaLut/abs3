Begin
MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1811' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1811' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1811' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1812' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1812' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1812' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1819' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1819' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '1819' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2800' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2800' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2800' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2801' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2801' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2801' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2802' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2802' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2802' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2805' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2805' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2805' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2806' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2806' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2806' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2809' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2809' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '2809' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3548' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3548' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3548' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3570' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3570' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3570' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3578' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3578' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3578' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3541' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3541' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3541' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3710' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3710' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3710' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3040' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3040' as NBS,
  383 as SPID,
  '1' as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3040' as NBS,
  384 as SPID,
  '0' as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3041' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3041' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3041' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3042' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3042' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3042' as NBS,
  354 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3044' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3044' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3044' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3049' as NBS,
  382 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3049' as NBS,
  383 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;

MERGE INTO BARS.PS_SPARAM A USING
 (SELECT
  '3049' as NBS,
  384 as SPID,
  NULL as OPT,
  NULL as SQLVAL
  FROM DUAL) B
ON (A.NBS = B.NBS and A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  NBS, SPID, OPT, SQLVAL)
VALUES (
  B.NBS, B.SPID, B.OPT, B.SQLVAL)
WHEN MATCHED THEN
UPDATE SET 
  A.OPT = B.OPT,
  A.SQLVAL = B.SQLVAL;
end;
/
COMMIT;
