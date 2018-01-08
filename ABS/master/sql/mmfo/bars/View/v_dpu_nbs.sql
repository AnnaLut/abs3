

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_NBS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_NBS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_NBS ("NBS_CODE", "NBS_NAME", "NBS_S181") AS 
  select p.NBS, p.NAME, d.IRVK
  from PS p
  join ( select unique IRVK, NBS_DEP
           from DPU_NBS4CUST
       ) d
    on ( d.NBS_DEP = p.NBS )
 where p.D_CLOSE Is Null
 order by d.IRVK, p.NBS;

PROMPT *** Create  grants  V_DPU_NBS ***
grant SELECT                                                                 on V_DPU_NBS       to ABS_ADMIN;
grant SELECT                                                                 on V_DPU_NBS       to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_NBS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_NBS       to START1;
grant SELECT                                                                 on V_DPU_NBS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_NBS.sql =========*** End *** ====
PROMPT ===================================================================================== 
