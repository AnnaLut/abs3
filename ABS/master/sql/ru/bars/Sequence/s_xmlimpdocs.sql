

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_XMLIMPDOCS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_XMLIMPDOCS ***

   CREATE SEQUENCE  BARS.S_XMLIMPDOCS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 14410044 CACHE 100 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_XMLIMPDOCS ***
grant SELECT                                                                 on S_XMLIMPDOCS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_XMLIMPDOCS.sql =========*** End *
PROMPT ===================================================================================== 
