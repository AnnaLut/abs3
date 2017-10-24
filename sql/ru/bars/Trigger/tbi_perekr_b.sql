

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_PEREKR_B.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_PEREKR_B ***

  CREATE OR REPLACE TRIGGER BARS.TBI_PEREKR_B 
BEFORE INSERT  ON perekr_b
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.id = 0 or :new.id is null) THEN
       SELECT s_perekr_b.NEXTVAL
       INTO   bars FROM DUAL;
       :new.id := bars;
    END IF;
END;

/
ALTER TRIGGER BARS.TBI_PEREKR_B ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_PEREKR_B.sql =========*** End **
PROMPT ===================================================================================== 
