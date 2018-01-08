

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OTC_W4_ND_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OTC_W4_ND_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OTC_W4_ND_ACC ("ND", "NAME", "ACC") AS 
  SELECT nd, name, acc
     FROM w4_acc UNPIVOT (acc
                 FOR name
                 IN  (ACC_2203,
                     ACC_2207,
                     ACC_2208,
                     ACC_2209,
                     ACC_2625D,
                     ACC_2625X,
                     ACC_2627,
                     ACC_2627X,
                     ACC_2628,
                     ACC_3570,
                     ACC_3579,
                     ACC_9129,
                     ACC_OVR,
                     ACC_PK));



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OTC_W4_ND_ACC.sql =========*** End **
PROMPT ===================================================================================== 
