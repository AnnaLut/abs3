

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_DOG_CREDIT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_DOG_CREDIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_DOG_CREDIT ("ID", "DOG_ID", "LIMIT_CURR_ID", "LIMIT_SUM", "UPDATE_DATE", "CREDIT_USAGE", "RES_CURR_ID", "RES_SUM", "OVERDUE_CURR_ID", "OVERDUE_SUM", "SYNC_DATE", "BRANCH", "OVERDUE_DAY_CNT", "OVERDUE_CNT") AS 
  select id,
       dog_id,
       limit_curr_id,
       limit_sum,
       update_date,
       credit_usage,
       res_curr_id,
       res_sum,
       overdue_curr_id,
       overdue_sum,
       sync_date,
       branch,
       overdue_day_cnt,
       overdue_cnt
  from CIG_DOG_CREDIT -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;

PROMPT *** Create  grants  V_CIG_DOG_CREDIT ***
grant SELECT,UPDATE                                                          on V_CIG_DOG_CREDIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_DOG_CREDIT to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_DOG_CREDIT to CIG_ROLE;
grant SELECT                                                                 on V_CIG_DOG_CREDIT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_DOG_CREDIT.sql =========*** End *
PROMPT ===================================================================================== 
