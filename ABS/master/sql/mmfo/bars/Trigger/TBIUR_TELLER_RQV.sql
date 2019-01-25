
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tbiur_teller_rqv.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TBIUR_TELLER_RQV 
  before insert or update
  on TELLER_REQUESTS
  for each row
declare
  -- local variables here
begin
  :new.creator := coalesce(:new.creator, user_name);
  :new.creation_date := coalesce(:new.creation_date, sysdate);
  :new.last_dt       := sysdate;
  :new.last_user     := sys_context('userenv','host');
  :new.status        := coalesce(:new.status,'IN');
end tbiur_teller_rqv;





/
ALTER TRIGGER BARS.TBIUR_TELLER_RQV ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tbiur_teller_rqv.sql =========*** En
 PROMPT ===================================================================================== 
 