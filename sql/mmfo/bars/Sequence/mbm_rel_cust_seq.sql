

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/MBM_REL_CUST_SEQ.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence MBM_REL_CUST_SEQ ***

   CREATE SEQUENCE  BARS.MBM_REL_CUST_SEQ  MINVALUE 0 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 102 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  MBM_REL_CUST_SEQ ***
grant SELECT                                                                 on MBM_REL_CUST_SEQ to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/MBM_REL_CUST_SEQ.sql =========*** E
PROMPT ===================================================================================== 
