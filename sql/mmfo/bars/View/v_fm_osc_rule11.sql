

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE11.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE11 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE11 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, opldok p, accounts a, customer c
 where o.ref = p.ref
   and p.acc = a.acc
   and a.rnk = c.rnk and c.custtype = 3 and nvl(trim(c.sed),'00') <> '91'
   -- Ê 2620, 2625
   and p.dk = 1
   and a.nbs in ('2620', '2625')
   and ( upper(o.nazn) like '%ÂÈÃÐÀØ%'
      or upper(o.nazn) like '%ËÎÒÅÐ%' )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE11 ***
grant SELECT                                                                 on V_FM_OSC_RULE11 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE11 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE11 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE11.sql =========*** End **
PROMPT ===================================================================================== 
