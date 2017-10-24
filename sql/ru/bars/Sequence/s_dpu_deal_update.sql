

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPU_DEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPU_DEAL_UPDATE ***

   CREATE SEQUENCE  BARS.S_DPU_DEAL_UPDATE  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 51417 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPU_DEAL_UPDATE ***
grant SELECT                                                                 on S_DPU_DEAL_UPDATE to ABS_ADMIN;
grant SELECT                                                                 on S_DPU_DEAL_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPU_DEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
