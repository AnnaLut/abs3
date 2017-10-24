

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPTREQS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPTREQS ***

   CREATE SEQUENCE  BARS.S_DPTREQS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1190495 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPTREQS ***
grant SELECT                                                                 on S_DPTREQS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPTREQS.sql =========*** End *** 
PROMPT ===================================================================================== 
