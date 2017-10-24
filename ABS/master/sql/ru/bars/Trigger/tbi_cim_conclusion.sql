

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_CONCLUSION.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_CONCLUSION ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_CONCLUSION 
before insert on cim_conclusion for each row
declare
  l_id number;
begin
  if (:new.id = 0 or :new.id is null) then
     select s_cim_conclusion.nextval into l_id from dual;
     :new.id := l_id;
  end if;
  if (:new.create_date is null) then
     :new.create_date :=  bankdate;
  end if;
   if (:new.create_uid is null) then
     :new.create_uid :=  user_id;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_CIM_CONCLUSION ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_CONCLUSION.sql =========*** 
PROMPT ===================================================================================== 
