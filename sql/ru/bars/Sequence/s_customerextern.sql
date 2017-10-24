

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMEREXTERN.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUSTOMEREXTERN ***

   CREATE SEQUENCE  BARS.S_CUSTOMEREXTERN  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUSTOMEREXTERN ***
grant SELECT                                                                 on S_CUSTOMEREXTERN to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMEREXTERN.sql =========*** E
PROMPT ===================================================================================== 
