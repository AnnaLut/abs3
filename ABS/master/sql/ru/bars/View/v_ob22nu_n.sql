

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22NU_N.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22NU_N ***

CREATE OR REPLACE FORCE VIEW BARS.V_OB22NU_N
(
   ACC,
   NLS,
   NMS,
   NBS,
   P080,
   OB22,
   ACCN,
   NLSN,
   NMSN,
   NBSN,
   NP080,
   NOB22,
   PRIZN,
   NMS8,
   D_CLOSE,
   VIDF
)
AS
   SELECT a.acc,
          a.nls,
          a.nms,
          a.nbs,
          s.p080,
          s.ob22,
          n.acc accn,
          n.nls nlsn,
          n.nms nmsn,
          n.nbs nbsn,
          n.p080 np080,
          n.ob22 nob22,
          n.prizn,
          n.nms8,
          n.d_close,
          DECODE (a.vid, 89, 1, 0) vidf
     FROM accounts a,
          specparam_int s,
          (SELECT a.acc,
                  a.nls,
                  a.nms,
                  a.nbs,
                  s.p080,
                  s.ob22,
                  s.r020_fa,
                  p.prizn_vidp prizn,
                  p.nms8,
                  p.d_close
             FROM accounts a,
                  specparam_int s,
                  (SELECT DISTINCT SUBSTR (txt, 1, 35) nms8,
                                   p080,
                                   r020_fa,
                                   r020,
                                   prizn_vidp,
                                   ob22,
                                   d_close
                     FROM sb_p0853
                     WHERE r020_fa <> '0000') p
            WHERE     a.acc = s.acc
                  AND a.kv = 980
                  AND SUBSTR (a.nls, 1, 1) = '8'
                  AND a.nbs = p.r020
                  AND s.ob22 = p.ob22
                  AND NVL (TRIM (s.r020_fa), '0000') = p.r020_fa
                  AND s.p080 = p.p080) n
    WHERE a.acc = s.acc AND a.nbs = n.r020_fa AND s.ob22 = n.ob22;

PROMPT *** Create  grants  V_OB22NU_N ***
grant SELECT                                                                 on V_OB22NU_N      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22NU_N      to NALOG;
grant SELECT                                                                 on V_OB22NU_N      to RPBN001;
grant SELECT                                                                 on V_OB22NU_N      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22NU_N      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22NU_N.sql =========*** End *** ===
PROMPT ===================================================================================== 
