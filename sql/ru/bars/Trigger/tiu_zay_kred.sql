

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAY_KRED.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ZAY_KRED ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ZAY_KRED 
   BEFORE INSERT OR UPDATE
   ON ZAYAVKA
   FOR EACH ROW
BEGIN
   -- Изменение приоритетности заявки на "желательную"
   -- для заявок на погашение кредита для банка "АЖИО"
   IF :NEW.META = 3
   THEN
      :NEW.PRIORITY := 1;
   END IF;
END;
/
ALTER TRIGGER BARS.TIU_ZAY_KRED ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAY_KRED.sql =========*** End **
PROMPT ===================================================================================== 
