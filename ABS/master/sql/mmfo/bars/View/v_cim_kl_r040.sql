

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KL_R040.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KL_R040 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KL_R040 ("COUNTRY", "NAME") AS 
  select lpad(c.country,3,'0') country, c.name from country c;

PROMPT *** Create  grants  V_CIM_KL_R040 ***
grant SELECT                                                                 on V_CIM_KL_R040   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KL_R040.sql =========*** End *** 
PROMPT ===================================================================================== 
