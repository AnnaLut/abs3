PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_PLEDGE_DEP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_PLEDGE_DEP ***

 CREATE OR REPLACE FORCE VIEW BARS.V_NBU_PLEDGE_DEP AS 
 select "RNK","ACC","ORDERNUM","NUMBERPLEDGE","PLEDGEDAY","S031","R030","SUMPLEDGE","PRICEPLEDGE","LASTPLEDGEDAY","CODREALTY","ZIPREALTY","SQUAREREALTY","REAL6INCOME","NOREAL6INCOME","FLAGINSURANCEPLEDGE","NUMDOGDP","DOGDAYDP","R030DP","SUMDP","STATUS","STATUS_MESSAGE","KF" from NBU_PLEDGE_DEP n where n.kf = sys_context('bars_context','user_mfo');

grant SELECT                                  on V_NBU_PLEDGE_DEP   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_PLEDGE_DEP.sql =========*** End *
PROMPT ===================================================================================== 
