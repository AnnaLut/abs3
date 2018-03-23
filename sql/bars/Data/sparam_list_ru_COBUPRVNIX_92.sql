Begin
MERGE INTO BARS.SPARAM_LIST A USING
 (SELECT
  388 as SPID,
  'VALUE' as NAME,
  '�����. �� �������� �������� ���� ����������������' as SEMANTIC,
  'ACCOUNTSW' as TABNAME,
  'N' as TYPE,
  'ND_REST' as NSINAME,
  1 as INUSE,
  NULL as PKNAME,
  NULL as DELONNULL,
  NULL as NSISQLWHERE,
  NULL as SQLCONDITION,
  'ND_REST' as TAG,
  NULL as TABCOLUMN_CHECK,
  'OTHERS' as CODE,
  NULL as HIST,
  NULL as MAX_CHAR
  FROM DUAL) B
ON (A.SPID = B.SPID)
WHEN NOT MATCHED THEN 
INSERT (
  SPID, NAME, SEMANTIC, TABNAME, TYPE, 
  NSINAME, INUSE, PKNAME, DELONNULL, NSISQLWHERE, 
  SQLCONDITION, TAG, TABCOLUMN_CHECK, CODE, HIST, 
  MAX_CHAR)
VALUES (
  B.SPID, B.NAME, B.SEMANTIC, B.TABNAME, B.TYPE, 
  B.NSINAME, B.INUSE, B.PKNAME, B.DELONNULL, B.NSISQLWHERE, 
  B.SQLCONDITION, B.TAG, B.TABCOLUMN_CHECK, B.CODE, B.HIST, 
  B.MAX_CHAR)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.SEMANTIC = B.SEMANTIC,
  A.TABNAME = B.TABNAME,
  A.TYPE = B.TYPE,
  A.NSINAME = B.NSINAME,
  A.INUSE = B.INUSE,
  A.PKNAME = B.PKNAME,
  A.DELONNULL = B.DELONNULL,
  A.NSISQLWHERE = B.NSISQLWHERE,
  A.SQLCONDITION = B.SQLCONDITION,
  A.TAG = B.TAG,
  A.TABCOLUMN_CHECK = B.TABCOLUMN_CHECK,
  A.CODE = B.CODE,
  A.HIST = B.HIST,
  A.MAX_CHAR = B.MAX_CHAR;
   
end;
/
COMMIT;
