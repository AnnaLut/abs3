

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_GQQUERYTYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_GQQUERYTYPE ***

   CREATE SEQUENCE  BARS.S_GQQUERYTYPE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_GQQUERYTYPE ***
grant SELECT                                                                 on S_GQQUERYTYPE   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_GQQUERYTYPE.sql =========*** End 
PROMPT ===================================================================================== 
