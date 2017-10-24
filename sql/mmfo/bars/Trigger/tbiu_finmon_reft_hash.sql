

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_FINMON_REFT_HASH.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_FINMON_REFT_HASH ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_FINMON_REFT_HASH 
before insert or update on finmon_reft for each row
--
-- Триггер для вычисления Hash-функции для наименования террориста
--
begin

  :new.name_hash := f_fm_hash(:new.c6 || :new.c7 || :new.c8 || :new.c9);

end;



/
ALTER TRIGGER BARS.TBIU_FINMON_REFT_HASH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_FINMON_REFT_HASH.sql =========*
PROMPT ===================================================================================== 
