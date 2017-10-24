

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_METATABLES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_METATABLES ***

   CREATE SEQUENCE  BARS.S_METATABLES  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 9798 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_METATABLES ***
grant SELECT                                                                 on S_METATABLES    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_METATABLES.sql =========*** End *
PROMPT ===================================================================================== 
