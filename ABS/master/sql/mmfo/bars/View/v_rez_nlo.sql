

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZ_NLO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZ_NLO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZ_NLO ("DAT", "RNK", "BRANCH", "ND", "KV", "NLS", "NMK", "SDATE", "WDATE", "OBS", "FIN", "KAT", "K", "BV", "BVQ", "PV", "REZ", "ZAL", "TIP", "OB22") AS 
  SELECT B,
          rnk,
          branch,
          acc,
          kv,
          nls,
          NULL,
          daos,
          mdate,
          obs,
          fin,
          kat,
          k,
          BV,
          0,
          ROUND (BV * (1 - k), 2) PV,
          GREATEST (BV * k - ZAL, 0) REZ,
          ZAL,
          TIP,
          OB22
     FROM (SELECT V.B,
                  a.rnk,
                  a.branch,
                  a.acc,
                  a.kv,
                  a.nls,
                  a.daos,
                  a.mdate,
                  f.obs,
                  f.fin,
                  f.kat,
                  f.k,
                  -OST_KORR (a.acc,
                             v.Z,
                             z23.di,
                             a.nbs)
                  / 100
                     BV,
                  a.ob22,
                  a.tip,
                  NVL ( (SELECT SUM (t.s)
                           FROM tmp_rez_obesp23 t
                          WHERE t.dat = v.B AND t.accs = a.acc),
                       0)
                  / 100
                     ZAL
             FROM acc_nlo al,
                  accounts a,
                  V_SFDAT v,
                  acc_fin_obs_kat f
            WHERE     al.acc = a.acc
                  AND a.acc = f.acc(+)
                  AND OST_KORR (a.acc,
                                v.Z,
                                z23.di,
                                a.nbs) < 0);

PROMPT *** Create  grants  V_REZ_NLO ***
grant SELECT                                                                 on V_REZ_NLO       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_NLO       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZ_NLO.sql =========*** End *** ====
PROMPT ===================================================================================== 
