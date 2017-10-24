

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROC_DR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view PROC_DR ***

  CREATE OR REPLACE FORCE VIEW BARS.PROC_DR ("NBS", "G67", "V67", "SOUR", "NBSN", "G67N", "V67N", "NBSZ", "REZID", "TT", "TTV", "IO", "BRANCH") AS 
  select NBS,G67,V67,SOUR,NBSN,G67N,V67N,NBSZ,REZID,TT,TTV,IO, BRANCH
from proc_dr$BASE where BRANCH=sys_context('bars_context','user_branch') 
 ;

PROMPT *** Create  grants  PROC_DR ***
grant SELECT                                                                 on PROC_DR         to BARS009;
grant SELECT                                                                 on PROC_DR         to BARS010;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROC_DR         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PROC_DR         to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on PROC_DR         to PROC_DR;
grant SELECT                                                                 on PROC_DR         to RCC_DEAL;
grant SELECT                                                                 on PROC_DR         to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on PROC_DR         to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROC_DR         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PROC_DR         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROC_DR.sql =========*** End *** ======
PROMPT ===================================================================================== 
