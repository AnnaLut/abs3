

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_PAY_ALT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_PAY_ALT ***

   CREATE SEQUENCE  BARS.S_PAY_ALT  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 184914 CACHE 100 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_PAY_ALT ***
grant SELECT                                                                 on S_PAY_ALT       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_PAY_ALT.sql =========*** End *** 
PROMPT ===================================================================================== 
