begin
MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id,
  47 as DPT_TYPE,
  NULL as DPT_VIDD,
  980 as KV,
  0.5 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id,
  48 as DPT_TYPE,
  NULL as DPT_VIDD,
  980 as KV,
  0.5 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id,
  49 as DPT_TYPE,
  NULL as DPT_VIDD,
  980 as KV,
  0.5 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id, 
  50 as DPT_TYPE,
  NULL as DPT_VIDD,
  980 as KV,
  0.5 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id, 
  47 as DPT_TYPE,
  NULL as DPT_VIDD,
  840 as KV,
  0.25 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id, 
  48 as DPT_TYPE,
  NULL as DPT_VIDD,
  840 as KV,
  0.25 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id, 
  49 as DPT_TYPE,
  NULL as DPT_VIDD,
  840 as KV,
  0.25 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id, 
  50 as DPT_TYPE,
  NULL as DPT_VIDD,
  840 as KV,
  0.25 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id, 
  47 as DPT_TYPE,
  NULL as DPT_VIDD,
  978 as KV,
  0.25 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id, 
  48 as DPT_TYPE,
  NULL as DPT_VIDD,
  978 as KV,
  0.25 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;

MERGE INTO BARS.DPT_BONUS_SETTINGS A USING
 (SELECT
  3 as bonus_id, 
  50 as DPT_TYPE,
  NULL as DPT_VIDD,
  978 as KV,
  0.25 as VAL
  FROM DUAL) B
ON (a.bonus_id = b.bonus_id and A.DPT_TYPE = B.DPT_TYPE and nvl(a.DPT_VIDD,0) = nvl(b.DPT_VIDD,0)  and A.KV = B.KV)
WHEN NOT MATCHED THEN 
INSERT (
  DPT_TYPE, DPT_VIDD, KV, VAL, bonus_id)
VALUES (
  B.DPT_TYPE, B.DPT_VIDD, B.KV, B.VAL, b.bonus_id)
WHEN MATCHED THEN
UPDATE SET 
  A.VAL = B.VAL;
exception when others then null;
end;
/
COMMIT;
/
