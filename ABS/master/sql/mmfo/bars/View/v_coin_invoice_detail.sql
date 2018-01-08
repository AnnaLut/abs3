

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_COIN_INVOICE_DETAIL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_COIN_INVOICE_DETAIL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_COIN_INVOICE_DETAIL ("RN", "ND", "CODE", "NAME", "METAL", "NOMINAL", "CNT", "NOMINAL_PRICE", "UNIT_PRICE_VAT", "UNIT_PRICE", "NOMINAL_SUM") AS 
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

PROMPT *** Create  grants  V_COIN_INVOICE_DETAIL ***
grant SELECT                                                                 on V_COIN_INVOICE_DETAIL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_COIN_INVOICE_DETAIL.sql =========*** 
PROMPT ===================================================================================== 
