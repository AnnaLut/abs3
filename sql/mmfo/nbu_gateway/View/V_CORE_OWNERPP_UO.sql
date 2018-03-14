PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_OWNERPP_UO.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_OWNERPP_UO ***
create or replace view V_CORE_OWNERPP_UO as 
select "REQUEST_ID","RNK","RNKB","LASTNAME","FIRSTNAME","MIDDLENAME","ISREZ","INN","COUNTRYCOD","PERCENT","KF"
  from CORE_OWNERPP_UO t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'COMPANY_OWNER_PERSON')
                         group by r.kf);

grant SELECT                                  on V_CORE_OWNERPP_UO   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_OWNERPP_UO.sql =========*** End *** 
PROMPT ===================================================================================== 
