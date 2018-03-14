PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_FINPERFORMANCEGR_UO.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_FINPERFORMANCEGR_UO ***

create or replace view V_CORE_FINPERFORMANCEGR_UO as
select "REQUEST_ID","RNK","SALESGR","EBITGR","EBITDAGR","TOTALDEBTGR","CLASSGR","KF" from nbu_gateway.V_CORE_FINPERFORMANCEGR_UO;


PROMPT *** Create  grants  V_CORE_FINPERFORMANCEGR_UO ***
grant SELECT                                                                 on V_CORE_FINPERFORMANCEGR_UO to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_FINPERFORMANCEGR_UO.sql =========**
PROMPT ===================================================================================== 
