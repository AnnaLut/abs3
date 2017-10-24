

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_JOBS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SYNC_JOBS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_SYNC_JOBS ("JOB_NAME", "STATE", "LAST_RUN_DATETIME", "STATUS", "ADDITIONAL_INFO") AS 
  (
  select j.job_name,
         j.state,
         l4.last_run_datetime,
         l4.status,
         l4.additional_info
    from dba_scheduler_jobs j,
         (select l3.job_name,
                 to_char(l3.log_date, 'DD.MM.YYYY HH24:MI:SS') as last_run_datetime,
                 l3.status,
                 l3.additional_info
            from (select l.job_name, max(l.log_id) max_log_id
                    from dba_scheduler_job_run_details l
                   where l.owner = 'BARSAQ'
                   group by l.job_name) l2,
                 dba_scheduler_job_run_details l3
           where l3.log_id = l2.max_log_id) l4
   where j.job_name = l4.job_name(+)
     and j.owner = 'BARSAQ'
);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_JOBS.sql =========*** End *** 
PROMPT ===================================================================================== 
