

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_BRANCH_TOBO.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOUNTS_BRANCH_TOBO ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOUNTS_BRANCH_TOBO 
   BEFORE INSERT OR UPDATE OF branch, tobo
   ON accounts
   FOR EACH ROW
DECLARE
   l_branch   branch.branch%TYPE;
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

      --
      -- для рахунків депозитних портфелів зміна підрозділу заборонена !
      IF :new.TIP IN ('DEP', 'DEN', 'NL8')
      THEN
         BEGIN
            SELECT branch
              INTO l_branch
              FROM (SELECT branch
                      FROM dpt_accounts a, dpt_deposit d
                     WHERE a.accid = :new.acc AND a.dptid = d.deposit_id
                    --and d.branch = :new.branch
                    UNION
                    SELECT branch
                      FROM dpu_accounts a, dpu_deal d
                     WHERE a.accid = :new.acc AND a.dpuid = d.dpu_id--and d.branch = :new.branch
                   );

            IF l_branch != :new.branch
            THEN
               BARS_ERROR.raise_nerror ('DPT', 'BRANCH_EDIT_DENIED');
            ELSE
               NULL;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;
   --
   END IF;
END;



/
ALTER TRIGGER BARS.TIU_ACCOUNTS_BRANCH_TOBO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_BRANCH_TOBO.sql =======
PROMPT ===================================================================================== 
