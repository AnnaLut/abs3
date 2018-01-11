

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPERW_PASPN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPERW_PASPN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPERW_PASPN ("REF", "VALUE") AS 
  select ref, value
    from operw
  where tag='PASPN';

PROMPT *** Create  grants  V_OPERW_PASPN ***
grant SELECT                                                                 on V_OPERW_PASPN   to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_OPERW_PASPN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPERW_PASPN   to START1;
grant SELECT                                                                 on V_OPERW_PASPN   to UPLD;
grant FLASHBACK,SELECT                                                       on V_OPERW_PASPN   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPERW_PASPN.sql =========*** End *** 
PROMPT ===================================================================================== 
