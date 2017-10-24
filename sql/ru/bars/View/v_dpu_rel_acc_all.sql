

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_REL_ACC_ALL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_REL_ACC_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_REL_ACC_ALL ("GEN_ID", "GEN_ACC", "TIP_ACC", "DEP_ID", "DEP_ACC") AS 
  ( select g.dpu_id,
         g.acc,
         'DEP',
         d.dpu_id,
         d.acc
    from dpu_deal g,
         dpu_deal d
   where nvl(g.dpu_gen,0) = 0
     and nvl(d.dpu_gen,0) = g.dpu_id
   union all
  select g.dpu_id,
         gi.acra,
         'DEN',
         d.dpu_id,
         di.acra
    from dpu_deal g,
         int_accn gi,
         dpu_deal d,
         int_accn di
   where nvl(g.dpu_gen,0) = 0
     and nvl(d.dpu_gen,0) = g.dpu_id
     and g.acc = gi.acc
     and gi.id = 1
     and d.acc = di.acc
     and di.id = 1
);

PROMPT *** Create  grants  V_DPU_REL_ACC_ALL ***
grant SELECT                                                                 on V_DPU_REL_ACC_ALL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_REL_ACC_ALL to DPT_ROLE;
grant SELECT                                                                 on V_DPU_REL_ACC_ALL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_REL_ACC_ALL.sql =========*** End 
PROMPT ===================================================================================== 
