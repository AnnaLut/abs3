

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_PENALTY_DETAILS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_PENALTY_DETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_PENALTY_DETAILS ("PNY_ID", "PNY_LWR_LMT", "PNY_UPR_LMT", "PNY_VAL", "PNY_TP_ID", "PNY_TP_NM", "PNY_PRD_TP_ID", "PNY_PRD_TP_NM", "PNY_PRD_VAL") AS 
  select v.PNY_ID
     , v.PNY_LWR_LMT
     , v.PNY_UPR_LMT
     , v.PNY_VAL
     , v.PNY_TP
     , t.NAME
     , v.PNY_PRD_TP
     , p.NAME
     , v.PNY_PRD_VAL
  from ( select ID      as PNY_ID
              , K_SROK  as PNY_LWR_LMT
              , lead(K_SROK) over ( partition by ID order by K_SROK) as PNY_UPR_LMT
              , K_PROC  as PNY_VAL
              , SH_PROC as PNY_TP
              , k_term  as PNY_PRD_VAL
              , sh_term as PNY_PRD_TP
           from DPT_STOP_A
       ) v
  left
  join BARS.DPT_SHTYPE t
    on ( t.ID = v.PNY_TP )
  left
  join BARS.DPT_SHTERM p
    on ( p.ID = v.PNY_PRD_TP )
--  join BARS.DPT_STOP p
--    on ( p.ID = v.ID )
 where v.PNY_UPR_LMT > 0
-- and ( p.MOD_CODE Is Null or p.MOD_CODE = 'DPU' )
;

PROMPT *** Create  grants  V_DPU_PENALTY_DETAILS ***
grant SELECT                                                                 on V_DPU_PENALTY_DETAILS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_PENALTY_DETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_PENALTY_DETAILS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_PENALTY_DETAILS.sql =========*** 
PROMPT ===================================================================================== 
