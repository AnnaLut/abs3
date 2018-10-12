prompt Importing table OW_OUT_FILES_SOURCE...

MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  5 as ID,
  'Формування файлу заміни рахунків по прогнозній таблиці для фіз. осіб' as FUNCNAME,
  'ow_transform_acc.transfer_out_files' as PROC,
  3 as TYPE
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
  6 as ID,
  'Формування файлу заміни рахунків по переліку рахунків для фіз. осіб' as FUNCNAME,
  'ow_transform_acc.transfer_w4_out_files' as PROC,
  4 as TYPE
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
  7 as ID,
  'Формування файлу заміни рахунків по прогнозній таблиці для юр. осіб' as FUNCNAME,
  'ow_transform_acc.transfer_out_files_le' as PROC,
  5 as TYPE
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
  8 as ID,
  'Формування файлу заміни рахунків по переліку рахунків для юр. осіб' as FUNCNAME,
  'ow_transform_acc.transfer_w4_out_files_le' as PROC,
  6 as TYPE
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
