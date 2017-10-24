

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZBSK_TRACE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZBSK_TRACE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZBSK_TRACE 
BEFORE INSERT ON OTCN_F13_ZBSK FOR EACH ROW
DECLARE
    RecId   NUMBER;
BEGIN
    SELECT S_ZBSK_RECORD.NEXTVAL INTO :NEW.recid FROM dual;
END TBI_RNBU_TRACE;
/
ALTER TRIGGER BARS.TBI_ZBSK_TRACE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZBSK_TRACE.sql =========*** End 
PROMPT ===================================================================================== 
