

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ZAY_CLOSETYPE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ZAY_CLOSETYPE ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ZAY_CLOSETYPE 
   BEFORE UPDATE
   ON zayavka
   FOR EACH ROW
    WHEN (old.sos = 0 AND new.sos = 0.5) BEGIN
   -- не даем обработать дилером заявку, если не проставлен тип закрытия заявки
   IF :new.close_type IS NULL
   THEN
      raise_application_error (
         - (20000 + 999),
         'Невозможно сохранение без указания типа закрытия заявки!',
         TRUE);
   END IF;
END;
/
ALTER TRIGGER BARS.TBU_ZAY_CLOSETYPE DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ZAY_CLOSETYPE.sql =========*** E
PROMPT ===================================================================================== 
