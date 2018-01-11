

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_1011.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_DFM02_1011 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_DFM02_1011 ("REF") AS 
  select o.ref
  from oper o, opldok p1, opldok p2, accounts a1, accounts a2
 where o.ref = p1.ref and o.ref = p2.ref
   and p1.dk = 0 and p2.dk = 1 and p1.s = p2.s
   and p1.acc = a1.acc and a1.nbs in ('2902', '2909')
   and p2.acc = a2.acc and a2.nls like '101%'
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_DFM02_1011 ***
grant SELECT                                                                 on V_FM_DFM02_1011 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_DFM02_1011 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_DFM02_1011 to START1;
grant SELECT                                                                 on V_FM_DFM02_1011 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_1011.sql =========*** End **
PROMPT ===================================================================================== 
