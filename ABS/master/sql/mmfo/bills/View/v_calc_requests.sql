
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_calc_requests.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_CALC_REQUESTS ("REQUEST_ID", "REQUEST_NAME", "DATE_FROM", "DATE_TO", "REQUEST_DATE", "REQUEST_BODY", "SCAN_NAME", "SCAN_BODY", "SCAN_DATE", "STATUS") AS 
  select
request_id,
request_name,
date_from,
date_to,
request_date,
request_body,
scan_name,
scan_body,
scan_date,
status
from bills.calc_request
;
 show err;
 
PROMPT *** Create  grants  V_CALC_REQUESTS ***
grant SELECT                                                                 on V_CALC_REQUESTS to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_calc_requests.sql =========*** End *
 PROMPT ===================================================================================== 
 