

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_VIDD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_VIDD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_VIDD ("VIDD_ID", "VIDD_NM", "VIDD_CODE", "TYPE_ID", "TYPE_NM", "CCY_ID", "CCY_CODE", "SROK", "R020_DEP", "R020_INT", "BR_ID", "BR_NM", "FREQ_ID", "FREQ_NM", "COMPROC", "AMNT_MIN", "AMNT_MAX", "AMNT_ADD", "REPLENISHABLE", "STOP_ID", "STOP_NM", "PROLONGABLE", "TEMPLATE_ID", "COMMENTS", "IS_LINE", "IS_ACTIVE", "IRREVOCABLE", "DPU_TYPE", "TERM_TP", "TERM_MIN_MO", "TERM_MIN_DY", "TERM_MAX_MO", "TERM_MAX_DY", "TERM_ADD", "SEGMENT", "DEAL_QTY") AS 
  select DPU_VIDD.VIDD
     , DPU_VIDD.NAME
     , DPU_VIDD.DPU_CODE
     , DPU_VIDD.TYPE_ID
     , DPU_TYPES.TYPE_NAME
     , DPU_VIDD.KV
     , TABVAL$GLOBAL.LCV
     , DPU_VIDD.SROK
     , DPU_VIDD.BSD
     , DPU_VIDD.BSN
     , BRATES.BR_ID
     , BRATES.NAME
     , FREQ.FREQ
     , FREQ.NAME
     , DPU_VIDD.COMPROC
     , DPU_VIDD.MIN_SUMM/100
     , DPU_VIDD.MAX_SUMM/100
     , LIMIT/100
     , nvl(DPU_VIDD.FL_ADD,0)
     , DPT_STOP.ID
     , DPT_STOP.NAME
     , DPU_VIDD.FL_AUTOEXTEND
     , DPU_VIDD.SHABLON
     , DPU_VIDD.COMMENTS
     , sign(DPU_VIDD.FL_EXTEND)
     , nvl(DPU_VIDD.FLAG,0)
     , DPU_VIDD.IRREVOCABLE
     , DPU_VIDD.DPU_TYPE
     , DPU_VIDD.TERM_TYPE
     , trunc(DPU_VIDD.TERM_MIN) as TERM_MIN_MO
     , (DPU_VIDD.TERM_MIN - trunc(DPU_VIDD.TERM_MIN))*10000 as TERM_MIN_DY
     , trunc(DPU_VIDD.TERM_MAX) as TERM_MAX_MO
     , (DPU_VIDD.TERM_MAX - trunc(DPU_VIDD.TERM_MAX))*10000 as TERM_MAX_DY
     , DPU_VIDD.TERM_ADD
     , 0 as SEGMENT
     , q.QTY
  from BARS.DPU_VIDD
  join BARS.DPU_TYPES
    on ( DPU_TYPES.TYPE_ID = DPU_VIDD.TYPE_ID )
  join BARS.TABVAL$GLOBAL
    on ( TABVAL$GLOBAL.KV = DPU_VIDD.KV )
  join BARS.DPT_STOP
    on ( DPT_STOP.ID = DPU_VIDD.ID_STOP )
  join BARS.FREQ
    on ( FREQ.FREQ = DPU_VIDD.FREQ_V )
  left
  join BARS.BRATES
    on ( BRATES.BR_ID = DPU_VIDD.BR_ID )
  left
  join ( select VIDD, count(DPU_ID) as QTY
           from DPU_DEAL
          where CLOSED = 0
          group by VIDD
       ) q
    on ( q.VIDD = DPU_VIDD.VIDD )
;

PROMPT *** Create  grants  V_DPU_VIDD ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPU_VIDD      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPU_VIDD      to DPT_ADMIN;
grant SELECT                                                                 on V_DPU_VIDD      to DPT_ROLE;
grant SELECT                                                                 on V_DPU_VIDD      to START1;
grant FLASHBACK,SELECT                                                       on V_DPU_VIDD      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_VIDD.sql =========*** End *** ===
PROMPT ===================================================================================== 
