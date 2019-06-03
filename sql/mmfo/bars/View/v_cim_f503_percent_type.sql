

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_PERCENT_TYPE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_PERCENT_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_PERCENT_TYPE ("ID", "NAME") AS 
  select id, name from CIM_CREDIT_PERCENT where D_CLOSE is null;

PROMPT *** Create  grants  V_CIM_F503_PERCENT_TYPE ***
grant SELECT                                                                 on V_CIM_F503_PERCENT_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F503_PERCENT_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F503_PERCENT_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_PERCENT_TYPE.sql =========**
PROMPT ===================================================================================== 
