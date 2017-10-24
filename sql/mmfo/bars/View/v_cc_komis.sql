

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_KOMIS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_KOMIS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_KOMIS ("PROD", "ND", "CC_ID", "RNK", "SDATE", "WDATE", "SOS", "NMK", "OKPO", "SDOG", "BRANCH") AS 
  SELECT
            d.prod prod,
            d.nd,
            d.cc_id,
            d.rnk,
            d.sdate,
            d.wdate,
            d.sos,
            c.nmk,
            c.okpo,
            d.sdog,
            d.branch
      FROM cc_deal d, customer c, cc_vidd v
      WHERE     c.rnk = d.rnk
            AND d.vidd = v.vidd
            AND v.custtype IN (3, 2)
	    and d.sos IN (10, 11, 13)
            AND d.branch like SYS_CONTEXT ('bars_context', 'user_branch') || '%'
   ORDER BY nmk;

PROMPT *** Create  grants  V_CC_KOMIS ***
grant FLASHBACK,SELECT                                                       on V_CC_KOMIS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_KOMIS      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_KOMIS.sql =========*** End *** ===
PROMPT ===================================================================================== 
