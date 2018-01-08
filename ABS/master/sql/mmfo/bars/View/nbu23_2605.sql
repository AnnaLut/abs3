

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_2605.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_2605 ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_2605 ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  select a.RNK,a.acc,a.mdate,a.nls,to_number(a.nbs),q.FIN, q.OBS, q.KAT, q.K, a.tobo 
  from v_gl a , ACC_FIN_OBS_KAT q
 where a.nbs in ('2605','2625') and dazs is null and a.acc = q.acc (+)  
--   and not exists (select 1 from nd_acc where acc=a.acc);

PROMPT *** Create  grants  NBU23_2605 ***
grant SELECT                                                                 on NBU23_2605      to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on NBU23_2605      to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_2605      to START1;
grant SELECT                                                                 on NBU23_2605      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_2605.sql =========*** End *** ===
PROMPT ===================================================================================== 
