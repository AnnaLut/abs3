

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZ_2605.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZ_2605 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZ_2605 ("ACC", "DAT", "RNK", "BRANCH", "ND", "KV", "NBS", "NLS", "SDATE", "WDATE", "OBS", "FIN", "KAT", "K", "BV", "PV", "REZ", "ZAL") AS 
  SELECT q.ACC,
          q.B,
          q.rnk,
          q.tobo,
          q.acc,
          q.kv,
          q.NBS,
          q.nls,
          q.daos,
          q.mdate,
          f.obs,
          f.fin,
          f.kat,
          f.k,
          q.BV / 100 BV,
          q.BV * (1 - f.k) / 100 PV,
          GREATEST (q.BV * f.k - q.ZAL, 0) / 100 REZ,
          q.ZAL / 100 ZAL
     FROM acc_fin_obs_kat f,
          (SELECT v.B,
                  a.acc,
                  a.rnk,
                  a.tobo,
                  a.kv,
                  a.nls,
                  a.nbs,
                  a.daos,
                  a.mdate,
                  -rez1.ostc96 (a.acc, Dat_last (v.b - 4, v.b)) BV,
                  NVL ( (SELECT SUM (s)
                           FROM tmp_rez_obesp23
                          WHERE dat = v.B AND accs = a.acc),
                       0)
                     zal
             FROM v_gl a, V_SFDAT v
            WHERE a.nbs = '2605'
                  AND rez1.ostc96 (a.acc, Dat_last (v.b - 4, v.b)) < 0) q
    WHERE q.acc = f.acc(+);

PROMPT *** Create  grants  V_REZ_2605 ***
grant SELECT                                                                 on V_REZ_2605      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_2605      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZ_2605.sql =========*** End *** ===
PROMPT ===================================================================================== 
