

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_PRODUCT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_PRODUCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_PRODUCT AS 
 SELECT M.vidd, m.vidd||'.'||M.name name , t.tipd,
(CASE
WHEN t.vidd IN (2700,2701,3660) THEN 1 ELSE 2 END) tipp,m.k9
FROM cc_vidd t, mbdk_OB22 M
WHERE M.VIDD = T.VIDD;

PROMPT *** Create  grants  V_MBDK_PRODUCT ***
grant SELECT                                                                 on V_MBDK_PRODUCT  to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBDK_PRODUCT  to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_MBDK_PRODUCT  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_MBDK_PRODUCT  to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_MBDK_PRODUCT  to START1;
grant SELECT                                                                 on V_MBDK_PRODUCT  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_PRODUCT.sql =========*** End ***
PROMPT ===================================================================================== 
