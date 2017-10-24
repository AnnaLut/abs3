create or replace force view v_w4_product_mkk as
select t.product_code, t.product_name, t.sub_code, t.sub_name, t.card_code
  from v_w4_product t
 where t.grp_code = 'INSTANT_MMSB' and t.kv = 980 and t.nbs = '2605';
grant select on V_W4_PRODUCT_MKK to BARS_ACCESS_DEFROLE;