

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SUMPOG_2ND.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SUMPOG_2ND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SUMPOG_2ND ("DAT", "KV", "ND", "CC_ID", "NMK", "WDATE", "G1", "G2", "MANAGER", "INIC") AS 
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

PROMPT *** Create  grants  V_SUMPOG_2ND ***
grant SELECT                                                                 on V_SUMPOG_2ND    to BARSREADER_ROLE;
grant SELECT                                                                 on V_SUMPOG_2ND    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SUMPOG_2ND    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SUMPOG_2ND.sql =========*** End *** =
PROMPT ===================================================================================== 
