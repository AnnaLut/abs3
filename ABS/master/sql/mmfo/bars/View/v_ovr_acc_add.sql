

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OVR_ACC_ADD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OVR_ACC_ADD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OVR_ACC_ADD ("ACC_P", "NMS", "NBS", "NLS", "OSTC", "KF", "BRANCH", "OKPO", "ACC", "ACC_ADD", "CHK") AS 
  select a.acc acc_p,
       a.nms,
       a.nbs,
       a.nls,
       a.OSTC/100 OSTC,
       a.kf,
       a.branch,
       c.okpo,
       aa.acc,
       oa.acc_add,
       case when oa.acc is null then 0 else 1 end chk
from  accounts        aa
     join customer    c    on c.rnk  = aa.rnk
     join accounts    a    on aa.acc<>a.acc and aa.rnk = a.rnk
left join OVR_ACC_ADD OA   on oa.acc_add = a.acc
where  a.kv=980
  and a.dazs is null
  and a.pap = 2
  and a.nbs like '2%'
;

PROMPT *** Create  grants  V_OVR_ACC_ADD ***
grant SELECT                                                                 on V_OVR_ACC_ADD   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OVR_ACC_ADD   to START1;
grant SELECT                                                                 on V_OVR_ACC_ADD   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OVR_ACC_ADD.sql =========*** End *** 
PROMPT ===================================================================================== 
