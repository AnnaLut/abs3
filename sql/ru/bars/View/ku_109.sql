

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_109.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_109 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_109 ("RNKK", "NMK", "KVK", "NLSK", "SUMK", "DATK", "ND1", "ND2", "ACCK", "ACCZ", "CC_ID", "PR_12", "RNKZ", "NMZ", "KVZ", "NLSZ", "SUMZ", "DATZ") AS 
  select ka.rnk RNKK, (select nmk from customer where rnk = ka.rnk) NMK,   ka.kv KVK,  ka.nls NLSK,  ka.ostc/100 SUMK, ka.DAZS DATK,
       z.nd   ND1 , NVL( (select n.nd from nd_acc n where n.acc = ka.acc and n.nd <> z.nd and rownum = 1), z.nd) ND2,
       ka.acc ACCK, za.acc ACCZ,  d.cc_id,  z.PR_12,
       za.rnk RNKZ, (select nmk from customer where rnk = za.rnk) NMZ,   za.kv KVZ,  za.nls NLSZ, za.ostc/100 SUMZ, za.dazs DATZ
from accounts ka, accounts za, cc_accp z, cc_deal d
where z.accs = ka.acc and z.acc = za.acc and z.nd = d.nd (+) ;

PROMPT *** Create  grants  KU_109 ***
grant SELECT                                                                 on KU_109          to BARSUPL;
grant SELECT                                                                 on KU_109          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_109          to BARS_SUP;
grant SELECT                                                                 on KU_109          to RCC_DEAL;
grant SELECT                                                                 on KU_109          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KU_109          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_109.sql =========*** End *** =======
PROMPT ===================================================================================== 
