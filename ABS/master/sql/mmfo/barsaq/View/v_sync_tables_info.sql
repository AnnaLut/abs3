

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_TABLES_INFO.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SYNC_TABLES_INFO ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_SYNC_TABLES_INFO ("TABLE_NAME", "SYNC_SQL", "PARAMETER_NAME", "SYNC_DATE", "STATUS", "STATUS_COMMENT", "START_TIME", "FINISH_TIME", "ERROR_MESSAGE", "JOB_ID") AS 
  select st.table_name, st.sync_sql, st.parameter_name, nvl(st.sync_date, trunc(sysdate)) sync_date,
sa.status, sa.status_comment, sa.start_time, sa.finish_time, sa.error_message, sa.job_id
from sync_tables st, sync_activity sa
where st.table_name = sa.table_name (+);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_TABLES_INFO.sql =========*** E
PROMPT ===================================================================================== 
