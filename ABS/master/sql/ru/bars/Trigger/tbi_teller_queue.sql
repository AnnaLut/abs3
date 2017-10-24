

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_TELLER_QUEUE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_TELLER_QUEUE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_TELLER_QUEUE 
BEFORE INSERT ON TELLER_QUEUE
FOR EACH ROW
BEGIN
  SELECT S_TELLER_QUEUE.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/
ALTER TRIGGER BARS.TBI_TELLER_QUEUE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_TELLER_QUEUE.sql =========*** En
PROMPT ===================================================================================== 
