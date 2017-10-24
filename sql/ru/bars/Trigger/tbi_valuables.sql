

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_VALUABLES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_VALUABLES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_VALUABLES 
   BEFORE INSERT
   ON BARS.VALUABLES
   FOR EACH ROW
   BEGIN
   :new.NOMINAL := NVL (:new.NOMINAL, 0);
   :new.CENA := NVL (:new.CENA, 0);
   :new.name := NVL (:new.name, '?');

   IF SUBSTR (:new.ob22, 1, 4) NOT IN
         ('9819', '9820', '9821', '9810', '9812','9703','9809')
   THEN
      RAISE_APPLICATION_ERROR (
         -20001,
         ' !!! НЕдопустимий код цiнностi !!! ');
   END IF;
END tbi_valuables;
/
ALTER TRIGGER BARS.TBI_VALUABLES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_VALUABLES.sql =========*** End *
PROMPT ===================================================================================== 
