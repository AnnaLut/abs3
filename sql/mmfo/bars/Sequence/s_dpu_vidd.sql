

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPU_VIDD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPU_VIDD ***

   CREATE SEQUENCE  BARS.S_DPU_VIDD  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1345 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPU_VIDD ***
grant SELECT                                                                 on S_DPU_VIDD      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPU_VIDD.sql =========*** End ***
PROMPT ===================================================================================== 
