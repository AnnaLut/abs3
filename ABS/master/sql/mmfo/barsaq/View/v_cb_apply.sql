

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_CB_APPLY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CB_APPLY ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_CB_APPLY ("APPLY_NAME", "STATUS", "STATUS_CHANGE_TIME", "APPLY_TIME", "ERROR_MESSAGE") AS 
  select da.apply_name, da.status, da.status_change_time, dap.apply_time, da.error_message
from dba_apply da, dba_apply_progress dap
where da.apply_name = 'CB_APPLY' and da.apply_name = dap.apply_name;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_CB_APPLY.sql =========*** End *** =
PROMPT ===================================================================================== 
