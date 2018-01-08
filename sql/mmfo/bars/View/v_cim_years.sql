

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_YEARS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_YEARS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_YEARS ("YYYY") AS 
  select to_char(bankdate,'YYYY')+level-1 from dual connect by level < 50;

PROMPT *** Create  grants  V_CIM_YEARS ***
grant SELECT                                                                 on V_CIM_YEARS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_YEARS.sql =========*** End *** ==
PROMPT ===================================================================================== 
