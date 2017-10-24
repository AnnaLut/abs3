

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KF3800.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF3800 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KF3800 ("NAL", "KV", "BRANCH", "REF", "TTR", "TTD", "TTP", "N", "RAT", "Q", "PPF", "SPF", "B", "E") AS 
  select decode(a29.ob22,'09',1,0) NAL,  a38.kv,   p.branch,  p.ref,   p.tt ttR , o38.tt ttd,  o29.tt ttp,  o38.s/100 N,
 round( (o29.s*1000/5 )/ o38.s , 4) rat,  round( o29.s*1000/5,0)/100 q  , '0.5' ppf,    o29.s/100  spf, d.B, d.e
from (select * from accounts where nbs ='3800' and ob22 in ('10','20') ) a38,
     (select * from accounts where nbs ='2902' and ob22 in ('09','15') ) a29,
    opldok o38,  oper p , opldok o29 , V_SFDAT d
where o38.dk = 0 and o38.fdat >= d.B     and o38.fdat <= d.e   and o38.acc = a38.acc
  and o29.dk = 1 and o29.ref  = o38.ref  and o29.acc   = a29.acc
  and p.sos  = 5 and p.ref    = o38.ref  and o29.s     > 0     and o38.s >0  ;

PROMPT *** Create  grants  V_KF3800 ***
grant SELECT                                                                 on V_KF3800        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KF3800.sql =========*** End *** =====
PROMPT ===================================================================================== 
