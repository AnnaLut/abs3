

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RNK_KAT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RNK_KAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RNK_KAT ("TIP", "NMO", "VIDD", "RNK", "ND", "SDATE", "WDATE", "BRANCH", "FIN23", "OBS23", "KAT23", "K23", "KV", "PROD", "ISTVAL") AS 
  SELECT   'CCK' AS tip, 'Кредит' NMO , c.vidd, c.rnk, c.nd, c.sdate, c.wdate, c.branch, c.fin23,
         c.obs23     , c.kat23,c.k23, d.kv  , c.prod PROD, f_get_istval (c.nd,0,c.sdate,d.kv) ISTVAL
         -- для валютных кредитов и нет источника вал.выручки ISTVAL=0,
         -- для всех остальных ISTVAL=1, при определении единой категории качества
FROM     cc_deal c, cc_add d, V_SFDAT v, nd_acc nd, accounts ac
WHERE    c.nd = nd.nd AND nd.acc = ac.acc AND ac.tip = 'LIM' AND SUBSTR (c.prod, 1, 1) <> '9'
         AND (ac.dazs IS NULL OR ac.dazs > v.z) AND c.nd = d.nd AND c.sos>=10
UNION ALL
SELECT   'OVR' AS tip, 'Овердрафт' NMO, 2600 AS vidd, a.rnk, o.nd, datd AS sdate, datd2 AS wdate,
         a.branch, o.fin23, o.obs23, o.kat23, o.k23, a.kv, a.nls prod,
         f_get_istval (0,a.acc,datd,a.kv) ISTVAL
FROM     acc_over o, accounts a
WHERE    o.acc = a.acc AND o.acc = o.acco
UNION ALL
SELECT   b.bpk tip, DECODE (b.bpk, 'BPK', 'Старий процесінг','Новий процесінг') NMO,
         0 vidd, a.rnk, b.nd, b.sdate, NULL wdate, a.branch, b.fin23, b.obs23, b.kat23, b.k23,
         a.kv, a.nls PROD, f_get_istval (0,a.acc,b.sdate,a.kv) ISTVAL
FROM    (SELECT acc_2207 ACC, fin23, obs23, kat23, k23,'BPK' BPK, nd, NULL sdate
         FROM   v_bbpk_acc WHERE  acc_2207 IS NOT NULL
         UNION ALL
         SELECT acc_2209    , fin23, obs23, kat23, k23,'BPK' BPK, nd, NULL sdate
         FROM v_bbpk_acc   WHERE acc_2209 IS NOT NULL
         UNION ALL
         SELECT acc_2208    , fin23, obs23, kat23, k23,'BPK' BPK, nd, NULL sdate
         FROM V_bbpk_acc   WHERE acc_2208 IS NOT NULL
         UNION ALL
         SELECT ACC_OVR     , fin23, obs23, kat23, k23,'BPK' BPK, nd, NULL sdate
         FROM V_bbpk_acc   WHERE acc_OVR IS NOT NULL
         UNION ALL
         SELECT ACC_9129    , fin23, obs23, kat23, k23,'BPK' BPK, nd, NULL sdate
         FROM V_bbpk_acc   WHERE acc_9129 IS NOT NULL
         UNION ALL
         SELECT ACC_PK      , fin23, obs23, kat23, k23,'BPK' BPK, nd, NULL sdate
         FROM V_bbpk_acc   WHERE acc_PK IS NOT NULL
         UNION ALL
         SELECT acc_2207    , fin23, obs23, kat23, k23,'W4'  BPK, nd, dat_begin sdate
         FROM V_w4_acc     WHERE acc_2207 IS NOT NULL
         UNION ALL
         SELECT acc_2209    , fin23, obs23, kat23, k23,'W4'  BPK, nd, dat_begin sdate
         FROM V_w4_acc     WHERE acc_2209 IS NOT NULL
         UNION ALL
         SELECT acc_2208    , fin23, obs23, kat23, k23,'W4'  BPK, nd, dat_begin sdate
         FROM V_w4_acc     WHERE acc_2208 IS NOT NULL
         UNION ALL
         SELECT NVL (ACC_OVR, acc_2203), fin23, obs23, kat23, k23,'W4' BPK, nd, dat_begin sdate
         FROM V_w4_acc     WHERE NVL (ACC_OVR, acc_2203) IS NOT NULL
         UNION ALL
         SELECT ACC_2627    , fin23, obs23, kat23, k23, 'W4' BPK, nd, dat_begin sdate
         FROM V_w4_acc     WHERE acc_2627 IS NOT NULL
         UNION ALL
         SELECT ACC_9129    , fin23, obs23, kat23, k23, 'W4' BPK, nd, dat_begin sdate
         FROM V_w4_acc     WHERE acc_9129 IS NOT NULL
         UNION ALL
         SELECT ACC_PK      , fin23, obs23, kat23, k23, 'W4' BPK, nd, dat_begin sdate
         FROM v_w4_acc     WHERE acc_PK IS NOT NULL) b, accounts a,  V_SFDAT v
