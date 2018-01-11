

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22NU80_OTC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22NU80_OTC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22NU80_OTC ("ACCN", "NLSN", "NMSN", "NBSN", "NP080", "NR020_FA", "NOB22", "PRIZN", "NMS8", "DAZS") AS 
  SELECT z.acc,
          z.nls,
          z.nms,
          z.nbs,
          s.p080,
          s.r020_fa,
          z.ob22,
          p.prizn_vidp,
          p.nms8, 
          z.dazs
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
                           OR d_open >= TO_DATE ('04-01-2011', 'dd-mm-yyyy')))) p
    WHERE z.kv = 980
          AND z.acc = s.acc
          AND z.nbs = p.r020
          AND s.r020_fa = p.r020_fa
          AND z.ob22 = p.ob22
          AND z.nbs = p.r020
          AND s.p080 = p.p080;

PROMPT *** Create  grants  V_OB22NU80_OTC ***
grant SELECT                                                                 on V_OB22NU80_OTC  to BARSREADER_ROLE;
grant SELECT                                                                 on V_OB22NU80_OTC  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22NU80_OTC.sql =========*** End ***
PROMPT ===================================================================================== 
