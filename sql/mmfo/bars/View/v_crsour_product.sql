

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRSOUR_PRODUCT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRSOUR_PRODUCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRSOUR_PRODUCT ("VIDD", "NAME") AS 
  select t.vidd, t.name
from   cc_vidd t
where  t.vidd in (3902, 3903);

PROMPT *** Create  grants  V_CRSOUR_PRODUCT ***
grant SELECT                                                                 on V_CRSOUR_PRODUCT to BARSREADER_ROLE;
grant SELECT                                                                 on V_CRSOUR_PRODUCT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CRSOUR_PRODUCT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRSOUR_PRODUCT.sql =========*** End *
PROMPT ===================================================================================== 
