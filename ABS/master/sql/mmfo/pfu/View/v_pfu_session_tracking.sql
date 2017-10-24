

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_SESSION_TRACKING.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_SESSION_TRACKING ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_SESSION_TRACKING ("ID", "SESSION_ID", "REQUEST_ID", "STATE_ID", "STATE_CODE", "SYS_TIME", "TRACKING_COMMENT") AS 
  SELECT t.id,
          t.session_id,
          ses.request_id,
          t.state,
          s.state_code,
          t.sys_time,
          t.tracking_comment
     FROM pfu_session_tracking t
          JOIN pfu_session ses ON ses.id = t.session_id
          JOIN pfu_session_state s ON s.id = t.state
    union all
       SELECT t.id,  -- дочірні сесії
          t.session_id,
          (select parent_request_id from pfu_request where id = ses.request_id) request_id,
          t.state,
          s.state_code,
          t.sys_time,
          t.tracking_comment
     FROM pfu_session_tracking t
          JOIN pfu_session ses ON ses.id = t.session_id
          JOIN pfu_session_state s ON s.id = t.state
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_SESSION_TRACKING.sql =========*** 
PROMPT ===================================================================================== 
