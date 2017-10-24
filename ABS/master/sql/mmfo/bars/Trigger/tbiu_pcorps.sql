

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_PCORPS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_PCORPS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_PCORPS 
  BEFORE INSERT OR UPDATE ON "BARS"."PCORPS"
  REFERENCING FOR EACH ROW
  BEGIN
   :NEW.FIO := UPPER(:NEW.FIO);  :NEW.NAM := UPPER(:NEW.NAM);
END;



/
ALTER TRIGGER BARS.TBIU_PCORPS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_PCORPS.sql =========*** End ***
PROMPT ===================================================================================== 
