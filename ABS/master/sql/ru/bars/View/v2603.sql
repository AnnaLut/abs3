

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V2603.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V2603 ***

  CREATE OR REPLACE FORCE VIEW BARS.V2603 ("ACC", "NLS", "NMS", "RNK", "BRANCH", "OB22", "OSTV", "OSTC", "OSTB", "KAZ", "SA", "SR", "SALL", "IDG", "IDS", "SPS") AS 
  select a.acc, a.nls, a.nms, a.rnk, a.branch, a.ob22,
       fost(a.acc, gl.bd-1)/100 OSTV,  a.ostc/100 OSTC, a.ostb/100 OSTB, kaz( s.sps, a.acc)/100 KAZ,
       t.SA/100 SA, t.SR/100 SR,    t.SA/100 + t.SR/100 SALL,
       s.idg, s.ids, s.sps
from accounts a, specparam s,  t2603 t
where a.acc= s.acc and a.acc = t.acc (+) and a.nbs ='2603' and a.kv =980 and s.ids >0
 and s.idg = to_number ( pul.Get_Mas_Ini_Val('IDG') )  ;

PROMPT *** Create  grants  V2603 ***
grant SELECT                                                                 on V2603           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V2603.sql =========*** End *** ========
PROMPT ===================================================================================== 
