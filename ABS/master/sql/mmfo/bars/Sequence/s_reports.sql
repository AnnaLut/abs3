

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_REPORTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_REPORTS ***

   CREATE SEQUENCE  BARS.S_REPORTS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 100992 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_REPORTS ***
grant SELECT                                                                 on S_REPORTS       to ABS_ADMIN;
grant SELECT                                                                 on S_REPORTS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_REPORTS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_REPORTS.sql =========*** End *** 
PROMPT ===================================================================================== 
