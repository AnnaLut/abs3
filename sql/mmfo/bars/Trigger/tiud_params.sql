

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_PARAMS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_PARAMS ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_PARAMS 
INSTEAD OF INSERT OR UPDATE OR DELETE ON "DEPRICATED_PARAMS"
FOR EACH ROW
BEGIN
  -- Реализация обновления представления PARAMS
  IF INSERTING THEN
    INSERT INTO PARAMS$BASE (PAR, VAL, COMM, KF)
    VALUES (:NEW.PAR, :NEW.VAL, :NEW.COMM, SYS_CONTEXT('bars_context','user_mfo'));
  ELSIF UPDATING THEN
    UPDATE PARAMS$BASE  SET
    PAR=:NEW.PAR, VAL=:NEW.VAL, COMM=:NEW.COMM
    WHERE
      PAR=:OLD.PAR AND KF=SYS_CONTEXT('bars_context','user_mfo');
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-(20001),'Обновление глобального параметра запрещено!',TRUE);
    END IF;
  ELSIF DELETING THEN
    DELETE FROM PARAMS$BASE
    WHERE
      PAR=:OLD.PAR AND KF=SYS_CONTEXT('bars_context','user_mfo');
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-(20001),'Удаление глобального параметра запрещено!',TRUE);
    END IF;
  END IF;
END;


/
ALTER TRIGGER BARS.TIUD_PARAMS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_PARAMS.sql =========*** End ***
PROMPT ===================================================================================== 
