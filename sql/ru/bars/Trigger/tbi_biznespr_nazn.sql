

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BIZNESPR_NAZN.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BIZNESPR_NAZN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BIZNESPR_NAZN 
before insert or update of slovo on biznespr_nazn for each row
begin
  :new.slovo := upper(trim(:new.slovo));
end;
/
ALTER TRIGGER BARS.TBI_BIZNESPR_NAZN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BIZNESPR_NAZN.sql =========*** E
PROMPT ===================================================================================== 
