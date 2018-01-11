

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BAZA_PR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view BAZA_PR ***

  CREATE OR REPLACE FORCE VIEW BARS.BAZA_PR ("KV", "NLS", "NMS", "MDATE", "PROC", "SROK", "SROKM", "OST") AS 
  select a.kv,a.nls,a.nms,a.mdate,acrn.fproc(a.acc,bankdate),
a.mdate-bankdate,round((a.mdate-bankdate)/30,1), a.ostc
from accounts a, int_accn i
where a.acc=i.acc and (a.mdate>bankdate or ostc<>0);

PROMPT *** Create  grants  BAZA_PR ***
grant SELECT                                                                 on BAZA_PR         to BARSREADER_ROLE;
grant SELECT                                                                 on BAZA_PR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BAZA_PR         to START1;
grant SELECT                                                                 on BAZA_PR         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BAZA_PR.sql =========*** End *** ======
PROMPT ===================================================================================== 
