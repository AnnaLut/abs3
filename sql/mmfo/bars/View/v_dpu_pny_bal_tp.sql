

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_PNY_BAL_TP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_PNY_BAL_TP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_PNY_BAL_TP ("BAL_TP_ID", "BAL_TP_NM") AS 
  select ID
     , NAME
  from DPT_SHOST
;

PROMPT *** Create  grants  V_DPU_PNY_BAL_TP ***
grant SELECT                                                                 on V_DPU_PNY_BAL_TP to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_PNY_BAL_TP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_PNY_BAL_TP.sql =========*** End *
PROMPT ===================================================================================== 
