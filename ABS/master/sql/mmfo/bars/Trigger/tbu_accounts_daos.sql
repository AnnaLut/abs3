

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAOS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_DAOS ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_DAOS 
   BEFORE UPDATE OF DAOS
   ON ACCOUNTS
   FOR EACH ROW
DECLARE
   l_fdat   DATE;
BEGIN
   /**
   -- 05-08-2014 NVV
   -- BRSMAIN-2826  Запретить изменять дату открыти счета на более позднюю, чем дата возникновения остатка на счете
   */

   IF (:OLD.daos IS NOT NULL AND :OLD.daos != :NEW.daos)
   THEN
      SELECT MIN (fdat)
        INTO l_fdat
        FROM saldoa
       WHERE     fdat <= :NEW.daos
             AND ABS (dos) + ABS (kos) > 0
             AND acc = :NEW.acc;


      IF (:new.daos > NVL (l_fdat, :NEW.daos))
      THEN
         raise_application_error (
            -20444,
               ' Рах.'
            || :new.nls
            || ' вал.'
            || :new.kv
            || ' Дата першого.руху '
            || TO_CHAR (l_fdat, 'dd.mm.yyyy')
            || ' >='
            || ' Датi відкриття '
            || TO_CHAR (:NEW.daos, 'dd.mm.yyyy'));
      END IF;
   END IF;
END TBU_ACCOUNTS_DAOS;



/
ALTER TRIGGER BARS.TBU_ACCOUNTS_DAOS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAOS.sql =========*** E
PROMPT ===================================================================================== 
