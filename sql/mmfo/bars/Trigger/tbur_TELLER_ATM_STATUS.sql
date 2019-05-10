 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/taur_teller_atm_status.sql =========
 PROMPT ===================================================================================== 
 
declare
  v_num number;
begin
  select count(1) into v_num
    from user_triggers 
    where trigger_name = 'TBUR_TELLER_ATM_STATUS';
  if v_num = 1 then
    execute immediate 'drop TRIGGER BARS.TBUR_TELLER_ATM_STATUS';
  end if;
end;
/

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/taur_teller_atm_status.sql =========
 PROMPT ===================================================================================== 
 