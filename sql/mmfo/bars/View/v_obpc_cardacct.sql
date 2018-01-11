

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_CARDACCT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_CARDACCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_CARDACCT ("CARD_ACCT", "CARD_CURRENCY", "CARD_CLIENTNAME", "NLS", "NMK") AS 
  select a.card_acct, a.currency, a.client_n, c.nls, r.nmk
from obpc_acct a, accounts c, customer r
where a.acc = c.acc and c.rnk = r.rnk
 ;

PROMPT *** Create  grants  V_OBPC_CARDACCT ***
grant SELECT                                                                 on V_OBPC_CARDACCT to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_CARDACCT to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_CARDACCT to OBPC;
grant SELECT                                                                 on V_OBPC_CARDACCT to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_CARDACCT to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_OBPC_CARDACCT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_CARDACCT.sql =========*** End **
PROMPT ===================================================================================== 
