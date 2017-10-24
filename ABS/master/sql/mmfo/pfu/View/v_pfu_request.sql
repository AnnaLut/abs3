

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_REQUEST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_REQUEST ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_REQUEST ("ID", "DATE_FROM", "DATE_TO", "TYPE", "TYPE_NAME", "STATE_ID", "STATE_NAME", "PFU_REQUEST_ID", "REQUEST_TIME") AS 
  SELECT r.id,
          CASE
             WHEN UPPER (r.request_type) = 'GET_CONVERT_LISTS'
             THEN
                e.date_from
             WHEN r.request_type = 'GET_EPP_BATCH_LISTS'
             THEN
                f.date_from
          END
             date_from,
          CASE
             WHEN UPPER (r.request_type) = 'GET_CONVERT_LISTS' THEN e.date_to
             WHEN r.request_type = 'GET_EPP_BATCH_LISTS' THEN f.date_to
          END
             date_to,
          r.request_type,
          rt.request_type_name,
          r.state,
          s.state_name,
          r.pfu_request_id,
          r.sys_time request_time
     FROM pfu_request r
          LEFT JOIN pfu_envelope_list_request e ON e.id = r.id
          LEFT JOIN pfu_epp_batch_list_request f ON f.id = r.id
          LEFT JOIN pfu_request_state s ON s.state_code = r.state
          LEFT JOIN pfu_request_type rt ON rt.request_type_code = r.request_type
--where r.request_type in ('GET_CONVERT_LISTS', 'GET_EPP_BATCH_LISTS')
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_REQUEST.sql =========*** End *** =
PROMPT ===================================================================================== 
