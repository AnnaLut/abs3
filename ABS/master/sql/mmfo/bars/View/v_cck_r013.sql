

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_R013.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_R013 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_R013 ("KV8", "VIDD", "RNK", "NMK", "BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "OST8", "PROD", "ACC", "KV", "NLS", "NMS", "OST2", "R013", "KL", "NBS", "DAPP") AS 
  select a8.kv kv8, d.VIDD, d.rnk, c.NMK, d.BRANCH, d.ND,  d.CC_ID, d.SDATE,  d.WDATE, a8.ostc/100 ost8, substr(d.prod,1,6) prod,
       a2.acc, a2.kv, a2.nls, a2.nms, a2.ostc/100 ost2, s2.r013 , a2.nbs ||'.'|| s2.r013  KL, a2.nbs, a2.dapp
from cc_deal d, customer  c,  nd_acc n8, accounts a8 ,
     (select nd, acc from nd_acc  union all select distinct nd,acc from cc_accp where nd is not null) n2,
    (select * from  accounts where nbs in (select r020 from KL_R013 where prem ='สม'  and d_close is null)
     ) a2,
     specparam s2
where d.sos  < 15  and d.vidd in (1,2,3,11,12,13) and d.nd = n8.nd and n8.acc = a8.acc and a8.dazs is null and a8.tip = 'LIM'
  and d.nd = n2.nd and n2.acc = a2.acc and a2.dazs is null         and substr (a2.nls,1,1) in ('2','3','9')
  and a2.acc = s2.acc and d.rnk = c.rnk ;

PROMPT *** Create  grants  V_CCK_R013 ***
grant SELECT                                                                 on V_CCK_R013      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_R013      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_R013.sql =========*** End *** ===
PROMPT ===================================================================================== 
