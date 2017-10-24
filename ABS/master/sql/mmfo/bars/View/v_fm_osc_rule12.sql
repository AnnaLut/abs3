

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE12.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE12 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE12 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, opldok p, accounts a, customer c
 where o.ref = p.ref
   and p.acc = a.acc
    -- þð.ëèöî, VED=92710
   and a.rnk = c.rnk and c.custtype = 2 and ved = '92710'
    -- Ê 2600
   and a.nbs = '2600'
   and ( upper(o.nazn) like '%ÂÈÃÐÀØ%'
      or upper(o.nazn) like '%ËÎÒÅÐ%' )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE12 ***
grant SELECT                                                                 on V_FM_OSC_RULE12 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE12 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE12 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE12.sql =========*** End **
PROMPT ===================================================================================== 
