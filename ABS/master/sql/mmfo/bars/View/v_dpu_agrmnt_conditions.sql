

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_AGRMNT_CONDITIONS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_AGRMNT_CONDITIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_AGRMNT_CONDITIONS ("DPU_ID", "RNK", "ND", "FREQV", "COMPROC", "STOP_ID", "AGRMNT_NEXT_NUM", "AGRMNT_NEXT_END_DATE", "KV", "FL_AUTOEXTEND", "TERM_TYPE", "MIN_AMNT", "MAX_AMNT", "DAT_END_MIN", "DAT_END_MAX") AS 
  select d.DPU_ID
     , d.RNK
     , nvl2(d.DPU_GEN,(select ND from DPU_DEAL where DPU_ID = d.DPU_GEN),d.ND) as ND
     , d.FREQV
     , d.COMPROC
     , d.ID_STOP as STOP_ID
     , ( select count(1) + 1
           from DPU_AGREEMENTS a
          where a.DPU_ID = d.DPU_ID
       ) as AGRMNT_NEXT_NUM
     , DPU_AGR.GET_NEXT_END_DATE(d.DPU_ID) AGRMNT_NEXT_END_DATE
     , v.KV
     , v.FL_AUTOEXTEND
     , v.TERM_TYPE
     , greatest(d.MIN_SUM,v.MIN_SUMM) as MIN_AMNT
     , v.MAX_SUMM as MAX_AMNT
     , DPU.F_DURATION(d.DAT_BEGIN,trunc(v.TERM_MIN),(v.TERM_MIN - trunc(v.TERM_MIN))*10000) as DAT_END_MIN
     , DPU.F_DURATION(d.DAT_BEGIN,trunc(v.TERM_MAX),(v.TERM_MAX - trunc(v.TERM_MAX))*10000) as DAT_END_MAX
  from DPU_DEAL d
  join DPU_VIDD v
    on ( v.VIDD = d.VIDD )
 where d.CLOSED = 0;

PROMPT *** Create  grants  V_DPU_AGRMNT_CONDITIONS ***
grant SELECT                                                                 on V_DPU_AGRMNT_CONDITIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_AGRMNT_CONDITIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_AGRMNT_CONDITIONS.sql =========**
PROMPT ===================================================================================== 