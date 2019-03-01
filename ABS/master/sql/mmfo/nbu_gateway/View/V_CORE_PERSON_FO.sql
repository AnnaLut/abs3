PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_PERSON_FO.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_PERSON_FO ***
create or replace view V_CORE_PERSON_FO as 
select "REQUEST_ID","RNK","LASTNAME","FIRSTNAME","MIDDLENAME","ISREZ","INN","BIRTHDAY","COUNTRYCODNEREZ","K060","EDUCATION","TYPEW","CODEDRPOU","NAMEW","PERSON_CODE","DEFAULT_PERSON_KF","DEFAULT_PERSON_ID","PERSON_OBJECT_ID","STATUS","STATUS_MESSAGE","KF"
  from CORE_PERSON_FO t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'PERSON')
                         group by r.kf);

grant SELECT                                  on V_CORE_PERSON_FO   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_PERSON_FO.sql =========*** End *** 
PROMPT ===================================================================================== 
