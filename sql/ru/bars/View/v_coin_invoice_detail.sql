create or replace view v_coin_invoice_detail as 
select v.rn, 
  v.nd, 
  v.code, 
  v.name, 
  v.metal, 
  v.nominal/100 nominal, 
  v.cnt, 
  v.nominal_price/100 nominal_price, 
  v.unit_price_vat/100 unit_price_vat, 
  v.unit_price/100 unit_price, 
  v.nominal_sum/100 nominal_sum
from tmp_coin_invoice_detail v where v.userid = bars.user_id
order by v.rn;
/
grant select on v_coin_invoice_detail to bars_access_defrole;
/