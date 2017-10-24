

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_DEAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_DEAL ("ND", "PRODUCT_ID", "BRANCH", "ACC_ACC", "ACC_NLS", "ACC_KV", "ACC_LCV", "CARD_ACCT", "COND_SET", "ACC_OB22", "ACC_TIP", "ACC_TIPNAME", "ACC_OST", "ACC_FOST", "ACC_DAOS", "ACC_DAZS", "CUST_RNK", "CUST_NAME", "CUST_OKPO", "CUST_TYPE", "CARD_SERVCODE", "CARD_SERVNAME") AS 
  select o.nd, o.product_id, a.branch, a.acc,
       a.nls, a.kv, decode(a.kv,980,'UAH','USD') lcv, p.card_acct, p.cond_set,
       a.ob22, a.tip, s.name, a.ostc/power(10, 2) ost, (a.ostc+nvl(q.s,0))/power(10, 2) ost, a.daos, a.dazs,
       c.rnk, c.nmk, c.okpo, c.custtype, i.demand_kk, k.name
  from bpk_acc o, accounts a, customer c, tips s,
       obpc_acct p, specparam_int i, demand_kk k,
       (select q.acc, sum(decode(r.dk,1,nvl(q.s,e.s),-nvl(q.s,e.s))) s
          from pkk_que q, oper e, obpc_trans_out u,obpc_trans r
         where q.ref = e.ref and e.tt = u.tt and u.tran_type = r.tran_type
         group by q.acc) q
 where o.acc_pk = a.acc
   and a.rnk = c.rnk
   and a.tip = s.tip
   and a.acc = p.acc(+)
   and a.acc = i.acc(+)
   and i.demand_kk = k.kk(+)
   and a.acc = q.acc(+)
   and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  OBPC_DEAL ***
grant SELECT                                                                 on OBPC_DEAL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_DEAL       to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_DEAL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_DEAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
