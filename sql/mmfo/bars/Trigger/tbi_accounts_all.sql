

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ACCOUNTS_ALL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ACCOUNTS_ALL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ACCOUNTS_ALL 
   BEFORE INSERT
   ON accounts
   FOR EACH ROW
BEGIN
   -- Триггер контроля изменений данных offline-отделений
   IF (DBMS_MVIEW.i_am_a_refresh = TRUE OR DBMS_REPUTIL.from_remote = TRUE)
   THEN
      RETURN;
   END IF;

   INSERT INTO accounts_all (acc,
                             kf,
                             nls,
                             kv)
        VALUES (:new.acc,
                :new.kf,
                :new.nls,
                :new.kv);
END;



/
ALTER TRIGGER BARS.TBI_ACCOUNTS_ALL DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ACCOUNTS_ALL.sql =========*** En
PROMPT ===================================================================================== 
