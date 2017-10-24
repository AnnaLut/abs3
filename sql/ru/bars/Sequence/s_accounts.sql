

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ACCOUNTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ACCOUNTS ***

   CREATE SEQUENCE  BARS.S_ACCOUNTS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2850643 NOCACHE  NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ACCOUNTS ***
grant SELECT                                                                 on S_ACCOUNTS      to ABS_ADMIN;
grant SELECT                                                                 on S_ACCOUNTS      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ACCOUNTS.sql =========*** End ***
PROMPT ===================================================================================== 
