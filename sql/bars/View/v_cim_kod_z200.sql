

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_Z200.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_Z200 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_Z200 ("Z200", "NAME") AS 
  select ID, NAME from cim_creditor_type
where delete_date is null;

PROMPT *** Create  grants  V_CIM_KOD_Z200 ***
grant SELECT                                                                 on V_CIM_KOD_Z200  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_Z200.sql =========*** End ***
PROMPT ===================================================================================== 
