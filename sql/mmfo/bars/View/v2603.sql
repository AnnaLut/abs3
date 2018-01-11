

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V2603.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V2603 ***

  CREATE OR REPLACE FORCE VIEW BARS.V2603 ("ACC", "NLS", "NMS", "RNK", "BRANCH", "OB22", "OSTV", "OSTC", "OSTB", "KAZ", "SA", "SR", "SALL", "IDG", "IDS", "SPS") AS 
  SELECT a.acc,
          a.nls,
          a.nms,
          a.rnk,
          a.branch,
          a.ob22,
          fost (a.acc, gl.bd - 1) / 100 OSTV,
          a.ostc / 100 OSTC,
          a.ostb / 100 OSTB,
          kaz (s.sps, a.acc) / 100 KAZ,
          t.SA / 100 SA,
          t.SR / 100 SR,
          t.SA / 100 + t.SR / 100 SALL,
          s.idg,
          s.ids,
          s.sps
     FROM accounts a, specparam s, t2603 t
    WHERE     a.acc = s.acc
          AND a.acc = t.acc(+)
          AND a.nbs = '2603'
          AND a.kv = 980
          AND s.ids > 0
          AND s.idg = TO_NUMBER (pul.Get_Mas_Ini_Val ('IDG'));

PROMPT *** Create  grants  V2603 ***
grant SELECT                                                                 on V2603           to BARSREADER_ROLE;
grant SELECT                                                                 on V2603           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V2603           to START1;
grant SELECT                                                                 on V2603           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V2603.sql =========*** End *** ========
PROMPT ===================================================================================== 
