

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BPK_ALL_ACCOUNTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view BPK_ALL_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.BPK_ALL_ACCOUNTS ("PC", "ND", "ACC_PK", "ACC_OVR", "ACC_9129", "ACC_2208", "ACC_3570", "ACC_2207", "ACC_3579", "ACC_2209", "ACC_2627", "ACC_2628", "CARD_CODE", "KOL_SP") AS 
  SELECT 'PK' pc,
          nd,
          acc_pk,
          acc_ovr,
          acc_9129,
          acc_2208,
          acc_3570,
          acc_2207,
          acc_3579,
          acc_2209,
          NULL,
          NULL,
          NULL,
          kol_sp
     FROM bpk_acc
   UNION
   SELECT 'W4' pc,
          nd,
          acc_pk,
          acc_ovr,
          acc_9129,
          acc_2208,
          acc_3570,
          acc_2207,
          acc_3579,
          acc_2209,
          acc_2627,
          acc_2628,
          card_code,
          kol_sp
     FROM w4_acc;

PROMPT *** Create  grants  BPK_ALL_ACCOUNTS ***
grant SELECT                                                                 on BPK_ALL_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_ALL_ACCOUNTS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BPK_ALL_ACCOUNTS.sql =========*** End *
PROMPT ===================================================================================== 
