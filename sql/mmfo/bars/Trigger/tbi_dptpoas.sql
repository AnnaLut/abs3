

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTPOAS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPTPOAS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPTPOAS 
  before insert on dpt_poas
  for each row
begin
  if (:new.id is null) then
    select s_dptpoas.nextval into :new.id from dual;
  end if;
end tbi_dptpoas;


/
ALTER TRIGGER BARS.TBI_DPTPOAS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTPOAS.sql =========*** End ***
PROMPT ===================================================================================== 
