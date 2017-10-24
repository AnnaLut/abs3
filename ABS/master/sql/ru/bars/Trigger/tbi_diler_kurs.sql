

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DILER_KURS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DILER_KURS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DILER_KURS 
before insert on diler_kurs
for each row
declare
  id_ number;
begin
  if :new.code is null or :new.code = 0 then
     select s_diler_kurs.nextval into id_  from dual;
     :new.code := id_;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_DILER_KURS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DILER_KURS.sql =========*** End 
PROMPT ===================================================================================== 
