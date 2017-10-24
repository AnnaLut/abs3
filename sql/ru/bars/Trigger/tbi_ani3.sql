

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ANI3.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ANI3 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ANI3 
BEFORE INSERT ON BARS.ANI3 FOR EACH ROW
 WHEN (
NEW.id IS NULL
      ) BEGIN
 SELECT s_ANI3.NEXTVAL INTO :NEW.id FROM dual;
END;
/
ALTER TRIGGER BARS.TBI_ANI3 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ANI3.sql =========*** End *** ==
PROMPT ===================================================================================== 
