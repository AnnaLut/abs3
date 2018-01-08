

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BBPK_ACC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BBPK_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BBPK_ACC ("ACC_PK", "ACC_OVR", "ACC_9129", "ACC_TOVR", "KF", "ACC_3570", "ACC_2208", "ND", "PRODUCT_ID", "ACC_2207", "ACC_3579", "ACC_2209", "ACC_W4", "FIN", "FIN23", "OBS23", "KAT23", "K23", "DAT_END", "KOL_SP", "S250", "GRP") AS 
  (select "ACC_PK","ACC_OVR","ACC_9129","ACC_TOVR","KF","ACC_3570","ACC_2208","ND","PRODUCT_ID","ACC_2207","ACC_3579","ACC_2209","ACC_W4","FIN","FIN23","OBS23","KAT23","K23","DAT_END","KOL_SP","S250","GRP" from bpk_acc where dat_end is null);

PROMPT *** Create  grants  V_BBPK_ACC ***
grant SELECT                                                                 on V_BBPK_ACC      to BARSREADER_ROLE;
grant SELECT                                                                 on V_BBPK_ACC      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BBPK_ACC      to START1;
grant SELECT                                                                 on V_BBPK_ACC      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BBPK_ACC.sql =========*** End *** ===
PROMPT ===================================================================================== 
