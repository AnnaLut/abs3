

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_OPER_SOS_DCP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_OPER_SOS_DCP ***

  CREATE OR REPLACE TRIGGER BARS.TIU_OPER_SOS_DCP 
  AFTER INSERT OR UPDATE OF SOS ON "BARS"."OPER"
  REFERENCING FOR EACH ROW
DECLARE
Mfo_ VARCHAR2(12);
BEGIN
  IF instr(:NEW.D_REC, '#d') > 0 THEN
    IF :NEW.MFOA <> :NEW.MFOB THEN
      BEGIN
        SELECT mfo INTO Mfo_ FROM banks
         WHERE mfo=:NEW.MFOB AND mfou=gl.aMFO ;
      EXCEPTION WHEN NO_DATA_FOUND THEN return;
      END;
    END IF;
    IF :NEW.SOS = 5 THEN
      INSERT INTO DCP_A(REF) VALUES(:NEW.REF);
    ELSE
      DELETE FROM DCP_A WHERE REF=:NEW.REF;
    END IF;
  END IF;
END;



/
ALTER TRIGGER BARS.TIU_OPER_SOS_DCP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_OPER_SOS_DCP.sql =========*** En
PROMPT ===================================================================================== 
