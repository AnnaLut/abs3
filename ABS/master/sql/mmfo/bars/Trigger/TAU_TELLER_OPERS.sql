
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tau_teller_opers.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TAU_TELLER_OPERS 
  after update
  on TELLER_OPERS
  for each row
declare
  -- local variables here
begin
  if nvl(:new.state,'XX') != nvl(:old.state,'00') then
    insert into teller_oper_history(op_ref, old_status, new_status, user_ref, dt_change)
      values(:new.id,:old.state,:new.state,user_id,sysdate);
  end if;
end tau_teller_opers;





/
ALTER TRIGGER BARS.TAU_TELLER_OPERS ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tau_teller_opers.sql =========*** En
 PROMPT ===================================================================================== 
 