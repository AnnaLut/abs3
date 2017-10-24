

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BRATES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BRATES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BRATES 
BEFORE INSERT  ON brates
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.br_id = 0 or :new.br_id is null) THEN
       SELECT s_brates.NEXTVAL
       INTO   bars FROM DUAL;
       :new.br_id := bars;
    END IF;
END;

/
ALTER TRIGGER BARS.TBI_BRATES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BRATES.sql =========*** End *** 
PROMPT ===================================================================================== 
