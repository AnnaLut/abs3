

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CM_SALARY.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CM_SALARY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CM_SALARY ("ID", "OKPO", "OKPO_N", "ORG_NAME", "PRODUCT_CODE", "CHG_DATE", "CHG_USER") AS 
  select id, okpo, okpo_n, org_name, product_code, chg_date, chg_user
  from cm_salary;

PROMPT *** Create  grants  V_CM_SALARY ***
grant SELECT                                                                 on V_CM_SALARY     to BARSREADER_ROLE;
grant SELECT                                                                 on V_CM_SALARY     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CM_SALARY.sql =========*** End *** ==
PROMPT ===================================================================================== 
