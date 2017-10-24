

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_VIDD_RATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_VIDD_RATE ***

   CREATE SEQUENCE  BARS.S_DPT_VIDD_RATE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 3 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_VIDD_RATE ***
grant SELECT                                                                 on S_DPT_VIDD_RATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_VIDD_RATE.sql =========*** En
PROMPT ===================================================================================== 
