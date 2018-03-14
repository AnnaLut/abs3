PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_GROUPUR_UO.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_GROUPUR_UO ***
create or replace view V_CORE_GROUPUR_UO as 
select "REQUEST_ID","RNK","WHOIS","ISREZGR","CODEDRPOUGR","NAMEURGR","COUNTRYCODGR","KF" from      CORE_GROUPUR_UO t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'COMPANY_GROUP')
                         group by r.kf);

grant SELECT                                  on V_CORE_GROUPUR_UO   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_GROUPUR_UO.sql =========*** End *** 
PROMPT ===================================================================================== 
