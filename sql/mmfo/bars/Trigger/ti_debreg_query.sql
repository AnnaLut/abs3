

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_DEBREG_QUERY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_DEBREG_QUERY ***

  CREATE OR REPLACE TRIGGER BARS.TI_DEBREG_QUERY 
BEFORE INSERT  ON DEBREG_QUERY FOR EACH ROW
DECLARE nID NUMBER;
BEGIN
   IF ( :new.requestid  = 0 ) THEN
       SELECT s_DEBREG_QUERY.NEXTVAL INTO nID FROM DUAL;
       :new.requestid := nID;
   END IF;
END;



/
ALTER TRIGGER BARS.TI_DEBREG_QUERY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_DEBREG_QUERY.sql =========*** End
PROMPT ===================================================================================== 
