

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_PAWN_ERROR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_PAWN_ERROR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_PAWN_ERROR ("T_KOD", "NAME_KOD", "BRANCH", "NLS", "KV", "PAWN_23", "OSTC", "ND", "ACC") AS 
  SELECT 1 t_kod,
          'Закр Код' name_kod,
          a.branch,
          a.nls,
          a.kv,
          c.pawn_23,
          ABS (a.ostc / 100) ostc,
          (SELECT n.nd
             FROM nd_acc n, cc_accp p
            WHERE n.acc = p.accs and p.acc= ac.acc AND ROWNUM = 1)
             nd,
             a.acc
     FROM cc_pawn c,
          pawn_acc ac,
          accounts a,
          customer r
    WHERE     ac.acc = a.acc
          AND c.pawn = ac.pawn
          AND a.dazs IS NULL
          AND A.NLS LIKE '9%'
          AND C.D_CLOSE IS NOT NULL
          AND a.rnk = r.rnk
   UNION ALL
   SELECT
          2 t_kod,
          'Невідпов. бал. рах' name_kod,
          a.branch,
          a.nls,
          a.kv,
          c.pawn_23,
          ABS (a.ostc / 100),
          (SELECT n.nd
             FROM nd_acc n, cc_accp p
            WHERE n.acc = p.accs and p.acc= ac.acc AND ROWNUM = 1)
             nd,
             a.acc
     FROM cc_pawn c,
          pawn_acc ac,
          accounts a,
          customer r
    WHERE     ac.acc = a.acc
          AND c.pawn = ac.pawn
          AND a.dazs IS NULL
          AND A.NLS LIKE '9%'
          AND a.nbs != C.NBSZ
          AND a.rnk = r.rnk
    UNION ALL
   SELECT
          3 t_kod,
          'Не зв''язан з жодним рахунком' name_kod,
          a.branch,
          a.nls,
          a.kv,
          c.pawn_23,
          ABS (a.ostc / 100),
          (SELECT n.nd
             FROM nd_acc n, cc_accp p
            WHERE n.acc = p.accs and p.acc= ac.acc AND ROWNUM = 1)
             nd,
             a.acc
     FROM cc_pawn c,
          pawn_acc ac,
          accounts a,
          customer r
    WHERE     ac.acc = a.acc
          AND c.pawn = ac.pawn
          AND a.dazs IS NULL
          AND A.NLS LIKE '9%'
          AND a.rnk = r.rnk
          AND  not exists (SELECT 1
                                  FROM cc_accp p
                                  WHERE p.acc= ac.acc);

PROMPT *** Create  grants  V_CC_PAWN_ERROR ***
grant SELECT                                                                 on V_CC_PAWN_ERROR to BARSREADER_ROLE;
grant SELECT                                                                 on V_CC_PAWN_ERROR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_PAWN_ERROR to SALGL;
grant SELECT                                                                 on V_CC_PAWN_ERROR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_PAWN_ERROR.sql =========*** End **
PROMPT ===================================================================================== 
