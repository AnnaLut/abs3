

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_POKPO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_POKPO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_POKPO ("REF", "VALUE") AS 
  select ref, value
     from operw
   where tag='POKPO';

PROMPT *** Create  grants  V_OPER_POKPO ***
grant SELECT                                                                 on V_OPER_POKPO    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_POKPO    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_POKPO.sql =========*** End *** =
PROMPT ===================================================================================== 
