

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASHACCOUNTS_HIST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASHACCOUNTS_HIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASHACCOUNTS_HIST ("OPDATE", "ACC", "NLS", "KV", "PAP", "NMS", "OSTC") AS 
  select s.opdate,a.acc, a.nls, a.kv, a.pap, a.nms, a.ostc
  from cash_snapshot s, accounts a
 where s.branch = sys_context ('bars_context', 'user_branch')
   and s.acc = a.acc;

PROMPT *** Create  grants  V_CASHACCOUNTS_HIST ***
grant SELECT                                                                 on V_CASHACCOUNTS_HIST to BARSREADER_ROLE;
grant SELECT                                                                 on V_CASHACCOUNTS_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CASHACCOUNTS_HIST to RPBN001;
grant SELECT                                                                 on V_CASHACCOUNTS_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASHACCOUNTS_HIST.sql =========*** En
PROMPT ===================================================================================== 
