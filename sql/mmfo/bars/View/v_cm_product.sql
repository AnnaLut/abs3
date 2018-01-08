

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CM_PRODUCT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CM_PRODUCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CM_PRODUCT ("PRODUCT_CODE", "PRODUCT_NAME", "PERCENT_OSN", "PERCENT_MOB", "PERCENT_CRED", "PERCENT_OVER", "PERCENT_NOTUSEDLIMIT", "PERCENT_GRACE", "MM_MAX") AS 
  select p.code, p.name,
       c.percent_osn, c.percent_mob,
       c.percent_cred, c.percent_over,
       c.percent_notusedlimit, c.percent_grace,
       c.mm_max
  from w4_product p, cm_product c
 where p.code = c.product_code(+);

PROMPT *** Create  grants  V_CM_PRODUCT ***
grant SELECT                                                                 on V_CM_PRODUCT    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CM_PRODUCT    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CM_PRODUCT    to OW;
grant SELECT                                                                 on V_CM_PRODUCT    to UPLD;
grant FLASHBACK,SELECT                                                       on V_CM_PRODUCT    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CM_PRODUCT.sql =========*** End *** =
PROMPT ===================================================================================== 
