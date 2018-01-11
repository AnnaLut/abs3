

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE23.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE23 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE23 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o
 where (   substr(o.nlsa,1,4) in ( '2512', '2513', '2520', '2523', '2525', '2526', '2530', '2541', '2542', '2544', '2545', '2546',
           '2554', '2555', '2560', '2561', '2562', '2565', '2570', '2571', '2572', '2600', '2604', '2605',
           '2610', '2615', '2620', '2625', '2630', '2635', '2650', '2651', '2652', '2655', '3320', '3330', '3340', '1600')
        or substr(o.nlsb,1,4) in ( '2512', '2513', '2520', '2523', '2525', '2526', '2530', '2541', '2542', '2544', '2545', '2546',
           '2554', '2555', '2560', '2561', '2562', '2565', '2570', '2571', '2572', '2600', '2604', '2605',
           '2610', '2615', '2620', '2625', '2630', '2635', '2650', '2651', '2652', '2655', '3320', '3330', '3340', '1600') )
   and (   upper(o.nazn) like '%Բ������%'
        or upper(o.nazn) like '%��������%'
        or upper(o.nazn) like '%Բ�������%'
        or upper(o.nazn) like '%�������%'
        or upper(o.nazn) like '%�����%' )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 10000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE23 ***
grant SELECT                                                                 on V_FM_OSC_RULE23 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE23 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE23 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE23 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE23.sql =========*** End **
PROMPT ===================================================================================== 
