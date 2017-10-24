

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S6_S6_CONTRACT_V.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view S6_S6_CONTRACT_V ***

  CREATE OR REPLACE FORCE VIEW BARS.S6_S6_CONTRACT_V ("IDCLIENT", "GROUP_C", "IDCONTRACT", "C_RISK") AS 
  select   IDCLIENT                        ,
                       GROUP_C                         ,
                       min(trim(IDCONTRACT)) IDCONTRACT,
                       min(C_RISK)           C_RISK
              from     S6_S6_CONTRACT
              group by IDCLIENT,
                       GROUP_C;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S6_S6_CONTRACT_V.sql =========*** End *
PROMPT ===================================================================================== 
