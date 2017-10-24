

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE15.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE15 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE15 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, opldok p, accounts a
 where o.ref = p.ref
   and p.acc = a.acc
   and a.nbs in ('2512', '2513', '2520', '2523', '2525', '2526', '2530',
       '2541', '2542', '2544', '2545', '2546', '2554', '2555', '2560',
       '2561', '2562', '2565', '2570', '2571', '2572', '2600', '2604',
       '2605', '2610', '2615', '2620', '2625', '2630', '2635', '2650',
       '2651', '2652', '2655', '3320', '3330', '3340', '1600')
   and (upper(o.nazn) like '%ÂÅÊÑ%'
     or upper(o.nazn) like '%ÖÁ%'
     or upper(o.nazn) like '%ÖÏ%'
     or upper(o.nazn) like '%ÖÅÍÍÛÅ%ÁÓÌÀÃÈ%'
     or upper(o.nazn) like '%Ö²ÍÍ²%ÏÀÏÅÐÈ%'
     or upper(o.nazn) like '%ÀÊÖÈÈ%'
     or upper(o.nazn) like '%ÀÊÖ²¯%'
     or upper(o.nazn) like '%ÎÁË²ÃÀÖ²¯%'
     or upper(o.nazn) like '%ÎÁËÈÃÀÖÈÈ%'
     or upper(o.nazn) like '%ÑÅÐÒÈÔ%'
     or upper(o.nazn) like '%ÊÀÇÍÀ×%')
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE15 ***
grant SELECT                                                                 on V_FM_OSC_RULE15 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE15 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE15 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE15.sql =========*** End **
PROMPT ===================================================================================== 
