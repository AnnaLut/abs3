create or replace force view bars.v_w4_product_groups as
select code, name
  from w4_product_groups
 where code not in ('INSTANT', 'CORPORATE', 'INSTANT_MMSB') -- oa?ai 'LOCAL' ii  COBUSUPABS-4290 ---aiaaaeaiu 'CORPORATE','INSTANT_MMSB'  - ii COBUSUPABS-4580
 order by code
;
grant select on BARS.V_W4_PRODUCT_GROUPS to BARS_ACCESS_DEFROLE;


