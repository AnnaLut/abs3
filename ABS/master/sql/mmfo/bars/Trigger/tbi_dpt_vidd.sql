

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPT_VIDD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPT_VIDD 
BEFORE INSERT  ON dpt_vidd
FOR EACH ROW
BEGIN
  IF :NEW.vidd IS NULL OR :NEW.vidd=0 THEN
     SELECT s_dpt_vidd.NEXTVAL INTO :new.vidd FROM DUAL;
  END IF;
END;





/
ALTER TRIGGER BARS.TBI_DPT_VIDD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD.sql =========*** End **
PROMPT ===================================================================================== 
