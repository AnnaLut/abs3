

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TARIF_SCALE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TARIF_SCALE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TARIF_SCALE ("KOD", "KV", "SUM_LIMIT", "SUM_TARIF", "PR", "SMIN", "KV_SMIN", "SMAX", "KV_SMAX") AS 
  select s.kod, t.kv, s.sum_limit, s.sum_tarif, s.pr,
       s.smin, t.kv_smin, s.smax, t.kv_smax
  from tarif_scale s, tarif t
 where s.kod = t.kod;

PROMPT *** Create  grants  V_TARIF_SCALE ***
grant SELECT                                                                 on V_TARIF_SCALE   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_TARIF_SCALE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TARIF_SCALE   to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_TARIF_SCALE   to TARIF;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_TARIF_SCALE   to TECH005;
grant SELECT                                                                 on V_TARIF_SCALE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TARIF_SCALE.sql =========*** End *** 
PROMPT ===================================================================================== 
