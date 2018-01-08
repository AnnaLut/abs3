

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_MGR_BID_TEMPLATES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_MGR_BID_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_MGR_BID_TEMPLATES ("BID_ID", "TEMPLATE_ID", "TEMPLATE_NAME", "PRINT_STATE_ID", "PRINT_STATE_NAME", "SCAN_QID", "WS_ID", "WS_NUM", "DOCEXP_TYPE_ID", "IMG", "IS_SCAN_REQUIRED", "ENABLED", "VISIBLE") AS 
  SELECT bt."BID_ID",
            bt."TEMPLATE_ID",
            bt."TEMPLATE_NAME",
            bt."PRINT_STATE_ID",
            bt."PRINT_STATE_NAME",
            bt."SCAN_QID",
            bt."WS_ID",
            bt."WS_NUM",
            bt."DOCEXP_TYPE_ID",
            bt."IMG",
            bt."IS_SCAN_REQUIRED",
            CASE
               WHEN (bt.print_state_id = 'DATA_INPUT'
                     AND (wcs_utl.has_bid_state (bt.bid_id, 'NEW_DATAINPUT') =
                             1
                          OR wcs_utl.
                              has_bid_state (bt.bid_id, 'NEW_DATAREINPUT') = 1))
               THEN
                  1
               WHEN (bt.print_state_id = 'DOC_SIGN'
                     AND wcs_utl.has_bid_state (bt.bid_id, 'NEW_SIGNDOCS') = 1)
               THEN
                  1
               ELSE
                  0
            END
               AS enabled,
            CASE
               WHEN (bt.print_state_id = 'DOC_SIGN'
                     AND wcs_utl.has_bid_state (bt.bid_id, 'NEW_SIGNDOCS') = 0)
               THEN
                  0
               WHEN (bt.TEMPLATE_ID = 'DOC_6.7_DESCRIP_CHARACTER_ACTIVITY'
                     AND wcs_utl.get_answ (bt.bid_id, 'CL_0_148') = 0)
               THEN
                  0
               ELSE
                  1
            END
               AS visible
       FROM v_wcs_bid_templates bt
      WHERE bt.print_state_id IN ('DATA_INPUT', 'DOC_SIGN')
   ORDER BY bt.bid_id, bt.template_id;

PROMPT *** Create  grants  V_WCS_MGR_BID_TEMPLATES ***
grant SELECT                                                                 on V_WCS_MGR_BID_TEMPLATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_MGR_BID_TEMPLATES.sql =========**
PROMPT ===================================================================================== 
