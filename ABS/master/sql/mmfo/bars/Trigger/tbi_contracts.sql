

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CONTRACTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CONTRACTS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CONTRACTS 
  BEFORE INSERT ON "BARS"."CONTRACTS"
  REFERENCING FOR EACH ROW
  declare
  l_id number;
begin

  if (:new.id = 0 or :new.id is null) then
    select s_contracts.nextval into l_id from dual;
    :new.id := l_id;
  end if;

end;



/
ALTER TRIGGER BARS.TBI_CONTRACTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CONTRACTS.sql =========*** End *
PROMPT ===================================================================================== 
