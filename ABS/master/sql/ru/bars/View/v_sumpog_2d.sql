CREATE OR REPLACE FORCE VIEW BARS.V_SUMPOG_2D
(
   DAT,
   KV,
   LCV,
   NAME,
   G1,
   G2
)
AS
     SELECT TO_DATE (g.CC_ID, 'dd/mm/yyyy'),
            g.KV,
            t.lcv,
            t.name,
            SUM (G1) / 100,
            SUM (G2) / 100
       FROM cck_Sum_POG_web g, tabval t
      WHERE     t.kv = g.kv
            AND g.g1 IS NOT NULL
            AND g.rec_id = SYS_CONTEXT ('bars_pul', 'REC_ID')
   GROUP BY TO_DATE (g.CC_ID, 'dd/mm/yyyy'),
            g.KV,
            t.lcv,
            t.name
   ORDER BY TO_DATE (g.CC_ID, 'dd/mm/yyyy'), g.KV;


GRANT SELECT ON BARS.V_SUMPOG_2D TO BARS_ACCESS_DEFROLE;
