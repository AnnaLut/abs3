

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBK_ADD_9100.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view MBK_ADD_9100 ***

  CREATE OR REPLACE FORCE VIEW BARS.MBK_ADD_9100 ("USERID", "ND", "CC_ID", "VIDD_NAME", "DATE_B", "DATE_U", "DATE_V", "DATE_END", "S", "S_PR", "A_NLS", "A_OSTC", "A_MDATE", "A_ACC", "A_KV", "RNK", "NMK", "NMKK", "OKPO", "NLS_9100", "KV_9100", "OSTC_9100", "DAZS_9100", "NLS_SDI", "KV_SDI", "OSTC_SDI", "DAZS_SDI") AS 
  SELECT deal.USERID,
          deal.ND,
          deal.CC_ID,
          deal.VIDD_NAME,
          deal.DATE_B,
          deal.DATE_U,
          deal.DATE_V,
          deal.DATE_END,
          deal.S,
          deal.S_PR,
          deal.A_NLS,
          deal.A_OSTC,
          deal.A_MDATE,
          deal.A_ACC,
          deal.A_KV,
          deal.RNK,
          deal.NMK,
          deal.NMKK,
          deal.OKPO,
          a2.nls nls_9100,
          a2.kv kv_9100,
          ABS (a2.ostc) / 100 OSTC_9100,
          a2.dazs,
          a3.nls nls_sdi,
          a3.kv kv_sdi,
          ABS (a3.ostc) / 100 OSTC_sdi,
          a3.dazs dazs_sdi
     FROM (SELECT d.user_id userid,
                  d.nd nd,
                  d.cc_id,
                  (SELECT name
                     FROM cc_vidd
                    WHERE vidd = d.vidd)
                     vidd_name,
                  d.sdate date_b,
                  ad.bdate date_u,
                  ad.wdate date_v,
                  d.wdate date_end,
                  ad.s,
                  acrn.fproc (a.acc, bankdate) s_pr,
                  a.nls a_nls,
                  a.ostc a_ostc,
                  a.mdate a_mdate,
                  a.acc a_acc,
                  a.kv a_kv,
                  c.rnk,
                  c.nmk,
                  c.nmkk,
                  c.okpo,
                  (SELECT a.acc
                     FROM nd_acc n, accounts a
                    WHERE a.acc = n.acc AND n.nd = d.nd AND a.nbs(+) = '9100')
                     acc_9100,
                  (SELECT a.acc
                     FROM nd_acc n, accounts a
                    WHERE     a.acc = n.acc
                          AND n.nd = d.nd
                          AND a.nbs in ('1626','1616','3666'))
                     acc_sdi,
                  d.wdate,
                  a.ostc
             FROM cc_deal d,
                  cc_add ad,
                  accounts a,
                  customer c,
                  custbank cb
            WHERE     d.nd = ad.nd
                  --     AND a.nbs = TO_CHAR (v.vidd)
                  AND ad.accs = a.acc
                  AND d.rnk = c.rnk
                  AND c.custtype = 1
                  AND c.rnk = cb.rnk
                  AND ad.adds = 0
                  AND d.sos < 15) deal,
          accounts a2,
          accounts a3
    WHERE     a2.acc(+) = deal.acc_9100
          AND a3.acc(+) = deal.acc_sdi
          AND (deal.wdate >= bankdate OR deal.ostc <> 0);

PROMPT *** Create  grants  MBK_ADD_9100 ***
grant SELECT                                                                 on MBK_ADD_9100    to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on MBK_ADD_9100    to BARS_ACCESS_DEFROLE;
grant DELETE,SELECT,UPDATE                                                   on MBK_ADD_9100    to FOREX;
grant SELECT                                                                 on MBK_ADD_9100    to START1;
grant SELECT                                                                 on MBK_ADD_9100    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBK_ADD_9100.sql =========*** End *** =
PROMPT ===================================================================================== 
