

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_VISA_IN_CHARGE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER_VISA_IN_CHARGE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER_VISA_IN_CHARGE 
before insert on oper_visa
for each row
-- проставл€ем флаг вида Ё÷ѕ на данном уровне визы
declare
  tt_     oper.tt%type;
  fsig_   oper_visa.f_in_charge%type;
begin
 select tt into tt_ from oper where ref=:new.ref;
 chk.visa_flag4sign(tt_, :new.groupid, fsig_);
 :new.f_in_charge := bitand(fsig_,3);
end;



/
ALTER TRIGGER BARS.TBI_OPER_VISA_IN_CHARGE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_VISA_IN_CHARGE.sql ========
PROMPT ===================================================================================== 
