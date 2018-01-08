

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SHM_TARIF_SCALE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SHM_TARIF_SCALE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SHM_TARIF_SCALE ("IDS", "KOD", "KV", "SUM_LIMIT", "SUM_TARIF", "PR", "SMIN", "KV_SMIN", "SMAX", "KV_SMAX") AS 
  select s.ids, s.kod, t.kv, s.sum_limit, s.sum_tarif, s.pr,
       s.smin, t.kv_smin, s.smax, t.kv_smax
  from sh_tarif_scale s, tarif t
 where s.kod = t.kod;

PROMPT *** Create  grants  V_SHM_TARIF_SCALE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SHM_TARIF_SCALE to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SHM_TARIF_SCALE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SHM_TARIF_SCALE to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SHM_TARIF_SCALE to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SHM_TARIF_SCALE.sql =========*** End 
PROMPT ===================================================================================== 
