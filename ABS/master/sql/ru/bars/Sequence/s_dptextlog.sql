

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPTEXTLOG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPTEXTLOG ***

   CREATE SEQUENCE  BARS.S_DPTEXTLOG  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPTEXTLOG ***
grant SELECT                                                                 on S_DPTEXTLOG     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPTEXTLOG.sql =========*** End **
PROMPT ===================================================================================== 
