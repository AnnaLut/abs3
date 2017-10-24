

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_3.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_3 ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_3 ("ACC", "ID", "KV", "NLS", "DAT1", "DAT2", "FREQ", "S", "MFOP", "NLSP", "DELTA") AS 
  SELECT acc,id,kv,nls,dat1,dat2,freq,s,mfop,nlsp,BANKDATE-dat2
FROM DPT_30
WHERE dat2 <= BANKDATE 

 ;

PROMPT *** Create  grants  DPT_3 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_3           to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_3           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_3           to DPT;
grant SELECT                                                                 on DPT_3           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_3           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_3.sql =========*** End *** ========
PROMPT ===================================================================================== 
