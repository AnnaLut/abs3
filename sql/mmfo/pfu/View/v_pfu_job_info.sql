

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_JOB_INFO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_JOB_INFO ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_JOB_INFO ("JOB_NAME", "COMMENTS", "STATE", "LAST_START_DATE", "LAST_RUN_DURATION", "NEXT_RUN_DATE", "RUN_STATUS", "ADD_INFO") AS 
  SELECT "JOB_NAME","COMMENTS","STATE","LAST_START_DATE","LAST_RUN_DURATION","NEXT_RUN_DATE","RUN_STATUS","ADD_INFO"
  FROM table (pfu_service_utl.get_job_info);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_JOB_INFO.sql =========*** End *** 
PROMPT ===================================================================================== 
