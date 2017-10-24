

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BM$LOCAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BM$LOCAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BM$LOCAL 
before insert on BANK_METALS$LOCAL
for each row
begin
 if (:new.FDAT is null) then     :NEW.FDAT := SYSDATE; end if;
end;
/
ALTER TRIGGER BARS.TBI_BM$LOCAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BM$LOCAL.sql =========*** End **
PROMPT ===================================================================================== 
