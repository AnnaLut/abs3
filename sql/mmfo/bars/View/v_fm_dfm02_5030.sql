

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_5030.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_DFM02_5030 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_DFM02_5030 ("REF") AS 
  select o.ref
  from oper o, opldok p, accounts a, customer c
 where c.custtype = 2 and nvl(c.ved, '00000') in ('66010', '66020', '66030')
   and c.rnk = a.rnk and a.nbs in ('2650', '2655')
   and a.acc = p.acc and p.dk = 1
   and p.ref = o.ref
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_DFM02_5030 ***
grant SELECT                                                                 on V_FM_DFM02_5030 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_DFM02_5030 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_DFM02_5030 to START1;
grant SELECT                                                                 on V_FM_DFM02_5030 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_5030.sql =========*** End **
PROMPT ===================================================================================== 
