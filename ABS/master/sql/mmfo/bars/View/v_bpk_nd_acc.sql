

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_ND_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_ND_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_ND_ACC ("ND", "NAME", "ACC") AS 
  select nd, 'ACC_PK',   acc_pk   from bpk_acc
union
select nd, 'ACC_OVR',  acc_ovr  from bpk_acc
union
select nd, 'ACC_TOVR', acc_tovr from bpk_acc
union
select nd, 'ACC_3570', acc_3570 from bpk_acc
union
select nd, 'ACC_2208', acc_2208 from bpk_acc
union
select nd, 'ACC_9129', acc_9129 from bpk_acc
union
select nd, 'ACC_2207', acc_2207 from bpk_acc
union
select nd, 'ACC_3579', acc_3579 from bpk_acc
union
select nd, 'ACC_2209', acc_2209 from bpk_acc;

PROMPT *** Create  grants  V_BPK_ND_ACC ***
grant SELECT                                                                 on V_BPK_ND_ACC    to BARSREADER_ROLE;
grant SELECT                                                                 on V_BPK_ND_ACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_ND_ACC    to OBPC;
grant SELECT                                                                 on V_BPK_ND_ACC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_ND_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
