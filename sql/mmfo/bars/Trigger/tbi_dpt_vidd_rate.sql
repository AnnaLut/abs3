

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD_RATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPT_VIDD_RATE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPT_VIDD_RATE 
BEFORE INSERT ON dpt_vidd_rate
FOR EACH ROW
DECLARE
  id_ NUMBER;
BEGIN
  IF :new.id IS NULL OR :new.id = 0 THEN
     SELECT s_dpt_vidd_rate.nextval INTO id_  FROM dual;
     :new.id := id_;
  END IF;
END;




/
ALTER TRIGGER BARS.TBI_DPT_VIDD_RATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD_RATE.sql =========*** E
PROMPT ===================================================================================== 
