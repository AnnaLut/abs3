

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PROECT_GROUPS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PROECT_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PROECT_GROUPS ("CODE", "NAME") AS 
  select code,
  name
from w4_product_groups
where code in ('PENSION','SOCIAL','SALARY')
order by code;

PROMPT *** Create  grants  V_W4_PROECT_GROUPS ***
grant SELECT                                                                 on V_W4_PROECT_GROUPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_PROECT_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_PROECT_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PROECT_GROUPS.sql =========*** End
PROMPT ===================================================================================== 
