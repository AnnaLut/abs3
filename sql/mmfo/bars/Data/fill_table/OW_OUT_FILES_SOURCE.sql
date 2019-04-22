prompt Importing table OW_OUT_FILES_SOURCE...

MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  0 as ID,
  'Way4. Формування файла списань IIC_Documents*.xml для Way4' as FUNCNAME,
  'bars_ow.web_out_files_debet' as PROC,
  0 as TYPE
  FROM DUAL) B
ON (A.id = B.id)
WHEN NOT MATCHED THEN 
INSERT (
  ID, FUNCNAME, PROC, TYPE)
VALUES (
  B.ID, B.FUNCNAME, B.PROC, B.TYPE)
WHEN MATCHED THEN
UPDATE SET 
  A.FUNCNAME = B.FUNCNAME,
  A.PROC = B.PROC,
  A.TYPE = B.TYPE;

MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  1 as ID,
  'Way4. Формування файла IIC_Documents*.xml по док. погашення КД з 2625' as FUNCNAME,
  'bars_ow.web_out_files_debet' as PROC,
  0 as TYPE
  FROM DUAL) B
ON (A.id = B.id)
WHEN NOT MATCHED THEN 
INSERT (
  ID, FUNCNAME, PROC, TYPE)
VALUES (
  B.ID, B.FUNCNAME, B.PROC, B.TYPE)
WHEN MATCHED THEN
UPDATE SET 
  A.FUNCNAME = B.FUNCNAME,
  A.PROC = B.PROC,
  A.TYPE = B.TYPE;
  
MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  2 as ID,
  'Way4. Формування файла IIC_Documents*.xml по док. регул.плат. (списання)' as FUNCNAME,
  'bars_ow.web_out_files_debet' as PROC,
  2 as TYPE
  FROM DUAL) B
ON (A.id = B.id)
WHEN NOT MATCHED THEN 
INSERT (
  ID, FUNCNAME, PROC, TYPE)
VALUES (
  B.ID, B.FUNCNAME, B.PROC, B.TYPE)
WHEN MATCHED THEN
UPDATE SET 
  A.FUNCNAME = B.FUNCNAME,
  A.PROC = B.PROC,
  A.TYPE = B.TYPE;


MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  10 as ID,
  'Way4. Формування файла поповнень IIC_Documents*.xml для Way4' as FUNCNAME,
  'bars_ow.web_out_files_credit' as PROC,
  10 as TYPE
  FROM DUAL) B
ON (A.id = B.id)
WHEN NOT MATCHED THEN 
INSERT (
  ID, FUNCNAME, PROC, TYPE)
VALUES (
  B.ID, B.FUNCNAME, B.PROC, B.TYPE)
WHEN MATCHED THEN
UPDATE SET 
  A.FUNCNAME = B.FUNCNAME,
  A.PROC = B.PROC,
  A.TYPE = B.TYPE;

MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  12 as ID,
  'Way4. Формування файла IIC_Documents*.xml по док. регул.плат. (зарахування)' as FUNCNAME,
  'bars_ow.web_out_files_credit' as PROC,
  12 as TYPE
  FROM DUAL) B
ON (A.id = B.id)
WHEN NOT MATCHED THEN 
INSERT (
  ID, FUNCNAME, PROC, TYPE)
VALUES (
  B.ID, B.FUNCNAME, B.PROC, B.TYPE)
WHEN MATCHED THEN
UPDATE SET 
  A.FUNCNAME = B.FUNCNAME,
  A.PROC = B.PROC,
  A.TYPE = B.TYPE;

commit;

prompt Done.
