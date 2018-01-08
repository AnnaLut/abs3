

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SEPTECHACCOUNT_V2.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view SEPTECHACCOUNT_V2 ***

  CREATE OR REPLACE FORCE VIEW BARS.SEPTECHACCOUNT_V2 ("ACC", "NLS", "NBS", "KV", "LCV", "NMS", "NLSALT", "PAP", "TIP", "ISP", "FIO", "DAOS", "DAZS", "RNK", "DIG", "BLKD", "BLKK", "TOBO", "ISF", "DOSF", "KOSF", "OSTCF", "OSTBF", "OSTFF", "DAPP", "OB22", "ACCCOUNT") AS 
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
              (  fost_h (a.acc, gl.bd)
               + fdos (a.acc, gl.bd, gl.bd)
               - fkos (a.acc, gl.bd, gl.bd))
            / POWER (10, t.dig)
               AS ISf,
            fdos (a.acc, gl.bd, gl.bd) / POWER (10, t.dig) AS DOSf,
            fkos (a.acc, gl.bd, gl.bd) / POWER (10, t.dig) AS KOSf,
            fost_h (a.acc, gl.bd) / POWER (10, t.dig) AS OSTCf,
            a.ostb / POWER (10, t.dig) AS OSTBf,
            (a.ostc + a.ostf) / POWER (10, t.dig) AS OSTFf,
            a.dapp,
            a.ob22,
            1 AS AccCount
       --INTO :colACC, :colNLS, :colNBS, :colKV, :colISO, :colNMS, :colNLSALT, :nPap, :colTIP, :colOWN, :colONAME, :colDAOS, :colDAZS, :colRNK, :colDig, :colBDCODE, :colBKCODE, :colTOBO,
       --:colISf, :colDOSf, :colKOSf, :colOSTCf, :colOSTBf, :colOSTFf, :colDAPP, :colOB22, :colAccCount FROM Accounts a, Tabval t, Staff f WHERE t.kv=a.kv AND a.isp=f.id (+)   AND a.tip in ('N99' :colONAME, :colDAOS, :colDAZS, :colRNK, :colDig, :colBDCODE, :colBKCODE, :colTOBO, :colISf, :colDOSf, :colKOSf, :colOSTCf, :colOSTBf, :colOSTFf, :colDAPP, :colOB22, :colAccCount
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

PROMPT *** Create  grants  SEPTECHACCOUNT_V2 ***
grant SELECT                                                                 on SEPTECHACCOUNT_V2 to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SEPTECHACCOUNT_V2.sql =========*** End 
PROMPT ===================================================================================== 
