

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_CREDIT_DEAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_CREDIT_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_CREDIT_DEAL ("DEAL_ND", "REP_DATE", "BPK_ND", "DATE_OPEN", "DATE_MAT", "DATE_MCUR", "DATE_CLOSE", "KV", "DEAL_SUM", "NLS_9129", "NLS_OVR", "NLS_2208", "NLS_2207", "NLS_2209", "FORM_DATE") AS 
  select d.deal_nd,
       v.report_dt,
       d.card_nd,
       d.open_dt,
       d.matur_dt,
       v.matur_dt,
       d.close_dt,
       c.kv,
       v.deal_sum/100 deal_sum,
       c.nls, b.nls, a8.nls, a7.nls, a9.nls,
       v.CREATE_DT
  from bpk_credit_deal d,
       bpk_credit_deal_var v,
       accounts b,
       accounts c,
       accounts a8,
       accounts a7,
       accounts a9
 where d.deal_nd  = v.deal_nd
   and d.acc_9129 = c.acc
   and d.acc_ovr  = b.acc(+)
   and d.acc_2208 = a8.acc(+)
   and d.acc_2207 = a7.acc(+)
   and d.acc_2209 = a9.acc(+);

PROMPT *** Create  grants  V_BPK_CREDIT_DEAL ***
grant SELECT                                                                 on V_BPK_CREDIT_DEAL to BARSREADER_ROLE;
grant SELECT                                                                 on V_BPK_CREDIT_DEAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_CREDIT_DEAL to OW;
grant SELECT                                                                 on V_BPK_CREDIT_DEAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_CREDIT_DEAL.sql =========*** End 
PROMPT ===================================================================================== 
