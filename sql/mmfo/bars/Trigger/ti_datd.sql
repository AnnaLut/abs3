

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_DATD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_DATD ***

  CREATE OR REPLACE TRIGGER BARS.TI_DATD 
BEFORE INSERT ON BARS.ARC_RRP    FOR EACH ROW
    WHEN ((
SUBSTR(NEW.fn_a,2,1)='A' OR NEW.fn_a IS NULL) AND NEW.dk IN (0,1)
      ) DECLARE
   ern  CONSTANT POSITIVE := 338; -- Trigger err code
   err  EXCEPTION;
   erm  VARCHAR2(80);
BEGIN
   IF :NEW.datd > gl.bDATE or :NEW.datd < gl.bDATE-30 THEN
      erm := '0610 - Ош. ДАТА платежного документа';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;
   IF trunc(:NEW.datp) > gl.bDATE THEN
      erm := '0906 - Невірна послідовність дат в платежі (рекв 10,11 і поточна)';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;
END;


/
ALTER TRIGGER BARS.TI_DATD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_DATD.sql =========*** End *** ===
PROMPT ===================================================================================== 
