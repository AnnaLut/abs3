
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_zal_nd.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_ZAL_ND ("PAP", "ND", "ND1", "PR_12", "ACC", "NLS", "KV", "OSTB", "OSTC", "PAWN", "MPAWN", "NREE", "DEPID", "CC_IDZ", "SDATZ", "RNK", "SV", "OB22", "R013", "MDATE", "DAZS", "DEL", "NAZN") AS 
  SELECT DISTINCT PAP,
                   nd,
                   nd1,
                   PR_12,
                   acc,
                   nls,
                   kv,
                   ostb,
                   ostC,
                   pawn,
                   mpawn,
                   nree,
                   depid,
                   cc_idz,
                   sdatz,
                   rnk,
                   sv,
                   OB22,
                   (select r013 from specparam sp where sp.acc = t.acc) R013,
                   mdate,
                   DAZS,
                   0 del,
                   '' nazn
     FROM (SELECT 1 PAP,
                  n.ND,
                  P.nd nd1,
                  1 PR_12,
                  Az.acc,
                  AZ.nls,
                  AZ.kv,
                  -Az.ostB / 100 ostb,
                  -Az.ostC / 100 ostC,
                  SZ.pawn,
                  SZ.mpawn,
                  SZ.nree,
                  SZ.deposit_id depid,
                  SZ.cc_idz,
                  SZ.sdatz,
                  az.rnk,
                  SZ.SV / 100 sv,
                  aZ.OB22,
                  aZ.mdate,
                  AZ.DAZS
             FROM accounts AZ,
                  pawn_acc SZ,
                  cc_accp p,
                  nd_acc n
            WHERE     Az.acc = SZ.acc(+)
                  AND AZ.acc = P.acc
                  AND p.accs = n.acc
                  AND n.nd = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND'))
                  AND NVL (pul.Get_Mas_Ini_Val ('PAP'), 1) = 1
           UNION ALL
           SELECT 2,
                  n.ND,
                  NULL,
                  NULL,
                  Az.acc,
                  AZ.nls,
                  AZ.kv,
                  -Az.ostB / 100,
                  -Az.ostC / 100,
                  SZ.pawn,
                  SZ.mpawn,
                  SZ.nree,
                  NULL,
                  SZ.cc_idz,
                  SZ.sdatz,
                  az.rnk,
                  SZ.SV / 100 sv,
                  aZ.OB22,
                  aZ.mdate,
                  AZ.DAZS
             FROM accounts AZ, pawn_acc SZ, nd_acc n
            WHERE     az.tip = 'ZAL'
                  AND Az.acc = SZ.acc(+)
                  AND az.acc = n.acc(+)
                  AND n.ND = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND'))
                  AND pul.Get_Mas_Ini_Val ('PAP') = 2) t
;
 show err;
 
PROMPT *** Create  grants  V_ZAL_ND ***
grant SELECT                                                                 on V_ZAL_ND        to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAL_ND        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAL_ND        to START1;
grant SELECT                                                                 on V_ZAL_ND        to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_zal_nd.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 