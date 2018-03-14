PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_PLEDGE_DEP.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_PLEDGE_DEP ***

create or replace view V_CORE_PLEDGE_DEP as
select "REQUEST_ID","RNK","ACC","ORDERNUM","NUMBERPLEDGE","PLEDGEDAY","S031","R030","SUMPLEDGE","PRICEPLEDGE","LASTPLEDGEDAY","CODREALTY","ZIPREALTY","SQUAREREALTY","REAL6INCOME","NOREAL6INCOME","FLAGINSURANCEPLEDGE","NUMDOGDP","DOGDAYDP","R030DP","SUMDP","DEFAULT_PLEDGE_KF","DEFAULT_PLEDGE_ID","PLEDGE_OBJECT_ID","STATUS","STATUS_MESSAGE","KF" from nbu_gateway.V_CORE_PLEDGE_DEP;


PROMPT *** Create  grants  V_CORE_PLEDGE_DEP ***
grant SELECT                                                                 on V_CORE_PLEDGE_DEP to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_PLEDGE_DEP.sql =========**
PROMPT ===================================================================================== 
