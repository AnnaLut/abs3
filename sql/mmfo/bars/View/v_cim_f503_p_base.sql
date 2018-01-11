

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_P_BASE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_P_BASE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_P_BASE ("BASE") AS 
  select 'libor' as base from dual
union all select 'euribor' as base from dual
union all select 'wibor' as base from dual;

PROMPT *** Create  grants  V_CIM_F503_P_BASE ***
grant SELECT                                                                 on V_CIM_F503_P_BASE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F503_P_BASE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F503_P_BASE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_P_BASE.sql =========*** End 
PROMPT ===================================================================================== 
