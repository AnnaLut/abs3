

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_NBUR_TMP_DEL_70.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_NBUR_TMP_DEL_70 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_NBUR_TMP_DEL_70 
   BEFORE  insert or update ON NBUR_TMP_DEL_70
   FOR EACH ROW
BEGIN
   :NEW.USERID := user_id;
   :NEW.KF := bc.current_mfo;
END;
/
ALTER TRIGGER BARS.TBI_NBUR_TMP_DEL_70 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_NBUR_TMP_DEL_70.sql =========***
PROMPT ===================================================================================== 
