

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE7.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE7 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE7 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o
 where (   substr(o.nlsa,1,4) in ('2801', '2805', '2901', '2905', '2907')
        or substr(o.nlsa,1,3) = '202'
        or substr(o.nlsb,1,4) in ('2801', '2805', '2901', '2905', '2907')
        or substr(o.nlsb,1,3) = '202' )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000;

PROMPT *** Create  grants  V_FM_OSC_RULE7 ***
grant SELECT                                                                 on V_FM_OSC_RULE7  to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE7  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE7  to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE7  to START1;
grant SELECT                                                                 on V_FM_OSC_RULE7  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE7.sql =========*** End ***
PROMPT ===================================================================================== 
