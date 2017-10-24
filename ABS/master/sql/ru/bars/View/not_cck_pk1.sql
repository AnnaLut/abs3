

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NOT_CCK_PK1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view NOT_CCK_PK1 ***

  CREATE OR REPLACE FORCE VIEW BARS.NOT_CCK_PK1 ("DAPP", "ACC", "BRANCH", "KV", "KOD", "NLS", "NMS", "DAOS", "RNK", "TIP", "ISP", "OST") AS 
  select  dapp, acc, branch, kv, nbs||ob22, nls, nms, daos, rnk, tip, isp, - ostc/100
from accounts A
where  acc in
 (select acc from accounts
  where nbs in
   ('2202','2203','2207','2208','2209',
    '2212','2213','2217','2218','2219',
    '2222','2223','2227','2228','2229',
    '2232','2233','2237','2238','2239',
    '9129')
    and dazs is null
  minus
  select acc from nd_acc
  minus
  select acc from (select ACC_OVR ACC from bpk_acc where ACC_OVR  is not null
                   union all
                   select ACC_9129    from bpk_acc where ACC_9129 is not null
                   union all
                   select acc_2208    from bpk_acc where ACC_2208 is not null
                   union all
                   select acc_2207    from bpk_acc where ACC_2207 is not null
                   union all
                   select acc_2209    from bpk_acc where ACC_2209 is not null
                   )
  minus
  select acc from (select ACC_OVR ACC from w4_acc where ACC_OVR  is not null
                   union all
                   select ACC_2203    from w4_acc where ACC_2203 is not null
                   union all
                   select ACC_9129    from w4_acc where ACC_9129 is not null
                   union all
                   select acc_2208    from w4_acc where ACC_2208 is not null
                   union all
                   select acc_2207    from w4_acc where ACC_2207 is not null
                   union all
                   select acc_2209    from w4_acc where ACC_2209 is not null
                   )
 );

PROMPT *** Create  grants  NOT_CCK_PK1 ***
grant SELECT                                                                 on NOT_CCK_PK1     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOT_CCK_PK1     to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NOT_CCK_PK1.sql =========*** End *** ==
PROMPT ===================================================================================== 
