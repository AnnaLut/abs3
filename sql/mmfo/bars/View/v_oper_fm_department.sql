

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_FM_DEPARTMENT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_FM_DEPARTMENT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_FM_DEPARTMENT ("REF") AS 
  select o.ref
  from oper o
 where o.userid in (select userid from otd_user where otd in (select otd from otd_user where userid=user_id));

PROMPT *** Create  grants  V_OPER_FM_DEPARTMENT ***
grant SELECT                                                                 on V_OPER_FM_DEPARTMENT to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPER_FM_DEPARTMENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_FM_DEPARTMENT to START1;
grant SELECT                                                                 on V_OPER_FM_DEPARTMENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_FM_DEPARTMENT.sql =========*** E
PROMPT ===================================================================================== 
