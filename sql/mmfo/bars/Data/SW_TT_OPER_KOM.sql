MERGE INTO BARS.SW_TT_OPER_KOM A USING
 (SELECT
  '97' as KOD_NBU,
  'CN1' as TT,
  'C57' as TTK,
  'CNC' as TTKM
  FROM DUAL) B
ON (A.KOD_NBU = B.KOD_NBU and A.TT = B.TT)
WHEN NOT MATCHED THEN 
INSERT (
  KOD_NBU, TT, TTK, TTKM)
VALUES (
  B.KOD_NBU, B.TT, B.TTK, B.TTKM)
WHEN MATCHED THEN
UPDATE SET 
  A.TTK = B.TTK,
  A.TTKM = B.TTKM;

MERGE INTO BARS.SW_TT_OPER_KOM A USING
 (SELECT
  '03' as KOD_NBU,
  'CN1' as TT,
  'C57' as TTK,
  'CNC' as TTKM
  FROM DUAL) B
ON (A.KOD_NBU = B.KOD_NBU and A.TT = B.TT)
WHEN NOT MATCHED THEN 
INSERT (
  KOD_NBU, TT, TTK, TTKM)
VALUES (
  B.KOD_NBU, B.TT, B.TTK, B.TTKM)
WHEN MATCHED THEN
UPDATE SET 
  A.TTK = B.TTK,
  A.TTKM = B.TTKM;

MERGE INTO BARS.SW_TT_OPER_KOM A USING
 (SELECT
  '22' as KOD_NBU,
  'CN1' as TT,
  'CND' as TTK,
  NULL as TTKM
  FROM DUAL) B
ON (A.KOD_NBU = B.KOD_NBU and A.TT = B.TT)
WHEN NOT MATCHED THEN 
INSERT (
  KOD_NBU, TT, TTK, TTKM)
VALUES (
  B.KOD_NBU, B.TT, B.TTK, B.TTKM)
WHEN MATCHED THEN
UPDATE SET 
  A.TTK = B.TTK,
  A.TTKM = B.TTKM;

MERGE INTO BARS.SW_TT_OPER_KOM A USING
 (SELECT
  '25' as KOD_NBU,
  'CN1' as TT,
  'CND' as TTK,
  NULL as TTKM
  FROM DUAL) B
ON (A.KOD_NBU = B.KOD_NBU and A.TT = B.TT)
WHEN NOT MATCHED THEN 
INSERT (
  KOD_NBU, TT, TTK, TTKM)
VALUES (
  B.KOD_NBU, B.TT, B.TTK, B.TTKM)
WHEN MATCHED THEN
UPDATE SET 
  A.TTK = B.TTK,
  A.TTKM = B.TTKM;

MERGE INTO BARS.SW_TT_OPER_KOM A USING
 (SELECT
  '26' as KOD_NBU,
  'CN1' as TT,
  'CND' as TTK,
  NULL as TTKM
  FROM DUAL) B
ON (A.KOD_NBU = B.KOD_NBU and A.TT = B.TT)
WHEN NOT MATCHED THEN 
INSERT (
  KOD_NBU, TT, TTK, TTKM)
VALUES (
  B.KOD_NBU, B.TT, B.TTK, B.TTKM)
WHEN MATCHED THEN
UPDATE SET 
  A.TTK = B.TTK,
  A.TTKM = B.TTKM;

MERGE INTO BARS.SW_TT_OPER_KOM A USING
 (SELECT
  '13' as KOD_NBU,
  'CN1' as TT,
  'CND' as TTK,
  NULL as TTKM
  FROM DUAL) B
ON (A.KOD_NBU = B.KOD_NBU and A.TT = B.TT)
WHEN NOT MATCHED THEN 
INSERT (
  KOD_NBU, TT, TTK, TTKM)
VALUES (
  B.KOD_NBU, B.TT, B.TTK, B.TTKM)
WHEN MATCHED THEN
UPDATE SET 
  A.TTK = B.TTK,
  A.TTKM = B.TTKM;

MERGE INTO BARS.SW_TT_OPER_KOM A USING
 (SELECT
  '04' as KOD_NBU,
  'CN1' as TT,
  'CND' as TTK,
  NULL as TTKM
  FROM DUAL) B
ON (A.KOD_NBU = B.KOD_NBU and A.TT = B.TT)
WHEN NOT MATCHED THEN 
INSERT (
  KOD_NBU, TT, TTK, TTKM)
VALUES (
  B.KOD_NBU, B.TT, B.TTK, B.TTKM)
WHEN MATCHED THEN
UPDATE SET 
  A.TTK = B.TTK,
  A.TTKM = B.TTKM;

COMMIT;