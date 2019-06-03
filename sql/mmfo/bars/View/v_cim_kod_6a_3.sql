

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_6A_3.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_6A_3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_6A_3 ("P3200", "NAME") AS 
  select ID, NAME from cim_credit_reorganization
  where d_close is null;

comment on table V_CIM_KOD_6A_3 is 'Код типу реорганізації(F070)';

PROMPT *** Create  grants  V_CIM_KOD_6A_3 ***
grant SELECT                                                                 on V_CIM_KOD_6A_3  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_6A_3.sql =========*** End ***
PROMPT ===================================================================================== 
