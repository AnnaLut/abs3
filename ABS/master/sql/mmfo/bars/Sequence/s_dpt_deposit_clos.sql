

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_DEPOSIT_CLOS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_DEPOSIT_CLOS ***

   CREATE SEQUENCE  BARS.S_DPT_DEPOSIT_CLOS  MINVALUE 0 MAXVALUE 999999999999999999999 INCREMENT BY 1 START WITH 101072596 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_DEPOSIT_CLOS ***
grant SELECT                                                                 on S_DPT_DEPOSIT_CLOS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPT_DEPOSIT_CLOS to BARS_CONNECT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_DEPOSIT_CLOS.sql =========***
PROMPT ===================================================================================== 
