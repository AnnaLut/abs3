

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_NOTARY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_NOTARY ***

   CREATE SEQUENCE  BARS.S_NOTARY  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 3096 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_NOTARY ***
grant SELECT                                                                 on S_NOTARY        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_NOTARY.sql =========*** End *** =
PROMPT ===================================================================================== 
