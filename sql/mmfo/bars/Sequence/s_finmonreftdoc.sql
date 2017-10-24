

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_FINMONREFTDOC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_FINMONREFTDOC ***

   CREATE SEQUENCE  BARS.S_FINMONREFTDOC  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_FINMONREFTDOC ***
grant SELECT                                                                 on S_FINMONREFTDOC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_FINMONREFTDOC.sql =========*** En
PROMPT ===================================================================================== 
