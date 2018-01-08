

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VV_ARJK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VV_ARJK ***

  CREATE OR REPLACE FORCE VIEW BARS.VV_ARJK ("B", "E", "KOL", "KV", "BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "RNK", "DAT1", "DAT2", "OST8", "IR", "ACC", "ARJK", "SN", "SK0", "IRS", "NMK", "OKPO") AS 
  SELECT i.B,
          i.E,
          i.KOL,
          i.KV,
          i.BRANCH,
          i.ND,
          i.CC_ID,
          i.SDATE,
          i.WDATE,
          i.RNK,
          i.DAT1,
          i.DAT2,
          i.OST8,
          i.IR,
          i.ACC,
          i.ARJK,
          i.SN,
          i.SK0,
          CASE
             WHEN i.OST8 = 0
             THEN
                0
             WHEN MOD (TO_CHAR (i.E, 'yyyy'), 4) = 0
             THEN
                ROUND ( (i.SN + i.SK0) * (36600 / i.kol) / i.OST8, 2)
             ELSE
                ROUND ( (i.SN + i.SK0) * (36500 / i.kol) / i.OST8, 2)
          END
             IRS,
          c.NMK,
          c.OKPO
     FROM customer c,
          (SELECT v.b,
                  v.e,
                  (v.e - v.b) + 1 KOL,
                  x.kv,
                  x.branch,
                  x.nd,
                  x.cc_id,
                  x.sdate,
                  x.wdate,
                  x.rnk,
                  x.dat1,
                  x.dat2,
                  -OSTS8 (x.acc, v.b, v.e) / 100 ost8,
                  acrn.fprocn (x.acc, 0, v.b) IR,
                  x.acc,
                  x.ARJK,
                  NVL (
                     (SELECT SUM (sn.dos) / 100
                        FROM saldoa sn, accounts an, nd_acc nn
                       WHERE     nn.nd = x.ND
                             AND nn.acc = an.acc
                             AND an.tip = 'SN '
                             AND an.acc = sn.acc
                             AND sn.fdat >= v.B
                             AND sn.fdat <= v.E),
                     0)
                     SN,
                  NVL (
                     (SELECT SUM (sk.dos) / 100
                        FROM saldoa sk, accounts ak, nd_acc nk
                       WHERE     nk.nd = x.ND
                             AND nk.acc = ak.acc
                             AND ak.tip = 'SK0'
                             AND ak.acc = sk.acc
                             AND sk.fdat >= v.B
                             AND sk.fdat <= v.E),
                     0)
                     SK0
             FROM V_SFDAT v,
                  (SELECT d.branch,
                          d.nd,
                          d.cc_id,
                          d.sdate,
                          d.wdate,
                          d.rnk,
                          a.kv,
                          a.acc,
                          TO_NUMBER (t.txt) ARJK,
                          TO_DATE (cck_app.get_nd_txt (d.nd, 'DINDU'),
                                   'dd.mm.yyyy')
                             dat1,
                          TO_DATE (cck_app.get_nd_txt (d.nd, 'DO_DU'),
                                   'dd.mm.yyyy')
                             dat2
                     FROM nd_acc n,
                          (SELECT *
                             FROM nd_txt
                            WHERE tag = 'ARJK') t,
                          (SELECT *
                             FROM cc_deal
                            WHERE vidd IN (11, 12, 13)) d,
                          (SELECT *
                             FROM accounts
                            WHERE tip = 'LIM') a
                    WHERE d.nd = n.nd AND d.nd = t.nd AND n.acc = a.acc) x) i
    WHERE i.rnk = c.rnk;

PROMPT *** Create  grants  VV_ARJK ***
grant SELECT                                                                 on VV_ARJK         to BARSREADER_ROLE;
grant SELECT                                                                 on VV_ARJK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VV_ARJK         to START1;
grant SELECT                                                                 on VV_ARJK         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VV_ARJK.sql =========*** End *** ======
PROMPT ===================================================================================== 
