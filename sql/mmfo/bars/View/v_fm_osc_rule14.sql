

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE14.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE14 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE14 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, opldok p1, opldok p2, accounts a1, accounts a2
 where o.ref = p1.ref and p1.acc = a1.acc and p1.dk = 0
   and o.ref = p2.ref and p2.acc = a2.acc and p2.dk = 1
   and (   (    a1.nbs in ('1011', '1012', '1013')
            and (   a2.nbs in ('2560', '2570', '2600', '2601', '2602',
                    '2604', '2605', '2606', '2610', '2611', '2615', '2620', '2622',
                    '2625', '2630', '2635', '2640', '2641', '2642', '2643', '2650',
                    '2651', '2652', '2655')
                 or a2.nbs = '2603' and a2.kv = 980 ) )
        or (    a2.nbs in ('1001', '1002')
            and (   a1.nbs in ('2560', '2570', '2600', '2601', '2602',
                    '2604', '2605', '2606', '2610', '2611', '2615', '2620', '2622',
                    '2625', '2630', '2635', '2640', '2641', '2642', '2643', '2650',
                    '2651', '2652', '2655')
                 or a1.nbs = '2603' and a1.kv = 980 ) ) )
   and upper(o.nazn) like '%вей%'
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE14 ***
grant SELECT                                                                 on V_FM_OSC_RULE14 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE14 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE14 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE14 to START1;
grant SELECT                                                                 on V_FM_OSC_RULE14 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE14.sql =========*** End **
PROMPT ===================================================================================== 
