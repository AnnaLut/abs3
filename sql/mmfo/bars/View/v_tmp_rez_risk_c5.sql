/* Formatted on 27/06/2018 20:36:57 (QP5 v5.227.12220.39724) */
CREATE OR REPLACE FORCE VIEW BARS.V_TMP_REZ_RISK_C5
(
   DAT,
   ACC,
   NLS,
   KV,
   RNK,
   ND,
   ID,
   S080,
   SZ,
   SZQ,
   REZ_30,
   REZQ_30,
   RZ,
   DISCONT,
   PREM,
   R013,
   REZNQ,
   BVQ,
   TOBO,
   ACCR,
   ACCR_30,
   DAT_MI,
   ZPR,
   PV, 
   NBS
)
AS
     SELECT fdat dat,
            acc,
            nls,
            kv,
            rnk,
            MAX (nd) nd,
            MAX (
               (CASE WHEN s250 = '8' THEN 'RUG' || SUBSTR (id, 4) ELSE id END))
               id,
            MAX (kat) s080,
            SUM (ROUND (rez * 100)) sz,
            SUM (ROUND (rezq * 100)) szq,
            SUM (ROUND (rez_30 * 100)) rez_30,
            SUM (ROUND (rezq_30 * 100)) rezq_30,
            MAX (rz) rz,
            SUM (NVL (diskont, 0) * 100) discont,
            0 prem,
            MAX (r013) r013,
            SUM (reznq * 100) reznq,
            SUM (bvq * 100) bvq,
            branch,
            NVL (NVL (acc_rez, acc_rezn), acc_rez_30) accr,
            NVL (acc_rez_30, NVL (acc_rez, acc_rezn)) accr_30,
            dat_mi,
            SUM (
               (CASE
                   WHEN nbs NOT LIKE '204%' THEN 0
                   ELSE NVL (zpr, 0) * 100
                END))
               zpr,
            SUM ( NVL (pv, 0) * 100 ) pv,
            nbs
       FROM nbu23_rez a
      WHERE rez <> 0 OR diskont <> 0
   GROUP BY fdat,
            acc,
            nls,
            nbs,
            kv,
            rnk,
            branch,
            NVL (NVL (acc_rez, acc_rezn), acc_rez_30),
            NVL (acc_rez_30, NVL (acc_rez, acc_rezn)),
            dat_mi;


GRANT SELECT ON BARS.V_TMP_REZ_RISK_C5 TO BARSREADER_ROLE;

GRANT SELECT ON BARS.V_TMP_REZ_RISK_C5 TO UPLD;
