

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_LIMBAK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_LIMBAK ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_LIMBAK 
after update of sos on oper
for each row
 WHEN (new.sos<0 and old.sos>0 and new.tt in ('AA4','AA6')) begin
  val_service.del_eq(:new.ref,:new.branch);
end tu_oper_limbak;
/
ALTER TRIGGER BARS.TU_OPER_LIMBAK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_LIMBAK.sql =========*** End 
PROMPT ===================================================================================== 
