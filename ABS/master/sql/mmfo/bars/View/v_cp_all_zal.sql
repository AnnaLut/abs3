

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ALL_ZAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ALL_ZAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_ALL_ZAL ("ID", "CP_ID", "RNK", "DATP", "KOL_ALL", "CP_BLK", "NMK", "ZAL_1522", "ZAL_1622") AS 
  select k.id, k.cp_id, k.rnk, k.datp,  x.ostc/(k.cena*100) kol_all , x.cp_blk, c.nmk ,
       y.zal_1522, y.zal_1622
from (select cp.id, - sum(a.ostb) ostc,  nvl(sum( GET_ACCW (a.acc,0,null,0,'CP_ZAL',gl.bd) ),0)  cp_blk
      from cp_deal cp, accounts a
      where  cp.dazs is null and cp.acc = a.acc
      group by cp.id
      having sum(a.ostb) < 0
     ) x ,
     cp_kod  k, customer c  ,
     (select m.id, sum(decode( m.tipd,1,m.kol,0)) zal_1522, sum(decode( m.tipd,2,m.kol,0)) zal_1622
      from mbk_cp m, cc_deal mb
      where m.nd = mb.nd and mb.wdate   >= gl.bd
      group by m.id
     ) y
where k.id  = x.id (+)
  and k.id  = y.id (+)
  and k.rnk = c.rnk(+)
;

PROMPT *** Create  grants  V_CP_ALL_ZAL ***
grant SELECT                                                                 on V_CP_ALL_ZAL    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ALL_ZAL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ALL_ZAL    to START1;
grant SELECT                                                                 on V_CP_ALL_ZAL    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ALL_ZAL.sql =========*** End *** =
PROMPT ===================================================================================== 
