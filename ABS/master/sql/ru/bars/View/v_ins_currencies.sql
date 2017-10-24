

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_CURRENCIES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_CURRENCIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_CURRENCIES ("KV", "LCV", "NAME", "DESCR") AS 
  select tg.kv,
       tg.lcv,
       tg.name,
       tg.kv || ' - ' || tg.lcv || ' - ' || tg.name as descr
  from tabval$global tg
 where tg.kv in (840, 980, 978)
 order by tg.kv desc;

PROMPT *** Create  grants  V_INS_CURRENCIES ***
grant SELECT                                                                 on V_INS_CURRENCIES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_CURRENCIES.sql =========*** End *
PROMPT ===================================================================================== 
