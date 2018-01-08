

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_FILE_INFO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_FILE_INFO ***

   CREATE SEQUENCE  BARS.S_FILE_INFO  MINVALUE 0 MAXVALUE 999999999999999999 INCREMENT BY 1 START WITH 43206182 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_FILE_INFO ***
grant SELECT                                                                 on S_FILE_INFO     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_FILE_INFO     to DPT_ROLE;
grant SELECT                                                                 on S_FILE_INFO     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_FILE_INFO.sql =========*** End **
PROMPT ===================================================================================== 
