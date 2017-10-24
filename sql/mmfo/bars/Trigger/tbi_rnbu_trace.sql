

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_TRACE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_RNBU_TRACE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_RNBU_TRACE 
BEFORE INSERT ON RNBU_TRACE FOR EACH ROW
     WHEN (
new.recid is NULL
      ) DECLARE
    RecId   NUMBER;
    UsrId   NUMBER;
BEGIN
    SELECT s_rnbu_record.nextval INTO :new.recid FROM dual;
    :new.userid := USER_ID;
END TBI_RNBU_TRACE;




/
ALTER TRIGGER BARS.TBI_RNBU_TRACE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_TRACE.sql =========*** End 
PROMPT ===================================================================================== 
