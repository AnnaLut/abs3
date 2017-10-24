

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_PTRTYPES.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_PTRTYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_PTRTYPES ("SUBPRODUCT_ID", "PTR_TYPE_ID", "PTR_TYPE_NAME") AS 
  select sp.subproduct_id, sp.ptr_type_id, pt.name as ptr_type_name
  from wcs_subproduct_ptrtypes sp, wcs_partner_types pt
 where sp.ptr_type_id = pt.id
 order by sp.subproduct_id, sp.ptr_type_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_PTRTYPES ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_PTRTYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_PTRTYPES.sql =========
PROMPT ===================================================================================== 
