

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_DEAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_DEAL ("ND", "CARD_CODE", "BRANCH", "ACC_ACC", "ACC_NLS", "ACC_KV", "ACC_LCV", "ACC_OB22", "ACC_TIP", "ACC_TIPNAME", "ACC_OST", "ACC_FOST", "ACC_DAOS", "ACC_DAZS", "CUST_RNK", "CUST_NAME", "CUST_OKPO", "CUST_TYPE", "PASS_DATE", "PASS_STATE", "DAT_ORIG_CA", "DAT_CALC_PAY") AS 
  select o.nd, o.card_code, a.branch, a.acc,
       a.nls, a.kv, t.lcv,
       a.ob22, a.tip, s.name, a.ostc/power(10, 2) ost,
       (a.ostc+nvl(q.s,0))/power(10, 2) ost,
       a.daos, a.dazs,
       c.rnk, c.nmk, c.okpo, c.custtype,
       o.pass_date, o.pass_state,
       bars_ow.get_nd_param_indate(o.nd, 'DAT_ORIG_CA'),
       bars_ow.get_nd_param_indate(o.nd, 'DAT_CALC_PAY')
  from w4_acc o, accounts a, customer c, tips s, tabval$global t,
       (select q.acc, sum(decode(q.dk,1,e.s,-e.s)) s
          from ow_pkk_que q, oper e
         where q.ref = e.ref and e.sos > 0
         group by q.acc) q, w4_nbs_ob22 n
 where o.acc_pk = a.acc
   and a.rnk = c.rnk
   and a.tip = s.tip
   and a.kv  = t.kv
   and a.acc = q.acc(+)
   and a.tip like 'W4%'
   and s.tip like 'W4%'
   and substr(a.nls,1,4) = n.nbs
   and a.ob22 = n.ob22
   and a.tip = n.tip
   and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  W4_DEAL ***
grant SELECT                                                                 on W4_DEAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_DEAL         to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_DEAL.sql =========*** End *** ======
PROMPT ===================================================================================== 
