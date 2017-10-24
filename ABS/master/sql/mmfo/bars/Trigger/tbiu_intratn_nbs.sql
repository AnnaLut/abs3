

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_INTRATN_NBS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_INTRATN_NBS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_INTRATN_NBS 
before insert or update on int_ratn
for each row    WHEN ( new.id = 0 ) declare
  l_nbs accounts.nbs%type;
begin
  if :new.ir = 0 then
     begin
        select nbs into l_nbs from accounts where acc = :new.acc;
        if substr(l_nbs, 1, 2) in ('20', '21', '22') then
           -- Заборонено встановлювати нульову процентну ставку для БР l_nbs
           bars_error.raise_nerror('CAC', 'ERROR_INTRATN0_NBS', l_nbs);
        end if;
     exception when no_data_found then null;
     end;
  end if;
end;


/
ALTER TRIGGER BARS.TBIU_INTRATN_NBS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_INTRATN_NBS.sql =========*** En
PROMPT ===================================================================================== 
