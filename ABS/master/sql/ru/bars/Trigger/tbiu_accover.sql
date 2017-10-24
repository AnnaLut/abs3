

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOVER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ACCOVER ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ACCOVER before insert or update on acc_over
for each row
begin
  if :new.acc_2067 = 0 then
     :new.acc_2067 := null; 
  end if;
  if :new.acc_2069 = 0 then
     :new.acc_2069 := null; 
  end if;
  if :new.acc_2096 = 0 then
     :new.acc_2096 := null; 
  end if;
end; 
/
ALTER TRIGGER BARS.TBIU_ACCOVER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOVER.sql =========*** End **
PROMPT ===================================================================================== 
