

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_OPER_SOS_TRACKER.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_OPER_SOS_TRACKER ***

  CREATE OR REPLACE TRIGGER BARS.TBU_OPER_SOS_TRACKER 
before update of sos ON BARS.OPER for each row
begin
    -- інкрементуємо номер зміни статусу документа(при вставці=0)
    :new.sos_tracker := nvl(:old.sos_tracker,0) + 1;
  :new.sos_change_time := sysdate;
end tbu_oper_sos_tracker;


/
ALTER TRIGGER BARS.TBU_OPER_SOS_TRACKER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_OPER_SOS_TRACKER.sql =========**
PROMPT ===================================================================================== 
