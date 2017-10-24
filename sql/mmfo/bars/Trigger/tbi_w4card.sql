

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_W4CARD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_W4CARD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_W4CARD 
before insert on w4_card
for each row
begin
  :new.code := trim(replace(:new.code, chr(9), ''));
end;


/
ALTER TRIGGER BARS.TBI_W4CARD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_W4CARD.sql =========*** End *** 
PROMPT ===================================================================================== 
