

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22NU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22NU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22NU ("ACC", "NLS", "NMS", "NBS", "P080", "OB22", "ACCN", "NLSN", "NMSN", "NBSN", "NP080", "NOB22", "PRIZN", "NMS8", "AP", "VIDF", "APF") AS 
  SELECT a.acc, a.nls, a.nms, a.nbs, s.p080, s.ob22, n.acc accn, n.nls nlsn,
          n.nms nmsn, n.nbs nbsn, n.p080 np080, n.ob22 nob22, n.prizn, n.nms8 ,n.ap,
          decode(a.vid,89,1,0) vidf, n.apf
     FROM accounts a,
          specparam_int s,
          (SELECT a.acc, a.nls, a.nms, a.nbs, s.p080, s.ob22, s.r020_fa,
                  p.prizn_vidp prizn, p.nms8,p.ap, p.apf
             FROM accounts a,
                  specparam_int s,
                  (SELECT DISTINCT SUBSTR (a.txt, 1, 35) nms8,
                                    a.p080,
                                    a.r020_fa,
                                    a.r020,
                                    a.prizn_vidp,
                                    a.ob22,
									a.ap,
                                    decode(b.r020_fa, null,3,a.ap) as apf
                     FROM sb_p0853 a, (select r020_fa, ob22
                                          from sb_p0853
                                         WHERE r020_fa <> '0000'
                                           AND (d_close IS NULL OR d_close > gl.bd)
                                           AND d_open <= gl.bd
                                           group by r020_fa, ob22
                                           having count(1) > 1) b
                    WHERE     a.r020_fa <> '0000'
                          AND (a.d_close IS NULL OR a.d_close > gl.bd)
                          AND a.d_open <= gl.bd
                          and a.r020_fa= b.r020_fa(+)
                          and a.ob22 = b.ob22(+)) p
            WHERE a.acc = s.acc
              AND a.daos<=gl.bd
              AND (a.dazs is null or a.dazs>gl.bd)
              AND a.kv = 980
              AND SUBSTR (a.nls, 1, 1) = '8'
              AND a.nbs = p.r020
              AND s.ob22 = p.ob22
              AND s.r020_fa = p.r020_fa
              AND s.p080 = p.p080
              AND a.vid<>89) n
    WHERE a.acc = s.acc AND a.nbs = n.r020_fa AND s.ob22 = n.ob22 AND a.vid<>89;

PROMPT *** Create  grants  V_OB22NU ***
grant SELECT                                                                 on V_OB22NU        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_OB22NU        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22NU        to CUST001;
grant SELECT,UPDATE                                                          on V_OB22NU        to NALOG;
grant SELECT                                                                 on V_OB22NU        to RPBN001;
grant SELECT                                                                 on V_OB22NU        to START1;
grant SELECT                                                                 on V_OB22NU        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22NU        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22NU.sql =========*** End *** =====
PROMPT ===================================================================================== 
