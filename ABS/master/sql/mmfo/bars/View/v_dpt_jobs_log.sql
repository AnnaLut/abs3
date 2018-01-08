

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_JOBS_LOG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_JOBS_LOG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_JOBS_LOG ("REC_ID", "RUN_ID", "JOB_ID", "DPT_ID", "BRANCH", "REF", "RNK", "KV", "DPT_SUM", "INT_SUM", "STATUS", "ERRMSG", "NLS", "CONTRACT_ID", "DEAL_NUM", "RATE_VAL", "RATE_DAT", "KF") AS 
  SELECT REC_ID, RUN_ID, JOB_ID, DPT_ID, BRANCH, REF, RNK, KV, DPT_SUM, INT_SUM,
         STATUS, ERRMSG, NLS, CONTRACT_ID, DEAL_NUM, RATE_VAL, RATE_DAT, KF
    FROM BARS.DPT_JOBS_LOG
   UNION ALL
  SELECT REC_ID, RUN_ID, JOB_ID, DPT_ID, BRANCH, REF, RNK, KV, DPT_SUM, INT_SUM,
         STATUS, ERRMSG, NLS, CONTRACT_ID, DEAL_NUM, RATE_VAL, RATE_DAT, KF
    FROM BARS.DPT_JOBS_LOG_ARCH;

PROMPT *** Create  grants  V_DPT_JOBS_LOG ***
grant SELECT                                                                 on V_DPT_JOBS_LOG  to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_JOBS_LOG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_JOBS_LOG  to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_JOBS_LOG  to RPBN001;
grant SELECT                                                                 on V_DPT_JOBS_LOG  to UPLD;
grant SELECT                                                                 on V_DPT_JOBS_LOG  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_JOBS_LOG.sql =========*** End ***
PROMPT ===================================================================================== 
