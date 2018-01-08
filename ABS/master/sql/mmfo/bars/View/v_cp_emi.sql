

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_EMI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_EMI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_EMI ("RNK", "NAME", "KOL", "CUSTTYPE") AS 
  select k.rnk, c.nmk, k.kol, c.custtype 
from (select rnk, count (*) kol from cp_kod where rnk is NOT  null group by rnk ) k, customer c
where k.rnk = c.rnk;

PROMPT *** Create  grants  V_CP_EMI ***
grant SELECT                                                                 on V_CP_EMI        to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_EMI        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_EMI        to START1;
grant SELECT                                                                 on V_CP_EMI        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_EMI.sql =========*** End *** =====
PROMPT ===================================================================================== 
