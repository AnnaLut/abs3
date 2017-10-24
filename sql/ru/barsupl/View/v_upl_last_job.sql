

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_LAST_JOB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_LAST_JOB ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_LAST_JOB ("JOB_ID", "BANK_DATE", "GROUP_ID", "STATUS_CODE", "CURRENT_UPLOADING_FILE", "LAST_UPLOADED_FILENAME", "STAT_ID", "START_TIME", "STOP_TIME") AS 
  select j."JOB_ID",j."BANK_DATE",j."GROUP_ID",j."STATUS_CODE",j."CURRENT_UPLOADING_FILE",j."LAST_UPLOADED_FILENAME",j."STAT_ID", s.start_time, s.stop_time from v_upl_current_jobs j, v_upl_stats s
    where job_id = (select max(job_id) from upl_current_jobs)
     and j.stat_id = s.id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_LAST_JOB.sql =========*** End 
PROMPT ===================================================================================== 
