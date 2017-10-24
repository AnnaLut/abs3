

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCN_R013.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCN_R013 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCN_R013 ("RNK", "NMK", "BRANCH", "NMS", "DAOS", "MDATE", "OST", "NBS", "OB22", "ACC", "KV", "NLS", "R013", "KL", "PROD", "DAPP") AS 
  select a.rnk, c.NMK, a.BRANCH, a.nms, a.daos,  a.mdate, a.ostc/100 ost, a.nbs, a.ob22, a.acc, a.kv, a.nls, s.r013 ,
       a.nbs ||'.'|| s.r013 kl , a.nbs||'/'||a.ob22 PROD , a.dapp
from customer c,specparam s, (select * from accounts where nbs in (select r020 from KL_R013 where prem='สม' and d_close is null)) a
where a.dazs is null  and a.acc = s.acc and a.rnk = c.rnk ;

PROMPT *** Create  grants  V_CCN_R013 ***
grant SELECT                                                                 on V_CCN_R013      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCN_R013      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCN_R013.sql =========*** End *** ===
PROMPT ===================================================================================== 
