

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_TTS_FLAGS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_TTS_FLAGS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_TTS_FLAGS 
BEFORE INSERT OR UPDATE ON tts
FOR EACH ROW
     WHEN (NEW.fli=1) DECLARE
BEGIN
  IF :OLD.fli<>1 OR :OLD.fli IS NULL THEN
     :NEW.flags:=SUBSTR(:NEW.flags,1,1)||
	 CHR(ASCII(SUBSTR(:NEW.flags,2,1))-BITAND(ASCII(SUBSTR(:NEW.flags,2,1)),2)+2)||
	 SUBSTR(:NEW.flags,3);
  END IF;
END;




/
ALTER TRIGGER BARS.TIU_TTS_FLAGS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_TTS_FLAGS.sql =========*** End *
PROMPT ===================================================================================== 
