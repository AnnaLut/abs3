CREATE OR REPLACE VIEW BARS.V_BLK_DOC_SUMMARY
(
   BLK,
   KV,
   CNT,
   SUM
)
AS
     SELECT BLK,
            KV,
            COUNT (*) cnt,
            SUM (S) SUM
       FROM V_RECQUE_ARCRRP_DATA, bp_rrp, s_er
      WHERE     V_RECQUE_ARCRRP_DATA.blk = bp_rrp.rule(+)
            AND V_RECQUE_ARCRRP_DATA.blk = S_ER.K_ER(+)
   GROUP BY BLK, kv
   ORDER BY SUM (S) DESC;


GRANT SELECT ON BARS.V_BLK_DOC_SUMMARY TO BARS_ACCESS_DEFROLE;
