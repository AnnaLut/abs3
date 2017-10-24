

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_2.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_2 ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_2 ("ISP", "VIDD", "KV", "S", "SN", "S_SROK", "S_SROK1", "S_PR_SROK") AS 
  SELECT isp, vidd, kv, s,  sn,   s*srok,   s*srok1,  s*pr*srok
FROM  dpt_0 

 ;

PROMPT *** Create  grants  DPT_2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_2           to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_2           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_2           to DPT;
grant SELECT                                                                 on DPT_2           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_2           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_2.sql =========*** End *** ========
PROMPT ===================================================================================== 
