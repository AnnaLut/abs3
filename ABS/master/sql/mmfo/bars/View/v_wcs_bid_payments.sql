

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_PAYMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_PAYMENTS ("BID_ID", "PAYMENT_ID", "PAYMENT_NAME") AS 
  select b.id as bid_id, sp.payment_id, sp.payment_name
  from wcs_bids b, v_wcs_subproduct_payments sp
 where b.subproduct_id = sp.subproduct_id
 order by b.id, sp.payment_id;

PROMPT *** Create  grants  V_WCS_BID_PAYMENTS ***
grant SELECT                                                                 on V_WCS_BID_PAYMENTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_PAYMENTS.sql =========*** End
PROMPT ===================================================================================== 
