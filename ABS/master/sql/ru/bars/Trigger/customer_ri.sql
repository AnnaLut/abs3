

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/CUSTOMER_RI.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger CUSTOMER_RI ***

  CREATE OR REPLACE TRIGGER BARS.CUSTOMER_RI 
BEFORE INSERT ON CUSTOMER_RI FOR EACH ROW
DECLARE
  id_  NUMBER;
BEGIN
--Идентификатор
  IF (:NEW.ID=0 OR :NEW.ID IS NULL) THEN
    SELECT S_CUSTOMER_RI.NEXTVAL INTO id_ FROM dual;
    :NEW.ID := id_;
  END IF;
END;
/
ALTER TRIGGER BARS.CUSTOMER_RI ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/CUSTOMER_RI.sql =========*** End ***
PROMPT ===================================================================================== 
