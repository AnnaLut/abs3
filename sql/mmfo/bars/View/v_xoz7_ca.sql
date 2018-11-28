create or replace view V_XOZ7_CA1 as 
SELECT a1.acc , a1.ob22, a1.nms  , a1.nls, a1.kv, a1.kf,   x1.ref1, x1.stmt1, x1.s/100 s,    z1.datz, z1.refd, o1.nazn, z1.sos 
FROM accounts a1, xoz_ref x1,  XOZ_DEB_ZAP z1 , oper o1
where z1.REFD = TO_NUMBER (pul.get ('REFD')) 
  and z1.kf   = x1.kf  AND z1.ref1 = x1.ref1 and z1.stmt1 = x1.stmt1 
  AND z1.kf   = A1.kf  and x1.acc  = a1.acc
  AND Z1.KF   = O1.KF  AND Z1.REF1 = O1.REF  ;

-------------------------------------------

CREATE OR REPLACE FORCE VIEW BARS.V_XOZ7_CA AS 
SELECT x.KF, x.nls, x.kv , x.ob22 OB3, x.S, z.nazn, z.s7/100 S7, a7.branch BR7,  a7.ob22 OB7,  a7.nls nls7,  a7.nms nms7,   z.kodZ,     z.ob40,  z.rowid RI
 FROM V_XOZ7_CA1 x, accounts a7, xoz7_ca z  
 WHERE x.refd = z.REC and a7.acc = z.acc7  and x.sos = 1 
UNION ALL      
 SELECT x.KF, x.nls, x.kv , x.ob22 OB3, x.S, x.nazn, 0 S7, a7.branch BR7,  a7.ob22 OB7,  a7.nls nls7,  a7.nms nms7, NULL kodz,  NULL ob40,    NULL RI
 FROM V_XOZ7_CA1 x, (SELECT a.* FROM accounts a, xoz_ob22 o WHERE o.deb= pul.get ('PROD') AND o.krd= a.nbs||a.ob22 AND a.dazs IS NULL AND a.kv=980 and kf='300465' ORDER BY a.nls) a7 
 where  x.sos = 1;


GRANT SELECT ON BARS.V_XOZ7_CA TO BARS_ACCESS_DEFROLE;
