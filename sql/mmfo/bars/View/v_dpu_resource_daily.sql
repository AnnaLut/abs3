

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_RESOURCE_DAILY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_RESOURCE_DAILY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_RESOURCE_DAILY ("KF", "CCY_ID", "CCY_CODE", "MAT_DT", "DEP_AMT", "DEP_QTY") AS 
  select dpt_u.KF
     , dpt_u.KV
     , dpt_u.ISO
     , dpt_u.DAT_V
     , sum(dpt_u.OST)/100
     , count(dpt_u.DPU_ID)
  from BARS.DPT_U
 where nvl(dpt_u.DPU_ADD,1) <> 0
   and dpt_u.OST <> 0
 group BY dpt_u.KF, dpt_u.dat_v, dpt_u.kv, dpt_u.ISO
 order BY dpt_u.KF, dpt_u.dat_v, dpt_u.kv
;

PROMPT *** Create  grants  V_DPU_RESOURCE_DAILY ***
grant SELECT                                                                 on V_DPU_RESOURCE_DAILY to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_RESOURCE_DAILY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_RESOURCE_DAILY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_RESOURCE_DAILY.sql =========*** E
PROMPT ===================================================================================== 
