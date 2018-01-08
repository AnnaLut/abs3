

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_ACCT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_ACCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_ACCT ("DOC_TYPE", "CARD_ACCT", "CURRENCY", "LACCT") AS 
  select 1, card_acct, currency, lacct
  from obpc_acct
 where nvl(status,'0') <> '4'
 union all
select 2, card_acct, currency, lacct
  from obpc_acct_imp
 where mfo <> getglobaloption('GLB-MFO')
   and nvl(status,'0') <> '4';

PROMPT *** Create  grants  V_OBPC_ACCT ***
grant SELECT                                                                 on V_OBPC_ACCT     to BARSREADER_ROLE;
grant SELECT                                                                 on V_OBPC_ACCT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OBPC_ACCT     to OBPC;
grant SELECT                                                                 on V_OBPC_ACCT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_ACCT.sql =========*** End *** ==
PROMPT ===================================================================================== 
