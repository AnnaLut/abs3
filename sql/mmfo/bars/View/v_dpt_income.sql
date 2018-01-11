

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_INCOME.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_INCOME ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_INCOME ("ATTR_INCOME", "NAME_INCOME") AS 
  select r.attr_income, m.short_name
  from DPT_INCOME_TAX_RATE r,
       ATTRIBUTE_INCOME    m
 where r.attr_income = m.attr_income;

PROMPT *** Create  grants  V_DPT_INCOME ***
grant SELECT                                                                 on V_DPT_INCOME    to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_INCOME    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_INCOME    to DPT_ROLE;
grant SELECT                                                                 on V_DPT_INCOME    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_INCOME.sql =========*** End *** =
PROMPT ===================================================================================== 
