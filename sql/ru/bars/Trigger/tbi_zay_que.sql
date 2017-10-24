

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_QUE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAY_QUE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAY_QUE 
   AFTER INSERT OR UPDATE
   ON zayavka
   FOR EACH ROW
BEGIN
   IF (INSERTING) OR (UPDATING AND :new.sos < 2 AND :old.sos = 2)
   THEN
      BEGIN
         INSERT INTO zay_queue (id)
              VALUES (:new.id);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
      END;
   ELSIF (UPDATING AND :new.sos = 2 AND :old.sos < 2)
   THEN
      DELETE FROM zay_queue
            WHERE id = :new.id;
   ELSIF (UPDATING AND :new.sos = -1)
   THEN
      DELETE FROM zay_queue
            WHERE id = :new.id;
   ELSE
      NULL;
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_ZAY_QUE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_QUE.sql =========*** End ***
PROMPT ===================================================================================== 
