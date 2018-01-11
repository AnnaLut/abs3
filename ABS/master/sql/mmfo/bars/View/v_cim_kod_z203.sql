

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_Z203.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_Z203 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_Z203 ("Z203", "NAME") AS 
  select ID, NAME
from CIM_CREDIT_TYPE
where delete_date is null;

PROMPT *** Create  grants  V_CIM_KOD_Z203 ***
grant SELECT                                                                 on V_CIM_KOD_Z203  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_KOD_Z203  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_KOD_Z203  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_Z203.sql =========*** End ***
PROMPT ===================================================================================== 
