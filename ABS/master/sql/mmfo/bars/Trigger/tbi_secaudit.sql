

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SECAUDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SECAUDIT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SECAUDIT 
  BEFORE INSERT ON "BARS"."SEC_AUDIT"
  REFERENCING FOR EACH ROW
  begin

    --
    -- Только для совместимости
    -- Работа с журналом через пакет BARS_AUDIT
    -- не требует данного триггера
    --

    if (:new.rec_id is null) then
        select s_secaudit.nextval into :new.rec_id from dual;
    end if;

    if (:new.rec_bdate is null) then
        :new.rec_bdate := bankdate;
    end if;
end;



/
ALTER TRIGGER BARS.TBI_SECAUDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SECAUDIT.sql =========*** End **
PROMPT ===================================================================================== 
