

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_CRV_ACC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_CRV_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_CRV_ACC ("ND", "ACC_PK", "ACC_OVR", "ACC_9129", "ACC_3570", "ACC_2208", "ACC_2627", "ACC_2207", "ACC_3579", "ACC_2209", "CARD_CODE", "ACC_2625X", "ACC_2627X", "ACC_2625D", "ACC_2628", "ACC_2203", "FIN", "FIN23", "OBS23", "KAT23", "K23", "DAT_BEGIN", "DAT_END", "DAT_CLOSE") AS 
  select c."ND",c."ACC_PK",c."ACC_OVR",c."ACC_9129",c."ACC_3570",c."ACC_2208",c."ACC_2627",c."ACC_2207",c."ACC_3579",c."ACC_2209",c."CARD_CODE",c."ACC_2625X",c."ACC_2627X",c."ACC_2625D",c."ACC_2628",c."ACC_2203",c."FIN",c."FIN23",c."OBS23",c."KAT23",c."K23",c."DAT_BEGIN",c."DAT_END",c."DAT_CLOSE"
  from w4_acc c, accounts a
 where c.acc_pk = a.acc
   and a.tip = 'W4V';

PROMPT *** Create  grants  W4_CRV_ACC ***
grant SELECT                                                                 on W4_CRV_ACC      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_CRV_ACC      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_CRV_ACC.sql =========*** End *** ===
PROMPT ===================================================================================== 
