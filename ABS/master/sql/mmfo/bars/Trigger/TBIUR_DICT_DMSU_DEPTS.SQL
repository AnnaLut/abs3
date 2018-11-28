
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tbiur_dict_dmsu_depts.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TBIUR_DICT_DMSU_DEPTS 
  before insert or update
  on DICT_DMSU_DEPTS 
  for each row
declare
  -- local variables here
begin
  :new.last_dt := sysdate;
  :new.last_user := user;
  if :new.id is null then
    select nvl(max(id),0)+1 into :new.id from dict_dmsu_depts;
  end if;
end tbiur_dict_dmsu_depts;

/
ALTER TRIGGER BARS.TBIUR_DICT_DMSU_DEPTS ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tbiur_dict_dmsu_depts.sql =========*
 PROMPT ===================================================================================== 
 