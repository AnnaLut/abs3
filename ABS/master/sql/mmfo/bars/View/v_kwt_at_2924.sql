

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KWT_AT_2924.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KWT_AT_2924 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KWT_AT_2924 ("ACC", "BRANCH", "DAT_KWT", "NLS", "OB22", "KV", "DATVZ", "IXD", "IXK", "RKW", "RI", "FDAT", "REF", "TT2", "SD", "SK", "S", "NAZN") AS 
  select a.ACC, a.BRANCH, a.dat_kwt, a.NLS, a.OB22, a.KV, a.DATVZ, a.IXD, a.IXK, t.RKW,  t.rowid RI,
       t.FDAT, t.REF, t.tt2,  decode ( sign(t.s), -1, -t.s/100, null ) SD,
                       decode ( sign(t.s),  1,  t.s/100, null ) SK, abs(t.s)/100 S,
      (select TT || ' | '|| substr(nazn,1,100) from oper where ref = t.REF) NAZN
from  (select * from bars.kwt_a_2924 where acc = to_number( bars.pul.get('ACC') )  ) a,      --
      (select * from bars.kwt_t_2924 where acc = to_number( bars.pul.get('ACC') )  ) t       --
where a.acc = t.acc  ;

PROMPT *** Create  grants  V_KWT_AT_2924 ***
grant SELECT                                                                 on V_KWT_AT_2924   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KWT_AT_2924   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KWT_AT_2924.sql =========*** End *** 
PROMPT ===================================================================================== 
