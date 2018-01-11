

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SHM_TARIF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SHM_TARIF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SHM_TARIF ("IDS", "KOD", "KV", "TAR", "PR", "SMIN", "KV_SMIN", "SMAX", "KV_SMAX", "NBS_OB22") AS 
  select s.ids, s.kod, t.kv, s.tar, s.pr,
       s.smin, t.kv_smin, s.smax, t.kv_smax, s.nbs_ob22
  from sh_tarif s, tarif t
 where s.kod = t.kod;

PROMPT *** Create  grants  V_SHM_TARIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SHM_TARIF     to ABS_ADMIN;
grant SELECT                                                                 on V_SHM_TARIF     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SHM_TARIF     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SHM_TARIF     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SHM_TARIF     to TECH005;
grant SELECT                                                                 on V_SHM_TARIF     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SHM_TARIF.sql =========*** End *** ==
PROMPT ===================================================================================== 
