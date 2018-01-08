

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SBP_DETAILS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SBP_DETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SBP_DETAILS ("PRODUCT_ID", "SUBPRODUCT_ID", "SUBPRODUCT_NAME", "SUM_MIN", "SUM_MAX", "SUM_INITIAL_MIN", "SUM_INITIAL_MAX", "TERM_MIN", "TERM_MAX", "CURRENCY", "INTEREST_RATE_MIN", "INTEREST_RATE_MAX", "GARANTEES", "DESCRIPTION", "DOCS", "ICO", "PRT_TPL") AS 
  SELECT sbp.product_id,
          sbp.id AS subproduct_id,
          sbp.name AS subproduct_name,
          TO_NUMBER (wcs_utl.
                      get_sbp_mac (
                        sbp.id,
                        'MAC_SUM_MIN',
                        SYS_CONTEXT ('bars_context', 'user_branch'),
                        glb_bankdate))
             AS sum_min,
          TO_NUMBER (wcs_utl.
                      get_sbp_mac (
                        sbp.id,
                        'MAC_SUM_MAX',
                        SYS_CONTEXT ('bars_context', 'user_branch'),
                        glb_bankdate))
             AS sum_max,
          TO_NUMBER (wcs_utl.
                      get_sbp_mac (
                        sbp.id,
                        'MAC_SUM_INITIAL_MIN',
                        SYS_CONTEXT ('bars_context', 'user_branch'),
                        glb_bankdate))
             AS sum_initial_min,
          TO_NUMBER (wcs_utl.
                      get_sbp_mac (
                        sbp.id,
                        'MAC_SUM_INITIAL_MAX',
                        SYS_CONTEXT ('bars_context', 'user_branch'),
                        glb_bankdate))
             AS sum_initial_max,
          TO_NUMBER (wcs_utl.
                      get_sbp_mac (
                        sbp.id,
                        'MAC_TERM_MIN',
                        SYS_CONTEXT ('bars_context', 'user_branch'),
                        glb_bankdate))
             AS term_min,
          TO_NUMBER (wcs_utl.
                      get_sbp_mac (
                        sbp.id,
                        'MAC_TERM_MAX',
                        SYS_CONTEXT ('bars_context', 'user_branch'),
                        glb_bankdate))
             AS term_max,
          wcs_utl.get_sbp_mac (sbp.id,
                               'MAC_CURRENCY',
                               SYS_CONTEXT ('bars_context', 'user_branch'),
                               glb_bankdate)
             AS currency,
          TO_NUMBER (wcs_utl.
                      get_sbp_mac (
                        sbp.id,
                        'MAC_INTEREST_RATE_MIN',
                        SYS_CONTEXT ('bars_context', 'user_branch'),
                        glb_bankdate))
             AS interest_rate_min,
          TO_NUMBER (wcs_utl.
                      get_sbp_mac (
                        sbp.id,
                        'MAC_INTEREST_RATE_MAX',
                        SYS_CONTEXT ('bars_context', 'user_branch'),
                        glb_bankdate))
             AS interest_rate_max,
          wcs_utl.get_sbp_garantees (sbp.id) AS garantees,
          wcs_utl.get_sbp_mac (sbp.id,
                               'MAC_SBP_DESCRIPTION',
                               SYS_CONTEXT ('bars_context', 'user_branch'),
                               glb_bankdate)
             AS description,
          wcs_utl.get_sbp_docs (sbp.id) AS docs,
          wcs_utl.
           get_sbp_mac_blob (sbp.id,
                             'MAC_ICO',
                             SYS_CONTEXT ('bars_context', 'user_branch'),
                             glb_bankdate)
             AS ico,
          wcs_utl.get_sbp_mac (sbp.id,
                               'MAC_PRINT_DETAILS_TEMPLATE',
                               SYS_CONTEXT ('bars_context', 'user_branch'),
                               glb_bankdate)
             AS prt_tpl
     FROM wcs_subproducts sbp;

PROMPT *** Create  grants  V_WCS_SBP_DETAILS ***
grant SELECT                                                                 on V_WCS_SBP_DETAILS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SBP_DETAILS.sql =========*** End 
PROMPT ===================================================================================== 
