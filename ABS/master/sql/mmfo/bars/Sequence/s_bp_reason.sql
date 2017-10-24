

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_BP_REASON.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BP_REASON ***

   CREATE SEQUENCE  BARS.S_BP_REASON  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 17 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_BP_REASON ***
grant SELECT                                                                 on S_BP_REASON     to ABS_ADMIN;
grant SELECT                                                                 on S_BP_REASON     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_BP_REASON     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_BP_REASON.sql =========*** End **
PROMPT ===================================================================================== 
