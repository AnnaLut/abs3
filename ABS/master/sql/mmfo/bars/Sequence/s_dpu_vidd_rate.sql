

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPU_VIDD_RATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPU_VIDD_RATE ***

   CREATE SEQUENCE  BARS.S_DPU_VIDD_RATE  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 33 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPU_VIDD_RATE ***
grant SELECT                                                                 on S_DPU_VIDD_RATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPU_VIDD_RATE to DPT_ADMIN;
grant SELECT                                                                 on S_DPU_VIDD_RATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPU_VIDD_RATE.sql =========*** En
PROMPT ===================================================================================== 
