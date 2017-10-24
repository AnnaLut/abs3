

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CM_CREDITS_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CM_CREDITS_UPDATE ***

   CREATE SEQUENCE  BARS.S_CM_CREDITS_UPDATE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_CM_CREDITS_UPDATE ***
grant SELECT                                                                 on S_CM_CREDITS_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CM_CREDITS_UPDATE.sql =========**
PROMPT ===================================================================================== 
