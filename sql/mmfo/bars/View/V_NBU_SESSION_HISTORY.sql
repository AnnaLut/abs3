

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_SESSION_HISTORY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_SESSION_HISTORY ***

 CREATE OR REPLACE FORCE VIEW BARS.V_NBU_SESSION_HISTORY ("ID", "OBJECT_ID", "OBJECT_TYPE_ID", "OBJECT_TYPE_NAME", "OBJECT_CODE", "OBJECT_NAME", "SESSION_CREATION_TIME", "SESSION_ACTIVITY_TIME", "SESSION_TYPE_ID", "SESSION_TYPE_NAME", "STATE_ID", "SESSION_STATE", "SESSION_DETAILS") AS 
 select "ID","OBJECT_ID","OBJECT_TYPE_ID","OBJECT_TYPE_NAME","OBJECT_CODE","OBJECT_NAME","SESSION_CREATION_TIME","SESSION_ACTIVITY_TIME","SESSION_TYPE_ID","SESSION_TYPE_NAME","STATE_ID","SESSION_STATE","SESSION_DETAILS" from nbu_gateway.v_nbu_session_history;

PROMPT *** Create  grants  V_NBU_SESSION_HISTORY ***
grant FLASHBACK,SELECT                                                       on V_NBU_SESSION_HISTORY to WR_REFREAD;

grant SELECT                                  on V_NBU_SESSION_HISTORY   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_SESSION_HISTORY.sql =========*** 
PROMPT ===================================================================================== 
