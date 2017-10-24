CREATE OR REPLACE FORCE VIEW BARS.V_SUMPOG_2ND
(
   DAT,
   KV,
   ND,
   CC_ID,
   NMK,
   WDATE,
   G1,
   G2,
   MANAGER,
   INIC
)
AS
     SELECT TO_DATE (g.CC_ID, 'dd/mm/yyyy'),
            g.KV,
            g.ND,
            d.CC_ID,
            g.NMK,
            d.WDATE,
            g.G1 / 100,
            g.G2 / 100,
            d.user_id || '/' || st.fio,
            SUBSTR (nt.txt, 1, 250)
       FROM cck_Sum_POG_web g,
            cc_deal d,
            nd_txt nt,
            staff st
      WHERE     g.g1 IS NOT NULL
            AND g.nd = d.nd
            AND nt.nd(+) = d.nd
            AND nt.tag(+) = 'INIC'
            AND d.user_id = st.id
   ORDER BY TO_DATE (g.CC_ID, 'dd/mm/yyyy'), g.KV, g.ND;


GRANT SELECT ON BARS.V_SUMPOG_2ND TO BARS_ACCESS_DEFROLE;
