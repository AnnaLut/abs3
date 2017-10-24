

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ALIEN_BANK_SW.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ALIEN_BANK_SW ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ALIEN_BANK_SW 
  BEFORE INSERT ON "BARS"."ALIEN_BANK_SW"
  REFERENCING FOR EACH ROW
  begin
 if (:new.rec_id is null) then
     select s_alien_bank_sw.nextval into :new.rec_id from dual;
 end if;
 if (:new.id is null) then
     :new.id := user_id;
 end if;

end;



/
ALTER TRIGGER BARS.TBI_ALIEN_BANK_SW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ALIEN_BANK_SW.sql =========*** E
PROMPT ===================================================================================== 
