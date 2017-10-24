

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_WARRANTY_WEB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_WARRANTY_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_WARRANTY_WEB ("REF", "PAWN", "NLS", "KV", "S", "IDZ", "CC_IDZ", "SDATZ", "RNK", "CP_WAR") AS 
  SELECT cd.REF,
          sz.pawn,
          A.nls,
          A.kv,
          ABS (A.ostB / 100) S,
          SZ.idz,
          SZ.cc_idz,
          SZ.sdatz,
          C.rnk,
          AW.VALUE CP_WAR
     FROM cc_accp P,
          pawn_acc SZ,
          accounts A,
          accountsw aw,
          customer C,
          cp_deal cd,
          cp_kod ck
    WHERE     SZ.acc = p.acc
          AND p.rnk = C.rnk(+)
          AND a.acc = aw.acc(+)
          AND 'CP_WARR' = aw.tag(+)
          AND A.acc = P.acc
          AND cd.acc = p.accs
          AND cd.REF = p.nd
          AND ck.id = cd.id;

PROMPT *** Create  grants  V_CP_WARRANTY_WEB ***
grant FLASHBACK,SELECT                                                       on V_CP_WARRANTY_WEB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_WARRANTY_WEB.sql =========*** End 
PROMPT ===================================================================================== 
