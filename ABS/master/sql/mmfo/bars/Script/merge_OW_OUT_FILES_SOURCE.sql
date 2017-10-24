MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  0 as ID,
  'Way4. ���������� ����� ���������/������� IIC_Documents*.xml ��� Way4' as FUNCNAME,
  'bars_ow.web_out_files' as PROC,
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
/
MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  1 as ID,
  'Way4. ���������� ����� IIC_Documents*.xml �� ���. ��������� �� � 2625' as FUNCNAME,
  'bars_ow.web_out_files' as PROC,
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
/
MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  2 as ID,
  'Way4. ���������� ����� IIC_Documents*.xml �� ���. �����.����.' as FUNCNAME,
  'bars_ow.web_out_files' as PROC,
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
/
MERGE INTO BARS.OW_OUT_FILES_SOURCE A USING
 (SELECT
  3 as ID,
  'Way4. ���������� ����� ���������� ������� OIC*LOCPAY*.xml' as FUNCNAME,
  'bars_ow.web_out_files' as PROC,
  1 as TYPE
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
/
COMMIT;
/