

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUST_REQUESTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUST_REQUESTS ***

   CREATE SEQUENCE  BARS.S_CUST_REQUESTS  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 211 NOCACHE  ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUST_REQUESTS ***
grant SELECT                                                                 on S_CUST_REQUESTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_CUST_REQUESTS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUST_REQUESTS.sql =========*** En
PROMPT ===================================================================================== 
