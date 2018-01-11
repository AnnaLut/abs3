

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BIC_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BIC_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BIC_ACC ("ACC_BIC", "NLS_KV") AS 
  (select t2.acc || '_' || t2.bic, a.nls || ' (' || a.kv || ')'
      from bic_acc t2, accounts a
     where     t2.acc = a.acc
           and a.kv in (select t1.kvp
                          from ch_kv t1
                         where t1.kvc = to_number (pul.get ('CHKVC'))));

PROMPT *** Create  grants  V_BIC_ACC ***
grant SELECT                                                                 on V_BIC_ACC       to BARSREADER_ROLE;
grant SELECT                                                                 on V_BIC_ACC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BIC_ACC       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BIC_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
