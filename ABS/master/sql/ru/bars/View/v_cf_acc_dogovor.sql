

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CF_ACC_DOGOVOR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CF_ACC_DOGOVOR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CF_ACC_DOGOVOR ("ND", "ACCTYPE", "ACCNUM", "ACCAMOUNT", "ACCCUR", "ACCAMUAH", "ACCPDATE") AS 
  SELECT kf.nd,
          a.tip AS acctype,
          a.nls AS accnum,
          fost (a.acc, SYSDATE) AS accamount,
          a.kv AS acccur,
          fost (a.acc, SYSDATE) AS accamuah,
          (SELECT MAX (s.fdat)
             FROM nd_acc nda, accounts aa, saldoa s
            WHERE     aa.acc = nda.acc
                  AND nda.acc = s.acc
                  AND nda.nd = kf.nd
                  AND aa.tip IN ('SP ', 'SPN')
                  AND aa.dazs IS NULL)
             AS accpdate
     FROM v_cf_dogovor kf, nd_acc na, accounts a
    WHERE kf.nd = na.nd AND na.acc = a.acc
    union
    SELECT kf.nd,
           a.tip AS acctype,
           a.nls AS accnum,
           fost (a.acc, SYSDATE) AS accamount,
           a.kv AS acccur,
           fost (a.acc, SYSDATE) AS accamuah,
          (SELECT MAX (s.fdat)
             FROM W4_ACC nda, accounts aa, saldoa s
            WHERE      aa.acc = s.acc
                  AND nda.nd = kf.nd
                  AND aa.ACC in (acc_2209, acc_2207,acc_3579)
                  AND aa.dazs IS NULL)
             AS accpdate
     FROM v_cf_dogovor kf, V_W4_ND_ACC na, accounts a
    WHERE kf.nd = na.nd AND na.acc = a.acc and a.dazs is null;

PROMPT *** Create  grants  V_CF_ACC_DOGOVOR ***
grant SELECT                                                                 on V_CF_ACC_DOGOVOR to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CF_ACC_DOGOVOR.sql =========*** End *
PROMPT ===================================================================================== 
