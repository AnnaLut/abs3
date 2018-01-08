

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_PAYMENTS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_PAYMENTS ("SUBPRODUCT_ID", "PAYMENT_ID", "PAYMENT_NAME") AS 
  select sp.subproduct_id, sp.payment_id, pt.name as payment_name
  from wcs_subproduct_payments sp, wcs_payment_types pt
 where sp.payment_id = pt.id
 order by sp.subproduct_id, sp.payment_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_PAYMENTS ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_PAYMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_PAYMENTS.sql =========
PROMPT ===================================================================================== 
