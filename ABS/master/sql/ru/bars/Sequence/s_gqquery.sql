

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_GQQUERY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_GQQUERY ***

   CREATE SEQUENCE  BARS.S_GQQUERY  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 421 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_GQQUERY ***
grant SELECT                                                                 on S_GQQUERY       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_GQQUERY.sql =========*** End *** 
PROMPT ===================================================================================== 
