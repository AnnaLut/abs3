

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_1000.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_DFM02_1000 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_DFM02_1000 ("REF") AS 
  select o.ref
  from oper o, opldok p, accounts a
 where o.ref = p.ref
   and p.acc = a.acc and a.nbs in ('1001', '1002')
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_DFM02_1000 ***
grant SELECT                                                                 on V_FM_DFM02_1000 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_DFM02_1000 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_DFM02_1000 to START1;
grant SELECT                                                                 on V_FM_DFM02_1000 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_1000.sql =========*** End **
PROMPT ===================================================================================== 
