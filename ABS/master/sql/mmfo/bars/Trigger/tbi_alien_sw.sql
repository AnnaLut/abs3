

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ALIEN_SW.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ALIEN_SW ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ALIEN_SW 
  BEFORE INSERT ON "BARS"."ALIEN_SW"
  REFERENCING FOR EACH ROW
  begin
 if (:new.rec_id is null) then
     select s_alien_sw.nextval into :new.rec_id from dual;
 end if;
 if (:new.id is null) then
     :new.id := user_id;
 end if;
end;



/
ALTER TRIGGER BARS.TBI_ALIEN_SW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ALIEN_SW.sql =========*** End **
PROMPT ===================================================================================== 
