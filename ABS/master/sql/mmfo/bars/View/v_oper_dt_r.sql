

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_DT_R.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_DT_R ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_DT_R ("REF", "VALUE") AS 
  select ref, value
     from operw
   where tag='DT_R';

PROMPT *** Create  grants  V_OPER_DT_R ***
grant SELECT                                                                 on V_OPER_DT_R     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_DT_R     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_DT_R.sql =========*** End *** ==
PROMPT ===================================================================================== 
