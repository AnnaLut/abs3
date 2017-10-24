

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_COIN_INVOICE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_COIN_INVOICE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_COIN_INVOICE ("TYPE_ID", "ND", "DAT", "REASON", "BAILEE", "PROXY", "TOTAL_COUNT", "TOTAL_NOMINAL", "TOTAL_SUM", "TOTAL_WITHOUT_VAT", "VAT_PERCENT", "VAT_SUM", "TOTAL_NOMINAL_PRICE", "TOTAL_WITH_VAT", "REF", "SUM_PR") AS 
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

PROMPT *** Create  grants  V_COIN_INVOICE ***
grant SELECT                                                                 on V_COIN_INVOICE  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_COIN_INVOICE.sql =========*** End ***
PROMPT ===================================================================================== 
