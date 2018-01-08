

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_AGREEMENTS_VISA.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_AGREEMENTS_VISA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_AGREEMENTS_VISA ("AGRMNT_ID", "AGRMNT_NUMBER", "AGRMNT_TYPE_NAME", "AGRMNT_DUE_DATE", "AGRMNT_BDATE", "AGRMNT_CRDATE", "AGRMNT_CREATOR_NAME", "AGRMNT_DPU_ID", "AGRMNT_STATE", "CNTRCT_BRANCH", "CNTRCT_CUST_ID") AS 
  SELECT AGRMNT_ID,
       AGRMNT_NUMBER,
       AGRMNT_TYPE_NAME,
       AGRMNT_DUE_DATE,
       AGRMNT_BDATE,
       AGRMNT_CRDATE,
       AGRMNT_CREATOR_NAME,
       AGRMNT_DPU_ID,
       AGRMNT_STATE,
       CNTRCT_BRANCH,
       CNTRCT_CUST_ID
  FROM BARS.V_DPU_AGREEMENTS
 WHERE AGRMNT_STATE = 0
;

PROMPT *** Create  grants  V_DPU_AGREEMENTS_VISA ***
grant SELECT                                                                 on V_DPU_AGREEMENTS_VISA to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_AGREEMENTS_VISA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_AGREEMENTS_VISA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_AGREEMENTS_VISA.sql =========*** 
PROMPT ===================================================================================== 
