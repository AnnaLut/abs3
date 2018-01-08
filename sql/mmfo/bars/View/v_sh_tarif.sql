

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SH_TARIF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SH_TARIF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SH_TARIF ("ID", "KOD", "KV", "NAME", "TAR", "PR", "SMIN", "KV_SMIN", "SMAX", "KV_SMAX") AS 
  select m.id, t.kod, t.kv, t.name, s.tar, s.pr, s.smin, t.kv_smin, s.smax, t.kv_smax
  from tarif_scheme m, sh_tarif s, v_tarif t
 where m.id = s.ids
   and s.kod = t.kod
 union all
-- добавляем тарифы для схемы 0 (если для счета не указана схема тарифа)
select 0, t.kod, t.kv, t.name, t.tar, t.pr, t.smin, t.kv_smin, t.smax, t.kv_smax
  from v_tarif t;

PROMPT *** Create  grants  V_SH_TARIF ***
grant SELECT                                                                 on V_SH_TARIF      to BARSREADER_ROLE;
grant SELECT                                                                 on V_SH_TARIF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SH_TARIF      to CUST001;
grant SELECT                                                                 on V_SH_TARIF      to START1;
grant SELECT                                                                 on V_SH_TARIF      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SH_TARIF.sql =========*** End *** ===
PROMPT ===================================================================================== 
