

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_OVR_FL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_OVR_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_OVR_FL ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  select a.RNK,o.ND,a.mdate,o.ndoc,to_number(a.nbs),o.FIN23,o.OBS23,o.KAT23,o.k23,a.tobo  
  from acc_over o, v_gl a, customer c   
  where o.acc=a.acc and a.rnk=c.rnk  and c.custtype = 3;

PROMPT *** Create  grants  NBU23_OVR_FL ***
grant SELECT,UPDATE                                                          on NBU23_OVR_FL    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_OVR_FL    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_OVR_FL.sql =========*** End *** =
PROMPT ===================================================================================== 
