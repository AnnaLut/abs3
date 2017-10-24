CREATE OR REPLACE FORCE VIEW BARS.V_XOZOB22_NLS AS
 SELECT x.deb,   x.krd,   a.branch,   a.ob22,   a.kv||'/'|| a.nls NLS , a.nms,   a.ostc/100 OST,   a.acc
 FROM (SELECT *  FROM xoz_ob22 WHERE deb= pul.get ('PROD')) x,         accounts a
 WHERE x.krd = a.nbs || a.ob22 AND a.dazs IS NULL 
  AND a.kv = CASE   WHEN x.krd  like '6%' or x.krd  like '7%'  THEN 980    ELSE        to_number (pul.get ('XOZ_KV'))      END ;
/
GRANT SELECT ON BARS.V_XOZOB22_NLS TO BARS_ACCESS_DEFROLE;
/