PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BR_TIER_EX.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view BR_TIER_EX ***

  CREATE OR REPLACE FORCE VIEW BARS.BR_TIER_EX ("BR_ID", "BDATE", "KV", "S", "RATE") AS 
  SELECT "BR_ID","BDATE","KV","S","RATE"
     FROM br_tier t
    WHERE t.bdate = (SELECT MAX (bdate)
                       FROM br_tier
                      WHERE bdate <= gl.bd)
   UNION ALL
   SELECT DISTINCT bn.br_id,
                   bn.bdate,
                   bn.kv,
                   DBS.S,
                   BN.RATE + NVL (DBS.VAL, 0)
     FROM br_normal bn, dpt_bonus_settings dbs, dpt_vidd dv
    WHERE     dv.type_id = dbs.dpt_type
          AND Dv.BR_ID = BN.BR_ID
          AND bn.kv = dbs.kv
          AND gl.bd between dbs.dat_begin and nvl(dbs.dat_end, to_date('31.12.4999','DD.MM.YYYY'))
          AND dbs.bonus_id = bars.dpt_bonus.get_bonus_id('EXCL')
          AND bn.bdate =
                 (SELECT MAX (bdate)
                    FROM br_normal
                   WHERE bdate <= gl.bd AND br_id = dv.br_id AND kv = dv.kv);

PROMPT *** Create  grants  BR_TIER_EX ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BR_TIER_EX      to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BR_TIER_EX.sql =========*** End *** ===
PROMPT ===================================================================================== 
