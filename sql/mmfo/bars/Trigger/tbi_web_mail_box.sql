

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_WEB_MAIL_BOX.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_WEB_MAIL_BOX ***

  CREATE OR REPLACE TRIGGER BARS.TBI_WEB_MAIL_BOX 
  BEFORE INSERT ON "BARS"."WEB_MAIL_BOX"
  REFERENCING FOR EACH ROW
  begin
 if (:new.mail_id is null) then
     select s_web_mail_box.nextval into :new.mail_id from dual;
 end if;
end;



/
ALTER TRIGGER BARS.TBI_WEB_MAIL_BOX ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_WEB_MAIL_BOX.sql =========*** En
PROMPT ===================================================================================== 
