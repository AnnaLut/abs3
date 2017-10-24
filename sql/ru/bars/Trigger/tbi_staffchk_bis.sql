

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFFCHK_BIS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_STAFFCHK_BIS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_STAFFCHK_BIS 
   BEFORE INSERT  ON BARS.STAFF_CHK
   FOR EACH ROW
DECLARE
   l_id1   NUMBER;
   l_id2   NUMBER;
BEGIN
   l_id1 := 94;
   l_id2 := 96;

   IF (:new.chkid = l_id1 OR :new.chkid = l_id2)
      AND f_check_visa_bis (:new.id) = 1
   THEN
      raise_application_error (
         -20000,
         'Визу №94 та №96 заборонено видавати
      WEB-користувачам та користувачам не рівня МФО !!!');
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_STAFFCHK_BIS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFFCHK_BIS.sql =========*** En
PROMPT ===================================================================================== 
