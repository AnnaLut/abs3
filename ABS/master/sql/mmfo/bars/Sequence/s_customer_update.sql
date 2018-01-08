

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMER_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUSTOMER_UPDATE ***

   CREATE SEQUENCE  BARS.S_CUSTOMER_UPDATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 10607048 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUSTOMER_UPDATE ***
grant SELECT                                                                 on S_CUSTOMER_UPDATE to ABS_ADMIN;
grant SELECT                                                                 on S_CUSTOMER_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMER_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
