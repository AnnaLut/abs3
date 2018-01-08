

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PACT_CUST.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PACT_CUST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PACT_CUST ("RNK") AS 
  select rnk
 from accounts asd
where     ( nls like '20%' OR
            nls like '21%'  OR
            nls like '22%'  OR
            nls like '357%') and not exists (select 1 from V_DEP_CUST where rnk = asd.rnk);

PROMPT *** Create  grants  V_PACT_CUST ***
grant SELECT                                                                 on V_PACT_CUST     to BARSREADER_ROLE;
grant SELECT                                                                 on V_PACT_CUST     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PACT_CUST     to START1;
grant SELECT                                                                 on V_PACT_CUST     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PACT_CUST.sql =========*** End *** ==
PROMPT ===================================================================================== 
