

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_CHANGE_INFO.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_CHANGE_INFO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_CHANGE_INFO ("ID", "INFO") AS 
  select f049 as id, txt as info from f049 where d_close is null;

PROMPT *** Create  grants  V_CIM_F503_CHANGE_INFO ***
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_CHANGE_INFO.sql =========***
PROMPT ===================================================================================== 
