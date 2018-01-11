

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_P_BASE_T.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_P_BASE_T ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_P_BASE_T ("TERM") AS 
  select '1m' as term from dual
union all select '3m' as term from dual
union all select '6m' as term from dual
union all select '9m' as term from dual
union all select '12m' as term from dual;

PROMPT *** Create  grants  V_CIM_F503_P_BASE_T ***
grant SELECT                                                                 on V_CIM_F503_P_BASE_T to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F503_P_BASE_T to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F503_P_BASE_T to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_P_BASE_T.sql =========*** En
PROMPT ===================================================================================== 
