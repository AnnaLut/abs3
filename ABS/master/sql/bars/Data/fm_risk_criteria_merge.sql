MERGE INTO FM_RISK_CRITERIA A USING
 (SELECT
  43 as ID,
  'регулярне одержання фінансової допомоги, у тому числі від нерезидентів, чи надання фінансової допомоги нерезидентам' as NAME,
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
  'проведення клієнтом фінансових операцій, що підлягали внутрішньому фінансовому моніторингу' as NAME,
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
  'отримання клієнтом послуг зі здійснення міжнародних переказів на суму, що дорівнює чи перевищує еквівалент 150 000 гривень' as NAME,
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
  'клієнт-юридична особа, кінцеві бенефіціарні власники (контролери) або особи, що мають право розпоряджатися рахунками та майном якої, включені до переліку осіб пов’язаних з провадженням терористичної діяльності, або щодо яких застосовано міжнародні санкції, або яких включено до санкційних списків' as NAME,
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
  'переказ клієнтом коштів за кордон за відсутності зовнішньоекономічного договору (контракту)' as NAME,
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
  'зарахування коштів в іноземній валюті на суму, що дорівнює чи перевищує еквівалент 150 000 грн. від нерезидентів на рахунки фізичних осіб, зокрема у вигляді заробітної плати, переказу коштів, поповнення карткового рахунку' as NAME,
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
  'взаємозалік вимог за експортно-імпортними операціями' as NAME,
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
  'здійснення клієнтом фінансових операцій щодо купівлі-продажу цінних паперів' as NAME,
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
  'передавання особою доручення про здійснення фінансової операції через представника (посередника), якщо представник (посередник) виконує доручення особи без встановлення прямого (особистого) контакту з Банком' as NAME,
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
  'істотне збільшення залишку на рахунку клієнта, який регулярно знімається готівкою через касу власне клієнтом або його представником' as NAME,
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
  'регулярне одержання/надання/повернення фінансової допомоги, позик, кредитів та інших запозичень' as NAME,
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
  'здійснення операції купівлі/продажу або відступлення права грошової вимоги' as NAME,
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
  'неприйнятно високий ризик' as NAME,
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
  'клієнт, щодо якого надходили застереження/повідомлення про наявність ризиків від ДСФМ, OFAC, ЄС' as NAME,
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
  'ненадання клієнтом або відмови від надання документів/ інформації, що дають змогу встановити реальних кінцевих бенефіціарних власників (контролерів)' as NAME,
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
  'встановлення факту подання клієнтом під час здійснення ідентифікації та/або верифікації клієнта (поглибленої перевірки клієнта) недостовірної інформації або подання інформації з метою введення Банк в оману' as NAME,
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
  'клієнт на запит Банку щодо обов’язкового уточнення інформації про клієнта не подав відповідну інформацію/документи' as NAME,
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
  'проведення клієнтом фінансових операцій, які мають ознаки ризикових' as NAME,
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
