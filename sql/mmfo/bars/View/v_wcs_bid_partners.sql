

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_PARTNERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_PARTNERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_PARTNERS ("BID_ID", "PARTNER_ID", "PARTNER_NAME", "TYPE_ID", "PTN_MFO", "PTN_NLS", "PTN_OKPO", "PTN_NAME") AS 
  SELECT b.id AS bid_id,
            p.id AS partner_id,
            p.name AS partner_name,
            p.type_id,
            p.ptn_mfo,
            p.ptn_nls,
            p.ptn_okpo,
            p.ptn_name
       FROM wcs_bids b, wcs_subproduct_ptrtypes sp, wcs_partners p
      WHERE     b.subproduct_id = sp.subproduct_id
            AND sp.ptr_type_id = p.type_id
            AND P.FLAG_A = 1
   ORDER BY b.id, sp.ptr_type_id, p.id;

PROMPT *** Create  grants  V_WCS_BID_PARTNERS ***
grant SELECT                                                                 on V_WCS_BID_PARTNERS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_PARTNERS.sql =========*** End
PROMPT ===================================================================================== 
