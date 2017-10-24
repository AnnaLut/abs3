

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DILER_KURS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DILER_KURS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DILER_KURS 
before insert ON BARS.DILER_KURS
for each row
declare
  id_ number;
begin
  if :new.code is null or :new.code = 0 then
     id_ := bars_sqnc.get_nextval('s_diler_kurs');
     :new.code := id_;
  end if;
end;

/
ALTER TRIGGER BARS.TBI_DILER_KURS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DILER_KURS.sql =========*** End 
PROMPT ===================================================================================== 
