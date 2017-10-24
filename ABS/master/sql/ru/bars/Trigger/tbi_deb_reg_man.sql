

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DEB_REG_MAN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DEB_REG_MAN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DEB_REG_MAN 
BEFORE INSERT  ON DEB_REG_MAN
FOR EACH ROW
DECLARE newACC NUMBER;
BEGIN
   IF  :new.ACC is null THEN
       SELECT S_DEB_REG_TMP.NEXTVAL INTO newACC FROM DUAL;
       :new.ACC := newACC;
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_DEB_REG_MAN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DEB_REG_MAN.sql =========*** End
PROMPT ===================================================================================== 
