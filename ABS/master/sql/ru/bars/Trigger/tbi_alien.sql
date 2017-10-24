

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ALIEN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ALIEN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ALIEN 
before insert on alien
for each row
begin
 if (:new.rec_id is null) then
     select s_alien.nextval into :new.rec_id from dual;
 end if;
end;
/
ALTER TRIGGER BARS.TBI_ALIEN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ALIEN.sql =========*** End *** =
PROMPT ===================================================================================== 
