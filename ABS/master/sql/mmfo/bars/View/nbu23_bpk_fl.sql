

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_BPK_FL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_BPK_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_BPK_FL ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  select a.RNK,o.ND,a.mdate, 'BPK' ,to_number(a.nbs),o.FIN23,o.OBS23,o.KAT23,o.k23,a.tobo   
from BPK_ACC o, v_gl a   where o.ACC_OVR = a.acc and a.dazs is null 
 union all 
select a.RNK,o.ND,a.mdate, 'W4' ,to_number(a.nbs),o.FIN23,o.OBS23,o.KAT23,o.k23,a.tobo  
from W4_aCC o, v_gl a   where o.ACC_OVR = a.acc and a.dazs is null;

PROMPT *** Create  grants  NBU23_BPK_FL ***
grant SELECT,UPDATE                                                          on NBU23_BPK_FL    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_BPK_FL    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_BPK_FL.sql =========*** End *** =
PROMPT ===================================================================================== 
