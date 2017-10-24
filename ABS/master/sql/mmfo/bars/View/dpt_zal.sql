

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_ZAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_ZAL ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_ZAL ("DEPOSIT_ID", "ND", "NLS", "KV", "OSTC", "RNK") AS 
  SELECT d.deposit_id, d.nd, a.nls, a.kv, a.ostc/100, c.rnk
FROM dpt_deposit d, accounts a,cust_acc c
WHERE d.acc=a.acc AND d.acc=c.acc AND nvl(d.dat_end, bankdate+1) > bankdate
 ;

PROMPT *** Create  grants  DPT_ZAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_ZAL         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_ZAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_ZAL         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_ZAL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_ZAL.sql =========*** End *** ======
PROMPT ===================================================================================== 
