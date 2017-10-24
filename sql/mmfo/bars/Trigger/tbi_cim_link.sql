

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_LINK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_LINK ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_LINK 
before insert on cim_link for each row
declare
  l_bound_id number;
begin
  if (:new.id = 0 or :new.id is null) then
     select bars_sqnc.get_nextval('s_cim_link') into l_bound_id from dual;
     :new.id := l_bound_id;
  end if;
  if (:new.create_date is null) then
     :new.create_date :=  bankdate;
  end if;
end;


/
ALTER TRIGGER BARS.TBI_CIM_LINK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_LINK.sql =========*** End **
PROMPT ===================================================================================== 
