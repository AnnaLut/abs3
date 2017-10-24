

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_VMD_BOUND.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_VMD_BOUND ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_VMD_BOUND 
before insert on cim_vmd_bound for each row
declare
  l_bound_id number;
begin
  if (:new.bound_id = 0 or :new.bound_id is null) then
     select s_cim_vmd_bound.nextval into l_bound_id from dual;
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
ALTER TRIGGER BARS.TBI_CIM_VMD_BOUND ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_VMD_BOUND.sql =========*** E
PROMPT ===================================================================================== 
