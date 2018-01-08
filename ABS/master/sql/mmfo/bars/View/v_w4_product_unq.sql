create or replace force view bars.v_w4_product_unq as
select unique proect_id,
       product_code,
       product_name,
       grp_code,
       acc_rate,
       mobi_rate,
       cred_rate,
       ovr_rate,
       lim_rate,
       grc_rate
  from v_w4_product;
grant select on BARS.V_W4_PRODUCT_UNQ to BARS_ACCESS_DEFROLE;


