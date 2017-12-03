

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VV_9819.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VV_9819 ***

  CREATE OR REPLACE FORCE VIEW BARS.VV_9819 ("BRANCH", "ND", "CC_ID", "SDATE", "RNK", "NMK", "ISP", "K_02", "K_03", "K_79", "K_83", "K_I3", "K_B8", "PRIM", branch_cx) AS 
  SELECT d.branch,
          d.nd,
          d.cc_id,
          d.sdate,
          d.rnk,
          c.nmk,
          d.USER_ID,
          k.k_02,
          k.k_03,
          k.k_79,
          k.k_83,
		  k.k_I3,
		  k.k_B8,
          k.prim,
		  k.branch branch_cx
     FROM cc_deal d, customer c, ND_9819 k
    WHERE     d.vidd IN (1, 2, 3, 11, 12, 13)
          --AND d.sos >= 10
          --AND d.sos <= 13
          AND d.rnk = c.rnk
          AND d.nd = k.nd(+)
          AND k.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  VV_9819 ***
grant SELECT                                                                 on VV_9819         to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on VV_9819         to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on VV_9819         to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VV_9819.sql =========*** End *** ======
PROMPT ===================================================================================== 
