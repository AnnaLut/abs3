

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VX1_BPK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VX1_BPK ***

  CREATE OR REPLACE FORCE VIEW BARS.VX1_BPK ("BPK", "ND", "FIN23", "OBS23", "KAT23", "K23", "ACC_PK", "ACC_2208", "ACC_2207", "ACC_2209", "ACC_2627", "ACC_OVR", "ACC_9129") AS 
  select 'BPK' BPK, nd, FIN23, OBS23, KAT23, K23, ACC_PK, ACC_2208, aCC_2207, ACC_2209, null ACC_2627 , ACC_OVR, acc_9129
     from bpk_acc union all
     select 'W4'  BPK, nd, FIN23, OBS23, KAT23, K23, ACC_PK, ACC_2208, aCC_2207, ACC_2209, ACC_2627, nvl(ACC_OVR,acc_2203), acc_9129
     from w4_acc  ;

PROMPT *** Create  grants  VX1_BPK ***
grant SELECT                                                                 on VX1_BPK         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VX1_BPK.sql =========*** End *** ======
PROMPT ===================================================================================== 
