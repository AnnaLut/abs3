

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_ACCOUNTS ("ACC", "NLS", "NMK", "OKPO", "RNK", "ND", "DAOS", "DAZS", "BRANCH", "EXIST_METHOD", "EXIST_TARIF") AS 
  select a.acc, a.nls, c.nmk, c.okpo, c.rnk, c.nd, a.daos, a.dazs, a.branch,
       (select nvl2(min(acc),'Заповнено','-') from rko_method where acc = a.acc) exist_method,
       (select nvl2(min(acc),'Заповнено','-') from rko_tarif where acc = a.acc) exist_tarif
  from accounts a, customer c
 where a.rnk = c.rnk
   and a.nbs in ( '2520', '2523', '2526', '2523', '2531', '2541', '2542', '2544', '2545',
                  '2552', '2553', '2554', '2555', '2560', '2570', '2571', '2600', '2601',
                  '2602', '2603', '2604', '2605', '2640', '2641', '2642', '2643', '2650', '2655' )
   and ( c.custtype = 2
      or c.custtype = 3 and nvl(trim(c.sed),'00') = '91' )
   and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_RKO_ACCOUNTS ***
grant SELECT                                                                 on V_RKO_ACCOUNTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RKO_ACCOUNTS  to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
