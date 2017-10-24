

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_ACT_BOUND.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_ACT_BOUND ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_ACT_BOUND 
before insert on cim_act_bound for each row
declare
  l_bound_id number;
begin
  if (:new.bound_id = 0 or :new.bound_id is null) then
     select bars_sqnc.get_nextval('s_cim_act_bound') into l_bound_id from dual;
     :new.bound_id := l_bound_id;
  end if;
  if (:new.create_date is null) then
     :new.create_date :=  bankdate;
  end if;
  if (:new.modify_date is null) then
     :new.modify_date :=  bankdate;
  end if;
end;


/
ALTER TRIGGER BARS.TBI_CIM_ACT_BOUND ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_ACT_BOUND.sql =========*** E
PROMPT ===================================================================================== 
