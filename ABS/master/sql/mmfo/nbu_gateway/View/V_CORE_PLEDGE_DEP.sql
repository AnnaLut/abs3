PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_PLEDGE_DEP.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_PLEDGE_DEP ***
create or replace view V_CORE_PLEDGE_DEP as 
select "REQUEST_ID","RNK","ACC","ORDERNUM","NUMBERPLEDGE","PLEDGEDAY","S031","R030","SUMPLEDGE","PRICEPLEDGE","LASTPLEDGEDAY","CODREALTY","ZIPREALTY","SQUAREREALTY","REAL6INCOME","NOREAL6INCOME","FLAGINSURANCEPLEDGE","NUMDOGDP","DOGDAYDP","R030DP","SUMDP","DEFAULT_PLEDGE_KF","DEFAULT_PLEDGE_ID","PLEDGE_OBJECT_ID","STATUS","STATUS_MESSAGE","KF"
  from CORE_PLEDGE_DEP t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'PLEDGE')
                         group by r.kf);

grant SELECT                                  on V_CORE_PLEDGE_DEP   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_PLEDGE_DEP.sql =========*** End *** 
PROMPT ===================================================================================== 
