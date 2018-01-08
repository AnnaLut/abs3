

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NADA4.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view NADA4 ***

  CREATE OR REPLACE FORCE VIEW BARS.NADA4 ("MFO", "SEGMENT", "ZN50", "PAP", "BRANCH2", "B", "E", "KOL", "ACC", "BRANCH", "RNK", "NBS", "OB22", "KV", "NLS", "NMS", "OSTS", "OSTQS", "SPOK") AS 
  SELECT a.kf,
          o.SEGMENT,
          o.ZN50,
          DECODE (SIGN (a.osts),  1, 'P',  -1, 'A',  '') PAP,
          SUBSTR (a.branch, 1, 15) BRANCH2,
          a.B,
          a.E,
          (a.E - a.B + 1) KOL,
          a.acc,
          a.branch,
          a.rnk,
          a.nbs,
          a.ob22,
          a.kv,
          a.nls,
          a.NMS,
          a.osts / 100 OSTS,
          gl.p_icurval (a.kv, a.OSTS, a.E) / 100 OSTqS,
          s.SPOK
     FROM (SELECT r020 || ob22 kod, SEGMENT, zn50 FROM sb_ob22) o,
          (SELECT nada.OSTS8 (v.acc, d.B, d.E) OSTS,
                  v.branch,
                  v.acc,
                  v.rnk,
                  v.kf,
                  v.nbs,
                  v.ob22,
                  v.kv,
                  v.nls,
                  v.NMS,
                  d.B,
                  d.E,
                  (d.E - d.B + 1) KOL
             FROM v_gl v, v_sFdat d) a,
          (SELECT n.acc, SUBSTR (t.txt, 1, 10) SPOK
             FROM nd_txt t, nd_acc n, accounts a
            WHERE     t.nd = n.nd
                  AND tag = 'SPOK'
                  AND a.acc = n.acc
                  AND a.nbs < '4') s
    WHERE a.nbs || a.ob22 = o.kod(+) AND a.acc = s.acc(+);

PROMPT *** Create  grants  NADA4 ***
grant SELECT                                                                 on NADA4           to BARSREADER_ROLE;
grant SELECT                                                                 on NADA4           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NADA4           to SALGL;
grant SELECT                                                                 on NADA4           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NADA4.sql =========*** End *** ========
PROMPT ===================================================================================== 
