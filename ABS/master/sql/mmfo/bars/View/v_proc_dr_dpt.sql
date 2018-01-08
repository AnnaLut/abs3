

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PROC_DR_DPT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PROC_DR_DPT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PROC_DR_DPT ("NBS", "G67", "V67", "SOUR", "NBSN", "G67N", "V67N", "REZID", "IO", "BRANCH", "KF") AS 
  select nbs, g67,v67, sour,nbsn, g67n,v67n, rezid, io, branch, kf
  from proc_dr$base
 where (nbs, rezid)in(select bsd,vidd
                        from dpt_vidd)
with check option
 ;

PROMPT *** Create  grants  V_PROC_DR_DPT ***
grant SELECT                                                                 on V_PROC_DR_DPT   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_PROC_DR_DPT   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_PROC_DR_DPT   to DPT_ADMIN;
grant SELECT                                                                 on V_PROC_DR_DPT   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PROC_DR_DPT   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PROC_DR_DPT.sql =========*** End *** 
PROMPT ===================================================================================== 
