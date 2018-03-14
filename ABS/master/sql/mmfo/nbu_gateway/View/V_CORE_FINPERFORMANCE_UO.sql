PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_FINPERFORMANCE_UO.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_FINPERFORMANCE_UO ***
create or replace view V_CORE_FINPERFORMANCE_UO as 
select "REQUEST_ID","RNK","SALES","EBIT","EBITDA","TOTALDEBT","KF" from      CORE_FINPERFORMANCE_UO t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'COMPANY_PERFORMANCE')
                         group by r.kf);

grant SELECT                                  on V_CORE_FINPERFORMANCE_UO   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_FINPERFORMANCE_UO.sql =========*** End *** 
PROMPT ===================================================================================== 
