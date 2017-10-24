

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_CP_OSTC.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_CP_OSTC ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_CP_OSTC 
   AFTER UPDATE OF ostc
   ON accounts
   FOR EACH ROW
     WHEN (new.nbs IS NULL AND old.ostc = 0 AND old.ostc <> new.ostc) DECLARE
   fl   INT;
BEGIN
   SELECT COUNT (*)
     INTO fl
     FROM cp_deal
    WHERE acc = :new.acc;

   IF fl <> 0
   THEN
      UPDATE CP_DEAL
         SET active = 1
       WHERE acc = :new.acc AND NVL (active, 0) = 0;
   END IF;
END TAU_ACCOUNTS_CP_OSTC;



/
ALTER TRIGGER BARS.TAU_ACCOUNTS_CP_OSTC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_CP_OSTC.sql =========**
PROMPT ===================================================================================== 
