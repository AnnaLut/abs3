

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPU_JOBS_JRNL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPU_JOBS_JRNL ***

   CREATE SEQUENCE  BARS.S_DPU_JOBS_JRNL  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1086 NOCACHE  ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPU_JOBS_JRNL ***
grant SELECT                                                                 on S_DPU_JOBS_JRNL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPU_JOBS_JRNL to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPU_JOBS_JRNL.sql =========*** En
PROMPT ===================================================================================== 
