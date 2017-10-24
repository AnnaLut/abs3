

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_RI_MESSAGES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_RI_MESSAGES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_RI_MESSAGES 
BEFORE INSERT ON RI_MESSAGES FOR EACH ROW
DECLARE
  key_  NUMBER;
BEGIN
--Идентификатор
  IF (:NEW.KEY=0 OR :NEW.KEY IS NULL) THEN
    SELECT S_RI_MESSAGES.NEXTVAL
    INTO   key_
    FROM   dual;
    :NEW.KEY := key_;
  END IF;
END;


/
ALTER TRIGGER BARS.TBI_RI_MESSAGES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_RI_MESSAGES.sql =========*** End
PROMPT ===================================================================================== 
