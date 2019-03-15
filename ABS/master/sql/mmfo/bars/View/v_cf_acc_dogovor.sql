
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_cf_acc_dogovor.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_CF_ACC_DOGOVOR ("ND", "ACCTYPE", "ACCNUM", "OB22", "ACCAMOUNT", "ACCCUR", "ACCAMUAH", "ACCPDATE") AS 
  SELECT na.nd,
          a.tip AS acctype,
          a.nls AS accnum,
          a.ob22 as ob22,
          fost (a.acc, SYSDATE) AS accamount,
          a.kv AS acccur,
          case a.kv
            when 980 then fost(a.acc,sysdate)
            else round(a.acc*rato(a.kv,trunc(sysdate)),2)
          end  AS accamuah,
          A.DAPP AS accpdate
     FROM /*v_cf_dogovor kf,*/ nd_acc na, accounts a
    WHERE /*kf.nd = na.nd AND*/ na.acc = a.acc
   UNION
   SELECT na.nd,
          a.tip AS acctype,
          a.nls AS accnum,
          a.ob22 as ob22,
          fost (a.acc, SYSDATE) AS accamount,
          a.kv AS acccur,
          case a.kv
            when 980 then fost(a.acc,sysdate)
            else round(a.acc*rato(a.kv,trunc(sysdate)),2)
          end  AS accamuah,
          A.DAPP AS accpdate
     FROM /*v_cf_dogovor kf,*/ V_W4_ND_ACC na, accounts a
    WHERE /*kf.nd = na.nd AND*/ na.acc = a.acc AND a.dazs IS NULL
;
 show err;
 
PROMPT *** Create  grants  V_CF_ACC_DOGOVOR ***
grant SELECT                                                                 on V_CF_ACC_DOGOVOR to BARSREADER_ROLE;
grant SELECT                                                                 on V_CF_ACC_DOGOVOR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CF_ACC_DOGOVOR to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_cf_acc_dogovor.sql =========*** End *
 PROMPT ===================================================================================== 
 