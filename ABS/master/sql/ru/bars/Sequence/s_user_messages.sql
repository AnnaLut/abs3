

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_USER_MESSAGES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_USER_MESSAGES ***

   CREATE SEQUENCE  BARS.S_USER_MESSAGES  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 81944 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_USER_MESSAGES ***
grant SELECT                                                                 on S_USER_MESSAGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_USER_MESSAGES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_USER_MESSAGES.sql =========*** En
PROMPT ===================================================================================== 
