

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_PENALTIES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_PENALTIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_PENALTIES ("PENALTY_ID", "PENALTY_NM", "MSR_PRD_ID", "PNY_BAL_TP", "RUTHLESS", "DIF_PNY_TP", "DIF_TERM_TP", "PNY_TP_ID", "TERM_TP_ID", "MODULE_CODE") AS 
  SELECT p.ID
     , p.NAME
     , p.FL
     , p.SH_OST
     , p.SH_PROC
     , case when nvl(cb.PNY_TP_QTY,0) >= 1 then 1 else 0 end
     , case when nvl(cb.TERM_TP_QTY,0) > 1 then 1 else 0 end
     , cb.PNY_TP_ID
     , cb.TERM_TP_ID
     , p.MOD_CODE
  from BARS.DPT_STOP p
  left
  join ( select ID
              , count(unique SH_PROC) as PNY_TP_QTY
              , count(unique SH_TERM) as TERM_TP_QTY
              , min(SH_PROC)          as PNY_TP_ID
              , min(SH_TERM)          as TERM_TP_ID
           from BARS.DPT_STOP_A
          where SH_PROC != 0
          group by ID
       ) cb
    on ( cb.ID = p.ID )
 where p.MOD_CODE Is Null
    or p.MOD_CODE = 'DPU'
;

PROMPT *** Create  grants  V_DPU_PENALTIES ***
grant SELECT                                                                 on V_DPU_PENALTIES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_PENALTIES.sql =========*** End **
PROMPT ===================================================================================== 
