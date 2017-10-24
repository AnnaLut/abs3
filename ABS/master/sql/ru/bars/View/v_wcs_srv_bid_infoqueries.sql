

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SRV_BID_INFOQUERIES.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SRV_BID_INFOQUERIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SRV_BID_INFOQUERIES ("SRV", "BID_ID", "TYPE_ID", "TYPE_NAME", "SERVICE_ID", "SERVICE_NAME", "SRV_HIERARCHY", "SRV_HIERARCHY_NAME", "WS_ID", "ACT_LEVEL", "IQUERY_ID", "IQUERY_NAME", "IQUERY_TEXT", "IS_REQUIRED", "STATUS", "STATUS_MSG", "PROCESSED", "ORD") AS 
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
       bi."BID_ID",bi."TYPE_ID",bi."TYPE_NAME",bi."SERVICE_ID",bi."SERVICE_NAME",bi."SRV_HIERARCHY",bi."SRV_HIERARCHY_NAME",bi."WS_ID",bi."ACT_LEVEL",bi."IQUERY_ID",bi."IQUERY_NAME",bi."IQUERY_TEXT",bi."IS_REQUIRED",bi."STATUS",bi."STATUS_MSG",bi."PROCESSED",bi."ORD"
  from v_wcs_bid_infoqueries bi, wcs_services s
 where bi.type_id = 'MANUAL'
   and bi.service_id = s.id
   and s.id in ('SECURITY_SERVICE',
                'LAW_SERVICE',
                'ASSETS_SERVICE',
                'RISK_DEPARTMENT',
                'FINANCE_DEPARTMENT');

PROMPT *** Create  grants  V_WCS_SRV_BID_INFOQUERIES ***
grant SELECT                                                                 on V_WCS_SRV_BID_INFOQUERIES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SRV_BID_INFOQUERIES.sql =========
PROMPT ===================================================================================== 
