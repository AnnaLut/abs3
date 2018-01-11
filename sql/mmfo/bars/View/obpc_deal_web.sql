

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_DEAL_WEB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_DEAL_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_DEAL_WEB ("ND", "BRANCH", "ACC_ACC", "ACC_NLS", "ACC_KV", "ACC_LCV", "CARD_ACCT", "ACC_TIP", "ACC_TIPNAME", "ACC_OST", "ACC_DAOS", "ACC_DAZS", "CUST_RNK", "CUST_NAME", "CUST_OKPO", "CUST_TYPE", "DOC_ID") AS 
  select nd, branch, acc acc_acc, nls acc_nls, kv acc_kv, lcv acc_lcv, card_acct,
       tip acc_tip, name acc_tipname, ost acc_ost, daos acc_daos, dazs acc_dazs,
       rnk cust_rnk, nmk cust_name, okpo cust_okpo, custtype cust_type,
       nvl2(prod_id, (select 'id in (''' || id_doc || ''', ''' || id_doc_cred || ''')' from bpk_product where id = prod_id), '1=0') doc_id from (
select o.nd, a.branch, a.acc, a.nls, a.kv, decode(a.kv,980,'UAH','USD') lcv, p.card_acct,
       a.tip, s.name, a.ostc/power(10, 2) ost, a.daos, a.dazs,
       c.rnk, upper(c.nmk) nmk, c.okpo, c.custtype,
       ( select b.id from bpk_product b, demand_acc_type d
          where d.tip = a.tip
            and b.type = d.type
            and b.card_type = d.card_type
            and b.kv = a.kv
            and b.kk = p.serv_code
            and b.cond_set = p.cond_set
            and b.nbs = a.nbs
            and b.ob22 = a.ob22 ) prod_id
  from bpk_acc o, accounts a, customer c, tips s, obpc_acct p
 where o.acc_pk = a.acc
   and a.rnk = c.rnk
   and a.tip = s.tip
   and a.acc = p.acc(+)
   and a.branch like sys_context('bars_context', 'user_branch_mask') );

PROMPT *** Create  grants  OBPC_DEAL_WEB ***
grant SELECT                                                                 on OBPC_DEAL_WEB   to BARSREADER_ROLE;
grant SELECT                                                                 on OBPC_DEAL_WEB   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_DEAL_WEB   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_DEAL_WEB.sql =========*** End *** 
PROMPT ===================================================================================== 
