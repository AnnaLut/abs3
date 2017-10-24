

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_LICENSE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_LICENSE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_LICENSE 
before insert on cim_license for each row
declare
  l_id number;
begin
  if (:new.license_id = 0 or :new.license_id is null) then
     select s_cim_license.nextval into l_id from dual;
     :new.license_id := l_id;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_CIM_LICENSE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_LICENSE.sql =========*** End
PROMPT ===================================================================================== 
