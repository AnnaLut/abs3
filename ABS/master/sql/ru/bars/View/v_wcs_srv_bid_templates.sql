

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SRV_BID_TEMPLATES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SRV_BID_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SRV_BID_TEMPLATES ("SRV", "BID_ID", "TEMPLATE_ID", "TEMPLATE_NAME", "PRINT_STATE_ID", "PRINT_STATE_NAME", "SCAN_QID", "WS_ID", "WS_NUM", "DOCEXP_TYPE_ID", "IMG", "IS_SCAN_REQUIRED", "ENABLED", "VISIBLE", "IQUERY_ID") AS 
  select decode(s.id,
              'SECURITY_SERVICE',
              'ss',
              'LAW_SERVICE',
              'ls',
              'ASSETS_SERVICE',
              'as',
              'RISK_DEPARTMENT',
              'rs',
              'FINANCE_DEPARTMENT',
              'fs') as srv,
       bt."BID_ID",bt."TEMPLATE_ID",bt."TEMPLATE_NAME",bt."PRINT_STATE_ID",bt."PRINT_STATE_NAME",bt."SCAN_QID",bt."WS_ID",bt."WS_NUM",bt."DOCEXP_TYPE_ID",bt."IMG",bt."IS_SCAN_REQUIRED",
       1 as enabled,
       1 as visible,
       (select distinct iquery_id from v_wcs_bid_infoquery_questions where bid_id = bt.BID_ID and question_id = bt.TEMPLATE_ID||'__TPLSCAN') as iquery_id
  from v_wcs_bid_templates bt, wcs_services s
 where bt.print_state_id = s.id
   and s.id in ('SECURITY_SERVICE',
                'LAW_SERVICE',
                'ASSETS_SERVICE',
                'RISK_DEPARTMENT',
                'FINANCE_DEPARTMENT')
 order by bt.bid_id, bt.template_id;

PROMPT *** Create  grants  V_WCS_SRV_BID_TEMPLATES ***
grant SELECT                                                                 on V_WCS_SRV_BID_TEMPLATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SRV_BID_TEMPLATES.sql =========**
PROMPT ===================================================================================== 
