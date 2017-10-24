

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_900.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_900 ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_900 ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  select a.RNK,a.acc,a.mdate,a.nls,to_number(a.nbs),q.FIN, q.OBS, q.KAT, q.K, a.tobo 
  from  v_gl a , ACC_FIN_OBS_KAT q
 where a.acc = q.acc (+)  and a.dazs is null  
--   and not exists (select 1 from nd_acc where acc=a.acc)
   and a.nbs in ('9000','9002','9001','9003',9020,9100);

PROMPT *** Create  grants  NBU23_900 ***
grant SELECT,UPDATE                                                          on NBU23_900       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_900       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_900.sql =========*** End *** ====
PROMPT ===================================================================================== 
