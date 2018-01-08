

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FXANI_3800.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FXANI_3800 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FXANI_3800 ("B", "E", "FDAT", "KOD3K", "KV", "OB22", "RATE", "NBS", "KOS", "DOS", "SAL", "CVF_KOS", "CVF_DOS", "CVF_SAL") AS 
  SELECT B,  E, fdat, KOD3k, kv, ob22,  round( gl.p_icurval ( kv, 1000000, fdat)/1000000, 6)  rate, NBS,
       sum(    kos)/100     kos, sum(    dos)/100     dos,  ( sum(    kos)/100 - sum(    dos)/100 )     sal,
       sum(CVF_KOS)/100 CVF_KOS, sum(CVF_DOS)/100 CVF_DOS,  ( sum(CVF_KOS)/100 - sum(CVF_DOS)/100 ) CVF_SAL
from ( SELECT d.B,  d.E, a.kv, a.ob22, fdat,
              CASE  WHEN o.dk = 0                   THEN  o.s  ELSE 0 END     DOS,
              CASE  WHEN o.dk = 1                   THEN  o.s  ELSE 0 END     KOS,
              CASE  WHEN o.dk = 0 and o.tt = 'CVF'  THEN  o.s  ELSE 0 END CVF_DOS,
              CASE  WHEN o.dk = 1 and o.tt = 'CVF'  THEN  o.s  ELSE 0 END CVF_KOS,
              SUBSTR (FOREX.get_forextype3K(f.deal_tag),1,15) KOD3k,        a.NBS
       FROM Fx_deal f,  V_SFDAT d,  opldok o,   accounts a
       WHERE f.dat >= d.B AND f.REF = o.REF AND o.acc = a.acc and o.fdat in (f.dat_a, f.dat_b) AND a.nbs ='3800'
--and swap_tag = 85324
       union all
       SELECT d.B,  d.E, a.kv, a.ob22, fdat,
              CASE  WHEN o.dk = 0                   THEN  o.s  ELSE 0 END     DOS,
              CASE  WHEN o.dk = 1                   THEN  o.s  ELSE 0 END     KOS,
              CASE  WHEN o.dk = 0 and o.tt = 'CVF'  THEN  o.s  ELSE 0 END CVF_DOS,
              CASE  WHEN o.dk = 1 and o.tt = 'CVF'  THEN  o.s  ELSE 0 END CVF_KOS,
              SUBSTR (FOREX.get_forextype3K(f.deal_tag),1,15) KOD3k ,       a.NBS
       FROM Fx_deal f,  V_SFDAT d,  opldok o , accounts a
       WHERE f.dat >= d.B AND f.REF = o.REF AND o.acc = a.acc and o.fdat in (f.dat_a, f.dat_b) AND a.nbs like '92__' and o.fdat > f.dat
         and not exists (select 1 from opldok oo, accounts aa where oo.ref = f.REF and oo.acc= aa.acc and aa.nbs='3800' ) and a.kv <> 980
         and o.txt like 'Закрити%'
--and swap_tag = 85324
      )
group by B,  E, fdat, KOD3k, kv, ob22, NBS;

PROMPT *** Create  grants  V_FXANI_3800 ***
grant SELECT                                                                 on V_FXANI_3800    to BARSREADER_ROLE;
grant SELECT                                                                 on V_FXANI_3800    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FXANI_3800    to START1;
grant SELECT                                                                 on V_FXANI_3800    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FXANI_3800.sql =========*** End *** =
PROMPT ===================================================================================== 