WHERE    b.acc = a.acc AND a.nbs NOT IN ('3550', '3551') AND ost_korr (a.acc,v.z,z23.di,a.nbs) < 0
UNION ALL
SELECT   '9020' AS tip, 'Гарантії' NMO, 9020 vidd, c.rnk, c.nd, c.sdate, c.wdate, c.branch,
         c.fin, c.obs, c.kat, c.k, c.kv, c.nls prod, f_get_istval (0,c.acc,c.sdate,c.kv) ISTVAL
         -- для валютных кредитов и нет источника вал.выручки ISTVAL=0,
         -- для всех остальных ISTVAL=1, при определении единой категории качества
FROM v_rez_9020 c
UNION ALL
SELECT   'KORR' AS tip, 'Коррахунки' NMO, TO_NUMBER (A.NBS) AS vidd, A.RNK,  a.acc AS ND, A.DAOS AS sdate,
         A.mdate AS wdate, A.tobo AS branch, NVL (d.fin23, 1) AS FIN, NVL (d.obs23, 1) AS OBS,
         NVL (d.kat23, 1) AS KAT, NVL (d.k23, 0) AS K, A.KV, A.Nls PROD, 1 AS ISTVAL
FROM     accounts a, nd_acc n, cc_deal d
WHERE    a.nbs IN (1500, 1502, 1508, 1509)  AND a.ostc < 0  AND a.nbs IS NOT NULL
         AND (a.dazs IS NULL or a.dazs >= trunc(sysdate,'MM') )  AND a.acc = n.acc and n.nd=d.nd
UNION ALL
SELECT   'MBDK' AS tip,'Міжбанк.кред./депоз.' NMO, 1521 AS vidd, d.RNK, d.nd AS ND, d.sdate AS sdate,
         d.wdate AS wdate, d.branch AS branch, d.fin23 AS FIN, d.obs23 AS OBS, d.kat23 AS KAT,d.k23 AS K,
         cd.KV, a.nbs PROD, 1 AS ISTVAL
         -- для межбанка не распространяется нет источника вал. выручки
FROM     cc_deal d, cc_add cd, accounts a
WHERE    vidd LIKE '15%'  AND sos <> 15 and vidd<>150 AND d.nd = cd.nd AND cd.accs = a.acc
         AND a.ostc < 0
UNION ALL
SELECT 'DEB_' AS TIP, 'Дебіторка' NMO, TO_NUMBER (a.nbs) VIDD, a.rnk, a.acc nd, a.daos sdate,
       a.mdate wdate, a.branch, b.fin, b.obs, b.kat, b.k, a.kv, a.nls prod,
       f_get_istval (0,a.acc,a.daos, a.kv) ISTVAL   -- вставила по параметру ISTVAL 04-11-2014
FROM ACCOUNTS a, V_SFDAT v, acc_deb_23 b, customer c
WHERE a.nbs IN ('1811', '1819', '2800', '2801', '2805', '2806', '2809', '3540', '3541', '3548',
                '3570', '3578', '3579', '3710', '3510', '3519', '3550', '3551', '3552', '3559')
      AND (dazs IS NULL OR dazs > v.z) AND a.acc = b.acc AND a.rnk = c.rnk
      AND SYS_CONTEXT ('bars_gl', 'okpo') <> c.OKPO;

PROMPT *** Create  grants  V_RNK_KAT ***
grant SELECT                                                                 on V_RNK_KAT       to BARSREADER_ROLE;
grant SELECT                                                                 on V_RNK_KAT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RNK_KAT       to START1;
grant SELECT                                                                 on V_RNK_KAT       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RNK_KAT.sql =========*** End *** ====
PROMPT ===================================================================================== 
