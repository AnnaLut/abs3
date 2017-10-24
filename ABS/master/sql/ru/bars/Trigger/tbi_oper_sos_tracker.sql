

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_SOS_TRACKER.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER_SOS_TRACKER ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER_SOS_TRACKER 
before insert on oper for each row
begin
    :new.sos_tracker := 0;
	:new.sos_change_time := sysdate;
end tbi_oper_sos_tracker;
/
ALTER TRIGGER BARS.TBI_OPER_SOS_TRACKER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_SOS_TRACKER.sql =========**
PROMPT ===================================================================================== 
