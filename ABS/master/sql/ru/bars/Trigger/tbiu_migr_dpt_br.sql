

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_MIGR_DPT_BR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_MIGR_DPT_BR ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_MIGR_DPT_BR 
before insert or update ON BARS.MIGR_DPT_BR for each row
declare
  l_ob22   sb_ob22.ob22%type;
  l_brtype brates.br_type%type;
begin
  begin
    select ob22
      into l_ob22
      from sb_ob22
     where r020 = :new.nbs
       and ob22 = :new.ob22
       and d_close is null;
  exception
    when no_data_found then
      bars_error.raise_nerror ('DPU', 'INVALID_OBB22', :new.ob22, :new.ob22);
  end;

  -- перевірка правильності заповнення базової ставки
  begin
    select BR_TYPE
      into l_brtype
      from BRATES
     where BR_ID = :new.BR;
  exception
    when no_data_found then
      bars_error.raise_nerror ('DPT', 'INVALID_BR', :new.BR);
  end;
end TBIU_MIGR_DPT_BR;
/
ALTER TRIGGER BARS.TBIU_MIGR_DPT_BR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_MIGR_DPT_BR.sql =========*** En
PROMPT ===================================================================================== 
