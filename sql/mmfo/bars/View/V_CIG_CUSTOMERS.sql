

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_CUSTOMERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_CUSTOMERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_CUSTOMERS ("CUST_ID", "CUST_TYPE", "RNK", "UPD_DATE", "SYNC_DATE", "CUST_NAME", "CUST_CODE", "LAST_ERR", "BRANCH") AS 
  select cust_id,
       cust_type,
       rnk,
       upd_date,
       sync_date,
       cust_name,
       cust_code,
       last_err,
       branch
  from CIG_CUSTOMERS  -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;

PROMPT *** Create  grants  V_CIG_CUSTOMERS ***
grant SELECT,UPDATE                                                          on V_CIG_CUSTOMERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_CUSTOMERS to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_CUSTOMERS to CIG_ROLE;
grant SELECT                                                                 on V_CIG_CUSTOMERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_CUSTOMERS.sql =========*** End **
PROMPT ===================================================================================== 
