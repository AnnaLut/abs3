

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CP_ALIEN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CP_ALIEN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CP_ALIEN 
BEFORE INSERT  ON CP_alien
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( nvl(:new.id,0) = 0 ) THEN
       SELECT bars_sqnc.get_nextval('S_CP_alien')
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;


/
ALTER TRIGGER BARS.TBI_CP_ALIEN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CP_ALIEN.sql =========*** End **
PROMPT ===================================================================================== 
