

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CP_RATES_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CP_RATES_UPDATE ***

   CREATE SEQUENCE  BARS.S_CP_RATES_UPDATE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 722 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CP_RATES_UPDATE ***
grant SELECT                                                                 on S_CP_RATES_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CP_RATES_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
