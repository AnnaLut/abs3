

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DILER_KURS_FACT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DILER_KURS_FACT ***

   CREATE SEQUENCE  BARS.S_DILER_KURS_FACT  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 239 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DILER_KURS_FACT ***
grant SELECT                                                                 on S_DILER_KURS_FACT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DILER_KURS_FACT.sql =========*** 
PROMPT ===================================================================================== 
