

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_OVER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_OVER ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_OVER ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  select a.RNK,a.acc,a.mdate,a.nls,to_number(a.nbs),q.FIN23, q.OBS23, q.KAT23, q.K23, a.tobo
  from  v_gl a , ACC_OVER q
 where  a.acc=q.acco (+)  and a.dazs is null
  and a.dazs is null  ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_OVER.sql =========*** End *** ===
PROMPT ===================================================================================== 
