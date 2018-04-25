

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BR_TIER_EX.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view BR_TIER_EX ***

  CREATE OR REPLACE FORCE VIEW BARS.BR_TIER_EX ("BR_ID", "BDATE", "KV", "S", "RATE") AS 
  SELECT "BR_ID",
          "BDATE",
          "KV",
          "S",
          "RATE"
     FROM br_tier t
    WHERE t.bdate = (SELECT MAX (bdate)
                       FROM br_tier
                      WHERE bdate <= sysdate AND br_id = t.br_id AND kv = t.kv)
   UNION ALL
   SELECT DISTINCT bn.br_id,
                   bn.bdate,
                   bn.kv,
                   NVL (dv.LIMIT, 0)*100,
                   BN.RATE
     FROM br_normal_edit bn, dpt_vidd dv
    WHERE     bn.bdate =
                 (SELECT MAX (bdate)
                    FROM br_normal_edit
                   WHERE bdate <= sysdate AND br_id = dv.br_id AND kv = dv.kv)
          AND Dv.BR_ID = BN.BR_ID
          AND dv.kv = bn.kv
   UNION ALL
   SELECT DISTINCT bn.br_id,
                   bn.bdate,
                   bn.kv,
                   DBS.S,
                   BN.RATE + NVL (DBS.VAL, 0) RATE
     FROM br_normal_edit bn, dpt_bonus_settings dbs, dpt_vidd dv
    WHERE     dv.type_id = dbs.dpt_type
          AND Dv.BR_ID = BN.BR_ID
          AND bn.kv = dbs.kv
          AND DBS.BONUS_ID = 4
          AND bn.bdate =
                 (SELECT MAX (bdate)
                    FROM br_normal_edit
                   WHERE bdate <= sysdate AND br_id = dv.br_id AND kv = dv.kv);

PROMPT *** Create  grants  BR_TIER_EX ***
grant SELECT                                                                 on BR_TIER_EX      to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BR_TIER_EX      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_TIER_EX      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BR_TIER_EX.sql =========*** End *** ===
PROMPT ===================================================================================== 
