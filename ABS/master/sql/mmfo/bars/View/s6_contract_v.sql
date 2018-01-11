

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S6_Contract_V.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view S6_Contract_V ***

  CREATE OR REPLACE FORCE VIEW BARS.S6_Contract_V ("IdClient", "GROUP_C", "IdContract", "C_RISK") AS 
  select   "IdClient"                    ,
                       GROUP_C                       ,
                       min("IdContract") "IdContract",
                       min(C_RISK)       C_RISK
              from     "S6_Contract"
              group by "IdClient",
                       GROUP_C
 ;

PROMPT *** Create  grants  S6_Contract_V ***
grant SELECT                                                                 on S6_Contract_V   to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S6_Contract_V.sql =========*** End *** 
PROMPT ===================================================================================== 
