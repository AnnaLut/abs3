

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANSI_ALL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANSI_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANSI_ALL ("SB", "FDAT", "NBS", "DOSR", "KOSR", "DOS", "KOS", "OSTD", "OSTK") AS 
  select decode(p.sb,'M','M','V','V','B') SB, b.fdat FDAT,b.nbs NBS,
       b.dosr DOSR, b.kosr KOSR, b.dosq DOS, b.kosq KOS,
       b.ostd OSTD, b.ostk OSTK
from v_balans_all b, ps p
where b.nbs=p.nbs AND (b.DOSQ>0 OR b.KOSQ>0 OR b.OSTD<>0 OR b.OSTK<>0)
 ;

PROMPT *** Create  grants  V_BALANSI_ALL ***
grant SELECT                                                                 on V_BALANSI_ALL   to BARSREADER_ROLE;
grant SELECT                                                                 on V_BALANSI_ALL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANSI_ALL   to UPLD;
grant SELECT                                                                 on V_BALANSI_ALL   to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANSI_ALL   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANSI_ALL.sql =========*** End *** 
PROMPT ===================================================================================== 
