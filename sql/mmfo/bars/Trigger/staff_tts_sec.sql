

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/STAFF_TTS_SEC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger STAFF_TTS_SEC ***

  CREATE OR REPLACE TRIGGER BARS.STAFF_TTS_SEC 
 BEFORE INSERT OR DELETE OR
         UPDATE OF approve,adate1, adate2, rdate1, rdate2, revoked
 ON  staff_tts  FOR EACH ROW
DECLARE
 action_ NUMBER(3);
 BEGIN
   IF INSERTING THEN
        action_:=1;
   ELSIF UPDATING THEN
        action_:=1;
   ELSIF DELETING THEN
        action_:=1;
   END IF;
 END;





/
ALTER TRIGGER BARS.STAFF_TTS_SEC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/STAFF_TTS_SEC.sql =========*** End *
PROMPT ===================================================================================== 
