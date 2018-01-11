

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_FIO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_FIO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_FIO ("REF", "VALUE") AS 
  select  ref, value
     from operw
   where tag= 'FIO';

PROMPT *** Create  grants  V_OPER_FIO ***
grant SELECT                                                                 on V_OPER_FIO      to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPER_FIO      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_FIO      to START1;
grant SELECT                                                                 on V_OPER_FIO      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_FIO.sql =========*** End *** ===
PROMPT ===================================================================================== 
