

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_TMP_EXPORT_TO_DBF.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_TMP_EXPORT_TO_DBF ***

   CREATE SEQUENCE  BARS.S_TMP_EXPORT_TO_DBF  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1261 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_TMP_EXPORT_TO_DBF ***
grant SELECT                                                                 on S_TMP_EXPORT_TO_DBF to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_TMP_EXPORT_TO_DBF.sql =========**
PROMPT ===================================================================================== 
