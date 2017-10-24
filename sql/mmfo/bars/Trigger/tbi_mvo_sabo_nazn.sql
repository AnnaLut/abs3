

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_MVO_SABO_NAZN.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_MVO_SABO_NAZN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_MVO_SABO_NAZN 
  BEFORE INSERT ON "BARS"."MVO_SABO_NAZN"
  REFERENCING FOR EACH ROW
  BEGIN
  IF :NEW.id IS NULL OR :NEW.id = 0 THEN
     SELECT s_mvo_sabo_nazn.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;



/
ALTER TRIGGER BARS.TBI_MVO_SABO_NAZN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_MVO_SABO_NAZN.sql =========*** E
PROMPT ===================================================================================== 
