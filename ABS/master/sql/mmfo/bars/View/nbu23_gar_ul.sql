

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_GAR_UL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_GAR_UL ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_GAR_UL ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO") AS 
  select d.RNK,d.ND,d.WDATE,d.CC_ID,d.vidd,d.FIN23,d.OBS23,d.KAT23,d.k23,d.branch  
  from cc_deal d where d.sos>9 and d.sos<15  and d.vidd in (9,19,29,39)
  and exists (select 1 from customer where rnk= d.rnk and custtype = 2);

PROMPT *** Create  grants  NBU23_GAR_UL ***
grant SELECT                                                                 on NBU23_GAR_UL    to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on NBU23_GAR_UL    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_GAR_UL    to START1;
grant SELECT                                                                 on NBU23_GAR_UL    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_GAR_UL.sql =========*** End *** =
PROMPT ===================================================================================== 
