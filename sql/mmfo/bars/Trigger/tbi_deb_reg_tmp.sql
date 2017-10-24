

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DEB_REG_TMP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DEB_REG_TMP ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DEB_REG_TMP 
  BEFORE INSERT ON "BARS"."DEB_REG_TMP"
  REFERENCING FOR EACH ROW
  DECLARE newACC NUMBER;
BEGIN
   IF  :new.ACC is null THEN
       SELECT S_DEB_REG_TMP.NEXTVAL INTO newACC FROM DUAL;
       :new.ACC := newACC;
   END IF;
END;



/
ALTER TRIGGER BARS.TBI_DEB_REG_TMP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DEB_REG_TMP.sql =========*** End
PROMPT ===================================================================================== 
