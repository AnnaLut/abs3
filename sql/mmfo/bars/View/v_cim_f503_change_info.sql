

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_CHANGE_INFO.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_CHANGE_INFO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_CHANGE_INFO ("ID", "INFO") AS 
  select '1' as id, '1 - без змін' as info from dual
union all select '2' as id, '2 - зміна строковості' as info from dual
union all select '3' as id, '3 - зміна типу кредитора' as info from dual
union all select '4' as id, '4 - переведення боргу з первісного на нового боржника' as info from dual
union all select '5' as id, '5 - перехід клієнта з іншого обслуговуючого банку' as info from dual
union all select '6' as id, '6 - анулювання реєстраційного свідоцтва' as info from dual
union all select '7' as id, '7 - інше' as info from dual;

PROMPT *** Create  grants  V_CIM_F503_CHANGE_INFO ***
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_CHANGE_INFO.sql =========***
PROMPT ===================================================================================== 
