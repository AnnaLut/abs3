

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMERW_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUSTOMERW_UPDATE ***

   CREATE SEQUENCE  BARS.S_CUSTOMERW_UPDATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 111724602 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUSTOMERW_UPDATE ***
grant SELECT                                                                 on S_CUSTOMERW_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMERW_UPDATE.sql =========***
PROMPT ===================================================================================== 
