

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASHACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASHACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASHACCOUNTS ("ACC", "NLS", "KV", "PAP", "NMS", "OSTC") AS 
  select a.acc, nls, kv, pap, nms, ostc
     from accounts a, cash_nbs c
     where a.nbs = c.nbs
      and branch = sys_context ('bars_context', 'user_branch')
      and nvl(trim(c.ob22), nvl(a.ob22,0)) = nvl(a.ob22,0)
      and dazs is null;

PROMPT *** Create  grants  V_CASHACCOUNTS ***
grant SELECT                                                                 on V_CASHACCOUNTS  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CASHACCOUNTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CASHACCOUNTS  to OPER000;
grant SELECT                                                                 on V_CASHACCOUNTS  to RPBN001;
grant SELECT                                                                 on V_CASHACCOUNTS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CASHACCOUNTS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASHACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
