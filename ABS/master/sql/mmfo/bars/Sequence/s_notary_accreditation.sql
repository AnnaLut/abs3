

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_NOTARY_ACCREDITATION.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_NOTARY_ACCREDITATION ***

   CREATE SEQUENCE  BARS.S_NOTARY_ACCREDITATION  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2207 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_NOTARY_ACCREDITATION ***
grant SELECT                                                                 on S_NOTARY_ACCREDITATION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_NOTARY_ACCREDITATION.sql ========
PROMPT ===================================================================================== 
