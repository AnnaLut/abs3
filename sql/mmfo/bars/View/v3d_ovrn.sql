

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3D_OVRN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V3D_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.V3D_OVRN ("ND", "FDAT", "ACC", "LIM_DOG", "KV", "NLS", "LIM_DIE", "CC_ID", "RNK", "TIP") AS 
  select l.ND, l.fdat, l.acc, l.lim/100 LIM_dog, a.kv, a.nls, a.lim/100 lim_die, d.cc_id, a.rnk, a.tip
from accounts a, OVR_LIM_dog l , cc_deal d
where l.acc = a.acc  and d.ND  = to_number( pul.Get('ND') ) and d.nd = l.nd ;

PROMPT *** Create  grants  V3D_OVRN ***
grant SELECT                                                                 on V3D_OVRN        to BARSREADER_ROLE;
grant SELECT                                                                 on V3D_OVRN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3D_OVRN        to START1;
grant SELECT                                                                 on V3D_OVRN        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3D_OVRN.sql =========*** End *** =====
PROMPT ===================================================================================== 
