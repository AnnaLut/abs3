

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_109.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_109 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_109 ("RNKK", "NMK", "ACCK", "KVK", "NLSK", "SUMK", "DATK", "S080", "FIN", "CC_ID", "ID", "ND", "RNKZ", "NMZ", "ACCZ", "KVZ", "NLSZ", "SUMZ", "PAWN", "MPAWN", "IDZ", "NDZ", "NREE", "OBS", "PR_12") AS 
  WITH zz AS
        (
           SELECT az.acc accz, az.kv kvz, az.nbs nbsz, az.nls nlsz,
                  az.daos daosz, az.dazs dazsz, az.ostb / 100 ostbz,
                  cz.rnk rnkz, cz.nmkk nmkz, pa.pawn, pa.mpawn, pa.idz,
                  pa.ndz, pa.nree
             FROM accounts az,
                  pawn_acc pa,
                  cust_acc cuz,
                  customer cz,
                  (SELECT nbsz nbs
                     FROM cc_pawn
                   UNION
                   SELECT nbsz2 nbs
                     FROM cc_pawn
                   UNION
                   SELECT nbsz3 nbs
                     FROM cc_pawn) cp
            WHERE az.nbs = cp.nbs
              AND az.acc = pa.acc(+)
              AND az.acc = cuz.acc
              AND cuz.rnk = cz.rnk),
        kk AS
        (
           SELECT  ak.acc acck, cp.acc accz, ak.kv kvk, ak.nbs nbsk,
                  ak.nls nlsk, ak.daos daosk, ak.dazs dazsk,
                  -ak.ostb / 100 ostbk, ak.mdate mdatek, ck.crisk,
                  ck.rnk rnkk, ck.nmk nmkk, s.s080, cp.PR_12
             FROM accounts ak,
                  cc_accp cp,
                  cust_acc cuk,
                  customer ck,
                  specparam s
            WHERE cp.accs = ak.acc
              AND cp.accs = cuk.acc
              AND cuk.rnk = ck.rnk
              AND cp.accs = s.acc(+)),
        nn AS
        (
		   SELECT  n.acc acc, d.cc_id , d.user_id, d.obs, n.nd
             FROM nd_acc n, cc_deal d
            WHERE n.nd = d.nd AND d.sos <> 15
           UNION ALL
           SELECT a.acc acc, a.ndoc , a.userid user_id, a.obs, a.ND
             FROM acc_over a
            WHERE a.acc = a.acco
			)
   SELECT kk.rnkk, kk.nmkk, kk.acck, kk.kvk, kk.nlsk, kk.ostbk, kk.mdatek,
          kk.s080, kk.crisk, nn.cc_id, nn.user_id, nn.nd, zz.rnkz, zz.nmkz,
          zz.accz, zz.kvz, zz.nlsz, zz.ostbz, zz.pawn, zz.mpawn, zz.idz,
          zz.ndz, zz.nree, nn.obs , kk.PR_12
     FROM zz, kk, nn
    WHERE zz.accz = kk.accz(+) AND kk.acck = nn.acc(+)
    
 ;

PROMPT *** Create  grants  KU_109 ***
grant SELECT                                                                 on KU_109          to BARSREADER_ROLE;
grant SELECT                                                                 on KU_109          to BARSUPL;
grant SELECT                                                                 on KU_109          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_109          to RCC_DEAL;
grant SELECT                                                                 on KU_109          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KU_109          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_109.sql =========*** End *** =======
PROMPT ===================================================================================== 
