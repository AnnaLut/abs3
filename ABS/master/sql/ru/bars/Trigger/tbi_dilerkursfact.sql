

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DILERKURSFACT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DILERKURSFACT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DILERKURSFACT 
before insert on diler_kurs_fact
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
ALTER TRIGGER BARS.TBI_DILERKURSFACT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DILERKURSFACT.sql =========*** E
PROMPT ===================================================================================== 
