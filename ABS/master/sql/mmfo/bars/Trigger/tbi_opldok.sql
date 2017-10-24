

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPLDOK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPLDOK ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPLDOK 
  BEFORE INSERT ON "BARS"."OPLDOK"
  REFERENCING FOR EACH ROW
DECLARE
   -- NID NUMBER;
BEGIN
   -- SELECT S_OPLDOK.NEXTVAL INTO NID FROM DUAL;
   :NEW.ID := bars_sqnc.get_nextval('S_OPLDOK');
END;


/
ALTER TRIGGER BARS.TBI_OPLDOK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPLDOK.sql =========*** End *** 
PROMPT ===================================================================================== 
