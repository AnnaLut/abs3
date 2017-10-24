create or replace view v_ovr_acc_add as
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

grant select on  BARS.v_ovr_acc_add  to start1 ;
grant select on  BARS.v_ovr_acc_add  to BARS_ACCESS_DEFROLE ; 