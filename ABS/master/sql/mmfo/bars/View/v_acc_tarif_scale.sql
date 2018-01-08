

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACC_TARIF_SCALE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACC_TARIF_SCALE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACC_TARIF_SCALE ("ACC", "IDS", "KOD", "SUM_LIMIT", "SUM_TARIF", "PR", "SMIN", "KV_SMIN", "SMAX", "KV_SMAX") AS 
  select c.acc, c.ids, t.kod, t.sum_limit, t.sum_tarif, t.pr,
       nvl(t.smin, f.smin), f.kv_smin, nvl(t.smax, f.smax), f.kv_smax
  from -- список счетов и их схем тарифов
       ( select a.acc, nvl(m.id,0) ids
           from accounts a,
                -- список действующих схем тарифов счетов
                ( select w.acc, m.id
                    from accountsw w, tarif_scheme m
                   where w.tag = 'SHTAR' and trim(w.value) = to_char(m.id) ) m
           where a.acc = m.acc(+) ) c, 
       -- список тарифов для каждой схемы
       ( -- отбираем тарифы, указанные для схем
         select m.id, t.kod, s.sum_limit, s.sum_tarif, s.pr, s.smin, s.smax
           from tarif_scheme m, sh_tarif_scale s, v_tarif t
          where m.id = s.ids
            and s.kod = t.kod
          union all
         -- отбираем тарифы по умолчанию
         select m.id, t.kod, t.sum_limit, t.sum_tarif, t.pr, t.smin, t.smax
           from tarif_scheme m, tarif_scale t
          where not exists (select 1 from sh_tarif_scale where ids = m.id and kod = t.kod)
          union all
         -- добавляем тарифы для схемы 0 (если для счета не указана схема тарифа)
         select 0, t.kod, t.sum_limit, t.sum_tarif, t.pr, t.smin, t.smax
           from tarif_scale t ) t, tarif f
 where c.ids = t.id
   and t.kod = f.kod;

PROMPT *** Create  grants  V_ACC_TARIF_SCALE ***
grant SELECT                                                                 on V_ACC_TARIF_SCALE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACC_TARIF_SCALE to CUST001;
grant SELECT                                                                 on V_ACC_TARIF_SCALE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACC_TARIF_SCALE.sql =========*** End 
PROMPT ===================================================================================== 
