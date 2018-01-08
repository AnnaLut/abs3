

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SEC_CTX_QUE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SEC_CTX_QUE ***

   CREATE SEQUENCE  BARS.S_SEC_CTX_QUE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 118707 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_SEC_CTX_QUE ***
grant SELECT                                                                 on S_SEC_CTX_QUE   to ABS_ADMIN;
grant SELECT                                                                 on S_SEC_CTX_QUE   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SEC_CTX_QUE.sql =========*** End 
PROMPT ===================================================================================== 
