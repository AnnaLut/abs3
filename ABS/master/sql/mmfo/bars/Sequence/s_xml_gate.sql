

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_XML_GATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_XML_GATE ***

   CREATE SEQUENCE  BARS.S_XML_GATE  MINVALUE 1 MAXVALUE 999999999999999 INCREMENT BY 1 START WITH 2 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_XML_GATE ***
grant SELECT                                                                 on S_XML_GATE      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_XML_GATE.sql =========*** End ***
PROMPT ===================================================================================== 
