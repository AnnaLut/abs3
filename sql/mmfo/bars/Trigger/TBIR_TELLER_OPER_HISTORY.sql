
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tbir_teller_oper_history.sql =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TBIR_TELLER_OPER_HISTORY 
  before insert
  on teller_oper_history
  for each row
declare
  -- local variables here
begin
  :new.id := s_teller_oper_history_id.nextval;
  :new.host  := sys_context('userenv','host');
end tbir_teller_oper_history;





/
ALTER TRIGGER BARS.TBIR_TELLER_OPER_HISTORY ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tbir_teller_oper_history.sql =======
 PROMPT ===================================================================================== 
 