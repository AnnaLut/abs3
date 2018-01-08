

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_JOBS_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_JOBS_LOG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_JOBS_LOG ("REC_ID", "RUN_ID", "JOB_ID", "DPT_ID", "BRANCH", "REF", "RNK", "KV", "DPT_SUM", "INT_SUM", "STATUS", "ERRMSG", "NLS", "DEAL_NUM", "RATE_VAL", "RATE_DAT", "KF") AS 
  SELECT REC_ID, RUN_ID, JOB_ID, DPT_ID, BRANCH,
         REF, RNK, KV, DPT_SUM, INT_SUM, STATUS,
         case
           when InStr(ERRMSG,chr(10),1,1) = 0
           then ERRMSG
           else SubStr(ERRMSG, 1, InStr(ERRMSG,chr(10),1,1)-1)
         end as ERRMSG,
         NLS, DEAL_NUM, RATE_VAL, RATE_DAT, KF
    FROM BARS.DPU_JOBS_LOG;

PROMPT *** Create  grants  V_DPU_JOBS_LOG ***
grant SELECT                                                                 on V_DPU_JOBS_LOG  to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_JOBS_LOG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_JOBS_LOG  to DPT_ADMIN;
grant SELECT                                                                 on V_DPU_JOBS_LOG  to RPBN001;
grant SELECT                                                                 on V_DPU_JOBS_LOG  to UPLD;
grant SELECT                                                                 on V_DPU_JOBS_LOG  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_JOBS_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
