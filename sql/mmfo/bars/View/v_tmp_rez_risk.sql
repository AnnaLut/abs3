DROP VIEW BARS.V_TMP_REZ_RISK;

/* Formatted on 20/02/2019 14:36:06 (QP5 v5.252.13127.32847) */
CREATE OR REPLACE FORCE VIEW BARS.V_TMP_REZ_RISK
(
   DAT,
   ACC,
   NBS,
   NLS,
   OB22,
   KV,
   RNK,
   OKPO,
   CUSTTYPE,
   OBS,
   S080,
   S080_351,
   SZ,
   SZQ,
   REZ_30,
   REZQ_30,
   RZ,
   DISCONT,
   PREM,
   ND,
   R013,
   REZNQ,
   BRANCH,
   ID,
   ACCR,
   ACCR_30,
   TOBO,
   MDATE, 
   ZPR
)
AS
   SELECT n.fdat AS dat,
          n.acc,
          n.nbs,
          n.nls,
          n.ob22,
          n.kv,
          n.rnk,
          n.okpo,
          n.custtype,
          n.obs,
          n.kat AS s080,
          n.s080 AS s080_351,
          ROUND (n.rez * 100) AS sz,
          ROUND (n.rezq * 100) AS szq,
          ROUND (n.rez_30 * 100) rez_30,
          ROUND (n.rezq_30 * 100) rezq_30,
          n.rz,
          NVL (n.diskont, 0) * 100 AS discont,
          0 prem,
          n.nd,
          n.r013,
          n.reznq,
          n.branch,
          (CASE
              WHEN n.s250 = '8' THEN 'RUG' || SUBSTR (n.id, 4)
              ELSE n.id
           END)
             id,
          NVL (NVL (n.acc_rez, n.acc_rezn), n.acc_rez_30) accr,
          NVL (n.acc_rez_30, NVL (n.acc_rez, n.acc_rezn)) accr_30,
          n.branch AS tobo,
          a.mdate, 
          (CASE
              WHEN n.nbs NOT LIKE '204%' AND n.nbs NOT LIKE '239%' THEN 0
              ELSE NVL (n.zpr, 0) * 100
           END) zpr
     FROM nbu23_rez n, accounts a
    WHERE n.acc = a.acc;


GRANT SELECT ON BARS.V_TMP_REZ_RISK TO BARSREADER_ROLE;

GRANT SELECT ON BARS.V_TMP_REZ_RISK TO UPLD;
