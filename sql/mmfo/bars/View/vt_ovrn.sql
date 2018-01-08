

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VT_OVRN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VT_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.VT_OVRN ("CC_ID", "ND", "DATVZ", "DATSP", "TRZ", "NLS1", "ACC1", "RNK1", "NLS", "ACC", "RNK", "ORD", "NAME") AS 
  select  d.cc_id, d.nd, t.DATVZ, t.DATSP, t.trz,  a1.nls NLS1, t.acc1, a1.rnk rnk1, a.nls, t.acc ,  a.rnk ,
        decode (a1.acc, t.acc, 1,2) ORD, z.name
from accounts  a1, accounts a, nd_acc n, OVR_TERM_TRZ t, cc_deal d , OVR_ZONE z
where t.acc1 = a1.acc and t.acc = a.acc and d.vidd =10 and d.nd = n.nd and n.acc = t.acc1 and t.trz = z.id (+) ;

PROMPT *** Create  grants  VT_OVRN ***
grant SELECT                                                                 on VT_OVRN         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VT_OVRN.sql =========*** End *** ======
PROMPT ===================================================================================== 
