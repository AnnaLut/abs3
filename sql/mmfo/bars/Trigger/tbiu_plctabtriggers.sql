

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_PLCTABTRIGGERS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_PLCTABTRIGGERS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_PLCTABTRIGGERS 
before insert or update on policy_table_triggers for each row
begin
  -- всегда преобразуем поля owner, table_name, triggers в верхний регистр
  :new.owner := upper(:new.owner);
  :new.table_name := upper(:new.table_name);
  :new.triggers := upper(:new.triggers);
end;




/
ALTER TRIGGER BARS.TBIU_PLCTABTRIGGERS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_PLCTABTRIGGERS.sql =========***
PROMPT ===================================================================================== 
