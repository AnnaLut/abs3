

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE21.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE21 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE21 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, opldok p, accounts a, customerw w
 where o.ref = p.ref
   and p.acc = a.acc
   and a.rnk = w.rnk
   and w.tag = 'RIZIK'
   and lower(w.value) in ('високий', 'неприйнятно високий')
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE21 ***
grant SELECT                                                                 on V_FM_OSC_RULE21 to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE21.sql =========*** End **
PROMPT ===================================================================================== 
