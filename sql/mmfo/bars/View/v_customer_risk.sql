

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_RISK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_RISK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_RISK ("RNK", "RISK_ID", "RISK_NAME", "VALUE") AS 
  select c.rnk, c.risk_id, r.name, c.value
  from fm_risk_criteria r,
       ( select rnk, risk_id, 1 value
           from customer_risk
          where dat_end is null
          union all  
         select c.rnk, f.id, 0
           from customer c, fm_risk_criteria f
          where (c.rnk, f.id) not in
                (select rnk, risk_id
                   from customer_risk
                  where dat_end is null) ) c
 where r.id = c.risk_id
   and r.inuse = 1;

PROMPT *** Create  grants  V_CUSTOMER_RISK ***
grant SELECT                                                                 on V_CUSTOMER_RISK to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_RISK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_RISK to CUST001;
grant SELECT                                                                 on V_CUSTOMER_RISK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_RISK.sql =========*** End **
PROMPT ===================================================================================== 
