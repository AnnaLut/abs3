

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_1004.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_1004 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_1004 
   BEFORE UPDATE OF ostb
   ON accounts
   FOR EACH ROW
     WHEN (old.nbs = '1004') BEGIN
   IF :old.ob22 = '01' AND (MOD ( (:old.ostb - :new.ostb) / 100, 1) <> 0)
   THEN
      raise_application_error (
         -20000,
         'Сумма снятия/пополнения счета 1004 должна быть кратной 1!');
   END IF;
END;



/
ALTER TRIGGER BARS.TBU_ACCOUNTS_1004 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_1004.sql =========*** E
PROMPT ===================================================================================== 
