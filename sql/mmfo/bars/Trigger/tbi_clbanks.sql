

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CLBANKS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CLBANKS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CLBANKS 
  BEFORE INSERT ON "BARS"."CLBANKS"
  REFERENCING FOR EACH ROW
  DECLARE
   NID NUMBER;
BEGIN
   SELECT S_CLBANKS.NEXTVAL INTO NID FROM DUAL;
   :NEW.CLBID := NID;
END;



/
ALTER TRIGGER BARS.TBI_CLBANKS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CLBANKS.sql =========*** End ***
PROMPT ===================================================================================== 
