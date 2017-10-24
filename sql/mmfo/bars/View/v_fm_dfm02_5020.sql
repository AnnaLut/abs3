

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_5020.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_DFM02_5020 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_DFM02_5020 ("REF") AS 
  select o.ref
  from oper o, opldok p, accounts a, customer c
 where c.custtype = 3
   and c.rnk = a.rnk and a.nbs in ('2600', '2620')
   and a.acc = p.acc and p.dk = 1
   and p.ref = o.ref
   and (   upper(o.nazn) like '%ÑÒÐÀÕ%'
        or upper(o.nazn) like '%Â_ÄØÊ%'
        or upper(o.nazn) like '%ÂÎÇÌ%' )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_DFM02_5020 ***
grant SELECT                                                                 on V_FM_DFM02_5020 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_DFM02_5020 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_5020.sql =========*** End **
PROMPT ===================================================================================== 
