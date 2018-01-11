

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BAZA_PR1.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view BAZA_PR1 ***

  CREATE OR REPLACE FORCE VIEW BARS.BAZA_PR1 ("KV", "NLS", "NMS", "MDATE", "PROC", "SROK", "SROKM", "OST") AS 
  select a.kv,a.nls,a.nms,a.mdate,acrn.fproc(a.acc,bankdate),
a.mdate-bankdate,round((a.mdate-bankdate)/30,1), a.ostc
from saldo a, int_accn i
where substr(a.nls,1,1)<>'2' and 
       a.acc=i.acc and a.dazs is null;

PROMPT *** Create  grants  BAZA_PR1 ***
grant SELECT                                                                 on BAZA_PR1        to BARSREADER_ROLE;
grant SELECT                                                                 on BAZA_PR1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BAZA_PR1        to START1;
grant SELECT                                                                 on BAZA_PR1        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BAZA_PR1.sql =========*** End *** =====
PROMPT ===================================================================================== 
