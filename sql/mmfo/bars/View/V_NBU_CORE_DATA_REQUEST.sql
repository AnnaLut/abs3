

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_CORE_DATA_REQUEST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_CORE_DATA_REQUEST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBU_CORE_DATA_REQUEST ("ID", "KF", "BRANCH_NAME", "DATA_TYPE_NAME", "REQUEST_STATE", "TRACKING_MESSAGE", "REPORTING_TIME", "REPORTING_PERSON") AS 
  select id, kf, branch_name, data_type_name,
    request_state,tracking_message,reporting_time,reporting_person
from   nbu_gateway.v_nbu_core_data_request
;

PROMPT *** Create  grants  V_NBU_CORE_DATA_REQUEST ***
grant SELECT                                                                 on V_NBU_CORE_DATA_REQUEST to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_CORE_DATA_REQUEST.sql =========**
PROMPT ===================================================================================== 
