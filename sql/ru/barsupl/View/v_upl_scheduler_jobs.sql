

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_SCHEDULER_JOBS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_SCHEDULER_JOBS ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_SCHEDULER_JOBS ("JOB_NAME", "STATE", "ENABLED", "LAST_START_DATE", "NEXT_RUN_DATE", "COMMENTS", "JOB_ACTION", "MESS_COMMENTS", "MESS_JOB_ACTION") AS 
  select job_name, state,
                   enabled, cast(last_start_date as date) last_start_date,
                   cast(next_run_date  as date) next_run_date,
                   substr(comments,1,200) comments,
                   substr(job_action,1,200) job_action,
                   replace(comments, chr(10), chr(13)||chr(10))  mess_comments,
                   replace(job_action, chr(10), chr(13)||chr(10)) mess_job_action
 from dba_scheduler_jobs where owner = 'BARSUPL';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_SCHEDULER_JOBS.sql =========**
PROMPT ===================================================================================== 
