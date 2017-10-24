

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMER_ADDRESS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUSTOMER_ADDRESS ***

   CREATE SEQUENCE  BARS.S_CUSTOMER_ADDRESS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUSTOMER_ADDRESS ***
grant SELECT                                                                 on S_CUSTOMER_ADDRESS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMER_ADDRESS.sql =========***
PROMPT ===================================================================================== 
