

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CLV_CUSTOMER_RISK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CLV_CUSTOMER_RISK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CLV_CUSTOMER_RISK ("RNK", "RISK_ID", "RISK_NAME", "VALUE") AS 
  select c.rnk, c.risk_id, r.name, c.value
  from fm_risk_criteria r,
       ( select rnk, risk_id, 1 value
           from clv_customer_risk
          union all
         select c.rnk, f.id, 0
           from clv_customer c, fm_risk_criteria f
          where (c.rnk, f.id) not in (select rnk, risk_id from clv_customer_risk) ) c
 where r.id = c.risk_id
   and r.inuse = 1;

PROMPT *** Create  grants  V_CLV_CUSTOMER_RISK ***
grant SELECT                                                                 on V_CLV_CUSTOMER_RISK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CLV_CUSTOMER_RISK to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CLV_CUSTOMER_RISK.sql =========*** En
PROMPT ===================================================================================== 
