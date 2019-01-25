
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tbir_teller_opers.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TBIR_TELLER_OPERS 
  before insert
  on TELLER_OPERS
  for each row
declare
  -- local variables here
begin
  if :new.id is null then
    :new.id        := s_teller_opers_id.nextval;
  end if;
  :new.exec_time := sysdate;
  :new.user_ref  := user_id;
  :new.work_date := gl.bd;
end tbir_teller_opers;



/
ALTER TRIGGER BARS.TBIR_TELLER_OPERS ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tbir_teller_opers.sql =========*** E
 PROMPT ===================================================================================== 
 