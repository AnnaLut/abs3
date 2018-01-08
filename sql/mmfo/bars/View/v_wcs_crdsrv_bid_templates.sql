

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_CRDSRV_BID_TEMPLATES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_CRDSRV_BID_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_CRDSRV_BID_TEMPLATES ("BID_ID", "TEMPLATE_ID", "TEMPLATE_NAME", "PRINT_STATE_ID", "PRINT_STATE_NAME", "SCAN_QID", "WS_ID", "WS_NUM", "DOCEXP_TYPE_ID", "IMG", "IS_SCAN_REQUIRED", "ENABLED", "VISIBLE") AS 
  select bt."BID_ID",bt."TEMPLATE_ID",bt."TEMPLATE_NAME",bt."PRINT_STATE_ID",bt."PRINT_STATE_NAME",bt."SCAN_QID",bt."WS_ID",bt."WS_NUM",bt."DOCEXP_TYPE_ID",bt."IMG",bt."IS_SCAN_REQUIRED", 1 as enabled, 1 as visible
  from v_wcs_bid_templates bt
 where bt.print_state_id = 'CREDIT_SERVICE'
 order by bt.bid_id, bt.template_id;

PROMPT *** Create  grants  V_WCS_CRDSRV_BID_TEMPLATES ***
grant SELECT                                                                 on V_WCS_CRDSRV_BID_TEMPLATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_CRDSRV_BID_TEMPLATES.sql ========
PROMPT ===================================================================================== 
