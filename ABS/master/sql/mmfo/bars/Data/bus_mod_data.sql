begin
MERGE INTO BARS.BUS_MOD A USING
 (SELECT
  1 as BUS_MOD_ID,
  'збирання грошових коштів за міжбанківськими активами' as BUS_MOD_NAME
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
  'справедлива вартість із відображенням переоцінки у складі прибутку або збитку/FVTPL для міжбанківських похідних фінансових інструментів' as BUS_MOD_NAME
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
  'збирання грошових коштів за облігаціями внутрішньої державної позики (надалі – «ОВДП») та їх продажу' as BUS_MOD_NAME
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
  'справедлива вартість із відображенням переоцінки у складі прибутку або збитку/FVTPL для боргових цінних паперів із вбудованими похідними фінансовими інструментами' as BUS_MOD_NAME
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
  'збирання грошових коштів за корпоративними та іншими облігаціями та для їх продажу' as BUS_MOD_NAME
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
  'збирання грошових коштів за корпоративними кредитами, виданими державним монополіям (включно із сектором енергетики)' as BUS_MOD_NAME
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
  'призначена для збирання грошових коштів за корпоративними кредитами (інвестиційними проектами), виданими підприємствам секторів будівництва та інфраструктури' as BUS_MOD_NAME
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
  'збирання грошових коштів за корпоративними кредитами, виданими підприємствам секторів сільського господарства, виробництва та переробки продуктів харчування та напоїв' as BUS_MOD_NAME
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
  'збирання грошових коштів за кредитами, виданими середнім підприємствам' as BUS_MOD_NAME
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
  'для збирання грошових коштів за кредитами, виданими малим підприємствам' as BUS_MOD_NAME
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
  'збирання грошових потоків за кредитами, виданими мікро-бізнесу' as BUS_MOD_NAME
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
  'збирання грошових коштів за кредитами, виданими фізичним особам' as BUS_MOD_NAME
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
  'збирання кредитів за кредитними картками (включно з овердрафтами)' as BUS_MOD_NAME
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
  'збирання грошових коштів за іншими корпоративними кредитами' as BUS_MOD_NAME
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
  'збирання грошових коштів за фінансовою дебіторською заборгованістю' as BUS_MOD_NAME
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
