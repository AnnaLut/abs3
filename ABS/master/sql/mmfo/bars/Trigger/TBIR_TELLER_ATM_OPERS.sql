
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tbir_teller_atm_opers.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TBIR_TELLER_ATM_OPERS 
  before insert
  on TELLER_ATM_OPERS 
  for each row
declare
  -- local variables here
begin
  if :new.user_ref is null then
    :new.user_ref := user_id;
  end if;
  if :new.user_ip is null then
    :new.user_ip  := sys_context('bars_global', 'host_name');
  end if;
end tbir_teller_atm_opers;

/
ALTER TRIGGER BARS.TBIR_TELLER_ATM_OPERS ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tbir_teller_atm_opers.sql =========*
 PROMPT ===================================================================================== 
 