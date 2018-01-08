

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_CRDSRV_BID_INFOQUERIES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_CRDSRV_BID_INFOQUERIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_CRDSRV_BID_INFOQUERIES ("BID_ID", "TYPE_ID", "TYPE_NAME", "SERVICE_ID", "SERVICE_NAME", "SRV_HIERARCHY", "SRV_HIERARCHY_NAME", "WS_ID", "ACT_LEVEL", "IQUERY_ID", "IQUERY_NAME", "IQUERY_TEXT", "IS_REQUIRED", "STATUS", "STATUS_MSG", "PROCESSED", "ORD") AS 
  select "BID_ID","TYPE_ID","TYPE_NAME","SERVICE_ID","SERVICE_NAME","SRV_HIERARCHY","SRV_HIERARCHY_NAME","WS_ID","ACT_LEVEL","IQUERY_ID","IQUERY_NAME","IQUERY_TEXT","IS_REQUIRED","STATUS","STATUS_MSG","PROCESSED","ORD"
  from v_wcs_bid_infoqueries bi
 where bi.type_id = 'MANUAL'
   and bi.service_id = 'CREDIT_SERVICE';

PROMPT *** Create  grants  V_WCS_CRDSRV_BID_INFOQUERIES ***
grant SELECT                                                                 on V_WCS_CRDSRV_BID_INFOQUERIES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_CRDSRV_BID_INFOQUERIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_CRDSRV_BID_INFOQUERIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_CRDSRV_BID_INFOQUERIES.sql ======
PROMPT ===================================================================================== 
