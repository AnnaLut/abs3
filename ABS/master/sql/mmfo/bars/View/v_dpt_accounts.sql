

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_ACCOUNTS ("DPT_ID", "TYPE_ID", "ACC_ID") AS 
  select deposit_id, 'DPT', acc
  from dpt_deposit
 union
select d.deposit_id, 'INT', i.acra
  from dpt_deposit d, int_accn i
 where d.acc = i.acc and i.id = 1
 union
select d.deposit_id, 'AMR', i.acrb
  from dpt_deposit d, dpt_vidd v, int_accn i, accounts a
 where d.acc = i.acc and i.id = 1 and i.acc = a.acc and a.nbs = v.bsa AND d.vidd = v.vidd
 union
select d.deposit_id, 'TCH', a.acc
  from dpt_deposit d, accounts a
 where a.acc = d.acc_d and a.tip = 'TCH'
 ;

PROMPT *** Create  grants  V_DPT_ACCOUNTS ***
grant SELECT                                                                 on V_DPT_ACCOUNTS  to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_ACCOUNTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_ACCOUNTS  to DPT_ROLE;
grant SELECT                                                                 on V_DPT_ACCOUNTS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_ACCOUNTS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
