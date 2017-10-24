

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TBI_FILE_ATTACH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_FILE_ATTACH ***

  CREATE OR REPLACE TRIGGER FINMON.TBI_FILE_ATTACH 
BEFORE INSERT ON FINMON.FILE_ATTACH FOR EACH ROW
BEGIN
   if (:NEW.ID is null)then
      SELECT S_FILE_ATTACH.NEXTVAL INTO :NEW.ID FROM dual;
   end if;
END TBI_FILE_ATTACH;
/
ALTER TRIGGER FINMON.TBI_FILE_ATTACH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TBI_FILE_ATTACH.sql =========*** E
PROMPT ===================================================================================== 
