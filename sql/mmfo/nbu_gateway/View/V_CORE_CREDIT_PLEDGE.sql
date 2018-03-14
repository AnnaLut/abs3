PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_CREDIT_PLEDGE.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_CREDIT_PLEDGE ***
create or replace view V_CORE_CREDIT_PLEDGE as 
select "REQUEST_ID","RNK","ND","ACC","SUMPLEDGE","PRICEPLEDGE","KF" from      CORE_CREDIT_PLEDGE t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'LOAN_PLEDGE')
                         group by r.kf);

grant SELECT                                  on V_CORE_CREDIT_PLEDGE   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_CREDIT_PLEDGE.sql =========*** End *** 
PROMPT ===================================================================================== 
