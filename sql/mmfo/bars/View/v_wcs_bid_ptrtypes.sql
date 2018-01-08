

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_PTRTYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_PTRTYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_PTRTYPES ("BID_ID", "PTR_TYPE_ID", "PTR_TYPE_NAME") AS 
  select b.id as bid_id, sp.ptr_type_id, sp.ptr_type_name
  from wcs_bids b, v_wcs_subproduct_ptrtypes sp
 where b.subproduct_id = sp.subproduct_id
 order by b.id, sp.ptr_type_id;

PROMPT *** Create  grants  V_WCS_BID_PTRTYPES ***
grant SELECT                                                                 on V_WCS_BID_PTRTYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_PTRTYPES.sql =========*** End
PROMPT ===================================================================================== 
