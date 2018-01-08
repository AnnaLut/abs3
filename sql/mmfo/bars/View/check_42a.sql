

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_42A.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_42A ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_42A ("VDATE", "RNK", "NMK", "OST") AS 
  select
       a.fdat, c.rnk, c.nmk, SUM(gl.p_icurval( a.kv, a.ost, a.fdat))
from   sal a, cust_acc ca, customer c,
       kl_f3_29 kl
where  ca.acc=a.acc     and ca.rnk=c.rnk          and
       kl.kf='42'       and a.nbs=kl.r020         and
       a.ost<>0
group by a.fdat, c.rnk, c.nmk;

PROMPT *** Create  grants  CHECK_42A ***
grant SELECT                                                                 on CHECK_42A       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_42A       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_42A.sql =========*** End *** ====
PROMPT ===================================================================================== 
