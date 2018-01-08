

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZ_9020.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZ_9020 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZ_9020 ("DAT", "BRANCH", "RNK", "ND", "CC_ID", "ACC", "KV", "NLS", "SDATE", "WDATE", "NBS", "OBS", "FIN", "KAT", "K", "BV", "PV", "REZ", "ZAL", "SDI", "CUST", "R013", "ISTVAL", "VKR") AS 
  SELECT x.b , x.branch, x.rnk, x.nd, x.cc_id, x.acc, x.kv, x.nls, x.sdate, x.wdate, x.nbs, x.obs, x.fin, x.KAT, x.K,
          x.BV,
          DECODE ( SUBSTR (nls, 1, 4), '9023', DECODE (x.r013, 1, bv, ROUND (NVL (x.bv * (1 - x.k), 0), 2) + x.SDI),
                                                                      ROUND (NVL (x.bv * (1 - x.k), 0), 2) + x.SDI) PV,
          --  для 9023 R013=1 -  для авалів податкових векселів - резерв не нараховується
          --  п.1.2 Глава 1 Розділ IV Постанови 23 НБУ
          DECODE ( SUBSTR (nls, 1, 4), '9023', DECODE (x.r013, 1, 0, GREATEST ( (x.bv - NVL (x.bv * (1 - x.k), 0) - x.zal - x.SDI), 0)),
                                                                     GREATEST ( (x.bv - NVL (x.bv * (1 - x.k), 0) - x.zal - x.SDI), 0)) REZ,
          x.zal, x.SDI, x.cust, x.R013, x.istval, x.vkr
   FROM (SELECT V.b B, a.tobo branch, a.rnk, NVL (d.nd, a.acc) nd, cd.cc_id cc_id, a.acc acc, a.kv, a.nls, a.nbs, cd.sdate sdate,
                NVL (cd.wdate, a.mdate) wdate, NVL (cd.obs23, f.obs) obs, NVL (cd.fin23, f.fin) fin, NVL (cd.kat23, f.kat) kat,
                NVL (cd.k23, f.k) k, -ost_korr (a.acc, v.z, z23.di, a.nbs) / 100  BV,
                NVL ( (SELECT SUM (t.s) FROM tmp_rez_obesp23 t  WHERE t.dat = v.B AND t.accs = a.acc) / 100, 0) ZAL,
                (SELECT NVL (SUM (NVL (ost_korr (a36.acc,v.z,z23.di,a36.nbs),0)),0)
                 FROM   accounts a36, nd_acc na, nd_acc n
                 WHERE  a.acc = na.acc AND na.nd = n.nd  AND n.acc = a36.acc AND a36.nbs = '3648') / 100  SDI,
                DECODE (custtype,  1, 2,  3, DECODE (sed, 91, 2, 3),  3) cust, s.r013, s.istval, cck_app.get_nd_txt (cd.nd, 'VNCRR') VKR
            FROM  accounts a, cc_deal cd, nd_acc d, V_SFDAT v, acc_fin_obs_kat f, customer c, specparam s
            WHERE a.nbs IN ('9020', '9023', '9122')  AND (dazs IS NULL OR dazs > v.z) AND a.rnk = c.rnk  AND d.nd = cd.nd(+)
              AND a.acc = d.acc(+)                   AND a.acc = s.acc(+)             AND ost_korr (a.acc,v.z,z23.di, a.nbs) < 0
              AND a.acc = f.acc(+)) x;

PROMPT *** Create  grants  V_REZ_9020 ***
grant SELECT                                                                 on V_REZ_9020      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_9020      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZ_9020.sql =========*** End *** ===
PROMPT ===================================================================================== 
