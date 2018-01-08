

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_FM_CRITERIA5.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_FM_CRITERIA5 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_FM_CRITERIA5 ("REF") AS 
  select o.ref
  from opldok p, oper o
 where (fdat, acc) in (select min(s1.fdat) fdat, s1.acc
                         from saldoa s1, accounts a
                        where s1.fdat between add_months(bankdate_g, -3) and bankdate_g
                          and (   s1.pdat is null and (s1.dos<>0 or s1.kos<>0)
                               or s1.pdat is not null and
                                  s1.pdat = (select min(s2.fdat)
                                               from saldoa s2
                                              where s2.acc=s1.acc
                                                and s2.pdat is null
                                                and s2.dos=0 and s2.kos=0)
                               or s1.pdat is not null and
                                  s1.fdat-s1.pdat>30 and (s1.dos<>0 or s1.kos<>0))
                          and s1.acc = a.acc
                        group by s1.acc)
   and o.ref = p.ref
   and gl.p_icurval(nvl(o.kv, 980), nvl(o.s, 0), p.fdat) >= 15000000;

PROMPT *** Create  grants  V_OPER_FM_CRITERIA5 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OPER_FM_CRITERIA5 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_FM_CRITERIA5.sql =========*** En
PROMPT ===================================================================================== 
