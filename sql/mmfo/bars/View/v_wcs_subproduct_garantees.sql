

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_GARANTEES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_GARANTEES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_GARANTEES ("SUBPRODUCT_ID", "GARANTEE_ID", "GARANTEE_NAME", "IS_REQUIRED", "ORD") AS 
  select sg.subproduct_id,
       sg.garantee_id,
       g.name as garantee_name,
       sg.is_required,
       sg.ord
  from wcs_subproduct_garantees sg, wcs_garantees g
 where sg.garantee_id = g.id
 order by sg.subproduct_id, sg.ord;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_GARANTEES ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_GARANTEES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_GARANTEES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_GARANTEES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_GARANTEES.sql ========
PROMPT ===================================================================================== 
