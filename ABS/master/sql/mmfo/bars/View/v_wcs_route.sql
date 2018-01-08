

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_ROUTE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_ROUTE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_ROUTE ("PARENT_ID", "CHILD_ID") AS 
  select s1.id, s2.id
  from wcs_states s1, wcs_states s2
 where s1.id = s2.parent;

PROMPT *** Create  grants  V_WCS_ROUTE ***
grant SELECT                                                                 on V_WCS_ROUTE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_ROUTE     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_ROUTE.sql =========*** End *** ==
PROMPT ===================================================================================== 
