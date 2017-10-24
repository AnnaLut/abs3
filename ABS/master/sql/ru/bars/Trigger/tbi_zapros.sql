

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAPROS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAPROS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAPROS 
BEFORE INSERT ON zapros
FOR EACH ROW
DECLARE newkod NUMBER;
BEGIN
   IF ( :new.kodz = 0 ) or ( :new.kodz IS NULL ) THEN
       SELECT s_zapros.NEXTVAL
       INTO newkod FROM DUAL;
       :new.kodz := newkod;
   END IF;
END;

/
ALTER TRIGGER BARS.TBI_ZAPROS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAPROS.sql =========*** End *** 
PROMPT ===================================================================================== 
