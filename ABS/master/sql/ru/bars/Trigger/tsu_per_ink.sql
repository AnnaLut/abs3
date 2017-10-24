

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TSU_PER_INK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TSU_PER_INK ***

  CREATE OR REPLACE TRIGGER BARS.TSU_PER_INK 
INSTEAD OF UPDATE OR DELETE ON BARS.PER_INK FOR EACH ROW
DECLARE
  sos_ NUMBER;
BEGIN
   UPDATE per_que SET refx=:NEW.ref WHERE ref=:OLD.ref;
   IF SQL%ROWCOUNT=0 THEN
      INSERT INTO per_que (ref,refx) VALUES (:OLD.ref,:NEW.ref);
   END IF;
END;
/
ALTER TRIGGER BARS.TSU_PER_INK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TSU_PER_INK.sql =========*** End ***
PROMPT ===================================================================================== 
