

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_CREDIT_F503_PURPOSE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_CREDIT_F503_PURPOSE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_CREDIT_F503_PURPOSE ("ID", "NAME") AS 
  select ID, NAME
from CIM_CREDIT_F503_PURPOSE
where d_close is null;

PROMPT *** Create  grants  V_CIM_CREDIT_F503_PURPOSE ***
grant SELECT                                                                 on V_CIM_CREDIT_F503_PURPOSE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_CREDIT_F503_PURPOSE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_CREDIT_F503_PURPOSE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_CREDIT_F503_PURPOSE.sql =========
PROMPT ===================================================================================== 
