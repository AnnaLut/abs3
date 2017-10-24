

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_PAY_PFU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_PAY_PFU ***

   CREATE SEQUENCE  BARS.S_PAY_PFU  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 10 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_PAY_PFU ***
grant SELECT                                                                 on S_PAY_PFU       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_PAY_PFU.sql =========*** End *** 
PROMPT ===================================================================================== 
