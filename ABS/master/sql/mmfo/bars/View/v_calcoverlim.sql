

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CALCOVERLIM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CALCOVERLIM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CALCOVERLIM ("RNK", "REF", "ACCK", "NLSD", "NLSK", "FDAT", "TT", "KV", "S", "SQ", "NAZN", "NAM_A") AS 
  select
kc.rnk,
d1.REF,
k1.ACC,
d2.NLS,
k2.NLS,
d1.FDAT,
d1.TT,
d2.KV,
least(d1.S,k1.S)/100,
least(d1.SQ,k1.SQ)/100,
o.nazn,
nam_a
from oper o,
     tts t,
     opldok d1,
     opldok k1 ,
     accounts d2,
     accounts k2,
     cust_acc dc,
     cust_acc kc
where o.ref  = d1.ref
  and t.tt   = d1.tt
  and d1.sos = 5
  and d1.dk  = 0
  and d1.fdat=k1.fdat
  and k1.sos = 5
  and k1.dk  = 1
  and d1.ref = k1.ref
  and d1.tt  = k1.tt
  and d1.fdat= k1.fdat
  and d1.acc = d2.acc
  and k1.acc = k2.acc
  and o.id_a <> o.id_b
  and (k2.nbs ='2600'
  or  k2.nbs in (select nbs2600 from acc_over_nbs))
  and d2.kv  = k2.kv
  and dc.acc = d2.acc
  and kc.acc = k2.acc
  and kc.rnk <> dc.rnk
 ;

PROMPT *** Create  grants  V_CALCOVERLIM ***
grant SELECT                                                                 on V_CALCOVERLIM   to BARS009;
grant SELECT                                                                 on V_CALCOVERLIM   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CALCOVERLIM   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CALCOVERLIM   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CALCOVERLIM.sql =========*** End *** 
PROMPT ===================================================================================== 
