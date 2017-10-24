

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAT_KWT_2924.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view VAT_KWT_2924 ***

  CREATE OR REPLACE FORCE VIEW BARS.VAT_KWT_2924 ("ACC", "BRANCH", "DAT_KWT", "NLS", "OB22", "KV", "DATVZ", "IXD", "IXK", "RKW", "RI", "FDAT", "REF", "TT2", "SD", "SK", "S", "NAZN") AS 
  select a.ACC, a.BRANCH, a.dat_kwt, a.NLS, a.OB22, a.KV, a.DATVZ, a.IXD, a.IXK, t.RKW,  t.rowid RI,
       t.FDAT, t.REF, t.tt2,  decode ( sign(t.s), -1, -t.s/100, null ) SD,       
                       decode ( sign(t.s),  1,  t.s/100, null ) SK, abs(t.s)/100 S,
      (select TT || ' | '|| substr(nazn,1,100) from oper where ref = t.REF) NAZN
from  (select * from A_KWT_2924 where acc = to_number( pul.get('ACC') )  ) a,      --
      (select * from T_KWT_2924 where acc = to_number( pul.get('ACC') )  ) t       --
where a.acc = t.acc;

PROMPT *** Create  grants  VAT_KWT_2924 ***
grant SELECT                                                                 on VAT_KWT_2924    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAT_KWT_2924.sql =========*** End *** =
PROMPT ===================================================================================== 
