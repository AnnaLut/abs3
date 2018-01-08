

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_TRAN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_TRAN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_TRAN ("ID", "FILE_NAME", "CARD_ACCT", "CURRENCY", "TRAN_DATE", "TRAN_TYPE", "ABVR_NAME", "CITY", "MERCHANT", "AMOUNT", "TRAN_RUSS", "IDN", "LACCT", "BRANCH") AS 
  select t.id, f.file_name, t.card_acct, t.currency, t.tran_date, t.tran_type,
       t.abvr_name, t.city, t.merchant, t.amount, t.tran_russ, t.idn,
       a.lacct, n.branch
  from obpc_tran t, obpc_acct a, accounts n, obpc_files f
 where t.card_acct = a.card_acct and a.acc = n.acc(+)
   and t.id = f.id
   and f.arc = 0
   and (   n.branch like sys_context ('bars_context', 'user_branch_mask')
        or n.branch is null );

PROMPT *** Create  grants  V_OBPC_TRAN ***
grant SELECT                                                                 on V_OBPC_TRAN     to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_OBPC_TRAN     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OBPC_TRAN     to OBPC;
grant SELECT                                                                 on V_OBPC_TRAN     to UPLD;
grant FLASHBACK,SELECT                                                       on V_OBPC_TRAN     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_TRAN.sql =========*** End *** ==
PROMPT ===================================================================================== 
