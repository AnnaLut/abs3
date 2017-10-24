

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_ND_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_ND_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_ND_ACC ("ND", "NAME", "ACC", "DAT_CLOSE") AS 
  SELECT nd,
          'ACC_PK',
          acc_pk,
          DAT_CLOSE
     FROM bpk_acc
   UNION
   SELECT nd,
          'ACC_OVR',
          acc_ovr,
          DAT_CLOSE
     FROM bpk_acc
   UNION
   SELECT nd,
          'ACC_TOVR',
          acc_tovr,
          DAT_CLOSE
     FROM bpk_acc
   UNION
   SELECT nd,
          'ACC_3570',
          acc_3570,
          DAT_CLOSE
     FROM bpk_acc
   UNION
   SELECT nd,
          'ACC_2208',
          acc_2208,
          DAT_CLOSE
     FROM bpk_acc
   UNION
   SELECT nd,
          'ACC_9129',
          acc_9129,
          DAT_CLOSE
     FROM bpk_acc
   UNION
   SELECT nd,
          'ACC_2207',
          acc_2207,
          DAT_CLOSE
     FROM bpk_acc
   UNION
   SELECT nd,
          'ACC_3579',
          acc_3579,
          DAT_CLOSE
     FROM bpk_acc
   UNION
   SELECT nd,
          'ACC_2209',
          acc_2209,
          DAT_CLOSE
     FROM bpk_acc;

PROMPT *** Create  grants  V_BPK_ND_ACC ***
grant SELECT                                                                 on V_BPK_ND_ACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_ND_ACC    to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_ND_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
