

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAUD_OPLDOK_LIMBAK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAUD_OPLDOK_LIMBAK ***

  CREATE OR REPLACE TRIGGER BARS.TAUD_OPLDOK_LIMBAK 
after update or delete on opldok
for each row
declare l_branch branch.branch%type;
begin
if (updating and :new.sos=5 and :old.sos=1 and :new.tt='BAK') or deleting then
  if instr(getglobaloption('TTLST'),:new.tt)>0 or :new.tt='BAK' then

    select branch into l_branch from oper where ref= :new.ref;
      val_service.del_eq(:new.ref, l_branch);

  end if;
end if;
end taud_opldok_limbak;
/
ALTER TRIGGER BARS.TAUD_OPLDOK_LIMBAK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAUD_OPLDOK_LIMBAK.sql =========*** 
PROMPT ===================================================================================== 
