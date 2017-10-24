

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ERR_REL_ACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ERR_REL_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ERR_REL_ACC ("NLS", "TIP", "KV", "ND", "RNK_ND", "RNK_ACC", "VIDD", "SOS", "DAZS", "ACC") AS 
  select x.NLS, x.TIP, x.KV, d.ND, d.rnk RNK_ND,  x.rnk RNK_ACC, d.VIDD, d.SOS,  x.DAZS, x.ACC
from nd_acc n, cc_deal d ,
    (select aa.acc, aa.kv, aa.nls, aa.rnk, aa.tip , aa.dazs, count ( * ) kol_nd
     from accounts aa, nd_acc nn, cc_deal dd
     where dd.vidd in (1,2,3,11,12,13) and dd.nd = nN.ND and aa.acc= nn.acc
       and (aa.nbs like '20%' or aa.nbs like '22%' or aa.nbs like '357%' )
     group by aa.acc, aa.kv, aa.nls , aa.rnk , aa.tip , aa.dazs
     having count ( * ) >1
     ) x
where n.acc= x.acc and n.nd = d.nd   ;

PROMPT *** Create  grants  V_CCK_ERR_REL_ACC ***
grant SELECT                                                                 on V_CCK_ERR_REL_ACC to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ERR_REL_ACC.sql =========*** End 
PROMPT ===================================================================================== 
