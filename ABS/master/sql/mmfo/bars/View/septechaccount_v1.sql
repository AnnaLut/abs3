

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SEPTECHACCOUNT_V1.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view SEPTECHACCOUNT_V1 ***

  CREATE OR REPLACE FORCE VIEW BARS.SEPTECHACCOUNT_V1 ("ACC", "NLS", "NBS", "KV", "LCV", "NMS", "NLSALT", "PAP", "TIP", "ISP", "FIO", "DAOS", "DAZS", "RNK", "DIG", "BLKD", "BLKK", "TOBO", "ISF", "DOSF", "KOSF", "OSTCF", "OSTBF", "OSTFF", "DAPP", "OB22", "ACCCOUNT") AS 
  SELECT a.acc,
            a.nls,
            a.nbs,
            a.kv,
            t.lcv,
            a.nms,
            a.nlsalt,
            a.pap,
            a.tip,
            a.isp,
            f.fio,
            a.daos,
            a.dazs,
            a.rnk,
            t.dig,
            a.blkd,
            a.blkk,
            a.tobo,
              (  a.ostc
               + DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                         bankdate, a.dos,
                         0)
               - DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                         bankdate, a.kos,
                         0))
            / POWER (10, t.dig)
               AS ISf,
              DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                      bankdate, a.dos,
                      0)
            / POWER (10, t.dig)
               AS DOSf,
              DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                      bankdate, a.kos,
                      0)
            / POWER (10, t.dig)
               AS KOSf,
            a.ostc / POWER (10, t.dig) AS OSTCf,
            a.ostb / POWER (10, t.dig) AS OSTBf,
            (a.ostc + a.ostf) / POWER (10, t.dig) AS OSTFf,
            a.dapp,
            a.ob22,
            1 AS AccCount
       FROM Accounts a, Tabval t, Staff f
      WHERE     t.kv = a.kv
            AND a.isp = f.id(+)
            AND a.tip IN ('N99',
                          'L99',
                          'N00',
                          'T00',
                          'T0D',
                          'TNB',
                          'TND',
                          'TUR',
                          'TUD',
                          'L00',
                          'N77',
                          '902',
                          '90D')
            AND a.acc IN (SELECT acc
                            FROM Bank_acc
                           WHERE mfo IN (SELECT mfo FROM lkl_rrp))
            AND a.dazs IS NULL
   ORDER BY a.nls;

PROMPT *** Create  grants  SEPTECHACCOUNT_V1 ***
grant SELECT                                                                 on SEPTECHACCOUNT_V1 to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SEPTECHACCOUNT_V1.sql =========*** End 
PROMPT ===================================================================================== 
