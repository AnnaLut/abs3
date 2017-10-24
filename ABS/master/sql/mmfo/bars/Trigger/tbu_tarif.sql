

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_TARIF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_TARIF ***

  CREATE OR REPLACE TRIGGER BARS.TBU_TARIF 
   BEFORE UPDATE OF kod
   ON BARS.TARIF
   FOR EACH ROW
BEGIN
   IF :old.kod <> :new.kod
   THEN
      raise_application_error (
         -20000,
         'Запрещено изменение кода тарифа',
         TRUE);
   END IF;
END;


/
ALTER TRIGGER BARS.TBU_TARIF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_TARIF.sql =========*** End *** =
PROMPT ===================================================================================== 
