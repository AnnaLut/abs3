

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_RKO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ACCOUNTS_RKO ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACCOUNTS_RKO 
   AFTER UPDATE OF DAZS
   ON accounts
   FOR EACH ROW
BEGIN
   IF :NEW.DAZS IS NOT NULL
   THEN
      DELETE FROM rko_lst
            WHERE acc = :NEW.ACC;
   END IF;
END;



/
--ALTER TRIGGER BARS.TU_ACCOUNTS_RKO ENABLE;

Alter trigger TU_ACCOUNTS_RKO disable;




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_RKO.sql =========*** End
PROMPT ===================================================================================== 
