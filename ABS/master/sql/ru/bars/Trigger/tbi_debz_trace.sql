

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DEBZ_TRACE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DEBZ_TRACE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DEBZ_TRACE 
BEFORE INSERT ON OTCN_F08_DEBZ FOR EACH ROW
DECLARE
    RecId   NUMBER;
BEGIN
    SELECT S_DEBZ_RECORD.NEXTVAL INTO :NEW.recid FROM dual;
END TBI_DEBZ_TRACE;
/
ALTER TRIGGER BARS.TBI_DEBZ_TRACE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DEBZ_TRACE.sql =========*** End 
PROMPT ===================================================================================== 
