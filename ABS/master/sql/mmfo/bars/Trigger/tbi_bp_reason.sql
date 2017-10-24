

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BP_REASON.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BP_REASON ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BP_REASON 
BEFORE INSERT  ON bp_reason
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.id = 0 or :new.id is null) THEN
       SELECT s_bp_reason.NEXTVAL
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;





/
ALTER TRIGGER BARS.TBI_BP_REASON ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BP_REASON.sql =========*** End *
PROMPT ===================================================================================== 
