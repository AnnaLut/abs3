

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
          A.DAPP
             AS accpdate
     FROM v_cf_dogovor kf, nd_acc na, accounts a
    WHERE kf.nd = na.nd AND na.acc = a.acc
   UNION
   SELECT kf.nd,
          a.tip AS acctype,
          a.nls AS accnum,
          fost (a.acc, SYSDATE) AS accamount,
          a.kv AS acccur,
          fost (a.acc, SYSDATE) AS accamuah,
          A.DAPP
             AS accpdate
     FROM v_cf_dogovor kf, V_W4_ND_ACC na, accounts a
    WHERE kf.nd = na.nd AND na.acc = a.acc AND a.dazs IS NULL;

PROMPT *** Create  grants  V_CF_ACC_DOGOVOR ***
grant SELECT                                                                 on V_CF_ACC_DOGOVOR to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CF_ACC_DOGOVOR.sql =========*** End *
PROMPT ===================================================================================== 
