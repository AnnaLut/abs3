
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/taiur_teller_state.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TAIUR_TELLER_STATE 
  before insert or update
  on TELLER_STATE
  for each row
declare
  -- local variables here
begin
  if :new.active_oper is not null and :new.start_oper is null then
    :new.start_oper := :new.active_oper;
  elsif :new.active_oper is null then
    :new.start_oper := null;
  end if;
end taiur_teller_state;





/
ALTER TRIGGER BARS.TAIUR_TELLER_STATE ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/taiur_teller_state.sql =========*** 
 PROMPT ===================================================================================== 
 