

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_FM_CRITERIA1.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_FM_CRITERIA1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_FM_CRITERIA1 ("REF") AS 
  select unique p.ref
  from opldok p, accounts a
 where (p.acc, p.fdat) in (select s1.acc, min(s1.fdat) fdat
                             from saldoa s1
                            where (s1.pdat is null and (s1.dos<>0 or s1.kos<>0)
                               or s1.pdat is not null and
                                  s1.pdat=(select min(fdat) from saldoa where acc=s1.acc and pdat is null and dos=0 and kos=0))
                            group by s1.acc)
   and p.acc=a.acc
   and gl.p_icurval(nvl(a.kv, 980), nvl(p.s, 0), p.fdat) >= 15000000;

PROMPT *** Create  grants  V_OPER_FM_CRITERIA1 ***
grant SELECT                                                                 on V_OPER_FM_CRITERIA1 to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPER_FM_CRITERIA1 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_FM_CRITERIA1 to START1;
grant SELECT                                                                 on V_OPER_FM_CRITERIA1 to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OPER_FM_CRITERIA1 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_FM_CRITERIA1.sql =========*** En
PROMPT ===================================================================================== 
