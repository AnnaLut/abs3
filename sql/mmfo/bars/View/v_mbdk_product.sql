

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_PRODUCT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_PRODUCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_PRODUCT ("VIDD", "NAME", "TIPD", "TIPP") AS 
  select vidd,
       name,
       tipd,
       (case when t.vidd in (2700,2701,3660,3661) then 1 else 2 end) tipp
from  cc_vidd t
where mbk.check_if_deal_belong_to_mbdk(t.vidd) = 'Y';

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
