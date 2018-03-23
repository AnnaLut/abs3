MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  1001 as ID,
  'переказ є в АБС – відсутній в ЄВ' as NAME,
  NULL as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  1002 as ID,
  'переказ є в ЄВ– відсутній в АБС' as NAME,
  NULL as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  1 as ID,
  'переміщення касира' as NAME,
  '1' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  2 as ID,
  'некорректна сумма ЄВ-АБС' as NAME,
  '2' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  4 as ID,
  'розбіжність у даті ЄВ-АБС' as NAME,
  '4' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  8 as ID,
  'відсутній рахунок ТВБВ (некорректний)' as NAME,
  '8' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  3 as ID,
  'переміщення касира + некорректна сумма ЄВ-АБС' as NAME,
  '1+2' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  7 as ID,
  'переміщення касира + некорректна сумма ЄВ-АБС + розбіжність у даті ЄВ-АБС' as NAME,
  '1+2+4' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  15 as ID,
  'переміщення касира + некорректна сумма ЄВ-АБС + розбіжність у даті ЄВ-АБС + відсутній рахунок ТВБВ (некорректний)' as NAME,
  '1+2+4+8' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  6 as ID,
  'некорректна сумма ЄВ-АБС + розбіжність у даті ЄВ-АБС' as NAME,
  '2+4' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  14 as ID,
  'некорректна сумма ЄВ-АБС + розбіжність у даті ЄВ-АБС + відсутній рахунок ТВБВ (некорректний)' as NAME,
  '2+4+8' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  5 as ID,
  'переміщення касира + розбіжність у даті ЄВ-АБС' as NAME,
  '1+4' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  9 as ID,
  'переміщення касира + відсутній рахунок ТВБВ (некорректний)' as NAME,
  '1+8' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  10 as ID,
  'некорректна сумма ЄВ-АБС + відсутній рахунок ТВБВ (некорректний)' as NAME,
  '2+8' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  11 as ID,
  'переміщення касира + некорректна сумма ЄВ-АБС + відсутній рахунок ТВБВ (некорректний)' as NAME,
  '1+2+8' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  12 as ID,
  'розбіжність у даті ЄВ-АБС + відсутній рахунок ТВБВ (некорректний)' as NAME,
  '4+8' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  13 as ID,
  'переміщення касира + розбіжність у даті ЄВ-АБС + відсутній рахунок ТВБВ (некорректний)' as NAME,
  '1+4+8' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  16 as ID,
  'некорректна комісія ЄВ-АБС' as NAME,
  '16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  17 as ID,
  'переміщення касира + некорректна комісія ЄВ-АБС' as NAME,
  '1+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  18 as ID,
  'некорректна сумма ЄВ-АБС + некорректна комісія ЄВ-АБС' as NAME,
  '2+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  19 as ID,
  'переміщення касира + некорректна сумма ЄВ-АБС + некорректна комісія ЄВ-АБС' as NAME,
  '1+2+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  20 as ID,
  'розбіжність у даті ЄВ-АБС + некорректна комісія ЄВ-АБС' as NAME,
  '4+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  21 as ID,
  'переміщення касира + розбіжність у даті ЄВ-АБС + некорректна комісія ЄВ-АБС' as NAME,
  '1+4+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  22 as ID,
  'некорректна сумма ЄВ-АБС + розбіжність у даті ЄВ-АБС + некорректна комісія ЄВ-АБС' as NAME,
  '2+4+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  23 as ID,
  'переміщення касира + некорректна сумма ЄВ-АБС + розбіжність у даті ЄВ-АБС + некорректна комісія ЄВ-АБС' as NAME,
  '1+2+4+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  24 as ID,
  'відсутній рахунок ТВБВ (некорректний) + некорректна комісія ЄВ-АБС' as NAME,
  '8+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  25 as ID,
  'переміщення касира + відсутній рахунок ТВБВ (некорректний) + некорректна комісія ЄВ-АБС' as NAME,
  '1+8+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  27 as ID,
  'переміщення касира + некорректна сумма ЄВ-АБС + відсутній рахунок ТВБВ (некорректний) + некорректна комісія ЄВ-АБС' as NAME,
  '1+2+8+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  28 as ID,
  'розбіжність у даті ЄВ-АБС + відсутній рахунок ТВБВ (некорректний) + некорректна комісія ЄВ-АБС' as NAME,
  '4+8+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  29 as ID,
  'переміщення касира + розбіжність у даті ЄВ-АБС + відсутній рахунок ТВБВ (некорректний) + некорректна комісія ЄВ-АБС' as NAME,
  '1+4+8+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  26 as ID,
  'некорректна сумма ЄВ-АБС + відсутній рахунок ТВБВ (некорректний) + некорректна комісія ЄВ-АБС' as NAME,
  '2+8+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  30 as ID,
  'некорректна сумма ЄВ-АБС + розбіжність у даті ЄВ-АБС + відсутній рахунок ТВБВ (некорректний) + некорректна комісія ЄВ-АБС' as NAME,
  '2+4+8+16' as DESCRIPTION,
  NULL as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

MERGE INTO BARS.SW_CAUSE_ERR A USING
 (SELECT
  31 as ID,
  'переміщення касира + некорректна сумма ЄВ-АБС + розбіжність у даті ЄВ-АБС + відсутній рахунок ТВБВ (некорректний) + некорректна комісія ЄВ-АБС' as NAME,
  '1+2+4+8+16' as DESCRIPTION,
  'PS1' as TT
  FROM DUAL) B
ON (A.ID = B.ID)
WHEN NOT MATCHED THEN 
INSERT (
  ID, NAME, DESCRIPTION, TT)
VALUES (
  B.ID, B.NAME, B.DESCRIPTION, B.TT)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.DESCRIPTION = B.DESCRIPTION,
  A.TT = B.TT;

  COMMIT;
