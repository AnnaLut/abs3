

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_POLICYTRIGGERS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_POLICYTRIGGERS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_POLICYTRIGGERS 
before insert or update on policy_triggers for each row
begin
  -- всегда преобразуем trigger_prefix в верхний регистр
  :new.trigger_prefix := upper(:new.trigger_prefix);
end;




/
ALTER TRIGGER BARS.TBIU_POLICYTRIGGERS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_POLICYTRIGGERS.sql =========***
PROMPT ===================================================================================== 
