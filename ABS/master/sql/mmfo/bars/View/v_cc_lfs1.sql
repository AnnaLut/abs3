

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_LFS1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_LFS1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_LFS1 ("A", "J", "L") AS 
  select n.acc as a, j.acc as j, l.acc as l
  from nd_acc n, cc_deal d, accounts j, accounts l
 where n.nd = d.nd
   and d.vidd in (11, 12, 13)
   and j.kv = l.kv;

PROMPT *** Create  grants  V_CC_LFS1 ***
grant SELECT                                                                 on V_CC_LFS1       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CC_LFS1       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_LFS1       to RCC_DEAL;
grant SELECT                                                                 on V_CC_LFS1       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_LFS1.sql =========*** End *** ====
PROMPT ===================================================================================== 
