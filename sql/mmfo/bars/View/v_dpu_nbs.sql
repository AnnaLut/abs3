

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_NBS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_NBS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_NBS ("NBS_CODE", "NBS_NAME", "NBS_S181") AS 
  select p.NBS, p.NAME, d.S181
  from bars.ps p
  join ( select unique S181, NBS_DEP
           from BARS.DPU_NBS4CUST
       ) d
    on ( d.NBS_DEP = p.NBS )
 where D_CLOSE Is Null
 order by d.S181, p.NBS;

PROMPT *** Create  grants  V_DPU_NBS ***
grant SELECT                                                                 on V_DPU_NBS       to ABS_ADMIN;
grant SELECT                                                                 on V_DPU_NBS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_NBS       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_NBS.sql =========*** End *** ====
PROMPT ===================================================================================== 
