

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_E_DEAL_ACC26.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_E_DEAL_ACC26 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_E_DEAL_ACC26 ("OPT", "ND", "RNK", "ACC", "NLS_KV") AS 
  (select case when d.acc26 = a.acc then 1 else 0 end as opt,
           d.nd,
           a.rnk,
           a.acc,
           a.nls || '(' || a.kv || ')' as nls_kv
      from accounts a, e_deal$base d
     where     a.rnk = d.rnk
           and a.nbs in (select nbs from e_nbs)
           and a.tip in ('ODB', 'BDB', 'SS')
           and a.dazs is null
           and d.nd = to_number (pul.get('DEAL_ND')));

PROMPT *** Create  grants  V_E_DEAL_ACC26 ***
grant SELECT                                                                 on V_E_DEAL_ACC26  to BARSREADER_ROLE;
grant SELECT                                                                 on V_E_DEAL_ACC26  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_E_DEAL_ACC26  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_E_DEAL_ACC26.sql =========*** End ***
PROMPT ===================================================================================== 
