

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_DEPARTMENT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_DEPARTMENT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_DEPARTMENT ("REF") AS 
  select o.ref
  from oper o
 where o.branch like sys_context('bars_context','user_branch_mask');

PROMPT *** Create  grants  V_OPER_DEPARTMENT ***
grant SELECT                                                                 on V_OPER_DEPARTMENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_DEPARTMENT to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OPER_DEPARTMENT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_DEPARTMENT.sql =========*** End 
PROMPT ===================================================================================== 
