create or replace view v_coin_invoice as 
select  v.type_id, 
  v.nd, 
  v.dat, 
  v.reason, 
  v.bailee, 
  v.proxy, 
  v.total_count, 
  v.total_nominal/100 total_nominal, 
  v.total_sum/100 total_sum,
  v. total_without_vat/100 total_without_vat,  
  v.vat_percent, 
  v.vat_sum/100 vat_sum, 
  v.total_nominal_price/100 total_nominal_price, 
  v.total_with_vat/100 total_with_vat,
  v.ref ,
  f_sumpr(v.total_with_vat,'980','F',100) sum_pr
 from tmp_coin_invoice v where v.userid = bars.user_id;
/ 
grant select on v_coin_invoice to bars_access_defrole;
/