

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMP_REZ_RISK.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view V_TMP_REZ_RISK ***
CREATE OR REPLACE FORCE VIEW BARS.V_TMP_REZ_RISK
AS
   SELECT n.fdat as dat,
          n.acc,
          n.nbs,
          n.nls,
          n.ob22,
          n.kv,
          n.rnk,
          n.okpo,
          n.custtype, 
          n.obs,
          n.kat as s080,
          n.s080 as s080_351,
          ROUND (n.rez * 100) as sz,
          ROUND (n.rezq * 100) as szq,
          ROUND (n.rez_30 * 100) rez_30,
          ROUND (n.rezq_30 * 100) rezq_30,
          n.rz,
          NVL (n.diskont, 0) * 100 as discont,
          0 prem,
          n.nd,
          n.r013,
          n.reznq,
          n.branch,
          (CASE WHEN n.s250 = '8' THEN 'RUG' || SUBSTR (n.id, 4) ELSE n.id END) id,
          NVL (NVL (n.acc_rez, n.acc_rezn), n.acc_rez_30) accr,
          NVL (n.acc_rez_30, NVL (n.acc_rez, n.acc_rezn)) accr_30,
          n.branch as tobo,
          a.mdate
     FROM nbu23_rez n, accounts a
     where n.acc = a.acc;

PROMPT *** Create  grants  V_TMP_REZ_RISK ***
grant SELECT                                                                 on V_TMP_REZ_RISK  to BARSREADER_ROLE;
grant SELECT                                                                 on V_TMP_REZ_RISK  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMP_REZ_RISK.sql =========*** End ***
PROMPT ===================================================================================== 
