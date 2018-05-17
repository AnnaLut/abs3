

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_OPER_SOS_TRACKER.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_OPER_SOS_TRACKER ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_OPER_SOS_TRACKER 
after insert or update of sos ON BARS.OPER for each row
    WHEN (
new.tt like 'IB%' and new.pdat >= trunc(sysdate, 'yyyy')
      ) begin
    -- зберігаємо історію змін статусів документів
    insert into sos_track(ref, sos_tracker, old_sos, new_sos, change_time, userid)
    values(:new.ref, :new.sos_tracker, :old.sos, nvl(:new.sos,0), :new.sos_change_time, user_id);
    --
end taiu_oper_sos_tracker;


/
ALTER TRIGGER BARS.TAIU_OPER_SOS_TRACKER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_OPER_SOS_TRACKER.sql =========*
PROMPT ===================================================================================== 
