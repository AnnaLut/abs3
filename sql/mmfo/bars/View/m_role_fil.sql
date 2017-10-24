

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_FIL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_FIL ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_FIL ("FID", "ID", "CODE", "NAME", "ACC", "ARMC", "ARMW", "CHK", "OTC", "TTS", "STA") AS 
  select FILTR_ROLE (r.ID) FID , r."ID",r."CODE",r."NAME",r."ACC",r."ARMC",r."ARMW",r."CHK",r."OTC",r."TTS",r."STA" from M_ROLE r;

PROMPT *** Create  grants  M_ROLE_FIL ***
grant SELECT                                                                 on M_ROLE_FIL      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_FIL.sql =========*** End *** ===
PROMPT ===================================================================================== 
