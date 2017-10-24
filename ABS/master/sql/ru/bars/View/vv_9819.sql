

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VV_9819.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VV_9819 ***

  CREATE OR REPLACE FORCE VIEW BARS.VV_9819 ("BRANCH", "ND", "CC_ID", "SDATE", "RNK", "NMK", "ISP", "K_02", "K_03", "K_79", "K_83") AS 
  SELect d.branch, d.nd, d.cc_id, d.sdate, d.rnk,c.nmk,d.USER_ID,
          k.k_02, k.k_03, k.k_79, k.k_83
   from cc_deal d, customer c, ND_9819 k
   where d.vidd in (1,2,3,11,12,13)
     and d.sos >= 10
     and d.sos <= 15
     and d.rnk  = c.rnk
     and d.nd =k.nd(+)
     and d.branch like sys_context('bars_context','user_branch') ||'%';

PROMPT *** Create  grants  VV_9819 ***
grant SELECT,UPDATE                                                          on VV_9819         to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on VV_9819         to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VV_9819.sql =========*** End *** ======
PROMPT ===================================================================================== 
