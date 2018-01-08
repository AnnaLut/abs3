

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_KODPL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_KODPL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_KODPL ("REF", "VALUE") AS 
  select ref, value
     from operw
   where tag='KODPL';

PROMPT *** Create  grants  V_OPER_KODPL ***
grant SELECT                                                                 on V_OPER_KODPL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_KODPL    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_KODPL.sql =========*** End *** =
PROMPT ===================================================================================== 
