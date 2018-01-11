

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZOB22_NLS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZOB22_NLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZOB22_NLS ("DEB", "KRD", "BRANCH", "OB22", "NLS", "NMS", "OST", "ACC") AS 
  SELECT x.deb,   x.krd,   a.branch,   a.ob22,   a.kv||'/'|| a.nls NLS , a.nms,   a.ostc/100 OST,   a.acc
 FROM (SELECT *  FROM xoz_ob22 WHERE deb= pul.get ('PROD')) x,         accounts a
 WHERE x.krd = a.nbs || a.ob22 AND a.dazs IS NULL
  AND a.kv = CASE   WHEN x.krd  like '6%' or x.krd  like '7%'  THEN 980    ELSE        to_number (pul.get ('XOZ_KV'))      END ;

PROMPT *** Create  grants  V_XOZOB22_NLS ***
grant SELECT                                                                 on V_XOZOB22_NLS   to BARSREADER_ROLE;
grant SELECT                                                                 on V_XOZOB22_NLS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XOZOB22_NLS   to START1;
grant SELECT                                                                 on V_XOZOB22_NLS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZOB22_NLS.sql =========*** End *** 
PROMPT ===================================================================================== 
