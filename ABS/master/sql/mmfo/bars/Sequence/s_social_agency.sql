

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SOCIAL_AGENCY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SOCIAL_AGENCY ***

   CREATE SEQUENCE  BARS.S_SOCIAL_AGENCY  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 13478 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SOCIAL_AGENCY ***
grant SELECT                                                                 on S_SOCIAL_AGENCY to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SOCIAL_AGENCY.sql =========*** En
PROMPT ===================================================================================== 
