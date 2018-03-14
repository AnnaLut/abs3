PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_PROFIT_FO.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_PROFIT_FO ***
create or replace view V_CORE_PROFIT_FO as 
select "REQUEST_ID","RNK","REAL6MONTH","NOREAL6MONTH","KF"
from CORE_PROFIT_FO t 
where t.request_id in
       (select max(r.id) from nbu_core_data_request r where r.data_type_id =
               (select drt.id from nbu_core_data_request_type drt where drt.data_type_code = 'PERSON_INCOME' )
               group by r.kf);

grant SELECT                                  on V_CORE_PROFIT_FO   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_PROFIT_FO.sql =========*** End *** 
PROMPT ===================================================================================== 
