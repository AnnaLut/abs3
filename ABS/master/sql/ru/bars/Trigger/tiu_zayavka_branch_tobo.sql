

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAYAVKA_BRANCH_TOBO.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ZAYAVKA_BRANCH_TOBO ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ZAYAVKA_BRANCH_TOBO 
   BEFORE INSERT OR UPDATE OF branch, tobo
   ON zayavka
   FOR EACH ROW
BEGIN
   --
   -- синхронизация полей BRANCH и TOBO
   --
   IF :new.tobo IS NULL
   THEN
      :new.tobo := SYS_CONTEXT ('bars_context', 'user_branch');
   END IF;

   IF :new.branch IS NULL
   THEN
      :new.branch := SYS_CONTEXT ('bars_context', 'user_branch');
   END IF;

   IF INSERTING
   THEN
      IF :new.tobo <> SYS_CONTEXT ('bars_context', 'user_branch')
      THEN
         :new.branch := :new.tobo;
      ELSIF :new.branch <> SYS_CONTEXT ('bars_context', 'user_branch')
      THEN
         :new.tobo := :new.branch;
      END IF;
   ELSIF UPDATING
   THEN
      IF :new.tobo <> :old.tobo AND :new.branch = :old.branch
      THEN
         :new.branch := :new.tobo;
      ELSIF :new.branch <> :old.branch AND :new.tobo <> :old.tobo
      THEN
         :new.tobo := :new.branch;
      END IF;
   END IF;
END;
/
ALTER TRIGGER BARS.TIU_ZAYAVKA_BRANCH_TOBO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAYAVKA_BRANCH_TOBO.sql ========
PROMPT ===================================================================================== 
