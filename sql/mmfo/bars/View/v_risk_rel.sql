

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RISK_REL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RISK_REL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RISK_REL ("RNK") AS 
  SELECT DISTINCT rnk
     FROM customer_rel
    WHERE rel_id IN (32, 36, 37, 38, 39,50 )
          AND rnk NOT IN (SELECT rnk
                             FROM customer_risk
                            WHERE risk_id IN (2, 3, 62, 63, 64, 65)
                                  AND dat_end IS NULL);

PROMPT *** Create  grants  V_RISK_REL ***
grant SELECT                                                                 on V_RISK_REL      to BARSREADER_ROLE;
grant SELECT                                                                 on V_RISK_REL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RISK_REL      to START1;
grant SELECT                                                                 on V_RISK_REL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RISK_REL.sql =========*** End *** ===
PROMPT ===================================================================================== 
