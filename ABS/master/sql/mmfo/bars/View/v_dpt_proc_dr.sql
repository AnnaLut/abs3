

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_PROC_DR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_PROC_DR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_PROC_DR ("NBS", "G67", "NBSN", "G67N", "REZID", "IO", "BRANCH") AS 
  select nbs,g67,nbsn,g67n,rezid,io,branch
   from proc_dr$base
  where (rezid,nbs) in (select vidd,bsd from dpt_vidd)
 ;

PROMPT *** Create  grants  V_DPT_PROC_DR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_PROC_DR   to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_PROC_DR   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_PROC_DR   to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_PROC_DR   to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_PROC_DR   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_DPT_PROC_DR   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_PROC_DR.sql =========*** End *** 
PROMPT ===================================================================================== 
