

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_51_1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_51_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_51_1 ("P102", "NAME") AS 
  select ID,NAME from CIM_CREDIT_BORROWER where delete_date is null;

PROMPT *** Create  grants  V_CIM_KOD_51_1 ***
grant SELECT                                                                 on V_CIM_KOD_51_1  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_KOD_51_1  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_KOD_51_1  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_51_1.sql =========*** End ***
PROMPT ===================================================================================== 
