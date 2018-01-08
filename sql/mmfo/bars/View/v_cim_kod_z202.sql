

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_Z202.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_Z202 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_Z202 ("Z202", "NAME") AS 
  select ID, NAME from CIM_CREDIT_PERIOD
where id between 1 and 6;

PROMPT *** Create  grants  V_CIM_KOD_Z202 ***
grant SELECT                                                                 on V_CIM_KOD_Z202  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_KOD_Z202  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_KOD_Z202  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_Z202.sql =========*** End ***
PROMPT ===================================================================================== 
