DELETE FROM POST_BANK_ENG;

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  1 as POST_ID,
  'Економіст 1 категорії' as POST_ENG_DESC,
  '1st Category Economist ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  2 as POST_ID,
  'Економіст ' as POST_ENG_DESC,
  'Economist ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  3 as POST_ID,
  'Провідний економіст' as POST_ENG_DESC,
  'Leading Economist' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  4 as POST_ID,
  'Керуючий ТВБВ/Пров. економ. - т.в.о. кер.ТВБВ/В.О. Кер.ТВБВ - Пров. економ./Контр.-касир -т.в.о. кер.ТВБВ/Старш. Контр.-касир -т.в.о. кер.ТВБВ/В.О.Кер.-Зав.сектора/
Зав.сектора кас. операц.-в.о. кер.ТВБВ/В.О.Кер.ТВБВ - зав. сектора кас. Операц./В.О.Кер.ТВБВ/Заст. Кер.-нач. відділу продажів ТВБВ/Заст. Кер.ТВБВ/Зав. ТВБВ/Кер. ТВБВ' as POST_ENG_DESC,
  'Acting Head of Branch ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  5 as POST_ID,
  'Головний економіст' as POST_ENG_DESC,
  'Senior Economist' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  6 as POST_ID,
  'Контролер - касир' as POST_ENG_DESC,
  'Head Cashier' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  7 as POST_ID,
  'Старший контролер - касир' as POST_ENG_DESC,
  'Senior Head Cashier ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  8 as POST_ID,
  'Завідувач сектора касових операцій' as POST_ENG_DESC,
  'Head of Cash Payments Sector' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  9 as POST_ID,
  'Завідувач сектора' as POST_ENG_DESC,
  'Head of Sector' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  10 as POST_ID,
  'Начальник відділу' as POST_ENG_DESC,
  'Head of Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  11 as POST_ID,
  'Начальник відділу касових операцій' as POST_ENG_DESC,
  'Head of Cash Payments Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  12 as POST_ID,
  'Заступник начальника відділу' as POST_ENG_DESC,
  'Deputy Head of Division ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  13 as POST_ID,
  'Завідувач сектора роздрібного біснесу' as POST_ENG_DESC,
  'Head of Retail Business Sector ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  14 as POST_ID,
  'Начальник відділу роздрібного бізнесу' as POST_ENG_DESC,
  'Head of Retail Business Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  15 as POST_ID,
  'Начальник відділу клієнтів роздрібного бізнесу' as POST_ENG_DESC,
  'Head of Ratel Business Customers Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  16 as POST_ID,
  'Заступник начальника відділу клієнтів роздрібного бізнесу' as POST_ENG_DESC,
  'Deputy Head of the Retail Customers Division' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  17 as POST_ID,
  'Завідувач ТВБВ/Керуючий ТВБВ' as POST_ENG_DESC,
  'Head of Branch ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  19 as POST_ID,
  'Заступник керуючого ТВБВ/Заступник керуючого-начальник відділу продажів ТВБВ' as POST_ENG_DESC,
  'Deputy  Head of Branch ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  20 as POST_ID,
  'Начальник Головного управління' as POST_ENG_DESC,
  'Head of the Main Directorate' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  21 as POST_ID,
  'Заступник начальника Головного управління' as POST_ENG_DESC,
  'Deputy Head of the Main Directorate' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  22 as POST_ID,
  'Заступник начальника Головного управління з роздрібного бізнесу' as POST_ENG_DESC,
  'Deputy Head of Retail Business   of the  Main Directorate' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  23 as POST_ID,
  'Заступник начальника Головного управління з мікро-,малого та середнього бізнесу' as POST_ENG_DESC,
  'Deputy Head of MSMB  of the  Main Directorate' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

MERGE INTO BARS.POST_BANK_ENG A USING
 (SELECT
  24 as POST_ID,
  'Завідувач сектора мікро, малого та середнього бізнесу' as POST_ENG_DESC,
  'Head of the MSMB Sector ' as POST_ENG
  FROM DUAL) B
ON (A.POST_ID = B.POST_ID)
WHEN NOT MATCHED THEN 
INSERT (
  POST_ID, POST_ENG_DESC, POST_ENG)
VALUES (
  B.POST_ID, B.POST_ENG_DESC, B.POST_ENG);

COMMIT;
