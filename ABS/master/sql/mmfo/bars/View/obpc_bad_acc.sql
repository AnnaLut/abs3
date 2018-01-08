

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OBPC_BAD_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view OBPC_BAD_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.OBPC_BAD_ACC ("BRANCH", "CARD_ACCT", "CARD_NLS", "CARD_LCV", "ACC_NMS", "CUST_OKPO", "CARD_STARTDATE", "CARD_OST") AS 
  select branch, card_acct, lacct, currency, client_n, id_numb, open_date, end_bal
  from obpc_acct
 where acc is null
    -- только открытые счета
   and nvl(status,'0')<>'4'
   and sys_context('bars_context', 'user_branch') = '/' || sys_context('bars_context', 'user_mfo') || '/'
union
select a.branch, null, a.nls, v.lcv, a.nms, c.okpo, a.daos, a.ostc/100
  from bpk_acc o, accounts a, customer c, tabval$global v
 where o.acc_pk = a.acc and a.rnk = c.rnk and a.kv = v.kv
    -- только открытые счета
   and a.dazs is null
   and not exists ( select 1 from obpc_acct where acc = a.acc )
   and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  OBPC_BAD_ACC ***
grant SELECT                                                                 on OBPC_BAD_ACC    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_BAD_ACC    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_BAD_ACC    to OBPC;
grant SELECT                                                                 on OBPC_BAD_ACC    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_BAD_ACC    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OBPC_BAD_ACC    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OBPC_BAD_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
