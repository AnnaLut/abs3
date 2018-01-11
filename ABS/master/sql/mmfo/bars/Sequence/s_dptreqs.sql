

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPTREQS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPTREQS ***

   CREATE SEQUENCE  BARS.S_DPTREQS  MINVALUE 0 MAXVALUE 999999999999999999999 INCREMENT BY 1 START WITH 2703223 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPTREQS ***
grant SELECT                                                                 on S_DPTREQS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPTREQS       to BARS_CONNECT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPTREQS.sql =========*** End *** 
PROMPT ===================================================================================== 
