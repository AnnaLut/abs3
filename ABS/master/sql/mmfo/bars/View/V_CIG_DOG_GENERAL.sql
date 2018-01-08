

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_DOG_GENERAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_DOG_GENERAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_DOG_GENERAL ("ID", "ND", "CUST_ID", "PHASE_ID", "PAY_METHOD_ID", "PAY_PERIOD_ID", "OPERATION", "CONTRACT_TYPE", "CONTRACT_CODE", "CONTRACT_DATE", "CONTRACT_START_DATE", "CURRENCY_ID", "CREDIT_PURPOSE", "NEGATIVE_STATUS", "APPLICATION_DATE", "EXP_END_DATE", "FACT_END_DATE", "UPD_DATE", "SYNC_DATE", "BRANCH", "BRANCH_DOG", "SEND_DATE", "SEND_ID", "BATCH_ID") AS 
  select id,
       nd,
       cust_id,
       phase_id,
       pay_method_id,
       pay_period_id,
       operation,
       contract_type,
       contract_code,
       contract_date,
       contract_start_date,
       currency_id,
       credit_purpose,
       negative_status,
       application_date,
       exp_end_date,
       fact_end_date,
       upd_date,
       sync_date,
       branch,
       branch_dog,
       send_date,
       send_id,
       batch_id
  from CIG_DOG_GENERAL -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;

PROMPT *** Create  grants  V_CIG_DOG_GENERAL ***
grant SELECT,UPDATE                                                          on V_CIG_DOG_GENERAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_DOG_GENERAL to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_DOG_GENERAL to CIG_ROLE;
grant SELECT                                                                 on V_CIG_DOG_GENERAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_DOG_GENERAL.sql =========*** End 
PROMPT ===================================================================================== 
