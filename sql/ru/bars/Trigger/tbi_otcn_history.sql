

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OTCN_HISTORY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OTCN_HISTORY ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OTCN_HISTORY 
BEFORE INSERT ON BARS.OTCN_HISTORY FOR EACH ROW
DECLARE
    RecId   NUMBER;
    UsrId   NUMBER;
BEGIN
    SELECT s_rnbu_record.nextval INTO :new.recid FROM dual;
    BEGIN
         SELECT id INTO :new.userid FROM staff WHERE upper(logname)=upper(USER);
    EXCEPTION WHEN NO_DATA_FOUND THEN
         :new.userid := 20094;
    END;
END TBI_OTCN_HISTORY;
/
ALTER TRIGGER BARS.TBI_OTCN_HISTORY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OTCN_HISTORY.sql =========*** En
PROMPT ===================================================================================== 
