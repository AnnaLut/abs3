

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_ACC ("ND", "ACC_PK", "ACC_OVR", "ACC_9129", "ACC_3570", "ACC_2208", "ACC_2627", "ACC_2207", "ACC_3579", "ACC_2209", "CARD_CODE", "ACC_2625X", "ACC_2627X", "ACC_2625D", "ACC_2628", "ACC_2203", "FIN", "FIN23", "OBS23", "KAT23", "K23", "DAT_BEGIN", "DAT_END", "DAT_CLOSE", "PASS_DATE", "PASS_STATE", "KOL_SP", "S250", "GRP", "NOT_USE_REZ23") AS 
  select "ND","ACC_PK","ACC_OVR","ACC_9129","ACC_3570","ACC_2208","ACC_2627","ACC_2207","ACC_3579","ACC_2209","CARD_CODE","ACC_2625X","ACC_2627X","ACC_2625D","ACC_2628","ACC_2203","FIN","FIN23","OBS23","KAT23","K23","DAT_BEGIN","DAT_END","DAT_CLOSE","PASS_DATE","PASS_STATE","KOL_SP","S250","GRP","NOT_USE_REZ23" from W4_acc where NOT_USE_REZ23 is null;

PROMPT *** Create  grants  V_W4_ACC ***
grant SELECT                                                                 on V_W4_ACC        to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_ACC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_ACC        to START1;
grant SELECT                                                                 on V_W4_ACC        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
