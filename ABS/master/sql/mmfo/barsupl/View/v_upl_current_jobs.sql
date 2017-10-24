

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_CURRENT_JOBS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_CURRENT_JOBS ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_CURRENT_JOBS ("JOB_ID", "BANK_DATE", "GROUP_ID", "STATUS_CODE", "CURRENT_UPLOADING_FILE", "LAST_UPLOADED_FILENAME", "STAT_ID") AS 
  select j.job_id, bank_date, group_id, P.STATUS_CODE, F.FILENAME_PRFX current_uploading_file, last_filename last_uploaded_filename, stat_id
  from upl_current_jobs j, upl_process_status p, upl_files f
where j.status_id = p.status_id and j.current_fileid = f.file_id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_CURRENT_JOBS.sql =========*** 
PROMPT ===================================================================================== 
