

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SUMPOG_2N.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SUMPOG_2N ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SUMPOG_2N ("KV", "ND", "CC_ID", "NMK", "WDATE", "G1", "G2", "MANAGER", "INIC") AS 
  SELECT g.KV,
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
            AND g.rec_id = SYS_CONTEXT ('bars_pul', 'REC_ID')
   ORDER BY g.KV, g.ND;

PROMPT *** Create  grants  V_SUMPOG_2N ***
grant SELECT                                                                 on V_SUMPOG_2N     to BARSREADER_ROLE;
grant SELECT                                                                 on V_SUMPOG_2N     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SUMPOG_2N     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SUMPOG_2N.sql =========*** End *** ==
PROMPT ===================================================================================== 
