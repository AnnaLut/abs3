

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_ND_ACC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_ND_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_ND_ACC (ND, NAME, ACC) AS 
  select nd, 'ACC_PK',   acc_pk   from w4_acc
union all
select nd, 'ACC_OVR',  acc_ovr  from w4_acc
union all
select nd, 'ACC_9129', acc_9129 from w4_acc
union all
select nd, 'ACC_3570', acc_3570 from w4_acc
union all
select nd, 'ACC_2208', acc_2208 from w4_acc
union all
select nd, 'ACC_2627', acc_2627 from w4_acc
union all
select nd, 'ACC_2207', acc_2207 from w4_acc
union all
select nd, 'ACC_3579', acc_3579 from w4_acc
union all
select nd, 'ACC_2209', acc_2209 from w4_acc
union all
select nd, 'ACC_2625X', acc_2625x from w4_acc
union all
select nd, 'ACC_2627X', acc_2627x from w4_acc
union all
select nd, 'ACC_2625D', acc_2625d from w4_acc
union all
select nd, 'ACC_2628', acc_2628 from w4_acc
union all
select nd, 'ACC_9129I', acc_9129i from w4_acc
union all
select nd, trans_mask, acc from w4_acc_inst;

PROMPT *** Create  grants  V_W4_ND_ACC ***
grant SELECT                                                                 on V_W4_ND_ACC     to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_ND_ACC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_ND_ACC     to OW;
grant SELECT                                                                 on V_W4_ND_ACC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_ND_ACC.sql =========*** End *** ==
PROMPT ===================================================================================== 
