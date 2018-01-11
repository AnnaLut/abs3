

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE3.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE3 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, opldok p, accounts a, customer c
 where o.ref = p.ref
   and p.acc = a.acc
   and a.rnk = c.rnk
   -- клиенты-ЮЛ/ФЛ-предприниматели
   and (c.custtype = 2 or c.custtype = 3 and nvl(trim(c.sed),'00') = '91')
   -- дата проведення операції знаходиться в межах 90 днів від дати реєстрації особи в держадміністрації
   and p.fdat between c.datea and c.datea+92
   -- счета клиента
   and (   a.nbs in ('2520', '2560', '2570', '2600', '2604', '2605', '2650', '2655')
        or a.nbs = '2603' and a.kv = 980
        or a.nls like '264%' )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE3 ***
grant SELECT                                                                 on V_FM_OSC_RULE3  to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_OSC_RULE3  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE3  to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE3  to START1;
grant SELECT                                                                 on V_FM_OSC_RULE3  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE3.sql =========*** End ***
PROMPT ===================================================================================== 
