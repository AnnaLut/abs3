

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CC_W11.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CC_W11 ***

  CREATE OR REPLACE TRIGGER BARS.TU_CC_W11 
  instead of update ON BARS.CC_W11   for each row
begin
  if :new.fin >= 1 and :new.fin <= 5 and nvl(:old.fin, 0) <> :new.fin then
    update cc_deal set fin = :new.fin where nd = :old.nd;
  end if;
end tu_cc_w11;
/
ALTER TRIGGER BARS.TU_CC_W11 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CC_W11.sql =========*** End *** =
PROMPT ===================================================================================== 
