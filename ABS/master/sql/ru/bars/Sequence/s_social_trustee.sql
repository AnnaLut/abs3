

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SOCIAL_TRUSTEE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SOCIAL_TRUSTEE ***

   CREATE SEQUENCE  BARS.S_SOCIAL_TRUSTEE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 8832 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SOCIAL_TRUSTEE ***
grant SELECT                                                                 on S_SOCIAL_TRUSTEE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SOCIAL_TRUSTEE.sql =========*** E
PROMPT ===================================================================================== 
