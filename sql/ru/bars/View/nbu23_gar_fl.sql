

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_GAR_FL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_GAR_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_GAR_FL ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  select  RNK,d.ND,d.WDATE,d.CC_ID,d.vidd,d.FIN23,d.OBS23,d.KAT23,d.k23,d.branch
  from cc_deal d
where d.sos>9 and d.sos<15 and d.vidd in (9,19,29,39)
  and exists (select 1 from customer where rnk= d.rnk and custtype = 3);

PROMPT *** Create  grants  NBU23_GAR_FL ***
grant SELECT,UPDATE                                                          on NBU23_GAR_FL    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_GAR_FL    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_GAR_FL.sql =========*** End *** =
PROMPT ===================================================================================== 
