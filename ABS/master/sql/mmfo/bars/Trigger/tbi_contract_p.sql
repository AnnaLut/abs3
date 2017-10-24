

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CONTRACT_P.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CONTRACT_P ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CONTRACT_P 
  BEFORE INSERT ON "BARS"."CONTRACT_P"
  REFERENCING FOR EACH ROW
  declare
  l_idp  number;
begin

  :new.dat := gl.bdate;

  if (:new.idp = 0 or :new.idp is null) then

     select s_contract_p.nextval into l_idp from dual;
     :new.idp := l_idp;

  end if;

end;



/
ALTER TRIGGER BARS.TBI_CONTRACT_P ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CONTRACT_P.sql =========*** End 
PROMPT ===================================================================================== 
