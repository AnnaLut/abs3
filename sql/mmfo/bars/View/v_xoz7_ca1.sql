

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZ7_CA1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZ7_CA1 ***

CREATE OR REPLACE VIEW V_XOZ7_CA1 AS
SELECT a1.acc , a1.ob22, a1.nms  , a1.nls, a1.kv, a1.kf,   x1.ref1, x1.stmt1, x1.s/100 s,    z1.datz, z1.refd, o1.nazn, z1.sos
FROM accounts a1, xoz_ref x1,  XOZ_DEB_ZAP z1 , oper o1
where z1.REFD = TO_NUMBER (pul.get ('REFD'))
  and z1.kf   = x1.kf  AND z1.ref1 = x1.ref1 and z1.stmt1 = x1.stmt1
  AND z1.kf   = A1.kf  and x1.acc  = a1.acc
  AND Z1.KF   = O1.KF  AND Z1.REF1 = O1.REF;

PROMPT *** Create  grants  V_XOZ7_CA1 ***
grant SELECT                                                                 on V_XOZ7_CA1       to BARSREADER_ROLE;
grant SELECT                                                                 on V_XOZ7_CA1       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XOZ7_CA1       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZ7_CA1.sql =========*** End *** ====
PROMPT ===================================================================================== 
