

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_LIMITS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_LIMITS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_LIMITS ("LIMIT_ID", "NAME", "SUM_VALUE", "PERC_VALUE") AS 
  select l.id as limit_id, l.name, l.sum_value, l.perc_value
  from ins_limits l
 order by l.id;

PROMPT *** Create  grants  V_INS_LIMITS ***
grant SELECT                                                                 on V_INS_LIMITS    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_LIMITS.sql =========*** End *** =
PROMPT ===================================================================================== 
