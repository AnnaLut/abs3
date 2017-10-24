

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_ENERGY.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_ENERGY ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_ENERGY ("OTM", "BRANCH", "CC_ID", "ND", "PROD", "RNK", "SDATE", "SDOG", "SOS", "WDATE", "OST") AS 
  select 0 OTM,
branch, cc_id, nd, prod, rnk, sdate, sdog, sos, wdate,
(select -a.ostc/100  from accounts a, nd_acc n where a.tip='LIM' and a.acc= n.acc and n.nd = d.ND) ost
from cc_deal d
where sos < 14 and ( prod like '220256%' or prod  like '220346%' ) ;

PROMPT *** Create  grants  CC_ENERGY ***
grant SELECT                                                                 on CC_ENERGY       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_ENERGY.sql =========*** End *** ====
PROMPT ===================================================================================== 
