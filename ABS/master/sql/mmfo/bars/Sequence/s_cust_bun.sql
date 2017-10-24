

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUST_BUN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUST_BUN ***

   CREATE SEQUENCE  BARS.S_CUST_BUN  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUST_BUN ***
grant SELECT                                                                 on S_CUST_BUN      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUST_BUN.sql =========*** End ***
PROMPT ===================================================================================== 
