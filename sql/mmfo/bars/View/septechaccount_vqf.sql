

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SEPTECHACCOUNT_VQF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view SEPTECHACCOUNT_VQF ***

  CREATE OR REPLACE FORCE VIEW BARS.SEPTECHACCOUNT_VQF ("ACC", "NLS", "NBS", "KV", "LCV", "NMS", "NLSALT", "PAP", "TIP", "ISP", "FIO", "DAOS", "DAZS", "RNK", "DIG", "BLKD", "BLKK", "TOBO", "ISQF", "DOSQF", "KOSQF", "OSTCQF", "OSTBQF", "OSTFQF", "ISF", "DOSF", "KOSF", "OSTCF", "OSTBF", "OSTFF", "DAPP", "OB22", "COLACCCOUNT") AS 
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
            gl.p_icurval (
               a.kv,
               (  a.ostc
                + DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                          bankdate, a.dos,
                          0)
                - DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                          bankdate, a.kos,
                          0)),
               bankdate)
               AS ISqf,
            gl.p_icurval (
               a.kv,
               DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                       bankdate, a.dos,
                       0),
               bankdate)
               AS DOSqf,
            gl.p_icurval (
               a.kv,
               DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                       bankdate, a.kos,
                       0),
               bankdate)
               AS KOSqf,
            gl.p_icurval (a.kv, a.ostc, bankdate) AS OSTCqf,
            gl.p_icurval (a.kv, a.ostb, bankdate) AS OSTBqf,
            gl.p_icurval (a.kv, (a.ostc + a.ostf), bankdate) AS OSTFqf,
            (  a.ostc
             + DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                       bankdate, a.dos,
                       0)
             - DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                       bankdate, a.kos,
                       0))
               AS ISf,
            DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                    bankdate, a.dos,
                    0)
               AS DOSf,
            DECODE (GREATEST (a.dapp, NVL (a.dapp, a.dappq)),
                    bankdate, a.kos,
                    0)
               AS KOSf,
            a.ostc AS OSTCf,
            a.ostb AS OSTBf,
            (a.ostc + a.ostf) AS OSTFf,
            a.dapp,
            a.ob22,
            1 AS colAccCount
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

PROMPT *** Create  grants  SEPTECHACCOUNT_VQF ***
grant SELECT                                                                 on SEPTECHACCOUNT_VQF to BARSREADER_ROLE;
grant SELECT                                                                 on SEPTECHACCOUNT_VQF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEPTECHACCOUNT_VQF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SEPTECHACCOUNT_VQF.sql =========*** End
PROMPT ===================================================================================== 
