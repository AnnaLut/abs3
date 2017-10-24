

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_ZCONV.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_KLP_ZCONV ***

  CREATE OR REPLACE TRIGGER BARS.TBI_KLP_ZCONV 
BEFORE INSERT ON KLP_ZCONV FOR EACH ROW
DECLARE
  id_ NUMBER;
BEGIN
--Идентификатор
  IF (:NEW.ID=0 OR :NEW.ID IS NULL) THEN
    SELECT s_KLP_ZCONV.NEXTVAL INTO id_ FROM dual;
    :NEW.ID := id_;
  END IF;
-- дата поступления заявки
   if :new.datedokkb is null then
      :new.datedokkb := sysdate;
   end if;
END;



/
ALTER TRIGGER BARS.TBI_KLP_ZCONV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_ZCONV.sql =========*** End *
PROMPT ===================================================================================== 
