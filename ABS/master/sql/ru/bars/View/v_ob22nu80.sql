

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22NU80.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22NU80 ***

CREATE OR REPLACE FORCE VIEW BARS.V_OB22NU80
(
   ACCN,
   NLSN,
   NMSN,
   NBSN,
   NP080,
   NR020_FA,
   NOB22,
   PRIZN,
   NMS8
)
AS
   SELECT z.acc,
          z.nls,
          z.nms,
          z.nbs,
          s.p080,
          s.r020_fa,
          p.ob22,
          p.prizn_vidp,
          p.nms8
     FROM accounts z,
          specparam_int s,
          (SELECT DISTINCT SUBSTR (txt, 1, 35) nms8,
                           p080,
                           r020_fa,
                           r020,
                           prizn_vidp,
                           ob22,
                           d_open,
                           d_close
             FROM sb_p0853
            WHERE     r020_fa = '0000'
                  AND (   gl.bd < TO_DATE ('01-04-2011', 'dd-mm-yyyy')
                       OR (       gl.bd >=
                                     TO_DATE ('01-04-2011', 'dd-mm-yyyy')
                              AND (d_open >=
                                      TO_DATE ('01-04-2011', 'dd-mm-yyyy'))
                           OR d_open >= TO_DATE ('04-01-2011', 'dd-mm-yyyy'))))
          p
    WHERE     (   gl.bd < TO_DATE ('01-04-2011', 'dd-mm-yyyy')
               OR     gl.bd >= TO_DATE ('01-04-2011', 'dd-mm-yyyy')
                  AND z.dazs IS NULL)
          AND z.kv = 980
          AND z.acc = s.acc
          AND z.nbs = p.r020
          AND NVL (TRIM (s.r020_fa), '0000') = p.r020_fa
          AND s.ob22 = p.ob22
          AND z.nbs = p.r020
          AND s.p080 = p.p080;

PROMPT *** Create  grants  V_OB22NU80 ***
grant SELECT                                                                 on V_OB22NU80      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22NU80      to CUST001;
grant SELECT                                                                 on V_OB22NU80      to NALOG;
grant SELECT                                                                 on V_OB22NU80      to RPBN001;
grant SELECT                                                                 on V_OB22NU80      to RPBN002;
grant SELECT                                                                 on V_OB22NU80      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22NU80      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22NU80.sql =========*** End *** ===
PROMPT ===================================================================================== 
