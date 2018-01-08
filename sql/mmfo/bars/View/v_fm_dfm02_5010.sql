

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_5010.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_DFM02_5010 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_DFM02_5010 ("REF") AS 
  select o.ref
  from oper o, opldok p, accounts a
 where o.ref = p.ref
   and p.acc = a.acc
   and (a.nbs in ('2801', '2805', '2887', '2901', '2904', '2905', '2907') or a.nls like '202%')
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_DFM02_5010 ***
grant SELECT                                                                 on V_FM_DFM02_5010 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_DFM02_5010 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_5010.sql =========*** End **
PROMPT ===================================================================================== 
