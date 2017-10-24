

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_W4SUBPRODUCT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_W4SUBPRODUCT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_W4SUBPRODUCT 
before insert on w4_subproduct
for each row
begin
  :new.code := trim(replace(:new.code, chr(9), ''));
end;
/
ALTER TRIGGER BARS.TBI_W4SUBPRODUCT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_W4SUBPRODUCT.sql =========*** En
PROMPT ===================================================================================== 
