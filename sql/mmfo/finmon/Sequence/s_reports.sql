

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Sequence/S_REPORTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_REPORTS ***

   CREATE SEQUENCE  FINMON.S_REPORTS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 2 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_REPORTS ***
grant SELECT                                                                 on S_REPORTS       to ABS_ADMIN;
grant SELECT                                                                 on S_REPORTS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_REPORTS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Sequence/S_REPORTS.sql =========*** End **
PROMPT ===================================================================================== 
