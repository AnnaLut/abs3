

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ISTR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ISTR ***

  CREATE OR REPLACE TRIGGER BARS.TU_ISTR 
BEFORE UPDATE OF blk ON arc_rrp
FOR EACH ROW  WHEN ( old.blk = 131312 and new.blk <> 131312 and new.blk <> -1) DECLARE
   ern  CONSTANT POSITIVE := 13; -- Trigger err code
   err  EXCEPTION;
   erm  VARCHAR2(80):='ФИН.МОНИТОРИНГ. Невозможно разблокировать документ '||:new.ref||' в течении 2-х дней';
BEGIN
----- Setting free of terrorists catched in 2 days------
   IF gl.bDATE<:OLD.dat_a + 1 THEN
      :NEW.blk := :OLD.blk;
      raise err;
   END IF;
exception when err then
  raise_application_error(-(20000+ern),'\'||erm,TRUE);
END;
/
ALTER TRIGGER BARS.TU_ISTR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ISTR.sql =========*** End *** ===
PROMPT ===================================================================================== 
