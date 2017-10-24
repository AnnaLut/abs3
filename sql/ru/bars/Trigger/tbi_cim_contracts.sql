

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_CONTRACTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_CONTRACTS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_CONTRACTS 
before insert on cim_contracts
for each row
declare
  l_contr_id number;
begin
  if (:new.contr_id is null) then
     select s_cim_contracts.nextval into l_contr_id from dual;
     :new.contr_id := l_contr_id;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_CIM_CONTRACTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_CONTRACTS.sql =========*** E
PROMPT ===================================================================================== 
