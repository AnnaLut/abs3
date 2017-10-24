

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_EADSYNCQUEUE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_EADSYNCQUEUE ***

   CREATE SEQUENCE  BARS.S_EADSYNCQUEUE  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 15718712 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_EADSYNCQUEUE ***
grant SELECT                                                                 on S_EADSYNCQUEUE  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_EADSYNCQUEUE.sql =========*** End
PROMPT ===================================================================================== 
