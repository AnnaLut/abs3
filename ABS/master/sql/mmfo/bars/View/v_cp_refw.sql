

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_REFW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_REFW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_REFW ("REF", "TAG", "VALUE") AS 
  select a.ref, t.tag, (select substr(value,1,255) from  cp_refw where ref= a.ref and tag = t.tag) 
from cp_arch a, v3_cp_tag t;

PROMPT *** Create  grants  V_CP_REFW ***
grant SELECT,UPDATE                                                          on V_CP_REFW       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CP_REFW       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_REFW.sql =========*** End *** ====
PROMPT ===================================================================================== 
