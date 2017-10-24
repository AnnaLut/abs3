

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SAL ***

  CREATE OR REPLACE TRIGGER BARS.TU_SAL 
  AFTER INSERT OR UPDATE OF dapp,ostc,ostq ON accounts
  FOR EACH ROW
-- Stores values in temp variables assuming trigger tu_sal_a
--        write it into saldoa table.
-- VER  tu_sal.sql 5.0.0.0 03/14/04
-- KF      -- для мульти-МФО схемы с полем KF
DECLARE
    -- 'No group accounts update allowed';
    ern          NUMBER := 3;
    err          EXCEPTION;
 BEGIN
    IF gl.val.a_acc IS NOT NULL THEN
       RAISE err;
    END IF;
    gl.val.a_acc := :NEW.acc;
    gl.val.a_ost := :NEW.ostc;
    gl.val.b_ost := CASE WHEN INSERTING THEN 0 ELSE :OLD.ostc END;
    gl.val.a_ostq:= :NEW.ostq;
    gl.val.b_ostq:= CASE WHEN INSERTING THEN 0 ELSE :OLD.ostq END;
EXCEPTION
    WHEN err THEN
       bars_error.raise_error('CAC', ern);
END tu_sal;
/
ALTER TRIGGER BARS.TU_SAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
