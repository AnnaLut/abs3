

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPU_JOBS_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPU_JOBS_LOG ***

   CREATE SEQUENCE  BARS.S_DPU_JOBS_LOG  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 39650681008602 CACHE 20 ORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPU_JOBS_LOG ***
grant SELECT                                                                 on S_DPU_JOBS_LOG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPU_JOBS_LOG  to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPU_JOBS_LOG.sql =========*** End
PROMPT ===================================================================================== 
