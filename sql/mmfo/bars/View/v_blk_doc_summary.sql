

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BLK_DOC_SUMMARY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BLK_DOC_SUMMARY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BLK_DOC_SUMMARY ("BLK", "KV", "CNT", "SUM") AS 
  SELECT BLK,
            KV,
            COUNT (*) cnt,
            SUM (S) SUM
       FROM V_RECQUE_ARCRRP_DATA, bp_rrp, s_er
      WHERE     V_RECQUE_ARCRRP_DATA.blk = bp_rrp.rule(+)
            AND V_RECQUE_ARCRRP_DATA.blk = S_ER.K_ER(+)
   GROUP BY BLK, kv
   ORDER BY SUM (S) DESC;

PROMPT *** Create  grants  V_BLK_DOC_SUMMARY ***
grant SELECT                                                                 on V_BLK_DOC_SUMMARY to BARSREADER_ROLE;
grant SELECT                                                                 on V_BLK_DOC_SUMMARY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BLK_DOC_SUMMARY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BLK_DOC_SUMMARY.sql =========*** End 
PROMPT ===================================================================================== 
