

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_BAD_FIO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_BAD_FIO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_BAD_FIO ("BRANCH", "NLS", "LCV", "NMK_ABS", "NMK_PC", "CARD_ACCT") AS 
  select a.branch, a.nls, t.currency, c.nmk, t.client_n, t.card_acct
  from accounts a, obpc_acct t, customer c
 where a.acc = t.acc and a.rnk = c.rnk
    -- только открытые счета
   and nvl(t.status,'0')<>'4' and a.dazs is null
   and f_bpk_like_fio(t.client_n, c.nmk, 1) = 0
   and a.branch like sys_context ('bars_context', 'user_branch') || '%'
   and a.nbs <> '3550' ;

PROMPT *** Create  grants  V_OBPC_BAD_FIO ***
grant SELECT                                                                 on V_OBPC_BAD_FIO  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_BAD_FIO  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_BAD_FIO  to OBPC;
grant SELECT                                                                 on V_OBPC_BAD_FIO  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_BAD_FIO  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_OBPC_BAD_FIO  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_BAD_FIO.sql =========*** End ***
PROMPT ===================================================================================== 
