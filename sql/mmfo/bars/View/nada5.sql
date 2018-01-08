

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NADA5.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view NADA5 ***

  CREATE OR REPLACE FORCE VIEW BARS.NADA5 ("MFO", "SEGMENT", "ZN50", "PAP", "BRANCH2", "B", "E", "KOL", "BRANCH", "NBS", "OB22", "KV", "OSTS", "OSTQS", "SPOK") AS 
  SELECT SUBSTR (a.branch, 2, 6),
          o.SEGMENT,
          o.ZN50,
          DECODE (a.AP,  1, 'P',  -1, 'A',  '') PAP,
          SUBSTR (a.branch, 1, 15) BRANCH2,
          a.B,
          a.E,
          (a.E - a.B + 1) KOL,
          a.branch,
          a.nbs,
          a.ob22,
          a.kv,
          a.osts / 100 OSTS,
          gl.p_icurval (a.kv, a.OSTS, a.E) / 100 OSTqS,
          a.spok
     FROM (SELECT r020 || ob22 kod, SEGMENT, zn50 FROM sb_ob22) o,
          (  SELECT SIGN (osts) AP,
                    B,
                    E,
                    branch,
                    nbs,
                    ob22,
                    kv,
                    spok,
                    SUM (OSTS) OSTS
               FROM (SELECT nada.OSTS8 (v.acc, d.B, d.E) OSTS,
                            v.branch,
                            v.nbs,
                            v.ob22,
                            v.kv,
                            d.B,
                            d.E,
                            s.SPOK
                       FROM v_gl v,
                            v_sFdat d,
                            (SELECT n.acc, SUBSTR (t.txt, 1, 10) SPOK
                               FROM nd_txt t, nd_acc n, accounts a
                              WHERE     t.nd = n.nd
                                    AND tag = 'SPOK'
                                    AND a.acc = n.acc
                                    AND a.nbs < '4') s
                      WHERE v.acc = s.acc(+))
           GROUP BY SIGN (osts),
                    B,
                    E,
                    branch,
                    nbs,
                    ob22,
                    kv,
                    SPOK
             HAVING SUM (OSTS) <> 0) a
    WHERE a.nbs || a.ob22 = o.kod(+);

PROMPT *** Create  grants  NADA5 ***
grant SELECT                                                                 on NADA5           to BARSREADER_ROLE;
grant SELECT                                                                 on NADA5           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NADA5           to SALGL;
grant SELECT                                                                 on NADA5           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NADA5.sql =========*** End *** ========
PROMPT ===================================================================================== 
