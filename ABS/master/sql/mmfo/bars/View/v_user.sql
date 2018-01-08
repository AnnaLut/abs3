

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER ("ID", "FIO", "LOGNAME", "TABN", "BRANCH", "TTS") AS 
  select id,  fio, logname, tabn, branch, 'Операції' tts
from staff
order by logname;

PROMPT *** Create  grants  V_USER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_USER          to ABS_ADMIN;
grant SELECT                                                                 on V_USER          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER          to START1;
grant SELECT                                                                 on V_USER          to UPLD;
grant FLASHBACK,SELECT                                                       on V_USER          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER.sql =========*** End *** =======
PROMPT ===================================================================================== 
