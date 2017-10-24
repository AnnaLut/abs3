

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_BRANCH_TOBO.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOUNTS_BRANCH_TOBO ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOUNTS_BRANCH_TOBO 
before insert or update of branch, tobo ON BARS.ACCOUNTS for each row
declare
  l_branch   branch.branch%type;
begin
  --
  -- синхронизация полей BRANCH и TOBO
  --
  if :new.tobo is null then
      :new.tobo   := sys_context('bars_context','user_branch');
  end if;
  if :new.branch is null then
      :new.branch := sys_context('bars_context','user_branch');
  end if;
  if inserting then
      if :new.tobo<>sys_context('bars_context','user_branch') then
         :new.branch := :new.tobo;
      elsif  :new.branch<>sys_context('bars_context','user_branch') then
             :new.tobo   := :new.branch;
      end if;
  elsif updating then
    if :new.tobo<>:old.tobo and :new.branch=:old.branch then
       :new.branch := :new.tobo;
    elsif :new.branch<>:old.branch and :new.tobo<>:old.tobo then
          :new.tobo   := :new.branch;
    end if;
    --
    -- для рахунків депозитних портфелів зміна підрозділу заборонена !

    --
  end if;
end;
/
ALTER TRIGGER BARS.TIU_ACCOUNTS_BRANCH_TOBO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_BRANCH_TOBO.sql =======
PROMPT ===================================================================================== 
