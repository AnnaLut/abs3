

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_1032.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_DFM02_1032 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_DFM02_1032 ("REF") AS 
  select o.ref
  from oper o, opldok p1, opldok p2, accounts a1, accounts a2
 where o.ref=p1.ref and o.ref=p2.ref
-- Д Касса - К Счета клиента
   and p1.dk=0 and p2.dk=1 and p1.s=p2.s
   and p1.acc=a1.acc and a1.nbs in ('1001', '1002', '2902')
   and p2.acc=a2.acc and a2.nbs in ('2600', '2620', '2650')
-- сумма док. по зачислению <= сумме Д оборотов (списание) этого и след. банк. дня
   and o.s <= (select sum(p.s)
                 from opldok p
                where p.acc=p2.acc and p.fdat in (p2.fdat, dat_next_u(p2.fdat,1)) and p.dk=0)
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_DFM02_1032 ***
grant SELECT                                                                 on V_FM_DFM02_1032 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_DFM02_1032 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_1032.sql =========*** End **
PROMPT ===================================================================================== 
