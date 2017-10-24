

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_SWIFT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_KLP_SWIFT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_KLP_SWIFT 
BEFORE INSERT ON KLP_SWIFT FOR EACH ROW
DECLARE
  id_ NUMBER;
BEGIN
--Идентификатор
  IF (:NEW.ID=0 OR :NEW.ID IS NULL) THEN
    SELECT s_KLP_SWIFT.NEXTVAL INTO id_ FROM dual;
    :NEW.ID := id_;
  END IF;
END;
/
ALTER TRIGGER BARS.TBI_KLP_SWIFT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_SWIFT.sql =========*** End *
PROMPT ===================================================================================== 
