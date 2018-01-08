

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUSTOMER ***

   CREATE SEQUENCE  BARS.S_CUSTOMER  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 3077747 NOCACHE  NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUSTOMER ***
grant SELECT                                                                 on S_CUSTOMER      to ABS_ADMIN;
grant SELECT                                                                 on S_CUSTOMER      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMER.sql =========*** End ***
PROMPT ===================================================================================== 
