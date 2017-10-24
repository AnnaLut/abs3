

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_ACTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_ACTS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_ACTS 
before insert on cim_acts for each row
declare
  l_act_id number;
begin
  if (:new.act_id = 0 or :new.act_id is null) then
     select bars_sqnc.get_nextval('s_CIM_ACTS') into l_act_id from dual;
     :new.act_id := l_act_id;
  end if;
  if (:new.create_date is null) then
     :new.create_date :=  bankdate;
  end if;
end;


/
ALTER TRIGGER BARS.TBI_CIM_ACTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_ACTS.sql =========*** End **
PROMPT ===================================================================================== 
