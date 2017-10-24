

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_PENALTY_PARAMS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_PENALTY_PARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_PENALTY_PARAMS ("PNY_ID", "CTC_TERM", "PNY_VAL", "PNY_TP", "PRD_TP", "PRD_VAL") AS 
  select v.ID
     , v.K_SROK
     , v.K_PROC
     , v.SH_PROC
     , v.K_TERM
     , v.SH_TERM
  from BARS.DPT_STOP_A v
  join BARS.DPT_STOP p
    on ( p.ID = v.ID )
 where p.MOD_CODE Is Null
    or p.MOD_CODE = 'DPU'
;

PROMPT *** Create  grants  V_DPU_PENALTY_PARAMS ***
grant SELECT                                                                 on V_DPU_PENALTY_PARAMS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_PENALTY_PARAMS.sql =========*** E
PROMPT ===================================================================================== 
