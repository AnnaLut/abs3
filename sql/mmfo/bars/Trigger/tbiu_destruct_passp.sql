

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_DESTRUCT_PASSP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_DESTRUCT_PASSP ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_DESTRUCT_PASSP 
before insert on DESTRUCT_PASSP
for each row
declare
  l_id number;
begin
  if :new.id is null then
     select max(id) into l_id from destruct_passp;
     :new.id := l_id + 1;
  end if;
end;


/
ALTER TRIGGER BARS.TBIU_DESTRUCT_PASSP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_DESTRUCT_PASSP.sql =========***
PROMPT ===================================================================================== 
