

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_XMLIMPDOCS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_XMLIMPDOCS ***

   CREATE SEQUENCE  BARS.S_XMLIMPDOCS  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 68975482 CACHE 100 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_XMLIMPDOCS ***
grant SELECT                                                                 on S_XMLIMPDOCS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_XMLIMPDOCS.sql =========*** End *
PROMPT ===================================================================================== 
