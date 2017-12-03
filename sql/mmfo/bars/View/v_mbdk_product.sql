

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_PRODUCT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_PRODUCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_PRODUCT ("VIDD", "NAME", "TIPD") AS 
  select vidd,
       name,
       tipd
from  cc_vidd t
where mbk.check_if_deal_belong_to_mbdk(t.vidd) = 'Y';

PROMPT *** Create  grants  V_MBDK_PRODUCT ***
grant SELECT                                                                 on V_MBDK_PRODUCT  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_PRODUCT.sql =========*** End ***
PROMPT ===================================================================================== 
