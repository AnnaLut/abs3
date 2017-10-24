

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CUST_NAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CUST_NAL ***

   CREATE SEQUENCE  BARS.S_CUST_NAL  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CUST_NAL ***
grant SELECT                                                                 on S_CUST_NAL      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CUST_NAL.sql =========*** End ***
PROMPT ===================================================================================== 
