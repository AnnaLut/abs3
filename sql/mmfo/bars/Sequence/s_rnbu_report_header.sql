

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_REPORT_HEADER.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_RNBU_REPORT_HEADER ***

   CREATE SEQUENCE  BARS.S_RNBU_REPORT_HEADER  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_RNBU_REPORT_HEADER ***
grant SELECT                                                                 on S_RNBU_REPORT_HEADER to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_RNBU_REPORT_HEADER.sql =========*
PROMPT ===================================================================================== 
