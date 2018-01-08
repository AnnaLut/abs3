

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AUD_CCK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view AUD_CCK ***

  CREATE OR REPLACE FORCE VIEW BARS.AUD_CCK ("PROD", "BRANCH", "ND", "NLS", "KV", "OB22F", "TIP", "OST", "DAOS", "ACC", "OB22P") AS 
  SELECT SUBSTR (prod, 1, 6),
          branch,
          nd,
          nls,
          kv,
          ob22f,
          tip,
          ostc,
          daos,
          acc,
          ob22p
     FROM (SELECT d.prod,
                  d.branch,
                  d.nd,
                  a.nls,
                  a.kv,
                  NVL (a.ob22, '  ') ob22f,
                  a.tip,
                  -a.ostc / 100 ostc,
                  a.daos,
                  a.acc,
                  DECODE (
                     a.tip,
                     'SS ', c.ob22,
                     'SPI', c.spi,
                     'SDI', c.sdi,
                     'SP ', c.sp,
                     'SN ', c.sn,
                     'SNO', c.sn,
                     'SPN', c.spn,
                     'SLN', c.sln,
                     'CR9', c.cr9,
                     'SK0', c.sk0,
                     'SK9', c.sk9,
                     'SG ', c.sg,
                     'SL ', c.sl,
                     'CRD', c.crd,
                     'SLK', c.slk,
                     'S36', c.s36,
                     'ISG', c.isg,
                     'SD ', DECODE (a.kv, 980, c.sd_n, c.sd_i),
                     DECODE (SUBSTR (a.nbs, 1, 3),
                             '903', s903,
                             '950', s950,
                             '952', s952,
                             '??'))
                     ob22p
             FROM cck_ob22 c,
                  accounts a,
                  cc_deal d,
                  nd_acc n
            WHERE     d.vidd IN (1, 2, 3, 11, 12, 13)
                  AND d.nd = n.nd
                  AND n.acc = a.acc
                  AND a.nls NOT LIKE '8%'
                  AND a.dazs IS NULL
                  AND c.nbs = SUBSTR (d.prod, 1, 4)
                  AND c.ob22 = SUBSTR (d.prod, 5, 2)
                  AND a.tip not in ('DEP'))
    WHERE ob22f <> ob22p
   UNION ALL
   SELECT SUBSTR (d.prod, 1, 6),
          d.branch,
          d.nd,
          a.nls,
          a.kv,
          a.ob22,
          a.tip,
          a.ostc / 100,
          a.daos,
          a.acc,
          '!!'
     FROM cc_deal d, nd_acc n, accounts a
    WHERE     d.vidd IN (1, 2, 3, 11, 12, 13)
          AND d.nd = n.nd
          AND n.acc = a.acc
          AND a.nls NOT LIKE '8%'
          AND a.tip not in ('DEP')
          AND a.dazs IS NULL
          AND NOT EXISTS
                     (SELECT 1
                        FROM cck_ob22 c
                       WHERE     c.nbs = SUBSTR (d.prod, 1, 4)
                             AND ob22 = SUBSTR (d.prod, 5, 2));

PROMPT *** Create  grants  AUD_CCK ***
grant SELECT                                                                 on AUD_CCK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AUD_CCK         to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on AUD_CCK         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AUD_CCK.sql =========*** End *** ======
PROMPT ===================================================================================== 
