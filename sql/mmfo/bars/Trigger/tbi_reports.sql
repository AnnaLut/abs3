

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_REPORTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_REPORTS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_REPORTS 
BEFORE INSERT  ON reports
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.id = 0 ) THEN
       SELECT s_reports.NEXTVAL
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;





/
ALTER TRIGGER BARS.TBI_REPORTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_REPORTS.sql =========*** End ***
PROMPT ===================================================================================== 
