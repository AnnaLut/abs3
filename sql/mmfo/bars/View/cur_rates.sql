

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUR_RATES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CUR_RATES ***

  CREATE OR REPLACE FORCE VIEW BARS.CUR_RATES ("BRANCH", "KV", "VDATE", "BSUM", "RATE_O", "RATE_B", "RATE_S", "RATE_SPOT", "RATE_FORWARD", "LIM_POS", "TOBO", "OFFICIAL") AS 
  SELECT branch                               ,
       kv                                   ,
       vdate                                ,
       bsum                                 ,
       rate_o                               ,
       DECODE(otm,'Y',rate_b,NULL) AS rate_b,
       DECODE(otm,'Y',rate_s,NULL) AS rate_s,
       rate_spot                            ,
       rate_forward                         ,
       lim_pos                              ,
       branch                      AS tobo  ,                                                                                     --,
       official
FROM   cur_rates$base
WHERE  branch=SYS_CONTEXT('bars_context','user_branch')
WITH   CHECK OPTION;

PROMPT *** Create  grants  CUR_RATES ***
grant FLASHBACK,REFERENCES,SELECT                                            on CUR_RATES       to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on CUR_RATES       to BARSAQ_ADM with grant option;
grant SELECT                                                                 on CUR_RATES       to BARSREADER_ROLE;
grant SELECT                                                                 on CUR_RATES       to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUR_RATES       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_RATES       to CUR_RATES;
grant SELECT                                                                 on CUR_RATES       to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_RATES       to INSPECTOR;
grant SELECT                                                                 on CUR_RATES       to RPBN001;
grant SELECT                                                                 on CUR_RATES       to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_RATES       to TECH005;
grant SELECT                                                                 on CUR_RATES       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUR_RATES       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CUR_RATES       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUR_RATES.sql =========*** End *** ====
PROMPT ===================================================================================== 
