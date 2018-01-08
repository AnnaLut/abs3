

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIN_REP_FM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIN_REP_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIN_REP_FM ("FM", "NAME") AS 
  Select 'P' fm, 'ф.№1 та ф.№2– великого або середнього підприємства  ' name from dual
union all Select 'M' fm, 'ф.№1М та ф.№2М– малого підприємства  '                  name from dual
union all Select 'C' fm, 'ф.№1МС та ф.№2МС– малого підприємства  '                name from dual
;

PROMPT *** Create  grants  V_FIN_REP_FM ***
grant SELECT                                                                 on V_FIN_REP_FM    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIN_REP_FM.sql =========*** End *** =
PROMPT ===================================================================================== 
