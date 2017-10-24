

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMER_BIN_DATA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUSTOMER_BIN_DATA ***

   CREATE SEQUENCE  BARS.S_CUSTOMER_BIN_DATA  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUSTOMER_BIN_DATA ***
grant SELECT                                                                 on S_CUSTOMER_BIN_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_CUSTOMER_BIN_DATA to CUST001;
grant SELECT                                                                 on S_CUSTOMER_BIN_DATA to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUSTOMER_BIN_DATA.sql =========**
PROMPT ===================================================================================== 
