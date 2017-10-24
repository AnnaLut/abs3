

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_WCS_PARTNERS_ALL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_WCS_PARTNERS_ALL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_WCS_PARTNERS_ALL 
BEFORE INSERT ON WCS_PARTNERS_ALL
FOR EACH ROW
DECLARE newid NUMBER;
BEGIN
   IF ( :new.id = 0 ) or ( :new.id IS NULL ) THEN
       SELECT S_WCS_PARTNERS_ALL.NEXTVAL
       INTO newid FROM DUAL;
       :new.id := newid;
   END IF;
END;


/
ALTER TRIGGER BARS.TBI_WCS_PARTNERS_ALL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_WCS_PARTNERS_ALL.sql =========**
PROMPT ===================================================================================== 
