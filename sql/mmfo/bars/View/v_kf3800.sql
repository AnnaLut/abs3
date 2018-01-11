

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KF3800.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF3800 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KF3800 ("NAL", "KV", "BRANCH", "REF", "TTR", "TTD", "TTP", "N", "Q", "PPF", "SPF", "B", "E", "RAT") AS 
  select decode(a29.ob22,'09',1,0) NAL ,
       a38.KV        ,
       p.BRANCH      ,
       p.REF         ,
       p.tt       TTR,
       o38.tt     TTD,
       o29.tt     TTP,
       o38.s/100  N  ,
       p.S2/100   Q  ,  -----------------------------------------   round( o29.s*1000/5,0)/100 q  ,
      '0.5'       PPF,
       o29.s/100  SPF,
       d.B           ,
       d.E           ,
       round( p.S2/o38.s, 4) RAT
from (select * from accounts where nbs ='3800' and ob22 in ('10','20') ) a38,
     (select * from accounts where nbs ='2902' and ob22 in ('09','15') ) a29,
    opldok o38,  oper p , opldok o29 , V_SFDAT d
where o38.dk = 0 and o38.fdat >= d.B     and o38.fdat <= d.e   and o38.acc = a38.acc
  and o29.dk = 1 and o29.ref  = o38.ref  and o29.acc   = a29.acc
  and p.sos  = 5 and p.ref    = o38.ref  and o29.s     > 0     and o38.s >0  ;

PROMPT *** Create  grants  V_KF3800 ***
grant SELECT                                                                 on V_KF3800        to BARSREADER_ROLE;
grant SELECT                                                                 on V_KF3800        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KF3800        to START1;
grant SELECT                                                                 on V_KF3800        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KF3800.sql =========*** End *** =====
PROMPT ===================================================================================== 
