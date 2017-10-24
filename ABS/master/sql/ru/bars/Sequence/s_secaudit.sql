

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SECAUDIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SECAUDIT ***

   CREATE SEQUENCE  BARS.S_SECAUDIT  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 691708712 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SECAUDIT ***
grant SELECT                                                                 on S_SECAUDIT      to ABS_ADMIN;
grant SELECT                                                                 on S_SECAUDIT      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SECAUDIT.sql =========*** End ***
PROMPT ===================================================================================== 
