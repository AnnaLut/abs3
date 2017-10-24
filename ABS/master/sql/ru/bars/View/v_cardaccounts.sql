

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CARDACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CARDACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CARDACCOUNTS ("CARDNUM", "BALACC", "CURRENCY", "CUSTID", "CUSTNAME", "CUSTCODE", "BANKCODE", "BRANCH") AS 
  select p.nd, a.nls, a.kv, c.rnk, c.nmk, c.okpo, a.kf, a.branch
  from (select nd, acc_pk from bpk_acc
         union
        select nd, acc_pk from w4_acc ) p,
       accounts a,
       customer c
 where a.acc = p.acc_pk
   and a.rnk = c.rnk
   and a.nbs = '2625'
   and a.dazs is null;

PROMPT *** Create  grants  V_CARDACCOUNTS ***
grant SELECT                                                                 on V_CARDACCOUNTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CARDACCOUNTS  to DPT_ROLE;
grant SELECT                                                                 on V_CARDACCOUNTS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CARDACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
