

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ZAY_REF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ZAY_REF ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ZAY_REF 
AFTER UPDATE ON BARS.ZAYAVKA
FOR EACH ROW
    WHEN (
OLD.REF IS NULL AND NEW.REF IS NOT NULL AND NEW.DK=2
      ) DECLARE
   tobo_ VARCHAR2(30);
BEGIN
   SELECT TOBO INTO tobo_
     FROM ACCOUNTS
    WHERE acc=:NEW.acc1;
   INSERT INTO OPERW (REF, tag, value)
   VALUES (:NEW.REF, 'TOBO', tobo_);
END;


/
ALTER TRIGGER BARS.TAU_ZAY_REF DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ZAY_REF.sql =========*** End ***
PROMPT ===================================================================================== 
