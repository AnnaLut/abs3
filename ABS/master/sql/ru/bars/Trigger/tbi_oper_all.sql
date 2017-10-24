

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_ALL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER_ALL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER_ALL 
before insert on oper
for each row
begin
  insert into oper_all (ref, kf)
  values (:new.ref, :new.kf);
end;
/
ALTER TRIGGER BARS.TBI_OPER_ALL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_ALL.sql =========*** End **
PROMPT ===================================================================================== 
