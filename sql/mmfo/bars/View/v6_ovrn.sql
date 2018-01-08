

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V6_OVRN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V6_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.V6_OVRN ("ACC", "DATM", "S", "PR", "NLS", "RNK", "OKPO", "NMK", "SOS", "ND", "DATS") AS 
  select   o.ACC,  o.DATM,   o.S/100 S,   o.PR , a.nls, c.rnk, c.okpo, c.nmk, d.sos, d.nd , to_char(o.DATM,'dd/mm/yyyy') DATS
from OVR_CHKO  o, accounts a, customer c,  cc_deal d, nd_acc n
where a.accc = n.acc and n.nd = d.nd and o.acc = to_number ( pul.Get_Mas_Ini_Val('ACC26') ) and o.acc= a.acc and a.rnk = c.rnk ;

PROMPT *** Create  grants  V6_OVRN ***
grant SELECT                                                                 on V6_OVRN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V6_OVRN         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V6_OVRN.sql =========*** End *** ======
PROMPT ===================================================================================== 
