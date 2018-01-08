

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_TARIFFS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_TARIFFS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_TARIFFS ("TARIFF_ID", "NAME", "MIN_VALUE", "MIN_PERC", "MAX_VALUE", "MAX_PERC", "AMORT", "PER_CNT") AS 
  select t.id as tariff_id,
       t.name,
       t.min_value,
       t.min_perc,
       t.max_value,
       t.max_perc,
       t.amort,
       (select count(*) from ins_tariff_periods tp where tp.tariff_id = t.id) as per_cnt
  from ins_tariffs t
 order by t.id;

PROMPT *** Create  grants  V_INS_TARIFFS ***
grant SELECT                                                                 on V_INS_TARIFFS   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_TARIFFS.sql =========*** End *** 
PROMPT ===================================================================================== 
