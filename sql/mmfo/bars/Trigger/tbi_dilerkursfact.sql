

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DILERKURSFACT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DILERKURSFACT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DILERKURSFACT 
before insert ON BARS.DILER_KURS_FACT
for each row
begin
  if :new.code is null or :new.code = 0 then
     :new.code := bars_sqnc.get_nextval('S_DILER_KURS_FACT');
  end if;
end;

/
ALTER TRIGGER BARS.TBI_DILERKURSFACT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DILERKURSFACT.sql =========*** E
PROMPT ===================================================================================== 
