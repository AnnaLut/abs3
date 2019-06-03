

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_34_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_34_1 ("ID", "NAME") AS 
  select f045 as id, txt as name from f045 where d_close is null
;

PROMPT *** Create  grants  V_CIM_KOD_34_1 ***
grant SELECT                                                                 on V_CIM_KOD_34_1  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_KOD_34_1  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_KOD_34_1  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_1.sql =========*** End ***
PROMPT ===================================================================================== 
