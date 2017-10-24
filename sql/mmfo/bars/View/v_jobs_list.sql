

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_JOBS_LIST.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_JOBS_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_JOBS_LIST ("JOB_CODE", "JOB_NAME", "JOB_ID", "JOB_FILTER", "LAST_DATE", "NEXT_DATE", "BROKEN", "INTERVAL", "FAILURES", "WHAT") AS 
  select l.job_code, l.job_name, l.job_sysid, l.job_filter,
       a.last_date, a.next_date, a.broken, a.interval, a.failures, a.what
  from jobs_list l, all_jobs a
 where l.job_sysid = a.job(+)
 ;

PROMPT *** Create  grants  V_JOBS_LIST ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_JOBS_LIST     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_JOBS_LIST.sql =========*** End *** ==
PROMPT ===================================================================================== 
