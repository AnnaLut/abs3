

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_4040.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_DFM02_4040 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_DFM02_4040 ("REF") AS 
  select p.ref
  from oper o, opldok p, accounts a, customer c
 where o.ref = p.ref
-- клиенты-ёЋ
   and c.custtype = 2
-- счета клиента 26%
   and c.rnk = a.rnk and a.nls like '26%'
-- обороты по дебету (списание)
   and a.acc = p.acc and p.dk = 0
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

PROMPT *** Create  grants  V_FM_DFM02_4040 ***
grant SELECT                                                                 on V_FM_DFM02_4040 to BARSREADER_ROLE;
grant SELECT                                                                 on V_FM_DFM02_4040 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_DFM02_4040 to START1;
grant SELECT                                                                 on V_FM_DFM02_4040 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_DFM02_4040.sql =========*** End **
PROMPT ===================================================================================== 
