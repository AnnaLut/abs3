

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_STAFF_TABN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_STAFF_TABN ***

  CREATE OR REPLACE TRIGGER BARS.TIU_STAFF_TABN 
  before insert or update of tabn ON BARS.STAFF$BASE   for each row
begin
  :new.tabn := upper(trim(:new.tabn));
  if :new.branch='/' then
  	:new.policy_group := 'WHOLE';
  else
    :new.policy_group := 'FILIAL';
  end if;
end; 
/
ALTER TRIGGER BARS.TIU_STAFF_TABN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_STAFF_TABN.sql =========*** End 
PROMPT ===================================================================================== 
