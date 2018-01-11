

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CCLIM_UPDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CCLIM_UPDATE ***

   CREATE SEQUENCE  BARS.S_CCLIM_UPDATE  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 13935031 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CCLIM_UPDATE ***
grant SELECT                                                                 on S_CCLIM_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_CCLIM_UPDATE  to RCC_DEAL;
grant SELECT                                                                 on S_CCLIM_UPDATE  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CCLIM_UPDATE.sql =========*** End
PROMPT ===================================================================================== 
