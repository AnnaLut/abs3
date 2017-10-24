

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAPROS_LAST_UPDATED.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ZAPROS_LAST_UPDATED ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ZAPROS_LAST_UPDATED 
  BEFORE INSERT OR UPDATE ON "BARS"."ZAPROS"
  REFERENCING FOR EACH ROW
  BEGIN
  :NEW.LAST_UPDATED := SYSDATE;
END;



/
ALTER TRIGGER BARS.TIU_ZAPROS_LAST_UPDATED ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAPROS_LAST_UPDATED.sql ========
PROMPT ===================================================================================== 
