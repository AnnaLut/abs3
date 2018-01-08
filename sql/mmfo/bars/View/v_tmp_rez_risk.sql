

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMP_REZ_RISK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TMP_REZ_RISK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TMP_REZ_RISK ("DAT", "ACC", "NBS", "NLS", "KV", "RNK", "OBS", "S080", "S080_351", "SZ", "SZQ", "RZ", "DISCONT", "PREM", "ND", "R013", "REZNQ", "TOBO", "ID", "ACCR") AS 
  SELECT fdat dat,
          acc,
          nbs,
          nls,
          kv,
          rnk,
          obs,
          kat,
          s080,
          ROUND (rez * 100) sz,
          ROUND (rezq * 100) szq,
          rz,
          0 discont,
          0 prem,
          nd,
          r013,
          reznq,
          branch,
          (CASE WHEN s250 = '8' THEN 'RUG' || SUBSTR (id, 4) ELSE id END) id,
          NVL (NVL (acc_rez, acc_rezn), acc_rez_30) accr
     FROM nbu23_rez;

PROMPT *** Create  grants  V_TMP_REZ_RISK ***
grant SELECT                                                                 on V_TMP_REZ_RISK  to BARSREADER_ROLE;
grant SELECT                                                                 on V_TMP_REZ_RISK  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMP_REZ_RISK.sql =========*** End ***
PROMPT ===================================================================================== 
