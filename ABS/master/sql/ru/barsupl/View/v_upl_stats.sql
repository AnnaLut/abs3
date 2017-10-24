

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_STATS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_STATS ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_STATS ("ID", "PARENT_ID", "FILE_NAME", "UPL_BANKDATE", "REC_TYPE", "GROUP_ID", "FILE_ID", "SQL_ID", "SQL_TEXT", "VERS", "FILE_CODE", "START_TIME", "STOP_TIME", "UPL_TIME_MIN", "STATUS_CODE", "ROWS_UPLOADED", "PARAMS", "UPL_ERRORS", "START_ARC_TIME", "STOP_ARC_TIME", "ARC_TIME_MIN", "ARC_LOGMESS", "START_FTP_TIME", "STOP_FTP_TIME", "FTP_TIME_MIN", "FTP_LOGMESS") AS 
  select s.id, s.parent_id,s.file_name, s.upl_bankdate, s.rec_type, s.group_id, s.file_id,
       s.sql_id, q.sql_text, q.vers,
	   case rec_type when 'FILE'  then f.file_code
	                 when 'GROUP' then 'IT''S A GROUP#'||s.group_id||' INFO'
					 when 'JOB'   then 'IT''S A JOB INFO'  end file_code,
       s.start_time, s.stop_time, round((s.stop_time - s.start_time)*24*60,3) upl_time_min,
       p.status_code, s.rows_uploaded, params, upl_errors,
       s.start_arc_time, s.stop_arc_time, round((s.stop_arc_time - s.start_arc_time)*24*60,3) arc_time_min,
       arc_logmess,
       s.start_ftp_time, s.stop_ftp_time, round((s.stop_ftp_time - s.start_ftp_time)*24*60,3) ftp_time_min,
       ftp_logmess
 from upl_stats s, upl_files f, upl_process_status p, upl_sql q
where s.file_id  = f.file_id (+)
  and s.sql_id   = q.sql_id (+)
  and p.status_id = s.status_id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_STATS.sql =========*** End ***
PROMPT ===================================================================================== 
