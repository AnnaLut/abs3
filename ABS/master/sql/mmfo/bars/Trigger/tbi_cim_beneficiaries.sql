

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_BENEFICIARIES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_BENEFICIARIES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_BENEFICIARIES 
before insert on bars.cim_beneficiaries
for each row
declare
  l_benef_id number;
begin
  if (:new.benef_id = 0 or :new.benef_id is null) then
     select bars_sqnc.get_nextval('s_cim_beneficiaries') into l_benef_id from dual;
     :new.benef_id := l_benef_id;
  end if;
end;


/
ALTER TRIGGER BARS.TBI_CIM_BENEFICIARIES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_BENEFICIARIES.sql =========*
PROMPT ===================================================================================== 
