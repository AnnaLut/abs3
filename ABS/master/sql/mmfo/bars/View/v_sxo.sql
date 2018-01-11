

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SXO.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SXO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SXO ("BRANCH_SXO", "NAME") AS 
  select distinct CASH_SXO.GET_SXO(b.branch) branch_sxo, b1.name
 from branch b, branch b1
 where B.DATE_CLOSED is null
   and CASH_SXO.GET_SXO(b.branch) = b1.branch
 order by 1;

PROMPT *** Create  grants  V_SXO ***
grant SELECT                                                                 on V_SXO           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SXO           to START1;
grant SELECT                                                                 on V_SXO           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SXO.sql =========*** End *** ========
PROMPT ===================================================================================== 
