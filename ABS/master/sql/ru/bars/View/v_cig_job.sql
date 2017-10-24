

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_JOB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_JOB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_JOB ("JOB", "LOG_USER", "PRIV_USER", "SCHEMA_USER", "LAST_DATE", "LAST_SEC", "THIS_DATE", "THIS_SEC", "NEXT_DATE", "NEXT_SEC", "TOTAL_TIME", "BROKEN", "INTERVAL", "FAILURES", "WHAT", "NLS_ENV", "MISC_ENV", "INSTANCE") AS 
  select "JOB","LOG_USER","PRIV_USER","SCHEMA_USER","LAST_DATE","LAST_SEC","THIS_DATE","THIS_SEC","NEXT_DATE","NEXT_SEC","TOTAL_TIME","BROKEN","INTERVAL","FAILURES","WHAT","NLS_ENV","MISC_ENV","INSTANCE"
  from dba_jobs
 where lower(what) like 'cig_mgr.collect_data%'
   and rownum = 1;

PROMPT *** Create  grants  V_CIG_JOB ***
grant SELECT                                                                 on V_CIG_JOB       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_JOB       to CIG_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_JOB.sql =========*** End *** ====
PROMPT ===================================================================================== 
