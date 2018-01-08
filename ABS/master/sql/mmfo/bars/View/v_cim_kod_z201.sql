

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_Z201.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_Z201 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_Z201 ("Z201", "NAME") AS 
  select ID, NAME from CIM_CREDIT_PREPAY;

PROMPT *** Create  grants  V_CIM_KOD_Z201 ***
grant SELECT                                                                 on V_CIM_KOD_Z201  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_Z201.sql =========*** End ***
PROMPT ===================================================================================== 
