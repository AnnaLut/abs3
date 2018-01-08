

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_RS_TMP_REPORT_DATA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_RS_TMP_REPORT_DATA ***

   CREATE SEQUENCE  BARS.S_RS_TMP_REPORT_DATA  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 946185487 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_RS_TMP_REPORT_DATA ***
grant SELECT                                                                 on S_RS_TMP_REPORT_DATA to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_RS_TMP_REPORT_DATA.sql =========*
PROMPT ===================================================================================== 
