

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SALTURNQUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SALTURNQUE ***

   CREATE SEQUENCE  BARS.S_SALTURNQUE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SALTURNQUE ***
grant SELECT                                                                 on S_SALTURNQUE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SALTURNQUE.sql =========*** End *
PROMPT ===================================================================================== 
