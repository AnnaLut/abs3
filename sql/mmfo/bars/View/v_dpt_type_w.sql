

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_TYPE_W.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_TYPE_W ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_TYPE_W ("DPT_TYPE", "DPT_NAME", "CURRENCY_CODE", "CURRENCY_NAME", "CURRENCY_ISO", "DPT_MINSUM", "DPT_INT", "DPT_ENDDATE", "DPT_MONTHS", "DPT_DAYS", "DPT_CAP") AS 
  select
    v.vidd                                                  dpt_type,
    v.type_name                                             dpt_name,
    v.kv                                                    currency_code,
    t.name                                                  currency_name,
    t.lcv                                                   currency_iso,
    v.min_summ                                              dpt_minsum,
    getbrat(bankdate, v.br_id, v.kv, 0)	                    dpt_int,
    dpt.f_duration(bankdate, v.duration, v.duration_days)	dpt_enddate,
    v.duration                                              dpt_months,
    v.duration_days                                         dpt_days,
    v.comproc                                               dpt_cap
from
    dpt_vidd v,
    tabval t
where
    v.kv = t.kv
and v.flag = 1
 ;

PROMPT *** Create  grants  V_DPT_TYPE_W ***
grant SELECT                                                                 on V_DPT_TYPE_W    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_TYPE_W    to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_TYPE_W    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_TYPE_W.sql =========*** End *** =
PROMPT ===================================================================================== 
