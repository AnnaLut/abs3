

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_JOB_RUN_DETAILS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_JOB_RUN_DETAILS ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_JOB_RUN_DETAILS ("LOG_ID", "LOG_DATE", "JOB_NAME", "STATUS", "ACTUAL_START_DATE", "RUN_DURATION", "INFO", "MESS_INFO") AS 
  select log_id,cast(log_date as date) log_date,
    job_name, status,
        cast(ACTUAL_START_DATE as date) ACTUAL_START_DATE,
        extract( minute from RUN_DURATION) RUN_DURATION,
        substr(additional_info,1,20) info,
        replace(additional_info, chr(10), chr(13)||chr(10)) mess_info
from sys.DBA_SCHEDULER_JOB_RUN_DETAILS
where owner = 'BARSUPL';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_JOB_RUN_DETAILS.sql =========*
PROMPT ===================================================================================== 
