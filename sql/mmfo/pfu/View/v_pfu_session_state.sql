

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_SESSION_STATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_SESSION_STATE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_SESSION_STATE ("ID", "STATE_CODE", "STATE_NAME") AS 
  SELECT t.id, t.state_code, t.state_name
     FROM pfu_session_state t;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_SESSION_STATE.sql =========*** End
PROMPT ===================================================================================== 
