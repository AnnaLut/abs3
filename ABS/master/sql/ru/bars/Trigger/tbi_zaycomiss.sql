

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAYCOMISS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAYCOMISS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAYCOMISS 
before insert on zay_comiss
for each row
declare
  l_id number;
begin
  if :new.id is null or :new.id = 0 then
     select s_zay_comiss.nextval into l_id from dual;
     :new.id := l_id;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_ZAYCOMISS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAYCOMISS.sql =========*** End *
PROMPT ===================================================================================== 
