

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CONTRACTS_ALIEN.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CONTRACTS_ALIEN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CONTRACTS_ALIEN 
  BEFORE INSERT ON "BARS"."CONTRACTS_ALIEN"
  REFERENCING FOR EACH ROW
  declare
  l_benefrnk number;
begin

  if (:new.benefrnk = 0 or :new.benefrnk is null) then

     select s_contracts_alien.nextval into l_benefrnk from dual;
    :new.benefrnk := l_benefrnk;

  end if;

end;



/
ALTER TRIGGER BARS.TBI_CONTRACTS_ALIEN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CONTRACTS_ALIEN.sql =========***
PROMPT ===================================================================================== 
