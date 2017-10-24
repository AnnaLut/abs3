

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CONTRACT_P_DAT91.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CONTRACT_P_DAT91 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CONTRACT_P_DAT91 
  BEFORE INSERT OR UPDATE ON "BARS"."CONTRACT_P"
  REFERENCING FOR EACH ROW
  declare
  l_days  number;
  l_dat91 date;
begin

  if (:new.pid is not null and :new.dat91 is null) then

    select control_days into l_days from top_contracts where pid = :new.pid;

    l_dat91 := :new.fdat + l_days + 1;

    :new.dat91 := l_dat91;

  else

    if (:new.pid is null and :new.dat91 is not null) then

	:new.dat91 := to_date(null);

    end if;

  end if;

  if (:new.pid is not null and :old.pid is null) then

     :new.dat := gl.bdate;

  end if;

end tiu_contract_p_dat91;



/
ALTER TRIGGER BARS.TIU_CONTRACT_P_DAT91 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CONTRACT_P_DAT91.sql =========**
PROMPT ===================================================================================== 
