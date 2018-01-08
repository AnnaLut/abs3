

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCTS ("SUBPRODUCT_ID", "SUBPRODUCT_NAME", "PRODUCT_ID", "SUBPRODUCT_DESC") AS 
  select sbp.id as subproduct_id, sbp.name as subproduct_name, sbp.product_id, sbp.id || ' - ' || sbp.name as subproduct_desc
  from wcs_subproducts sbp
 where sbp.product_id in (select product_id from v_wcs_products);

PROMPT *** Create  grants  V_WCS_SUBPRODUCTS ***
grant SELECT                                                                 on V_WCS_SUBPRODUCTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCTS.sql =========*** End 
PROMPT ===================================================================================== 
