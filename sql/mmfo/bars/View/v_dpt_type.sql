

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_TYPE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_TYPE ("DPT_TYPE", "DPT_NAME", "CURRENCY_CODE", "CURRENCY_NAME", "CURRENCY_ISO", "CURRENCY_DENOM", "DPT_MINSUM", "DPT_BRATEID", "DPT_INT", "DPT_ENDDATE", "DPT_MONTHS", "DPT_DAYS", "DPT_MONTHS_MAX", "DPT_DAYS_MAX", "DPT_TERM_TYPE", "DPT_CAP", "IS_ACTIVE", "IS_CASH") AS 
  select v.vidd,
       v.type_name,
       v.kv,
       t.name,
       t.lcv,
       t.denom,
       v.min_summ,
       v.br_id,
       getbrat(sysdate, v.br_id, v.kv, 0) as dpt_int,
       dpt.get_datend_uni (sysdate, v.duration, v.duration_days, v.vidd) dpt_enddate,
       v.duration,
       v.duration_days,
       v.duration_max,
       v.duration_days_max,
       v.term_type,
       v.comproc,
       v.flag,
       nvl2(f.tag, 0, 1)
  from DPT_VIDD v
 inner join TABVAL t on ( t.kv = v.kv )
  left join DPT_VIDD_FIELD f on ( f.vidd = v.vidd And f.tag = 'NCASH' );

PROMPT *** Create  grants  V_DPT_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_TYPE      to ABS_ADMIN;
grant SELECT                                                                 on V_DPT_TYPE      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_TYPE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_TYPE      to DPT;
grant SELECT                                                                 on V_DPT_TYPE      to DPT_ROLE;
grant SELECT                                                                 on V_DPT_TYPE      to START1;
grant SELECT                                                                 on V_DPT_TYPE      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_TYPE      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_TYPE.sql =========*** End *** ===
PROMPT ===================================================================================== 
