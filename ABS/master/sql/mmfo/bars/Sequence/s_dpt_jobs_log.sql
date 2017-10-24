

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_JOBS_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_JOBS_LOG ***

   CREATE SEQUENCE  BARS.S_DPT_JOBS_LOG  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2827802 CACHE 1000 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_JOBS_LOG ***
grant SELECT                                                                 on S_DPT_JOBS_LOG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPT_JOBS_LOG  to DPT_ADMIN;
grant SELECT                                                                 on S_DPT_JOBS_LOG  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_JOBS_LOG.sql =========*** End
PROMPT ===================================================================================== 
