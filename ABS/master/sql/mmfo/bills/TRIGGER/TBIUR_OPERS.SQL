
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/trigger/tbiur_opers.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BILLS.TBIUR_OPERS 
  before insert or update
  on OPERS 
  for each row
declare
  -- local variables here
begin
  if :new.id is null then 
    :new.id := s_opers_id_seq.nextval;
  end if;
  :new.user_ref := user;
  :new.last_dt  := sysdate;
end tbiur_opers;

/
ALTER TRIGGER BILLS.TBIUR_OPERS ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/trigger/tbiur_opers.sql =========*** End **
 PROMPT ===================================================================================== 
 