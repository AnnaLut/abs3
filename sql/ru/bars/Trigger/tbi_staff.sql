

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_STAFF ***

  CREATE OR REPLACE TRIGGER BARS.TBI_STAFF 
BEFORE INSERT  ON STAFF$BASE
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.id = 0 ) THEN
       SELECT s_staff.NEXTVAL
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;

/
ALTER TRIGGER BARS.TBI_STAFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFF.sql =========*** End *** =
PROMPT ===================================================================================== 
