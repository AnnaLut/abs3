

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_PS_TTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_PS_TTS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_PS_TTS 
   BEFORE INSERT
   ON PS_TTS
   FOR EACH ROW
BEGIN
   IF :NEW.id IS NULL OR :NEW.id = 0
   THEN
      SELECT s_PS_TTS.NEXTVAL INTO :new.id FROM DUAL;
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_PS_TTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_PS_TTS.sql =========*** End *** 
PROMPT ===================================================================================== 
