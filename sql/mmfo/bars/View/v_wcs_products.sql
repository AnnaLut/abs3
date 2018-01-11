

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_PRODUCTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_PRODUCTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_PRODUCTS ("PRODUCT_ID", "PRODUCT_NAME") AS 
  select p.id as product_id, p.name as product_name from wcs_products p;

PROMPT *** Create  grants  V_WCS_PRODUCTS ***
grant SELECT                                                                 on V_WCS_PRODUCTS  to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_PRODUCTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_PRODUCTS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_PRODUCTS.sql =========*** End ***
PROMPT ===================================================================================== 
