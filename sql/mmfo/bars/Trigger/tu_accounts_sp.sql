PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_SP.sql =========*** Run 
PROMPT ===================================================================================== 


/*
PROMPT *** Create  trigger TU_ACCOUNTS_SP ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACCOUNTS_SP 
   AFTER UPDATE OF ostc
   ON accounts
   FOR EACH ROW
     WHEN (new.tip IN ('SP ', 'SPN')) DECLARE
   l_nd   NUMBER;
BEGIN
   IF :new.ostc = 0 AND :new.ostc <> :old.ostc
   THEN
      BEGIN
         SELECT nd
           INTO l_nd
           FROM nd_acc
          WHERE acc = :new.acc;

         DELETE FROM nd_txt
               WHERE     tag = DECODE (:new.tip, 'SP ', 'DATSP', 'DASPN')
                     AND nd = l_nd;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
      END;
   END IF;
END tu_accounts_sp;



/
ALTER TRIGGER BARS.TU_ACCOUNTS_SP ENABLE;
*/

declare
    trigger_doesnt_exist exception;
    pragma exception_init(trigger_doesnt_exist, -4080);
begin
    execute immediate 'drop trigger TU_ACCOUNTS_SP';
exception
    when trigger_doesnt_exist then
         null;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_SP.sql =========*** End 
PROMPT ===================================================================================== 
