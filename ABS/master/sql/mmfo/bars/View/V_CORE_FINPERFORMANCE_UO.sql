PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_FINPERFORMANCE_UO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_FINPERFORMANCE_UO ***

create or replace view V_CORE_FINPERFORMANCE_UO as
select "REQUEST_ID","RNK","SALES","EBIT","EBITDA","TOTALDEBT","KF" from nbu_gateway.V_CORE_FINPERFORMANCE_UO;


PROMPT *** Create  grants  V_CORE_FINPERFORMANCE_UO ***
grant SELECT                                                                 on V_CORE_FINPERFORMANCE_UO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_FINPERFORMANCE_UO.sql =========**
PROMPT ===================================================================================== 
