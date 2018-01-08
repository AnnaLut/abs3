create or replace view v_w4_product (
  proect_id, proect_name, proect_okpo,
  grp_code, grp_name, client_type, sh_id, sh_name,
  product_code, product_name, kv, nbs, ob22,
  acc_rate, mobi_rate, cred_rate, ovr_rate, 
  lim_rate, grc_rate, mm_max,
  sub_code, sub_name, flag_kk, card_code )
as
-- проекты с продуктами
select b.id proect_id, b.name proect_name, b.okpo proect_okpo, 
       g.code grp_code, g.name grp_name, g.client_type client_type, m.id sh_id, m.name sh_name,
       p.code product_code, p.name product_name, p.kv kv, p.nbs nbs, p.ob22 ob22,
       d.percent_osn acc_rate, d.percent_mob mobi_rate, d.percent_cred cred_rate, d.percent_over ovr_rate,
       d.percent_notusedlimit lim_rate, d.percent_grace grc_rate, c.maxterm,
       s.code sub_code, s.name sub_name, s.flag_kk, c.code card_code
  from w4_product_groups g, w4_product p, w4_subproduct s, w4_card c,
       bpk_scheme m, cm_product d, bpk_proect b, bpk_proect_card bb
 where g.code = 'SALARY'
   and g.code = p.grp_code
   and p.code = b.product_code and nvl(b.used_w4,0) = 1
   and b.okpo = bb.okpo and nvl(b.okpo_n,0) = nvl(bb.okpo_n,0)
   and bb.card_code = c.code
   and c.sub_code = s.code
   and g.scheme_id = m.id
   and p.code = d.product_code(+)
   and nvl(g.date_open,bankdate) <= bankdate
   and nvl(p.date_open,bankdate) <= bankdate
   and nvl(c.date_open,bankdate) <= bankdate
   and nvl(g.date_close,bankdate+1) > bankdate
   and nvl(p.date_close,bankdate+1) > bankdate
   and nvl(c.date_close,bankdate+1) > bankdate
 union all
-- без проекта
select -1 proect_id, '*Власна картка' proect_name, null proect_okpo, 
       g.code grp_code, g.name grp_name, g.client_type client_type, m.id sh_id, m.name sh_name,
       p.code product_code, p.name product_name, p.kv kv, p.nbs nbs, p.ob22 ob22,
       d.percent_osn acc_rate, d.percent_mob mobi_rate, d.percent_cred cred_rate, d.percent_over ovr_rate,
       d.percent_notusedlimit lim_rate, d.percent_grace grc_rate, d.mm_max,
       s.code sub_code, s.name sub_name, s.flag_kk, c.code card_code
  from w4_product_groups g, w4_product p, w4_subproduct s, w4_card c,
       bpk_scheme m, cm_product d
 where g.code <> 'SALARY'
   and g.code = p.grp_code
   and p.code = c.product_code
   and c.sub_code = s.code
   and g.scheme_id = m.id
   and p.code = d.product_code(+)
   and nvl(g.date_open,bankdate) <= bankdate
   and nvl(p.date_open,bankdate) <= bankdate
   and nvl(c.date_open,bankdate) <= bankdate
   and nvl(g.date_close,bankdate+1) > bankdate
   and nvl(p.date_close,bankdate+1) > bankdate
   and nvl(c.date_close,bankdate+1) > bankdate ;
/
comment on table v_w4_product is 'БПК. Продукти';
grant select on BARS.V_W4_PRODUCT to BARSREADER_ROLE;
grant select on v_w4_product to bars_access_defrole;
/