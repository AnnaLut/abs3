

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_PNY_MSR_PRD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_PNY_MSR_PRD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_PNY_MSR_PRD ("MSR_PRD_ID", "MSR_PRD_NM") AS 
  select ID
     , NAME
  from DPT_SHSROK
;

PROMPT *** Create  grants  V_DPU_PNY_MSR_PRD ***
grant SELECT                                                                 on V_DPU_PNY_MSR_PRD to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_PNY_MSR_PRD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_PNY_MSR_PRD.sql =========*** End 
PROMPT ===================================================================================== 
