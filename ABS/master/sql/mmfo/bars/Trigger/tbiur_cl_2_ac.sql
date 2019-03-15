
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tbiur_cl_2_ac.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TBIUR_CL_2_AC 
  before insert or update
  on CL_2_AC
  for each row
declare
  -- local variables here
begin
  :new.last_date := sysdate;
  :new.last_user := user;
  :new.status    := nvl(:new.status,'IN');
  :new.create_date := nvl(:new.create_date,sysdate);
  :new.create_user := nvl(:new.create_user,user);
end tbiur_cl_2_ac;



/
ALTER TRIGGER BARS.TBIUR_CL_2_AC ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tbiur_cl_2_ac.sql =========*** End *
 PROMPT ===================================================================================== 
 