

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OTC_BPK_ND_ACC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OTC_BPK_ND_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OTC_BPK_ND_ACC ("ND", "NAME", "ACC") AS 
  SELECT nd, name, acc
     FROM bpk_acc UNPIVOT (acc
                  FOR name
                  IN  (ACC_2207,
                      ACC_2208,
                      ACC_2209,
                      ACC_3570,
                      ACC_3579,
                      ACC_9129,
                      ACC_OVR,
                      ACC_PK,
                      ACC_TOVR,
                      ACC_W4));

PROMPT *** Create  grants  V_OTC_BPK_ND_ACC ***
grant SELECT                                                                 on V_OTC_BPK_ND_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on V_OTC_BPK_ND_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OTC_BPK_ND_ACC.sql =========*** End *
PROMPT ===================================================================================== 
