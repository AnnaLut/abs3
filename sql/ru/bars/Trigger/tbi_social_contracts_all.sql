

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SOCIAL_CONTRACTS_ALL.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SOCIAL_CONTRACTS_ALL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SOCIAL_CONTRACTS_ALL 
before insert ON BARS.SOCIAL_CONTRACTS for each row
begin

  -- Триггер контроля изменений данных offline-отделений
  if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
     return;
  end if;

  insert into social_contracts_all (contract_id, branch)
  values (:new.contract_id, :new.branch);

end; 
/
ALTER TRIGGER BARS.TBI_SOCIAL_CONTRACTS_ALL DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SOCIAL_CONTRACTS_ALL.sql =======
PROMPT ===================================================================================== 
