

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPT_JOBS_JRNL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPT_JOBS_JRNL ***

   CREATE SEQUENCE  BARS.S_DPT_JOBS_JRNL  MINVALUE 0 MAXVALUE 999999999999999999999 INCREMENT BY 1 START WITH 35721 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_DPT_JOBS_JRNL ***
grant SELECT                                                                 on S_DPT_JOBS_JRNL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_DPT_JOBS_JRNL to BARS_CONNECT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPT_JOBS_JRNL.sql =========*** En
PROMPT ===================================================================================== 
