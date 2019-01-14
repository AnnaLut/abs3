

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CARDACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CARDACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CARDACCOUNTS ("CARDNUM", "BALACC", "CURRENCY", "CUSTID", "CUSTNAME", "CUSTCODE", "BANKCODE","TIP", "BRANCH") AS 
  SELECT p.nd,
          a.nls,
          a.kv,
          c.rnk,
          c.nmk,
          c.okpo,
          a.kf,
		  a.tip,
          a.branch
     FROM (SELECT nd, acc_pk FROM bpk_acc
           UNION
           SELECT nd, acc_pk FROM w4_acc) p,
          accounts a,
          customer c
    WHERE     a.acc = p.acc_pk
          AND a.rnk = c.rnk
          AND a.nbs in ('2625','2620') and a.tip like 'W4%'
          AND a.dazs IS NULL
          union all
          SELECT a.acc,
       a.nls,
       a.kv,
       b.rnk,
       b.nmk,
       b.okpo,
       a.kf,
	   a.tip,
       a.branch
  FROM ACCOUNTS a, customer b
 WHERE a.nbs IN ('2620', '2630', '2635') AND a.dazs IS NULL AND a.RNK = b.RNK and a.tip not like 'W4%';

PROMPT *** Create  grants  V_CARDACCOUNTS ***
grant SELECT                                                                 on V_CARDACCOUNTS  to BARSREADER_ROLE;
grant SELECT                                                                 on V_CARDACCOUNTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CARDACCOUNTS  to DPT_ROLE;
grant SELECT                                                                 on V_CARDACCOUNTS  to UPLD;
grant SELECT                                                                 on V_CARDACCOUNTS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CARDACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
