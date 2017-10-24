

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_FINMONREFTADDR.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_FINMONREFTADDR ***

   CREATE SEQUENCE  BARS.S_FINMONREFTADDR  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_FINMONREFTADDR ***
grant SELECT                                                                 on S_FINMONREFTADDR to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_FINMONREFTADDR.sql =========*** E
PROMPT ===================================================================================== 
