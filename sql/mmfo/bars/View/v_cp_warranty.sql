

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_WARRANTY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_WARRANTY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_WARRANTY ("REF", "PAWN", "NLS", "KV", "S", "IDZ", "CC_IDZ", "SDATZ", "RNK", "CP_WAR") AS 
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
          and ck.id = cd.id;

PROMPT *** Create  grants  V_CP_WARRANTY ***
grant SELECT                                                                 on V_CP_WARRANTY   to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_CP_WARRANTY   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_WARRANTY   to UPLD;
grant FLASHBACK,SELECT                                                       on V_CP_WARRANTY   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_WARRANTY.sql =========*** End *** 
PROMPT ===================================================================================== 