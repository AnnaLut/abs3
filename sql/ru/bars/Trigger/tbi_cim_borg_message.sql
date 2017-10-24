

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_BORG_MESSAGE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_BORG_MESSAGE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_BORG_MESSAGE 
before insert on cim_borg_message for each row
declare
  l_id number;
begin
  if (:new.id = 0 or :new.id is null) then
     select s_cim_borg_message.nextval into l_id from dual;
     :new.id := l_id;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_CIM_BORG_MESSAGE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_BORG_MESSAGE.sql =========**
PROMPT ===================================================================================== 
