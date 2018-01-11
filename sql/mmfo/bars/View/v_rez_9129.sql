

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZ_9129.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZ_9129 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZ_9129 ("DAT", "BRANCH", "RNK", "ND", "SDATE", "WDATE", "NBS", "KV", "NLS", "TIP", "CUST", "FIN", "OBS", "KAT", "K", "BV", "R013", "ZAL", "SDI", "PV", "REZ", "ISTVAL", "VKR") AS 
  SELECT x.b, x.tobo, x.rnk, x.acc, x.sdate, x.wdate, x.nbs, x.kv, x.nls, x.tip, c.custtype, x.fin, x.obs, x.kat, x.k, x.bv, p.r013, x.zal, 0,
          ROUND (bv * (1 - k), 2) PV, GREATEST ( DECODE (p.r013, 9, 0, ROUND (bv - bv * (1 - k) - x.zal, 2)), 0) rez, p.istval, x.vkr
   FROM customer c, specparam p,
       (SELECT DISTINCT v.b, a.tobo, a.rnk, a.acc, a.daos sdate, a.mdate wdate, a.nbs, a.nls, a.kv, a.tip,
               -ost_korr (a.acc, v.z, NULL, a.nbs) / 100 BV, f.fin, f.obs, f.kat, f.k,
               ROUND (NVL ( (SELECT SUM (s) FROM tmp_rez_obesp23 WHERE dat = v.b AND accs = a.acc) / 100, 0), 2) ZAL,
              (SELECT TRIM (VALUE) FROM accountsw  WHERE tag = 'VNCRR' AND acc = a.acc) VKR
               FROM V_SFDAT v, acc_fin_obs_kat f,
                    (SELECT *  FROM v_gl
                     WHERE     nbs = '9129'
                          AND tip NOT IN ('CR9')                 -- не кредиты
                          AND acc NOT IN (SELECT acc_9129 FROM acc_over WHERE acc_9129 IS NOT NULL) -- не ќверы
                          AND acc NOT IN (SELECT acc_9129 FROM bpk_acc  WHERE acc_9129 IS NOT NULL) -- не BPK
                          AND acc NOT IN (SELECT acc_9129 FROM w4_acc   WHERE acc_9129 IS NOT NULL) -- не BPK-W4
                     ) a
               WHERE a.acc = f.acc(+) AND ost_korr (a.acc,v.z,NULL,a.nbs) < 0) x
   WHERE x.rnk = c.rnk AND x.acc = p.acc;

PROMPT *** Create  grants  V_REZ_9129 ***
grant SELECT                                                                 on V_REZ_9129      to BARSREADER_ROLE;
grant SELECT                                                                 on V_REZ_9129      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_9129      to START1;
grant SELECT                                                                 on V_REZ_9129      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZ_9129.sql =========*** End *** ===
PROMPT ===================================================================================== 
