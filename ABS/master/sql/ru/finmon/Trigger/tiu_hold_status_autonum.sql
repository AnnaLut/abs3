

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TIU_HOLD_STATUS_AUTONUM.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_HOLD_STATUS_AUTONUM ***

  CREATE OR REPLACE TRIGGER FINMON.TIU_HOLD_STATUS_AUTONUM 
    AFTER INSERT OR UPDATE ON OPER FOR EACH ROW
BEGIN
    IF :NEW.STATUS < 0 THEN begin
            INSERT INTO OPER_NOTES (OPER_ID, HOLD_REF_NUM, HOLD_REF_DATE)
            VALUES (:NEW.ID, :NEW.KL_ID, SYSDATE);
    exception when others then
        null;
    end; END IF;
END;
/
ALTER TRIGGER FINMON.TIU_HOLD_STATUS_AUTONUM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TIU_HOLD_STATUS_AUTONUM.sql ======
PROMPT ===================================================================================== 
