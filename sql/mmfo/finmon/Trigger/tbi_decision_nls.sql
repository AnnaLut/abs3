

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TBI_DECISION_NLS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DECISION_NLS ***

  CREATE OR REPLACE TRIGGER FINMON.TBI_DECISION_NLS 
BEFORE INSERT ON FINMON.DECISION_NLS FOR EACH ROW
BEGIN
   if (:NEW.ID is null)then
      SELECT S_DECISION_NLS.NEXTVAL INTO :NEW.ID FROM dual;
   end if;
END TBI_DECISION_NLS;
/
ALTER TRIGGER FINMON.TBI_DECISION_NLS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TBI_DECISION_NLS.sql =========*** 
PROMPT ===================================================================================== 
