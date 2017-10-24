

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE4.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE4 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE4 ("REF", "VDAT") AS 
  select p.ref, o.vdat
  from oper o, opldok p, accounts a, customer c
 where o.ref = p.ref
   and p.acc = a.acc
   and a.rnk = c.rnk
   -- клиенты-ЮЛ/ФЛ-предприниматели
   and (c.custtype = 2 or c.custtype = 3 and nvl(trim(c.sed),'00') = '91')
   -- счета клиента
   and (   a.nbs in ('2520', '2560', '2570', '2600', '2604', '2605', '2650', '2655')
        or a.nbs = '2603' and a.kv = 980
        or a.nls like '264%' )
   -- первое движение по счету
   and (p.fdat, p.acc) in
       (select min(s1.fdat) fdat, s1.acc
          from saldoa s1
         where (   s1.pdat is null and (s1.dos<>0 or s1.kos<>0)
                or s1.pdat is not null and
                   s1.pdat = (select min(s2.fdat)
                                from saldoa s2
                               where s2.acc=s1.acc
                                 and s2.pdat is null
                                 and s2.dos=0 and s2.kos=0))
           and s1.acc = a.acc
         group by s1.acc)
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE4 ***
grant SELECT                                                                 on V_FM_OSC_RULE4  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE4  to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE4  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE4.sql =========*** End ***
PROMPT ===================================================================================== 
