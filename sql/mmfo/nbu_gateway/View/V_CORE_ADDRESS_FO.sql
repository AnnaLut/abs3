PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_ADDRESS_FO.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_ADDRESS_FO ***
create or replace view V_CORE_ADDRESS_FO as 
select "REQUEST_ID","RNK","CODREGION","AREA","ZIP","CITY","STREETADDRESS","HOUSENO","ADRKORP","FLATNO","KF" from      CORE_ADDRESS_FO t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'PERSON_ADDRESS')
                         group by r.kf);

grant SELECT                                  on V_CORE_ADDRESS_FO   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_ADDRESS_FO.sql =========*** End *** 
PROMPT ===================================================================================== 
