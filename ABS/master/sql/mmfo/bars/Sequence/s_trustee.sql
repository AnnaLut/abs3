

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_TRUSTEE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_TRUSTEE ***

   CREATE SEQUENCE  BARS.S_TRUSTEE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 23 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_TRUSTEE ***
grant SELECT                                                                 on S_TRUSTEE       to ABS_ADMIN;
grant SELECT                                                                 on S_TRUSTEE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_TRUSTEE       to CUST001;
grant SELECT                                                                 on S_TRUSTEE       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_TRUSTEE.sql =========*** End *** 
PROMPT ===================================================================================== 
