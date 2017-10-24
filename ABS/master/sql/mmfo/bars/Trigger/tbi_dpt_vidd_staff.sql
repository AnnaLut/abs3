

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD_STAFF.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPT_VIDD_STAFF ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPT_VIDD_STAFF 
before insert on dpt_vidd_staff
for each row
begin
  if :new.grantor is null then
    select id into :new.grantor from staff where logname=user;
  end if;
end;




/
ALTER TRIGGER BARS.TBI_DPT_VIDD_STAFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD_STAFF.sql =========*** 
PROMPT ===================================================================================== 
