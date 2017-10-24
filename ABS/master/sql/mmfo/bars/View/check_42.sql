

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_42.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_42 ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_42 ("VDATE", "RNK", "NMK", "NLS", "KV", "NMS", "DATPS", "OST", "DOS", "KOS") AS 
  select
       a.fdat, c.rnk, c.nmk, a.nls, a.kv, a.nms, k.mdate,
       a.ost, a.dos, a.kos
from   sal a, cust_acc ca, customer c, accounts k,
       kl_f3_29 kl
where  ca.acc=a.acc  and  ca.rnk=c.rnk   and  a.acc=k.acc and
       kl.kf='42'    and  a.nbs=kl.r020  and  a.ost<>0;

PROMPT *** Create  grants  CHECK_42 ***
grant SELECT                                                                 on CHECK_42        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_42        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_42.sql =========*** End *** =====
PROMPT ===================================================================================== 
