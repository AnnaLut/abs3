PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_PERSON_UO.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_PERSON_UO ***
create or replace view V_CORE_PERSON_UO as 
select "REQUEST_ID","RNK","NAMEUR","ISREZ","CODEDRPOU","REGISTRYDAY","NUMBERREGISTRY","K110","EC_YEAR","COUNTRYCODNEREZ","ISMEMBER","ISCONTROLLER","ISPARTNER","ISAUDIT","K060","COMPANY_CODE","DEFAULT_COMPANY_KF","DEFAULT_COMPANY_ID","COMPANY_OBJECT_ID","STATUS","STATUS_MESSAGE","KF"
  from CORE_PERSON_UO t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'COMPANY')
                         group by r.kf);

grant SELECT                                  on V_CORE_PERSON_UO   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_PERSON_UO.sql =========*** End *** 
PROMPT ===================================================================================== 
