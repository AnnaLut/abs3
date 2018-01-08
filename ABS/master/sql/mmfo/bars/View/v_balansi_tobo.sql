

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANSI_TOBO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANSI_TOBO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANSI_TOBO ("SB", "TOBO", "FDAT", "NBS", "DOSR", "KOSR", "DOS", "KOS", "OSTD", "OSTK") AS 
  select decode(p.sb,'M','M','V','V','B') SB, b.tobo, b.fdat FDAT,b.nbs NBS,
       b.dosr DOSR, b.kosr KOSR, b.dosq DOS, b.kosq KOS,
       b.ostd OSTD, b.ostk OSTK
from v_balans_tobo b, ps p
where b.nbs=p.nbs AND (b.DOSQ>0 OR b.KOSQ>0 OR b.OSTD<>0 OR b.OSTK<>0)
 ;

PROMPT *** Create  grants  V_BALANSI_TOBO ***
grant SELECT                                                                 on V_BALANSI_TOBO  to BARSREADER_ROLE;
grant SELECT                                                                 on V_BALANSI_TOBO  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANSI_TOBO  to UPLD;
grant SELECT                                                                 on V_BALANSI_TOBO  to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANSI_TOBO  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANSI_TOBO.sql =========*** End ***
PROMPT ===================================================================================== 
