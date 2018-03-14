PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_FINPERFORMANCEGR_UO.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_FINPERFORMANCEGR_UO ***
create or replace view V_CORE_FINPERFORMANCEGR_UO as 
select "REQUEST_ID","RNK","SALESGR","EBITGR","EBITDAGR","TOTALDEBTGR","CLASSGR","KF" from      CORE_FINPERFORMANCEGR_UO t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'COMPANY_GROUP_PERFORMANCE')
                         group by r.kf);

grant SELECT                                  on V_CORE_FINPERFORMANCEGR_UO   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_FINPERFORMANCEGR_UO.sql =========*** End *** 
PROMPT ===================================================================================== 
