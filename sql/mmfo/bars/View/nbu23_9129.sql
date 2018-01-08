

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_9129.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_9129 ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_9129 ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  select a.RNK,a.acc,a.mdate,a.nls,to_number(a.nbs),q.FIN, q.OBS, q.KAT, q.K, a.tobo 
  from  accounts a , ACC_FIN_OBS_KAT q
 where a.acc = q.acc (+)  and a.dazs is null  
--   and not exists (select 1 from nd_acc where acc=a.acc)
   and a.nls like ('9129%') and exists ( select nls from v_rez_9129 where fin is null );

PROMPT *** Create  grants  NBU23_9129 ***
grant SELECT                                                                 on NBU23_9129      to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on NBU23_9129      to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_9129      to START1;
grant SELECT                                                                 on NBU23_9129      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_9129.sql =========*** End *** ===
PROMPT ===================================================================================== 
