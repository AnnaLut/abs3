

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_ZVIDM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_KLP_ZVIDM ***

  CREATE OR REPLACE TRIGGER BARS.TBI_KLP_ZVIDM 
BEFORE INSERT ON KLP_ZVIDM FOR EACH ROW
DECLARE
  id_ NUMBER;
BEGIN
--Идентификатор
  IF (:NEW.ID=0 OR :NEW.ID IS NULL) THEN
    SELECT s_KLP_ZVIDM.NEXTVAL INTO id_ FROM dual;
    :NEW.ID := id_;
  END IF;
END;



/
ALTER TRIGGER BARS.TBI_KLP_ZVIDM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_ZVIDM.sql =========*** End *
PROMPT ===================================================================================== 
