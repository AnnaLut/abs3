

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_P_BASE_VAL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_P_BASE_VAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_P_BASE_VAL ("VAL") AS 
  select 'USD' as val from dual
union all select 'EUR' as val from dual
union all select 'GBP' as val from dual
union all select 'JPY' as val from dual
union all select 'CHF' as val from dual
union all select 'PLN' as val from dual;

PROMPT *** Create  grants  V_CIM_F503_P_BASE_VAL ***
grant SELECT                                                                 on V_CIM_F503_P_BASE_VAL to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F503_P_BASE_VAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F503_P_BASE_VAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_P_BASE_VAL.sql =========*** 
PROMPT ===================================================================================== 
