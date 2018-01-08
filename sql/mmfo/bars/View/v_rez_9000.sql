

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZ_9000.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZ_9000 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZ_9000 ("DAT", "RNK", "BRANCH", "ND", "KV", "NLS", "SDATE", "WDATE", "NBS", "OBS", "FIN", "KAT", "K", "BV", "PV", "REZ", "ZAL", "ISTVAL", "VKR") AS 
  SELECT x.B, x.rnk, x.branch, x.nd, x.kv, x.nls, x.sdate, x.wdate, x.nbs, x.obs, x.fin, x.kat, x.k, x.BV, ROUND (x.BV * (1 - x.k), 2) PV,
          GREATEST (ROUND (x.bv - x.bv * (1 - x.k) - x.ZAL, 2), 0) REZ, x.ZAL, x.istval, x.vkr
   FROM (SELECT V.b B, a.rnk, a.branch, a.acc nd, a.kv, a.nls,  a.daos sdate, a.mdate wdate, a.nbs, f.obs, f.fin, f.kat, f.k,
                -ost_korr (a.acc,v.z,z23.di,a.nbs) / 100 BV,
               (SELECT SUM (t.s) FROM tmp_rez_obesp23 t  WHERE t.dat = v.B AND t.accs = a.acc) / 100 ZAL,
                s.istval,
               (SELECT TRIM (VALUE) FROM accountsw WHERE tag = 'VNCRR' AND acc = a.acc) VKR
             FROM accounts a, V_SFDAT v, acc_fin_obs_kat f, SPECPARAM S
            WHERE     a.nbs IN ('9000', '9002', '9003') -- счет 9001 убран, вносится в кредитный портфель межбанка в ГОУ и там считается
                  AND dazs IS NULL  AND A.ACC = s.acc(+)  AND ost_korr (a.acc,v.z,z23.di,a.nbs) < 0 AND a.acc = f.acc(+)) x;

PROMPT *** Create  grants  V_REZ_9000 ***
grant SELECT                                                                 on V_REZ_9000      to BARSREADER_ROLE;
grant SELECT                                                                 on V_REZ_9000      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_9000      to START1;
grant SELECT                                                                 on V_REZ_9000      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZ_9000.sql =========*** End *** ===
PROMPT ===================================================================================== 
