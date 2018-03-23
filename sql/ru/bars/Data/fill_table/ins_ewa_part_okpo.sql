MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '1942' as OKPO,
  nvl((select max(nmk) from customer where okpo = '00001942'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '1943' as OKPO,
  nvl((select max(nmk) from customer where okpo = '00001943'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '2430' as OKPO,
  nvl((select max(nmk) from customer where okpo = '00002430'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '2431' as OKPO,
  nvl((select max(nmk) from customer where okpo = '00002431'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '20344871' as OKPO,
  nvl((select max(nmk) from customer where okpo = '20344871'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '20474912' as OKPO,
  nvl((select max(nmk) from customer where okpo = '20474912'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '20842474' as OKPO,
  nvl((select max(nmk) from customer where okpo = '20842474'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '21870998' as OKPO,
  nvl((select max(nmk) from customer where okpo = '21870998'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '24175269' as OKPO,
  nvl((select max(nmk) from customer where okpo = '24175269'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '24745673' as OKPO,
  nvl((select max(nmk) from customer where okpo = '24745673'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '30115243' as OKPO,
  nvl((select max(nmk) from customer where okpo = '30115243'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '31650052' as OKPO,
  nvl((select max(nmk) from customer where okpo = '31650052'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '32109907' as OKPO,
  nvl((select max(nmk) from customer where okpo = '32109907'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '33908322' as OKPO,
  nvl((select max(nmk) from customer where okpo = '33908322'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '34478248' as OKPO,
  nvl((select max(nmk) from customer where okpo = '34478248'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
MERGE INTO INS_EWA_PART_OKPO A USING
 (SELECT
  '34538696' as OKPO,
  nvl((select max(nmk) from customer where okpo = '34538696'),'Не знайдено') as NAME
  FROM DUAL) B
ON (A.OKPO = B.OKPO)
WHEN NOT MATCHED THEN 
INSERT (
  OKPO, NAME)
VALUES (
  B.OKPO, B.NAME)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME;
/
COMMIT;
/