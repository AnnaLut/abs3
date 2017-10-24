

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DILER_KURS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DILER_KURS ***

   CREATE SEQUENCE  BARS.S_DILER_KURS  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 10547 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DILER_KURS ***
grant SELECT                                                                 on S_DILER_KURS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DILER_KURS.sql =========*** End *
PROMPT ===================================================================================== 
