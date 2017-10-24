

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACRINT_USER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACRINT_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACRINT_USER ("METR", "BASEY", "ACC", "ID", "FREQ", "DAT1", "DAT2", "KV", "DAOS", "NLS", "NBS") AS 
  SELECT i.metr,i.basey, i.acc,i.id,i.freq, i.acr_dat+1 dat, i.stp_dat, s.kv, s.daos-1, s.nls ,s.nbs
FROM int_accN i, saldo s, tabval t, customer k, cust_acc c
WHERE (i.metr IN (0,1,2,4,5, 7 ) OR i.METR > 90)
  AND i.acc=s.acc
  AND c.acc=s.acc
  AND k.rnk=c.rnk
  AND s.kv=t.kv
 ;

PROMPT *** Create  grants  V_ACRINT_USER ***
grant SELECT                                                                 on V_ACRINT_USER   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACRINT_USER   to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ACRINT_USER   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACRINT_USER.sql =========*** End *** 
PROMPT ===================================================================================== 
