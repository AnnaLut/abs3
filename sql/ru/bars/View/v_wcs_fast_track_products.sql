

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_FAST_TRACK_PRODUCTS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_FAST_TRACK_PRODUCTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_FAST_TRACK_PRODUCTS ("PRODUCT_ID", "PRODUCT_NAME") AS 
  SELECT p.id AS product_id, p.name AS product_name
     FROM wcs_products p
    WHERE p.id IN ('PRD_AUTO','PRD_HULL_INSURANCE','PRD_CONSUMER','PRD_MORTGAGE');

PROMPT *** Create  grants  V_WCS_FAST_TRACK_PRODUCTS ***
grant SELECT                                                                 on V_WCS_FAST_TRACK_PRODUCTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_FAST_TRACK_PRODUCTS.sql =========
PROMPT ===================================================================================== 
