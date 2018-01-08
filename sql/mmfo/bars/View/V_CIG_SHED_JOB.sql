

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_SHED_JOB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_SHED_JOB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_SHED_JOB ("JOB", "LAST_DATE", "LAST_SEC", "THIS_DATE", "THIS_SEC", "NEXT_DATE", "NEXT_SEC", "TOTAL_TIME", "BROKEN", "INTERVAL", "FAILURES", "WHAT", "BRANCH") AS 
  select
  s.job_name job,
  TO_CHAR (s.last_start_date, 'dd.mm.yyyy') last_date,
  TO_CHAR (s.last_start_date, 'hh24:mi:ss') last_sec,
  TO_CHAR (s.this_start_date, 'dd.mm.yyyy') this_date,
  TO_CHAR (s.this_start_date, 'hh24:mi:ss') this_sec,
  TO_CHAR (s.next_start_date, 'dd.mm.yyyy') next_date,
  TO_CHAR (s.next_start_date, 'hh24:mi:ss') next_sec,
  nvl(total_time, (sysdate - this_start_date) * 24*60*60 ) total_time,
  broken,
  s.interval,
  s.failures,
  s.what,
  branch
from cig_shed_jobs_state s;

PROMPT *** Create  grants  V_CIG_SHED_JOB ***
grant SELECT                                                                 on V_CIG_SHED_JOB  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_SHED_JOB  to CIG_ROLE;
grant SELECT                                                                 on V_CIG_SHED_JOB  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_SHED_JOB.sql =========*** End ***
PROMPT ===================================================================================== 
