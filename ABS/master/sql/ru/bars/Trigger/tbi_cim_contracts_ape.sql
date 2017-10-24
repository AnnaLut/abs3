

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_CONTRACTS_APE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_CONTRACTS_APE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_CONTRACTS_APE 
before insert on cim_contracts_ape
for each row
declare
  l_ape_id number;
begin
  if (:new.ape_id = 0 or :new.ape_id is null) then
     select s_cim_contracts_ape.nextval into l_ape_id from dual;
     :new.ape_id := l_ape_id;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_CIM_CONTRACTS_APE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_CONTRACTS_APE.sql =========*
PROMPT ===================================================================================== 
