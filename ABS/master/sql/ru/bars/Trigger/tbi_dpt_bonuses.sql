

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_BONUSES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPT_BONUSES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPT_BONUSES 
BEFORE INSERT ON dpt_bonuses
FOR EACH ROW
BEGIN

  IF (:new.bonus_id IS NULL) OR (:new.bonus_id = 0) THEN

     SELECT s_dpt_bonuses.nextval INTO :new.bonus_id FROM dual;

  END IF;

END;
/
ALTER TRIGGER BARS.TBI_DPT_BONUSES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_BONUSES.sql =========*** End
PROMPT ===================================================================================== 
