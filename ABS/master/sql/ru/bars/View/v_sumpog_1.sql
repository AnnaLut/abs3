CREATE OR REPLACE VIEW V_SUMPOG_1
(kv, lcv, name, g1, g2)
AS
SELECT g.KV,
            t.lcv,
            t.name,
            SUM (G1) / 100,
            SUM (G2) / 100
       FROM cck_Sum_POG_web g, tabval t
      WHERE     t.kv = g.kv
            AND g.g1 IS NOT NULL
            AND g.rec_id = SYS_CONTEXT ('bars_pul', 'REC_ID')
   GROUP BY g.KV, t.lcv, t.name
   ORDER BY g.KV;
