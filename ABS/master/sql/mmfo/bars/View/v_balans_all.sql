

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANS_ALL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANS_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANS_ALL ("NBS", "FDAT", "DOSR", "KOSR", "DOSQ", "KOSQ", "OSTD", "OSTK") AS 
  select a.nbs, a.fdat,
       sum(a.dosr) dosr, sum(a.kosr) kosr,
       sum(nvl(b.dos,a.dosr)) dosq,
       sum(nvl(b.kos,a.kosr)) kosq, sum(a.ostd) ostd, sum(a.ostk) ostk
from v_balans a, saldob b
where a.acc=b.acc(+) and b.fdat(+)=a.fdat
group by a.nbs, a.fdat
 ;

PROMPT *** Create  grants  V_BALANS_ALL ***
grant SELECT                                                                 on V_BALANS_ALL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANS_ALL    to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANS_ALL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANS_ALL.sql =========*** End *** =
PROMPT ===================================================================================== 
