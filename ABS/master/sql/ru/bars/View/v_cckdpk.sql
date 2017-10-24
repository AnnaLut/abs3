

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCKDPK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCKDPK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCKDPK ("Z8", "RNK", "CC_ID", "SDATE", "BRANCH", "KV", "NLS", "ACCOUNT_BRANCH", "ND", "NBS", "WDATE", "NMK", "KN_DPK", "Z1", "Z2", "Z3", "Z4", "Z5", "R1", "R2", "K0", "K1", "MES", "DAT_MOD", "K2") AS 
  SELECT cck_dpk.Z8 (ND) Z8,
          RNK,
          CC_ID,
          SDATE,
          BRANCH,
          KV,
          NLS,
          account_branch,
          ND,
          NBS,
          WDATE,
          NMK,
          make_url ('/barsroot/credit/repayment_dostr.aspx',
                    'Виконати',
                    'ccid',
                    nd)
             KN_DPK,
          Z1,
          Z2,
          Z3,
          (Z1 + Z2 + Z3) Z4,
          (LIM - Z3) Z5,
          R1,
          (R1 - (Z1 + Z2 + Z3)) R2,
          K0,
          LEAST ( (LIM - Z3), (R1 - (Z1 + Z2 + Z3))) K1,
          ROUND (MONTHS_BETWEEN (wdate, gl.bd), 1) MES,
          cck_dpk.DAT_MOD (ND) DAT_MOD,
          cck_dpk.DAY_PL (ND) K2
     FROM (SELECT d.branch,
                  d.ND,
                  d.CC_ID,
                  d.sdate,
                  d.wdate,
                  d.rnk,
                  c.nmk,
                  a.kv,
                  a.nls,
                  a.branch account_branch,
                  DECODE (a8.vid, 4, 1, 0) K0,
                  a.nbs,
                  -a8.ostc / 100 LIM,
                  a.ostb / 100 R1,
                  cck_dpk.sum_SP_ALL (d.nd) / 100 Z1,
                  cck_dpk.sum_SN_all (a8.vid, d.nd) / 100 Z2,
                  cck_dpk.sum_SS_next (d.nd) / 100 Z3
             FROM customer c,
                  nd_acc n,
                  nd_acc n8,
                  (SELECT *
                     FROM cc_deal
                    WHERE vidd IN (1, 11) AND sos > 0 AND sos < 15) d,
                  (SELECT *
                     FROM accounts
                    WHERE     (tip = 'SG ' OR nbs IN ('2600', '2620', '2625'))
                          AND dazs IS NULL) a,
                  (SELECT *
                     FROM accounts
                    WHERE (tip = 'LIM' AND ostb < 0) AND dazs IS NULL) a8
            WHERE     d.rnk = c.rnk
                  AND d.nd = n.nd
                  AND n.acc = a.acc
                  AND d.nd = n8.nd
                  AND n8.acc = a8.acc)
--where NOT ( Z1> 0 and  NBS ='2525') --  НЕ выполнять досрочное погашение с 2625 с перестроением ГПК при наличии ПРОСРОЧЕК.
;

PROMPT *** Create  grants  V_CCKDPK ***
grant FLASHBACK,SELECT                                                       on V_CCKDPK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCKDPK        to SBON;
grant SELECT                                                                 on V_CCKDPK        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCKDPK.sql =========*** End *** =====
PROMPT ===================================================================================== 
