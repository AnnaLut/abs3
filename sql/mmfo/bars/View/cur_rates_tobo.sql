

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUR_RATES_TOBO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view CUR_RATES_TOBO ***

  CREATE OR REPLACE FORCE VIEW BARS.CUR_RATES_TOBO ("TOBO", "KV", "VDATE", "BSUM", "RATE_B", "RATE_S") AS 
  SELECT branch, kv, vdate, bsum, rate_b, rate_s
     FROM cur_rates$base
    WHERE kv <> 980 AND branch IN (SELECT branch
                                     FROM branch
                                    WHERE date_closed IS NULL)
      AND branch like SYS_CONTEXT ('bars_context', 'user_branch_mask') 
 ;

PROMPT *** Create  grants  CUR_RATES_TOBO ***
grant REFERENCES,SELECT                                                      on CUR_RATES_TOBO  to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on CUR_RATES_TOBO  to BARSAQ_ADM with grant option;
grant SELECT                                                                 on CUR_RATES_TOBO  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_RATES_TOBO  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_RATES_TOBO  to PYOD001;
grant SELECT                                                                 on CUR_RATES_TOBO  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUR_RATES_TOBO  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUR_RATES_TOBO.sql =========*** End ***
PROMPT ===================================================================================== 
