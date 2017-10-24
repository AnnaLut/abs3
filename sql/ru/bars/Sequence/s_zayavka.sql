

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_ZAYAVKA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_ZAYAVKA ***

   CREATE SEQUENCE  BARS.S_ZAYAVKA  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 17713 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_ZAYAVKA ***
grant SELECT                                                                 on S_ZAYAVKA       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_ZAYAVKA.sql =========*** End *** 
PROMPT ===================================================================================== 
