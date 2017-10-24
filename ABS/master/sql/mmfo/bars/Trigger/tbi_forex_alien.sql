

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_FOREX_ALIEN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_FOREX_ALIEN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_FOREX_ALIEN 
  BEFORE INSERT ON "BARS"."FOREX_ALIEN"
  REFERENCING FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( nvl(:new.id,0) = 0 ) THEN
       SELECT S_Forex_alien.NEXTVAL
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;


/
ALTER TRIGGER BARS.TBI_FOREX_ALIEN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_FOREX_ALIEN.sql =========*** End
PROMPT ===================================================================================== 
