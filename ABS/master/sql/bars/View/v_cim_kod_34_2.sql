

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_34_2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_34_2 ("ID", "NAME") AS 
  select ID, NAME from cim_credit_state_calc where delete_date is null
  order by id;
;

PROMPT *** Create  grants  V_CIM_KOD_34_2 ***
grant SELECT                                                                 on V_CIM_KOD_34_2  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_2.sql =========*** End ***
PROMPT ===================================================================================== 
