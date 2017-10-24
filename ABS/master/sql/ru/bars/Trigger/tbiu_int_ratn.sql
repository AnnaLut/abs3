

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_INT_RATN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_INT_RATN ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_INT_RATN 
before insert or update on int_ratn
for each row
begin

  :new.idu := user_id;

end;
/
ALTER TRIGGER BARS.TBIU_INT_RATN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_INT_RATN.sql =========*** End *
PROMPT ===================================================================================== 
