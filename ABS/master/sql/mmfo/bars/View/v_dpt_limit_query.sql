

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_LIMIT_QUERY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_LIMIT_QUERY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_LIMIT_QUERY ("LIMIT_ID", "OPERDATE", "CURRENCY", "ACCOUNT", "SUMA", "BLOCK", "DEPOSIT_ID", "DAT_BEGIN", "DAT_END", "VIDD", "TYPE_NAME", "RNK", "NMK", "ACC", "OSTC", "NMS", "CURRENT_LIM") AS 
  select
    l.limit_id,
    l.operdate,
    l.currency,
    l.account,
    l.suma,
    l.block,
    d.deposit_id,
    d.dat_begin,
    d.dat_end,
    v.vidd,
    v.type_name,
    c.rnk,
    c.nmk,
    a.acc,
    a.ostc,
    a.nms,
    a.lim
from dpt_limit_query l, dpt_deposit d, accounts a, customer c, dpt_vidd v
where l.currency = a.kv
  and l.account = a.nls
  and a.acc = d.acc
  and d.rnk = c.rnk
  and d.vidd = v.vidd;

PROMPT *** Create  grants  V_DPT_LIMIT_QUERY ***
grant SELECT                                                                 on V_DPT_LIMIT_QUERY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_LIMIT_QUERY to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_LIMIT_QUERY.sql =========*** End 
PROMPT ===================================================================================== 
