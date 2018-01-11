

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ALEGRO_CH1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ALEGRO_CH1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ALEGRO_CH1 ("NUM", "NAMEUKRB") AS 
  (select t1.num, t1.nameukrb
      from alegro_ch1 t1
     where t1.mfo = f_ourmfo);

PROMPT *** Create  grants  V_ALEGRO_CH1 ***
grant SELECT                                                                 on V_ALEGRO_CH1    to BARSREADER_ROLE;
grant SELECT                                                                 on V_ALEGRO_CH1    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ALEGRO_CH1    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ALEGRO_CH1.sql =========*** End *** =
PROMPT ===================================================================================== 
