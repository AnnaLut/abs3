

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_TOP_CONTRACTS_CONTROLDAYS.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_TOP_CONTRACTS_CONTROLDAYS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_TOP_CONTRACTS_CONTROLDAYS 
BEFORE INSERT OR UPDATE OF CONTROL_DAYS ON TOP_CONTRACTS
FOR EACH ROW
 WHEN (
NEW.control_days = 90
      ) BEGIN

  IF (INSERTING AND :NEW.control_days = 90)
      OR
     (UPDATING AND :OLD.control_days != :NEW.control_days) THEN

    bars_error.raise_nerror ('EIK', 'INVALID_CNTRDAY', TO_CHAR(:NEW.control_days));

  END IF;

END;
/
ALTER TRIGGER BARS.TIU_TOP_CONTRACTS_CONTROLDAYS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_TOP_CONTRACTS_CONTROLDAYS.sql ==
PROMPT ===================================================================================== 
