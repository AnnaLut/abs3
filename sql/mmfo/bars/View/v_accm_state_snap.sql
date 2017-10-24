

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCM_STATE_SNAP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCM_STATE_SNAP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCM_STATE_SNAP ("CALDT_DATE", "CALDT_ID", "SNAP_BALANCE", "LOCKED", "SNAP_SCN", "SID", "SERIAL#", "SNAP_DATE", "CALL_SCN", "CALL_DATE", "CALL_FLAG") AS 
  select c.caldt_date, s."CALDT_ID",s."SNAP_BALANCE",s."LOCKED",s."SNAP_SCN",s."SID",s."SERIAL#",s."SNAP_DATE",s."CALL_SCN",s."CALL_DATE",s."CALL_FLAG"
  from accm_state_snap s, accm_calendar c
 where s.caldt_id=c.caldt_id;

PROMPT *** Create  grants  V_ACCM_STATE_SNAP ***
grant SELECT                                                                 on V_ACCM_STATE_SNAP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCM_STATE_SNAP to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCM_STATE_SNAP.sql =========*** End 
PROMPT ===================================================================================== 
