

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_TABVAL_DENOM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_TABVAL_DENOM ***

  CREATE OR REPLACE TRIGGER BARS.TIU_TABVAL_DENOM 
before insert or update of dig on tabval$global for each row
begin
  :new.denom := power(10, :new.dig);
end tiu_tabval_denom;




/
ALTER TRIGGER BARS.TIU_TABVAL_DENOM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_TABVAL_DENOM.sql =========*** En
PROMPT ===================================================================================== 
