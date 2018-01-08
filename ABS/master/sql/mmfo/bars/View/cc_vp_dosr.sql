

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_VP_DOSR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_VP_DOSR ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_VP_DOSR ("BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "RNK", "NMK", "MES", "KV", "NLS", "Z5", "R1", "K0", "DAT_MOD", "KN_DPK", "KN_PPK") AS 
  SELECT BRANCH,
          ND,
          CC_ID,
          SDATE,
          WDATE,
          RNK,
          NMK,
          ROUND (MONTHS_BETWEEN (wdate, gl.bd), 1) MES,
          KV,
          NLS,
          (LIM) / 100 Z5,
          R1 / 100 R1,
          K0,
          cck_dpk.DAT_MOD (ND) DAT_MOD,
          make_url ('/barsroot/credit/repayment_dostr.aspx',
                    'Виконати',
                    'ccid',
                    nd,
                    'acc',
                    acc,
                    'nls',
                    nls,
                    'type',
                    '1')
             KN_DPK,
          make_url ('/barsroot/credit/repayment_dostr.aspx',
                    'Виконати',
                    'ccid',
                    nd,
                    'acc',
                    acc,
                    'nls',
                    nls,
                    'type',
                    '2')
             KN_PPK
     FROM (SELECT d.branch,
                  d.ND,
                  d.CC_ID,
                  d.sdate,
                  d.wdate,
                  d.rnk,
                  c.nmk,
                  a.kv,
                  a.nls,
                  A.ACC,
                  -a8.ostc LIM,
                  a.ostb R1,
                  DECODE (a8.vid, 4, 1, 0) K0
             FROM cc_deal d,
                  customer c,
                  nd_acc n,
                  accounts a,
                  nd_acc n8,
                  accounts a8
            WHERE     d.vidd in (1,11)
                  AND d.sos > 0
                  AND d.sos < 15
                  AND d.rnk = c.rnk
                  AND d.nd = n.nd
                  AND n.acc = a.acc
                  AND a.dazs IS NULL
                  AND (a.nbs IN ('2620', '2625') OR a.tip = 'SG')
                  AND n8.nd = d.nd
                  AND n8.acc = a8.acc
                  AND a8.dazs IS NULL
                  AND a8.nls LIKE '8999%'
                  AND A8.TIP = 'LIM'
                  AND a8.ostb < 0);

PROMPT *** Create  grants  CC_VP_DOSR ***
grant FLASHBACK,SELECT                                                       on CC_VP_DOSR      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_VP_DOSR.sql =========*** End *** ===
PROMPT ===================================================================================== 
