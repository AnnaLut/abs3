MERGE INTO BARS.NBS_TIPS A USING
 (SELECT
  '2924' as NBS,
  'AT7' as TIP,
  NULL as OPT,
  NULL as OB22
  FROM DUAL) B
ON (A.NBS = B.NBS and A.TIP = B.TIP )
WHEN NOT MATCHED THEN 
INSERT (
  NBS, TIP, OPT, OB22)
VALUES (
  B.NBS, B.TIP, B.OPT, B.OB22);
/
commit; 
MERGE INTO BARS.NBS_TIPS A USING
 (SELECT
  '2924' as NBS,
  'AT8' as TIP,
  NULL as OPT,
  NULL as OB22
  FROM DUAL) B
ON (A.NBS = B.NBS and A.TIP = B.TIP )
WHEN NOT MATCHED THEN 
INSERT (
  NBS, TIP, OPT, OB22)
VALUES (
  B.NBS, B.TIP, B.OPT, B.OB22);
/
commit;