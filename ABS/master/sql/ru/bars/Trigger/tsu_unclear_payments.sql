

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TSU_UNCLEAR_PAYMENTS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TSU_UNCLEAR_PAYMENTS ***

  CREATE OR REPLACE TRIGGER BARS.TSU_UNCLEAR_PAYMENTS 
INSTEAD OF UPDATE OR DELETE ON BARS.v_unclear_payments FOR EACH ROW
DECLARE
  sos_ NUMBER;
BEGIN
   UPDATE per_que SET refx=:NEW.ref WHERE ref=:OLD.ref;
   IF SQL%ROWCOUNT=0 THEN
      INSERT INTO per_que (ref,refx) VALUES (:OLD.ref,:NEW.ref);
   END IF;

            begin
            insert into operw (ref, tag, value, kf)
            values (:new.ref, 'REF92', :old.ref, f_ourmfo);
            exception when dup_val_on_index then
            null;
            end;

END;
/
ALTER TRIGGER BARS.TSU_UNCLEAR_PAYMENTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TSU_UNCLEAR_PAYMENTS.sql =========**
PROMPT ===================================================================================== 
