

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ROZNICABUSINESS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ROZNICABUSINESS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ROZNICABUSINESS ("ID", "NAME") AS 
  SELECT DISTINCT to_number(id,'999'),
                     name
       FROM   ROZNICABUSINESS
   ORDER BY   to_number(id,'999');

PROMPT *** Create  grants  V_ROZNICABUSINESS ***
grant SELECT                                                                 on V_ROZNICABUSINESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ROZNICABUSINESS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ROZNICABUSINESS.sql =========*** End 
PROMPT ===================================================================================== 
