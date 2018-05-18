CREATE OR REPLACE FORCE VIEW BARS.V_CCKDPK
(
   RNK,
   CC_ID,
   SDATE,
   BRANCH,
   KV,
   NLS,
   ACCOUNT_BRANCH,
   ND,
   NBS,
   WDATE,
   NMK,
   KN_DPK,
   Z1,
   Z2,
   Z3,
   SUM_COM,
   Z4,
   Z5,
   R1,
   R2,
   K0,
   K1,
   MES,
   DAT_MOD,
   Z8,
   K2
)
AS
   SELECT RNK,
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
                    '��������',
                    'ccid',
                    nd)
             KN_DPK,
          NVL (Z1, 0) Z1,
          NVL (Z2, 0) Z2,
          NVL (Z3, 0) Z3,
          NVL (sum_com, 0) sum_com,
          NVL ( (Z1 + Z2 + Z3 + sum_com), 0) Z4,
          NVL ( (LIM - Z3), 0) Z5,
          NVL (R1, 0) R1,
          NVL (R1 - (Z1 + Z2 + Z3), 0) R2,
          NVL (K0, 0) K0,
          NVL (LEAST ( (LIM - Z3), (R1 - (Z1 + Z2 + Z3))), 0) K1,
          --(Z1 + Z2 + Z3) as K1,
          ROUND (MONTHS_BETWEEN (wdate, gl.bd), 1) MES,
          cck_dpk.DAT_MOD (ND) DAT_MOD,
          cck_dpk.Z8 (ND) Z8,
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
                  cck_dpk.sum_SS_next (d.nd) / 100 Z3,
                  /*cck_dpk.sum_SK_all ( d.nd) / 100*/
                  0 sum_com
             FROM customer c,
                  (SELECT *
                     FROM cc_deal
                    WHERE vidd IN (1, 11) AND sos > 0 AND sos < 15) d,
                  nd_acc n,
                  (SELECT *
                     FROM accounts
                    WHERE     (tip = 'SG ' OR nbs IN ('2600', '2620', '2625'))
                          AND dazs IS NULL) a,
                  nd_acc n8,
                  (SELECT *
                     FROM accounts
                    WHERE (tip = 'LIM' AND ostb < 0) AND dazs IS NULL) a8
            WHERE     d.rnk = c.rnk
                  AND d.nd = n.nd
                  AND n.acc = a.acc
                  AND d.nd = n8.nd
                  AND n8.acc = a8.acc)
--where NOT ( Z1> 0 and  NBS ='2525') --  �� ��������� ��������� ��������� � 2625 � ������������� ��� ��� ������� ���������.
;


GRANT SELECT, FLASHBACK ON BARS.V_CCKDPK TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_CCKDPK TO SBON;

GRANT SELECT ON BARS.V_CCKDPK TO START1;

GRANT SELECT ON BARS.V_CCKDPK TO UPLD;