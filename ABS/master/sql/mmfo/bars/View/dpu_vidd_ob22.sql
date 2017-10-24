

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPU_VIDD_OB22.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view DPU_VIDD_OB22 ***

  CREATE OR REPLACE FORCE VIEW BARS.DPU_VIDD_OB22 ("VIDD", "NAME", "KV", "NBS_DEP", "OB22_DEP", "NBS_INT", "OB22_INT", "NBS_EXP", "OB22_EXP", "NBS_RED", "OB22_RED") AS 
  SELECT distinct
       v.vidd, v.name, v.kv,
       o.nbs_dep, o.ob22_dep,
       o.nbs_int, o.ob22_int,
       o.nbs_exp, o.ob22_exp,
       o.nbs_red, o.ob22_red
  FROM BARS.DPU_VIDD v
  LEFT JOIN BARS.DPU_TYPES_OB22 o ON (v.type_id = o.type_id AND v.bsd = o.nbs_dep AND decode(v.KV,980,1,2) = o.R034)
 WHERE v.flag = 1;

PROMPT *** Create  grants  DPU_VIDD_OB22 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_VIDD_OB22   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_VIDD_OB22   to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPU_VIDD_OB22.sql =========*** End *** 
PROMPT ===================================================================================== 
