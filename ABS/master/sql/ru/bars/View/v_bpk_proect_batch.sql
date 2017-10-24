create or replace force view v_bpk_proect_batch
(id, name, okpo, product_code, product_name, grp_code)
as
select b.id, b.name, b.okpo, p.code, p.name, p.grp_code
  from bpk_proect b, v_w4_product_batch p
 where b.product_code = p.code
   and p.grp_code = 'SALARY';
grant select on V_BPK_PROECT_BATCH to BARS_ACCESS_DEFROLE;


