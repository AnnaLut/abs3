

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE1 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o
 where (   substr(nlsa,1,4) in ('2520', '2560', '2570', '2600', '2601', '2602',
           '2604', '2605', '2606', '2610', '2611', '2615', '2620', '2622',
           '2625', '2630', '2635', '2640', '2641', '2642', '2643', '2650',
           '2651', '2652', '2655')
        or substr(nlsa,1,4) = '2603' and kv = 980
        or substr(nlsb,1,4) in ('2520', '2560', '2570', '2600', '2601', '2602',
           '2604', '2605', '2606', '2610', '2611', '2615', '2620', '2622',
           '2625', '2630', '2635', '2640', '2641', '2642', '2643', '2650',
           '2651', '2652', '2655')
        or substr(nlsb,1,4) = '2603' and kv2 = 980 )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE1 ***
grant SELECT                                                                 on V_FM_OSC_RULE1  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE1  to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE1  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE1.sql =========*** End ***
PROMPT ===================================================================================== 
