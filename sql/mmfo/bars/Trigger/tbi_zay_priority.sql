

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_PRIORITY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAY_PRIORITY ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAY_PRIORITY 
  before insert on zayavka for each row
begin

  -- чтоб заявки проходили 2 визы (ZAY2, ZAY3)
  :new.priority := 1;

end;


/
ALTER TRIGGER BARS.TBI_ZAY_PRIORITY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_PRIORITY.sql =========*** En
PROMPT ===================================================================================== 
