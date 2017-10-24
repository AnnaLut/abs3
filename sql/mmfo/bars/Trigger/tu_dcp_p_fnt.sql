

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DCP_P_FNT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DCP_P_FNT ***

  CREATE OR REPLACE TRIGGER BARS.TU_DCP_P_FNT 
  AFTER UPDATE OF DATT ON "BARS"."DCP_P"
  REFERENCING FOR EACH ROW
  BEGIN
  IF :NEW.ERR_NBU IS NOT NULL AND :NEW.ERR_NBU <> '0000' OR
     :NEW.ERR_DEP IS NOT NULL AND :NEW.ERR_DEP <> '0000' THEN
    INSERT INTO DCP_A(REF) VALUES(:NEW.REF);
  END IF;
END;



/
ALTER TRIGGER BARS.TU_DCP_P_FNT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DCP_P_FNT.sql =========*** End **
PROMPT ===================================================================================== 
