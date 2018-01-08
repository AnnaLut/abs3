

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_PNY_MSR_PRD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_PNY_MSR_PRD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_PNY_MSR_PRD ("MSR_PRD_ID", "MSR_PRD_NM") AS 
  select ID
     , NAME
  from DPT_SHSROK
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_PNY_MSR_PRD.sql =========*** End 
PROMPT ===================================================================================== 
