

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_GROUPS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_GROUPS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_GROUPS 
BEFORE INSERT  ON groups
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.id = 0 ) THEN
       SELECT s_groups.NEXTVAL
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;

/
ALTER TRIGGER BARS.TBI_GROUPS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_GROUPS.sql =========*** End *** 
PROMPT ===================================================================================== 
