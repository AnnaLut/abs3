

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTDEPOSITCLOS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPTDEPOSITCLOS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPTDEPOSITCLOS 
before insert ON BARS.DPT_DEPOSIT_CLOS
for each row
begin

    if (:new.idupd is null) then
        select bars_sqnc.get_nextval('s_dpt_deposit_clos') into :new.idupd from dual;
    end if;

end;

/
ALTER TRIGGER BARS.TBI_DPTDEPOSITCLOS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTDEPOSITCLOS.sql =========*** 
PROMPT ===================================================================================== 
